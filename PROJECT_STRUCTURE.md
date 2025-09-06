# 📁 Project Structure

This document provides a detailed overview of the project structure and organization.

## 🏗️ Root Directory Structure

```
ecom-microservices/
├── 📁 additional/                 # Additional demo projects and examples
├── 📁 configserver/              # Spring Cloud Config Server
├── 📁 deploy/                    # Deployment configurations
├── 📁 eureka/                    # Service Discovery Server
├── 📁 gateway/                   # API Gateway Service
├── 📁 notification/              # Notification Service
├── 📁 order/                     # Order Management Service
├── 📁 product/                   # Product Catalog Service
├── 📁 user/                      # User Management Service
├── 📄 build-all.sh              # Build automation script
├── 📄 start-services.sh          # Service startup script
├── 📄 stop-services.sh           # Service shutdown script
├── 📄 README.md                  # Main project documentation
├── 📄 DEPLOYMENT.md              # Deployment guide
├── 📄 API_DOCUMENTATION.md       # API documentation
├── 📄 PROJECT_STRUCTURE.md       # This file
└── 📄 *.postman_collection.json # Postman API collections
```

## 🔧 Core Microservices

### User Service (`/user`)
```
user/
├── 📁 src/
│   ├── 📁 main/
│   │   ├── 📁 java/com/ecommerce/user/
│   │   │   ├── 📄 UserApplication.java      # Main application class
│   │   │   ├── 📁 controllers/              # REST controllers
│   │   │   ├── 📁 services/                 # Business logic
│   │   │   ├── 📁 repositories/             # Data access layer
│   │   │   ├── 📁 dto/                      # Data transfer objects
│   │   │   ├── 📁 entities/                 # JPA entities
│   │   │   └── 📁 config/                   # Configuration classes
│   │   └── 📁 resources/
│   │       ├── 📄 application.yml           # Application configuration
│   │       └── 📄 application-docker.yml    # Docker configuration
│   └── 📁 test/                             # Unit and integration tests
├── 📄 pom.xml                               # Maven configuration
├── 📄 Dockerfile                            # Container configuration
└── 📄 mvnw, mvnw.cmd                        # Maven wrapper
```

**Key Features:**
- MongoDB integration for user profiles
- OAuth2 integration with Keycloak
- User registration and profile management
- Address management
- User authentication and authorization

### Product Service (`/product`)
```
product/
├── 📁 src/
│   ├── 📁 main/
│   │   ├── 📁 java/com/ecommerce/product/
│   │   │   ├── 📄 ProductApplication.java   # Main application class
│   │   │   ├── 📁 controllers/              # REST controllers
│   │   │   ├── 📁 services/                 # Business logic
│   │   │   ├── 📁 repositories/             # Data access layer
│   │   │   ├── 📁 dtos/                     # Data transfer objects
│   │   │   ├── 📁 entities/                 # JPA entities
│   │   │   └── 📁 config/                   # Configuration classes
│   │   └── 📁 resources/
│   │       ├── 📄 application.yml           # Application configuration
│   │       └── 📄 application-docker.yml    # Docker configuration
│   └── 📁 test/                             # Unit and integration tests
├── 📄 pom.xml                               # Maven configuration
└── 📄 mvnw, mvnw.cmd                        # Maven wrapper
```

**Key Features:**
- PostgreSQL database integration
- Product catalog management
- Search functionality
- Inventory management
- Category-based organization
- Circuit breaker for resilience

### Order Service (`/order`)
```
order/
├── 📁 src/
│   ├── 📁 main/
│   │   ├── 📁 java/com/ecommerce/order/
│   │   │   ├── 📄 OrderApplication.java     # Main application class
│   │   │   ├── 📁 controller/               # REST controllers
│   │   │   ├── 📁 service/                  # Business logic
│   │   │   ├── 📁 repository/               # Data access layer
│   │   │   ├── 📁 dto/                      # Data transfer objects
│   │   │   ├── 📁 entity/                   # JPA entities
│   │   │   ├── 📁 config/                   # Configuration classes
│   │   │   └── 📁 events/                   # Event handling
│   │   └── 📁 resources/
│   │       ├── 📄 application.yml           # Application configuration
│   │       └── 📄 application-docker.yml    # Docker configuration
│   └── 📁 test/                             # Unit and integration tests
├── 📄 pom.xml                               # Maven configuration
└── 📄 mvnw, mvnw.cmd                        # Maven wrapper
```

