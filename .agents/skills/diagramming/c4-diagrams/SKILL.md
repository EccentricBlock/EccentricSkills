---
name: c4-diagrams
description: Guide for creating, understanding, and updating MermaidJS C4 diagrams (Context, Container, Component, and Deployment levels).
disable-model-invocation: true
title: "C4 Diagrams"
category: documentation
tags: ["documentation", "architecture", "mermaid", "c4"]
version: "1.0"
---


# C4 Mermaid Diagramming

## Workflow
1. **Scope**: Determine C4 level by audience.
2. **Analyze**: Identify components, containers, and relationships.
3. **Generate**: Create Mermaid C4 syntax.
4. **Document**: Write to markdown with context.

## Core Syntax & Configuration

### Structure
```mermaid
diagramType
  definition content
```

- `%%` for comments.
- Parameters fail silently; unknown words break diagrams.

### Frontmatter Config
```mermaid
---
config:
  theme: dark
---
flowchart TD
    A --> B
```

### Options
- **Themes**: `default`, `forest`, `dark`, `neutral`, `base`.
- **Layouts**: `dagre` (default), `elk`, `tidy-tree`, `cose-bilkent`.
- **Look**: `classic`, `handDrawn`.

## C4 Diagram Levels

| Level | Type | Audience | Focus | Requirement |
|-------|-------------|----------|-------|----------------|
| 1 | **C4Context** | Everyone | System + external actors | Required |
| 2 | **C4Container** | Technical | Apps, databases, services | Required |
| 3 | **C4Component** | Developers | Internal components | Optional |
| 4 | **C4Deployment** | DevOps | Infrastructure nodes | Production |
| - | **C4Dynamic** | Technical | Numbered request flows | Complex flows |

## C4 Elements

### System Context
- `Person(alias, label, ?descr)`
- `Person_Ext(alias, label, ?descr)`
- `System(alias, label, ?descr)`
- `System_Ext(alias, label, ?descr)`
- `SystemDb(alias, label, ?descr)`
- `SystemDb_Ext(alias, label, ?descr)`
- `SystemQueue(alias, label, ?descr)`
- `SystemQueue_Ext(alias, label, ?descr)`

### Containers
- `Container(alias, label, ?techn, ?descr)`
- `Container_Ext(alias, label, ?techn, ?descr)`
- `ContainerDb(alias, label, ?techn, ?descr)`
- `ContainerDb_Ext(alias, label, ?techn, ?descr)`
- `ContainerQueue(alias, label, ?techn, ?descr)`
- `ContainerQueue_Ext(alias, label, ?techn, ?descr)`

### Components
- `Component(alias, label, ?techn, ?descr)`
- `Component_Ext(alias, label, ?techn, ?descr)`
- `ComponentDb(alias, label, ?techn, ?descr)`
- `ComponentDb_Ext(alias, label, ?techn, ?descr)`
- `ComponentQueue(alias, label, ?techn, ?descr)`
- `ComponentQueue_Ext(alias, label, ?techn, ?descr)`

### Deployment
- `Deployment_Node(alias, label, ?type, ?descr) { ... }`
- `Node(alias, label, ?type, ?descr) { ... }`
- `Node_L(alias, label, ?type, ?descr) { ... }`
- `Node_R(alias, label, ?type, ?descr) { ... }`

## C4 Relationships

### Basic & Bidirectional
- `Rel(from, to, label, ?techn, ?descr)`
- `BiRel(from, to, label, ?techn)`

### Directional
- `Rel_U` / `Rel_Up` (Up)
- `Rel_D` / `Rel_Down` (Down)
- `Rel_L` / `Rel_Left` (Left)
- `Rel_R` / `Rel_Right` (Right)
- `Rel_Back(from, to, label)`

### Dynamic
- `RelIndex(index, from, to, label)` (Index ignored; order is sequential).

## C4 Boundaries
- `Enterprise_Boundary(alias, label) { ... }`
- `System_Boundary(alias, label) { ... }`
- `Container_Boundary(alias, label) { ... }`
- `Boundary(alias, label, ?type) { ... }`

## Styling & Layout

### Element Style
`UpdateElementStyle(elementAlias, $bgColor, $fontColor, $borderColor, $shadowing, $shape)`

### Relationship Style
`UpdateRelStyle(from, to, $textColor, $lineColor, $offsetX, $offsetY)`

### Layout Config
`UpdateLayoutConfig($c4ShapeInRow, $c4BoundaryInRow)`
- `$c4ShapeInRow`: Default 4.
- `$c4BoundaryInRow`: Default 2.

### Parameter Syntax
- **Positional**: `Rel(a, b, "label", "tech")`
- **Named**: `UpdateRelStyle(a, b, $offsetX="-40", $lineColor="blue")`

## Examples

