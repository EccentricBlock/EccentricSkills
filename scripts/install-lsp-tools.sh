#!/usr/bin/env bash
set -u

# ============================================================
# ensure-dev-runtimes.sh
#
# Checks for Node/npm, Rust/rustup, and terraform-ls.
# - If no supported runtime is present: exits 1.
# - If runtimes are present but packages/components are missing:
#   installs the missing packages/components.
# - If terraform-ls is missing:
#   adds the HashiCorp apt repository and installs terraform-ls.
# - If checks/installations succeed: exits 0.
# ============================================================

NODE_AVAILABLE=0
NPM_AVAILABLE=0
RUSTUP_AVAILABLE=0
HAD_RUNTIME=0
FAILED=0

echo "Checking runtimes..."

if command -v node >/dev/null 2>&1; then
    NODE_AVAILABLE=1
fi

if command -v npm >/dev/null 2>&1; then
    NPM_AVAILABLE=1
fi

if command -v rustup >/dev/null 2>&1; then
    RUSTUP_AVAILABLE=1
fi

if [ "$NODE_AVAILABLE" -eq 1 ] && [ "$NPM_AVAILABLE" -eq 1 ]; then
    HAD_RUNTIME=1
    echo "Node.js/npm detected."
fi

if [ "$RUSTUP_AVAILABLE" -eq 1 ]; then
    HAD_RUNTIME=1
    echo "Rust/rustup detected."
fi

if [ "$HAD_RUNTIME" -eq 0 ]; then
    echo "ERROR: No supported runtimes found."
    echo "Required: Node.js with npm and/or Rust with rustup."
    exit 1
fi

# ============================================================
# Function: ensure_npm_command
# Args:
#   $1 = npm package name
#   $2 = executable/command expected on PATH
# ============================================================

ensure_npm_command() {
    local package_name="$1"
    local command_name="$2"

    if command -v "$command_name" >/dev/null 2>&1; then
        echo "$package_name already installed."
        return 0
    fi

    echo "$package_name missing. Installing..."

    npm install -g "$package_name"

    if [ "$?" -ne 0 ]; then
        echo "ERROR: Failed to install $package_name."
        FAILED=1
        return 1
    fi

    if ! command -v "$command_name" >/dev/null 2>&1; then
        echo "ERROR: $package_name installed, but $command_name was not found on PATH."
        FAILED=1
        return 1
    fi

    echo "$package_name installed successfully."
    return 0
}

# ============================================================
# Node/npm global package checks
# ============================================================

if [ "$NODE_AVAILABLE" -eq 1 ] && [ "$NPM_AVAILABLE" -eq 1 ]; then
    echo
    echo "Checking npm global packages..."

    ensure_npm_command "typescript" "tsc"
    ensure_npm_command "typescript-language-server" "typescript-language-server"
    ensure_npm_command "pyright" "pyright"
    ensure_npm_command "yaml-language-server" "yaml-language-server"
    ensure_npm_command "bash-language-server" "bash-language-server"
else
    echo
    echo "Node.js/npm not fully available. Skipping npm package checks."
fi

# ============================================================
# Rust rust-analyzer component check
# ============================================================

if [ "$RUSTUP_AVAILABLE" -eq 1 ]; then
    echo
    echo "Checking Rust component: rust-analyzer..."

    if rustup component list --installed | grep -q "^rust-analyzer"; then
        echo "rust-analyzer already installed."
    else
        echo "rust-analyzer missing. Installing..."

        rustup component add rust-analyzer

        if [ "$?" -ne 0 ]; then
            echo "ERROR: Failed to install rust-analyzer."
            FAILED=1
        else
            echo "rust-analyzer installed successfully."
        fi
    fi
else
    echo
    echo "rustup not available. Skipping Rust component checks."
fi

# ============================================================
# terraform-ls check/install
# ============================================================

echo
echo "Checking terraform-ls..."

if command -v terraform-ls >/dev/null 2>&1; then
    echo "terraform-ls already installed."
    terraform-ls version