**Key Features:**
- Shopping cart management
- Order processing workflow
- Kafka integration for events
- PostgreSQL for order data
- Circuit breaker implementation
- Event-driven architecture

### Notification Service (`/notification`)
```
notification/
├── 📁 src/
│   ├── 📁 main/
│   │   ├── 📁 java/com/ecommerce/notification/
│   │   │   ├── 📄 NotificationApplication.java # Main application class
│   │   │   ├── 📁 service/                     # Business logic
│   │   │   ├── 📁 dto/                         # Data transfer objects
│   │   │   ├── 📁 config/                      # Configuration classes
│   │   │   └── 📁 events/                      # Event listeners
│   │   └── 📁 resources/
│   │       ├── 📄 application.yml              # Application configuration
│   │       └── 📄 application-docker.yml       # Docker configuration
│   └── 📁 test/                                # Unit and integration tests
├── 📄 pom.xml                                  # Maven configuration
├── 📄 Dockerfile                               # Container configuration
└── 📄 mvnw, mvnw.cmd                           # Maven wrapper
```

**Key Features:**
- Kafka event consumption
- Email/SMS notification handling
- Event-driven processing
- Asynchronous message processing

## 🌐 Infrastructure Services

### API Gateway (`/gateway`)
```
gateway/
├── 📁 src/
│   ├── 📁 main/
│   │   ├── 📁 java/com/ecommerce/gateway/
│   │   │   ├── 📄 GatewayApplication.java   # Main application class
│   │   │   ├── 📁 config/                   # Configuration classes
│   │   │   ├── 📁 filter/                   # Custom filters
│   │   │   └── 📄 FallbackController.java   # Fallback handling
│   │   └── 📁 resources/
│   │       ├── 📄 application.yml           # Application configuration
│   │       └── 📄 application-docker.yml    # Docker configuration
│   └── 📁 test/                             # Unit and integration tests
├── 📄 pom.xml                               # Maven configuration
└── 📄 mvnw, mvnw.cmd                        # Maven wrapper
```

**Key Features:**
- Spring Cloud Gateway
- OAuth2 resource server
- Rate limiting with Redis
- Circuit breaker integration
- Request/response transformation
- Load balancing

### Service Discovery (`/eureka`)
```
eureka/
├── 📁 src/
│   ├── 📁 main/
│   │   ├── 📁 java/com/ecommerce/eureka/
│   │   │   └── 📄 EurekaApplication.java    # Main application class
│   │   └── 📁 resources/
│   │       └── 📄 application.yml           # Application configuration
│   └── 📁 test/                             # Unit and integration tests
├── 📄 pom.xml                               # Maven configuration
└── 📄 mvnw, mvnw.cmd                        # Maven wrapper
```

**Key Features:**
- Netflix Eureka server
- Service registration and discovery
- Health check monitoring
- Service registry dashboard

### Configuration Server (`/configserver`)
```
configserver/
├── 📁 src/
│   ├── 📁 main/
│   │   ├── 📁 java/com/ecommerce/configserver/
│   │   │   └── 📄 ConfigserverApplication.java # Main application class
│   │   └── 📁 resources/
│   │       ├── 📄 application.yml              # Server configuration
│   │       └── 📁 config/                      # Service configurations
│   │           ├── 📄 gateway-service.yml      # Gateway config
│   │           ├── 📄 gateway-service-docker.yml
│   │           ├── 📄 user-service.yml         # User service config
│   │           ├── 📄 user-service-docker.yml
│   │           ├── 📄 product-service.yml      # Product service config
│   │           ├── 📄 product-service-docker.yml
│   │           ├── 📄 order-service.yml        # Order service config
│   │           └── 📄 order-service-docker.yml
│   └── 📁 test/                                # Unit and integration tests
├── 📄 pom.xml                                  # Maven configuration
└── 📄 mvnw, mvnw.cmd                           # Maven wrapper
```

**Key Features:**
- Spring Cloud Config Server
- Environment-specific configurations
- Configuration refresh via Spring Cloud Bus
- Encrypted property support
- Git-based configuration (optional)

## 🚀 Deployment Configuration (`/deploy`)

