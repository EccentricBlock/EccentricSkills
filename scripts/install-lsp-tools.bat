@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem ============================================================
rem ensure-dev-runtimes.bat
rem
rem Checks for Node/npm, Rust/rustup, and terraform-ls.
rem - If no supported runtime is present: exits 1.
rem - If runtimes are present but packages/components are missing:
rem   installs the missing packages/components.
rem - If terraform-ls is missing:
rem   downloads and installs terraform-ls 0.38.7 to %USERPROFILE%\bin.
rem - If checks/installations succeed: exits 0.
rem ============================================================

set "NODE_AVAILABLE=0"
set "NPM_AVAILABLE=0"
set "RUSTUP_AVAILABLE=0"
set "HAD_RUNTIME=0"
set "FAILED=0"

set "TERRAFORM_LS_URL=https://releases.hashicorp.com/terraform-ls/0.38.7/terraform-ls_0.38.7_windows_amd64.zip"
set "TERRAFORM_LS_INSTALL_DIR=%USERPROFILE%\bin"
set "TERRAFORM_LS_ZIP=%TEMP%\terraform-ls.zip"

echo Checking runtimes...

where node >nul 2>nul
if "%ERRORLEVEL%"=="0" set "NODE_AVAILABLE=1"

where npm >nul 2>nul
if "%ERRORLEVEL%"=="0" set "NPM_AVAILABLE=1"

where rustup >nul 2>nul
if "%ERRORLEVEL%"=="0" set "RUSTUP_AVAILABLE=1"

if "%NODE_AVAILABLE%"=="1" if "%NPM_AVAILABLE%"=="1" (
    set "HAD_RUNTIME=1"
    echo Node.js/npm detected.
)

if "%RUSTUP_AVAILABLE%"=="1" (
    set "HAD_RUNTIME=1"
    echo Rust/rustup detected.
)

if "%HAD_RUNTIME%"=="0" (
    echo ERROR: No supported runtimes found.
    echo Required: Node.js with npm and/or Rust with rustup.
    exit /b 1
)

rem ============================================================
rem Node/npm global package checks
rem ============================================================

if "%NODE_AVAILABLE%"=="1" if "%NPM_AVAILABLE%"=="1" (
    echo.
    echo Checking npm global packages...

    call :EnsureNpmCommand "typescript" "tsc"
    call :EnsureNpmCommand "typescript-language-server" "typescript-language-server"
    call :EnsureNpmCommand "pyright" "pyright"
    call :EnsureNpmCommand "yaml-language-server" "yaml-language-server"
    call :EnsureNpmCommand "bash-language-server" "bash-language-server"
) else (
    echo.
    echo Node.js/npm not fully available. Skipping npm package checks.
)

rem ============================================================
rem Rust rust-analyzer component check
rem ============================================================

if "%RUSTUP_AVAILABLE%"=="1" (
    echo.
    echo Checking Rust component: rust-analyzer...

    rustup component list --installed | findstr /R /C:"^rust-analyzer" >nul 2>nul

    if "!ERRORLEVEL!"=="0" (
        echo rust-analyzer already installed.
    ) else (
        echo rust-analyzer missing. Installing...

        call rustup component add rust-analyzer

        if "!ERRORLEVEL!" NEQ "0" (
            echo ERROR: Failed to install rust-analyzer.
            set "FAILED=1"
        ) else (
            echo rust-analyzer installed successfully.
        )
    )
) else (
    echo.
    echo rustup not available. Skipping Rust component checks.
)

rem ============================================================
rem terraform-ls check/install
rem ============================================================

echo.
echo Checking terraform-ls...

where terraform-ls.exe >nul 2>nul