else
    echo "terraform-ls missing. Installing..."

    if ! command -v sudo >/dev/null 2>&1; then
        echo "ERROR: sudo is required to install terraform-ls through apt."
        FAILED=1
    elif ! command -v apt >/dev/null 2>&1; then
        echo "ERROR: apt was not found. This installer expects Ubuntu/Debian."
        FAILED=1
    else
        sudo apt update

        if [ "$?" -ne 0 ]; then
            echo "ERROR: apt update failed."
            FAILED=1
        fi

        if [ "$FAILED" -eq 0 ]; then
            sudo apt install -y gpg wget lsb-release

            if [ "$?" -ne 0 ]; then
                echo "ERROR: Failed to install required packages: gpg wget lsb-release."
                FAILED=1
            fi
        fi

        if [ "$FAILED" -eq 0 ]; then
            wget -O- https://apt.releases.hashicorp.com/gpg \
                | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

            if [ "$?" -ne 0 ]; then
                echo "ERROR: Failed to install HashiCorp apt signing key."
                FAILED=1
            fi
        fi

        if [ "$FAILED" -eq 0 ]; then
            UBUNTU_CODENAME="$(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || true)"

            if [ -z "$UBUNTU_CODENAME" ]; then
                UBUNTU_CODENAME="$(lsb_release -cs)"
            fi

            if [ -z "$UBUNTU_CODENAME" ]; then
                echo "ERROR: Could not determine Ubuntu codename."
                FAILED=1
            else
                echo "Using Ubuntu codename: $UBUNTU_CODENAME"

                echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $UBUNTU_CODENAME main" \
                    | sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null

                if [ "$?" -ne 0 ]; then
                    echo "ERROR: Failed to write HashiCorp apt source list."
                    FAILED=1
                fi
            fi
        fi

        if [ "$FAILED" -eq 0 ]; then
            sudo apt update

            if [ "$?" -ne 0 ]; then
                echo "ERROR: apt update failed after adding HashiCorp repository."
                FAILED=1
            fi
        fi

        if [ "$FAILED" -eq 0 ]; then
            sudo apt install -y terraform-ls

            if [ "$?" -ne 0 ]; then
                echo "ERROR: Failed to install terraform-ls."
                FAILED=1
            fi
        fi

        if [ "$FAILED" -eq 0 ]; then
            if command -v terraform-ls >/dev/null 2>&1; then
                echo "terraform-ls installed successfully."
                terraform-ls version
            else
                echo "ERROR: terraform-ls installed, but was not found on PATH."
                FAILED=1
            fi
        fi
    fi
fi

# ============================================================
# Final result
# ============================================================

if [ "$FAILED" -eq 1 ]; then
    echo
    echo "ERROR: One or more package/component installations failed."
    exit 1
fi

# ============================================================
# Editor Extension Checks (VS Code / Cursor)
# ============================================================

echo
echo "Checking for VS Code..."
if command -v code >/dev/null 2>&1; then
    echo "VS Code detected, installing extensions..."
    code --install-extension ms-python.python
    code --install-extension ms-python.vscode-pylance
    code --install-extension rust-lang.rust-analyzer
    code --install-extension ms-dotnettools.csharp
    code --install-extension redhat.vscode-yaml
    code --install-extension timonwong.shellcheck
    code --install-extension hashicorp.terraform
else
    echo "VS Code not found."
fi

echo
echo "Checking for Cursor..."
if command -v cursor >/dev/null 2>&1; then
    echo "Cursor detected, installing extensions..."
    cursor --install-extension ms-python.python
    cursor --install-extension ms-python.vscode-pylance
    cursor --install-extension rust-lang.rust-analyzer
    cursor --install-extension ms-dotnettools.csharp
    cursor --install-extension redhat.vscode-yaml
    cursor --install-extension timonwong.shellcheck
    cursor --install-extension hashicorp.terraform
else
    echo "Cursor not found."
fi

echo
echo "Runtime/package checks completed successfully."
exit 0