```
deploy/
└── 📁 docker/
    ├── 📄 docker-compose.yml           # Main compose file
    ├── 📄 .env.sample                  # Environment variables template
    ├── 📄 init-multi-db.sql            # Database initialization
    ├── 📁 grafana/                     # Grafana configuration
    ├── 📁 logging/                     # Loki and Alloy configuration
    └── 📁 prometheus/                  # Prometheus configuration
```

**Key Features:**
- Complete Docker Compose setup
- Multi-database initialization
- Monitoring stack (Prometheus, Grafana, Loki)
- Distributed tracing with Zipkin
- Message brokers (Kafka, RabbitMQ)
- Identity management (Keycloak)

## 📚 Additional Projects (`/additional`)

```
additional/
├── 📁 ecom-application/             # Monolithic version
├── 📁 config-mgmt/                  # Configuration management demos
├── 📁 kafka/                        # Kafka producer/consumer examples
├── 📁 keycloak/                     # OAuth2 flow demonstrations
├── 📁 interservice/                 # Service communication examples
├── 📁 evaluate-loki/                # Loki evaluation setup
├── 📁 evaluate-prometheus/          # Prometheus evaluation setup
└── 📁 FirstSpring/                  # Basic Spring Boot example
```

**Key Features:**
- Learning examples and tutorials
- OAuth2 flow implementations
- Kafka integration examples
- Service communication patterns
- Monitoring stack evaluations

## 🧪 Testing Structure

Each service includes:
```
src/test/java/
├── 📁 unit/                         # Unit tests
├── 📁 integration/                  # Integration tests
├── 📁 controller/                   # Controller tests
└── 📁 service/                      # Service layer tests
```

**Testing Features:**
- JUnit 5 test framework
- Mockito for mocking
- Spring Boot Test slices
- TestContainers for integration tests
- MockMvc for web layer testing

## 📊 Monitoring and Observability

### Metrics Collection
- **Micrometer** - Application metrics
- **Prometheus** - Metrics storage and querying
- **Grafana** - Visualization and dashboards

### Distributed Tracing
- **Zipkin** - Request tracing across services
- **Spring Cloud Sleuth** - Automatic trace instrumentation

### Log Aggregation
- **Loki** - Log aggregation and querying
- **Grafana Alloy** - Log collection agent
- **Structured logging** - JSON format logs

### Health Monitoring
- **Spring Boot Actuator** - Health endpoints
- **Custom health indicators** - Database and external service checks
- **Circuit breaker metrics** - Resilience monitoring

## 🔐 Security Architecture

### Authentication & Authorization
- **Keycloak** - Identity and access management
- **OAuth2 + PKCE** - Secure authentication flows
- **JWT tokens** - Stateless authentication
- **Role-based access control** - Fine-grained permissions

### API Security
- **Spring Security** - Method-level security
- **CORS configuration** - Cross-origin resource sharing
- **Rate limiting** - API abuse protection
- **Input validation** - Request data validation

## 📦 Build and Packaging

### Maven Configuration
- **Multi-module structure** - Independent service builds
- **Spring Boot Maven Plugin** - Executable JAR creation
- **Jib Maven Plugin** - Container image building
- **Lombok annotation processing** - Code generation

### Container Strategy
- **Multi-stage Dockerfiles** - Optimized images
- **Distroless base images** - Security and size optimization
- **Health checks** - Container health monitoring
- **Resource limits** - Memory and CPU constraints

## 🌐 Communication Patterns

### Synchronous Communication
- **REST APIs** - HTTP-based service communication
- **Spring Cloud OpenFeign** - Declarative REST clients
- **Load balancing** - Client-side load balancing
- **Circuit breakers** - Fault tolerance

### Asynchronous Communication
- **Apache Kafka** - Event streaming
- **RabbitMQ** - Message queuing
- **Spring Cloud Stream** - Message-driven microservices
- **Event-driven architecture** - Loose coupling

## 📈 Scalability Considerations

### Horizontal Scaling
- **Stateless services** - Easy horizontal scaling
- **Load balancing** - Traffic distribution
- **Database per service** - Independent scaling
- **Caching strategies** - Performance optimization

### Performance Optimization
- **Connection pooling** - Database connection management
- **JVM tuning** - Memory and garbage collection optimization
- **Async processing** - Non-blocking operations
- **CDN integration** - Static asset delivery

---

This structure demonstrates a production-ready microservices architecture with comprehensive observability, security, and deployment automation - perfect for showcasing enterprise-level development skills! 🚀