### C4Context
```mermaid
C4Context
  title System Context - Internet Banking
  Enterprise_Boundary(b0, "Bank") {
    Person(customer, "Banking Customer", "A customer with bank accounts")
    System(bankingSystem, "Internet Banking System", "View accounts and make payments")
    Enterprise_Boundary(b1, "Internal Systems") {
      SystemDb_Ext(mainframe, "Mainframe", "Core banking data")
      System_Ext(email, "E-mail System", "Microsoft Exchange")
    }
  }
  BiRel(customer, bankingSystem, "Uses")
  Rel(bankingSystem, mainframe, "Reads/writes", "JDBC")
  Rel(bankingSystem, email, "Sends emails", "SMTP")
  Rel(email, customer, "Sends emails to")
  UpdateLayoutConfig($c4ShapeInRow="3", $c4BoundaryInRow="1")
```

### C4Container
```mermaid
C4Container
  title Container - Internet Banking
  Person(customer, "Customer", "Bank customer")
  System_Ext(email, "E-Mail System", "Exchange")
  System_Ext(mainframe, "Mainframe", "Core banking")
  Container_Boundary(c1, "Internet Banking") {
    Container(spa, "Single-Page App", "Angular", "UI")
    Container(mobile, "Mobile App", "Xamarin", "Mobile")
    Container(api, "API Application", "Spring MVC", "API")
    ContainerDb(db, "Database", "SQL Server", "User data")
  }
  Rel(customer, spa, "Uses", "HTTPS")
  Rel(customer, mobile, "Uses")
  Rel(spa, api, "Uses", "JSON/HTTPS")
  Rel(mobile, api, "Uses", "JSON/HTTPS")
  Rel(api, db, "Reads/writes", "JDBC")
  Rel(api, mainframe, "Uses", "XML/HTTPS")
  Rel(api, email, "Sends emails", "SMTP")
```

### C4Component
```mermaid
C4Component
  title Component - API Application
  Container(spa, "Single Page App", "Angular", "UI")
  ContainerDb(db, "Database", "SQL Server", "User data")
  System_Ext(mainframe, "Mainframe", "Core banking")
  Container_Boundary(api, "API Application") {
    Component(signIn, "Sign In Controller", "Spring MVC", "Auth")
    Component(accounts, "Accounts Controller", "Spring MVC", "Ops")
    Component(security, "Security Component", "Spring Bean", "Logic")
    Component(facade, "Mainframe Facade", "Spring Bean", "Integration")
  }
  Rel(spa, signIn, "Uses", "JSON/HTTPS")
  Rel(spa, accounts, "Uses", "JSON/HTTPS")
  Rel(signIn, security, "Uses")
  Rel(accounts, facade, "Uses")
  Rel(security, db, "Reads/writes", "JDBC")
  Rel(facade, mainframe, "Uses", "XML/HTTPS")
```

### C4Dynamic
```mermaid
C4Dynamic
  title Dynamic - User Sign In Flow
  ContainerDb(db, "Database", "SQL Server", "Credentials")
  Container(spa, "Single-Page App", "Angular", "UI")
  Container_Boundary(api, "API Application") {
    Component(signIn, "Sign In Controller", "Spring MVC", "Endpoint")
    Component(security, "Security Component", "Spring Bean", "Validation")
  }
  Rel(spa, signIn, "1. Submit credentials", "JSON/HTTPS")
  Rel(signIn, security, "2. Validate")
  Rel(security, db, "3. Query user", "JDBC")
```

### C4Deployment
```mermaid
C4Deployment
  title Deployment - Production
  Deployment_Node(mobile, "Customer's Mobile", "iOS/Android") {
    Container(mobileApp, "Mobile App", "Xamarin", "Mobile banking")
  }
  Deployment_Node(browser, "Customer's Browser", "Chrome/Firefox") {
    Container(spa, "SPA", "Angular", "Web banking")
  }
  Deployment_Node(dc, "Data Center", "AWS") {
    Deployment_Node(web, "Web Tier", "EC2") {
      Container(api, "API", "Spring Boot", "Banking API")
    }
    Deployment_Node(data, "Data Tier", "RDS") {
      ContainerDb(db, "Database", "PostgreSQL", "Banking data")
    }
  }
  Rel(mobileApp, api, "API calls", "HTTPS")
  Rel(spa, api, "API calls", "HTTPS")
  Rel(api, db, "Reads/writes", "JDBC")
```