if "%ERRORLEVEL%"=="0" (
    echo terraform-ls already installed.
    terraform-ls version
) else (
    echo terraform-ls missing. Installing...

    if not exist "%TERRAFORM_LS_INSTALL_DIR%" (
        mkdir "%TERRAFORM_LS_INSTALL_DIR%"

        if "!ERRORLEVEL!" NEQ "0" (
            echo ERROR: Failed to create %TERRAFORM_LS_INSTALL_DIR%.
            set "FAILED=1"
            goto AfterTerraformLs
        )
    )

    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
      "$ErrorActionPreference = 'Stop';" ^
      "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;" ^
      "Invoke-WebRequest -Uri '%TERRAFORM_LS_URL%' -OutFile '%TERRAFORM_LS_ZIP%';" ^
      "Expand-Archive -LiteralPath '%TERRAFORM_LS_ZIP%' -DestinationPath '%TERRAFORM_LS_INSTALL_DIR%' -Force;"

    if "!ERRORLEVEL!" NEQ "0" (
        echo ERROR: Failed to download or extract terraform-ls.
        set "FAILED=1"
        goto AfterTerraformLs
    )

    if not exist "%TERRAFORM_LS_INSTALL_DIR%\terraform-ls.exe" (
        echo ERROR: terraform-ls.exe was not found after extraction.
        set "FAILED=1"
        goto AfterTerraformLs
    )

    del "%TERRAFORM_LS_ZIP%" >nul 2>nul

    echo Checking user PATH for terraform-ls install directory...

    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
      "$ErrorActionPreference = 'Stop';" ^
      "$installDir = '%TERRAFORM_LS_INSTALL_DIR%';" ^
      "$userPath = [Environment]::GetEnvironmentVariable('Path', 'User');" ^
      "if ($null -eq $userPath) { $userPath = '' }" ^
      "$paths = $userPath -split ';' | Where-Object { -not [string]::IsNullOrWhiteSpace($_) };" ^
      "$exists = $false;" ^
      "foreach ($path in $paths) {" ^
      "  if ($path.Trim().TrimEnd('\') -ieq $installDir.TrimEnd('\')) { $exists = $true; break }" ^
      "}" ^
      "if (-not $exists) {" ^
      "  if ([string]::IsNullOrWhiteSpace($userPath)) {" ^
      "    $newPath = $installDir;" ^
      "  } elseif ($userPath.TrimEnd().EndsWith(';')) {" ^
      "    $newPath = $userPath + $installDir;" ^
      "  } else {" ^
      "    $newPath = $userPath + ';' + $installDir;" ^
      "  }" ^
      "  [Environment]::SetEnvironmentVariable('Path', $newPath, 'User');" ^
      "  Write-Host 'Added terraform-ls install directory to the user PATH.';" ^
      "} else {" ^
      "  Write-Host 'terraform-ls install directory is already present in the user PATH.';" ^
      "}"

    if "!ERRORLEVEL!" NEQ "0" (
        echo ERROR: Failed to update the user PATH.
        set "FAILED=1"
        goto AfterTerraformLs
    )

    rem Make terraform-ls available in this script session as well.
    echo !PATH! | findstr /I /C:"%TERRAFORM_LS_INSTALL_DIR%" >nul 2>nul
    if "!ERRORLEVEL!" NEQ "0" (
        set "PATH=!PATH!;%TERRAFORM_LS_INSTALL_DIR%"
    )

    terraform-ls version >nul 2>nul

    if "!ERRORLEVEL!" NEQ "0" (
        echo ERROR: terraform-ls was installed but could not be executed.
        echo You may need to open a new terminal for PATH changes to take effect.
        set "FAILED=1"
    ) else (
        echo terraform-ls installed successfully.
        terraform-ls version
    )
)

:AfterTerraformLs

if "%FAILED%"=="1" (
    echo.
    echo ERROR: One or more package/component installations failed.
    exit /b 1
)

rem ============================================================
rem Editor Extension Checks (VS Code / Cursor)
rem ============================================================

echo.
echo Checking for VS Code...
where code >nul 2>nul
if "%ERRORLEVEL%"=="0" (
    echo VS Code detected, installing extensions...
    call code --install-extension ms-python.python
    call code --install-extension ms-python.vscode-pylance
    call code --install-extension rust-lang.rust-analyzer
    call code --install-extension ms-dotnettools.csharp
    call code --install-extension redhat.vscode-yaml
    call code --install-extension timonwong.shellcheck
    call code --install-extension hashicorp.terraform
) else (
    echo VS Code not found.
)

echo.
echo Checking for Cursor...
where cursor >nul 2>nul
if "%ERRORLEVEL%"=="0" (
    echo Cursor detected, installing extensions...
    call cursor --install-extension ms-python.python
    call cursor --install-extension ms-python.vscode-pylance
    call cursor --install-extension rust-lang.rust-analyzer
    call cursor --install-extension ms-dotnettools.csharp
    call cursor --install-extension redhat.vscode-yaml
    call cursor --install-extension timonwong.shellcheck
    call cursor --install-extension hashicorp.terraform
) else (
    echo Cursor not found.
)

echo.
echo Runtime/package checks completed successfully.
exit /b 0


rem ============================================================
rem Function: EnsureNpmCommand
rem Args:
rem   %~1 = npm package name
rem   %~2 = executable/command expected on PATH
rem ============================================================

:EnsureNpmCommand
set "PACKAGE_NAME=%~1"
set "COMMAND_NAME=%~2"

where "%COMMAND_NAME%" >nul 2>nul

if "%ERRORLEVEL%"=="0" (
    echo %PACKAGE_NAME% already installed.
    exit /b 0
)

echo %PACKAGE_NAME% missing. Installing...

rem IMPORTANT:
rem npm on Windows is normally npm.cmd.
rem Calling a batch/cmd file from another batch file requires CALL,
rem otherwise control flow can break.
call npm install -g "%PACKAGE_NAME%"

if "%ERRORLEVEL%" NEQ "0" (
    echo ERROR: Failed to install %PACKAGE_NAME%.
    set "FAILED=1"
    exit /b 1
)

rem Re-check that the expected executable is now on PATH.
where "%COMMAND_NAME%" >nul 2>nul

if "%ERRORLEVEL%" NEQ "0" (
    echo ERROR: %PACKAGE_NAME% installed, but %COMMAND_NAME% was not found on PATH.
    set "FAILED=1"
    exit /b 1
)

echo %PACKAGE_NAME% installed successfully.
exit /b 0