### E-commerce Microservices
```mermaid
C4Container
  title E-commerce Platform
  Person(customer, "Customer", "Shopper")
  Person(admin, "Admin", "Manager")
  System_Ext(payment, "Stripe", "Payment")
  System_Ext(shipping, "FedEx API", "Shipping")
  Container_Boundary(platform, "E-commerce Platform") {
    Container(web, "Web App", "React", "Storefront")
    Container(adminApp, "Admin Portal", "React", "Management")
    Container(gateway, "API Gateway", "Kong", "Routing")
    Container(orderSvc, "Order Service", "Node.js", "Processing")
    Container(productSvc, "Product Service", "Go", "Catalog")
    Container(userSvc, "User Service", "Java", "Auth")
    ContainerDb(orderDb, "Order DB", "PostgreSQL", "Orders")
    ContainerDb(productDb, "Product DB", "MongoDB", "Products")
    ContainerDb(userDb, "User DB", "PostgreSQL", "Users")
    ContainerDb(cache, "Cache", "Redis", "Session")
  }
  Rel(customer, web, "Browses", "HTTPS")
  Rel(admin, adminApp, "Manages", "HTTPS")
  Rel(web, gateway, "API calls", "JSON/HTTPS")
  Rel(adminApp, gateway, "API calls", "JSON/HTTPS")
  Rel(gateway, orderSvc, "Routes to", "HTTP")
  Rel(gateway, productSvc, "Routes to", "HTTP")
  Rel(gateway, userSvc, "Routes to", "HTTP")
  Rel(orderSvc, orderDb, "Reads/writes", "SQL")
  Rel(productSvc, productDb, "Reads/writes", "MongoDB")
  Rel(userSvc, userDb, "Reads/writes", "SQL")
  Rel(userSvc, cache, "Caches sessions", "Redis")
  Rel(orderSvc, payment, "Charges cards", "REST")
  Rel(orderSvc, shipping, "Gets rates", "REST")
  UpdateLayoutConfig($c4ShapeInRow="4", $c4BoundaryInRow="1")
```

### Event-Driven Architecture
```mermaid
C4Container
  title Event-Driven Order Processing
  Container(orderSvc, "Order Service", "Java", "Accepts orders")
  Container(inventorySvc, "Inventory Service", "Go", "Stock")
  Container(paymentSvc, "Payment Service", "Node.js", "Payments")
  Container(notificationSvc, "Notification Service", "Python", "Alerts")
  ContainerQueue(orderCreated, "order.created", "Kafka", "Events")
  ContainerQueue(paymentProcessed, "payment.processed", "Kafka", "Events")
  ContainerQueue(orderFulfilled, "order.fulfilled", "Kafka", "Events")
  Rel(orderSvc, orderCreated, "Publishes", "Avro")
  Rel(inventorySvc, orderCreated, "Consumes", "Avro")
  Rel(paymentSvc, orderCreated, "Consumes", "Avro")
  Rel(paymentSvc, paymentProcessed, "Publishes", "Avro")
  Rel(orderSvc, paymentProcessed, "Consumes", "Avro")
  Rel(inventorySvc, orderFulfilled, "Publishes", "Avro")
  Rel(notificationSvc, orderFulfilled, "Consumes", "Avro")
  UpdateLayoutConfig($c4ShapeInRow="4")
```

### AWS Deployment
```mermaid
C4Deployment
  title Production Deployment - AWS

  Deployment_Node(cdn, "CloudFront", "CDN") {
    Container(static, "Static Assets", "S3", "HTML/CSS/JS")
  }

  Deployment_Node(vpc, "VPC", "10.0.0.0/16") {
    Deployment_Node(publicSubnet, "Public Subnet", "10.0.1.0/24") {
      Deployment_Node(alb, "Application Load Balancer", "ALB") {
        Container(lb, "Load Balancer", "AWS ALB", "Routes traffic")
      }
    }

    Deployment_Node(privateSubnet, "Private Subnet", "10.0.2.0/24") {
      Deployment_Node(ecs, "ECS Cluster", "Fargate") {
        Container(api1, "API Instance 1", "Node.js", "REST API")
        Container(api2, "API Instance 2", "Node.js", "REST API")
      }

      Deployment_Node(rds, "RDS", "Multi-AZ") {
        ContainerDb(primary, "Primary DB", "PostgreSQL", "Main database")
        ContainerDb(replica, "Read Replica", "PostgreSQL", "Read scaling")
      }
    }
  }

  Rel(cdn, alb, "Forwards requests", "HTTPS")
  Rel(lb, api1, "Routes to", "HTTP")
  Rel(lb, api2, "Routes to", "HTTP")
  Rel(api1, primary, "Writes to", "JDBC")
  Rel(api2, replica, "Reads from", "JDBC")
```

## Mermaid Limitations
Unsupported PlantUML C4 features:
- `sprite`, `tags`, `link`, `Legend`
- `AddElementTag`, `AddRelTag`
- `RoundedBoxShape`, `EightSidedShape`
- `DashedLine`, `DottedLine`, `BoldLine`
- Layout directives (`Lay_U`, `Lay_D`, `Lay_L`, `Lay_R`)

## Best Practices
- **Iterate**: Start simple $\rightarrow$ add detail.
- **Completeness**: Include Name, Type, Technology, and Description for every element.
- **Precision**: Use `%%` comments, technology labels (e.g., "gRPC"), and action verbs for arrows.
- **Clarity**: Use titles, meaningful aliases, and concise descriptions (<50 chars).
- **Complexity**: Keep <20 elements per diagram; split if needed. One diagram per file.

## Common Pitfalls
- Avoid `{}` in comments.
- Validate syntax in Mermaid Live.
- Ensure all critical relationships are documented.

## References
- `references/c4-syntax.md` - Syntax reference.
- `references/common-pitfalls.md` - Anti-patterns.
- `references/advanced-patterns.md` - Microservices/Event-driven/Deployment.
