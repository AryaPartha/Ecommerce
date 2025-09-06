# 🛒 E-Commerce Microservices Platform

[![Build Status](https://github.com/codergoel/ecommerce-microservices-platform/workflows/🚀%20CI%2FCD%20Pipeline/badge.svg)](https://github.com/codergoel/ecommerce-microservices-platform/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Java](https://img.shields.io/badge/Java-21-orange.svg)](https://openjdk.java.net/projects/jdk/21/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.4+-green.svg)](https://spring.io/projects/spring-boot)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue.svg)](https://www.docker.com/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-Ready-blue.svg)](https://kubernetes.io/)

A comprehensive, production-ready e-commerce platform built with Spring Boot microservices architecture, featuring advanced patterns like API Gateway, Service Discovery, Configuration Management, Circuit Breakers, and Event-Driven Architecture.

## 🏗️ Architecture Overview

This project demonstrates a complete microservices ecosystem with the following services:

### Core Business Services
- **User Service** - User management and authentication
- **Product Service** - Product catalog and inventory management  
- **Order Service** - Order processing and management
- **Notification Service** - Event-driven notifications

### Infrastructure Services
- **API Gateway** - Single entry point with routing, security, and rate limiting
- **Service Discovery (Eureka)** - Service registration and discovery
- **Configuration Server** - Centralized configuration management
- **Monitoring & Observability** - Distributed tracing, metrics, and logging

## 🛠️ Technology Stack

### Backend Technologies
- **Java 21** - Latest LTS version with modern features
- **Spring Boot 3.4+** - Latest Spring Boot with native compilation support
- **Spring Cloud 2024.0** - Microservices patterns and tools
- **Spring Security + OAuth2** - Authentication and authorization
- **Spring Data JPA/MongoDB** - Data persistence layers

### Infrastructure & DevOps
- **Docker & Docker Compose** - Containerization and orchestration
- **PostgreSQL** - Relational database for transactional data
- **MongoDB** - NoSQL database for user profiles
- **Apache Kafka** - Event streaming and messaging
- **RabbitMQ** - Message broker for internal communication

### Monitoring & Observability
- **Prometheus** - Metrics collection and monitoring
- **Grafana** - Visualization and dashboards
- **Loki** - Log aggregation and analysis
- **Zipkin** - Distributed tracing
- **Spring Boot Actuator** - Health checks and metrics

### Security & Authentication
- **Keycloak** - Identity and access management
- **OAuth2 + PKCE** - Secure authentication flows
- **JWT Tokens** - Stateless authentication
- **Spring Security** - Method-level security

## 🚀 Quick Start

### Prerequisites
- Java 21+ (OpenJDK recommended)
- Docker & Docker Compose
- Maven 3.8+
- Git

### 1. Clone the Repository
```bash
git clone <your-repo-url>
cd ecom-microservices
```

### 2. Start Infrastructure Services
```bash
cd deploy/docker
docker-compose up -d postgres mongo keycloak kafka zookeeper rabbitmq zipkin
```

### 3. Build All Services
```bash
# Build all microservices
./mvnw clean package -DskipTests

# Or build individual services
cd user && ./mvnw clean package -DskipTests
cd product && ./mvnw clean package -DskipTests
cd order && ./mvnw clean package -DskipTests
cd gateway && ./mvnw clean package -DskipTests
cd eureka && ./mvnw clean package -DskipTests
cd configserver && ./mvnw clean package -DskipTests
cd notification && ./mvnw clean package -DskipTests
```

### 4. Start Core Services (In Order)
```bash
# 1. Start Config Server
cd configserver && ./mvnw spring-boot:run

# 2. Start Eureka Server
cd eureka && ./mvnw spring-boot:run

# 3. Start Business Services
cd user && ./mvnw spring-boot:run
cd product && ./mvnw spring-boot:run
cd order && ./mvnw spring-boot:run
cd notification && ./mvnw spring-boot:run

# 4. Start API Gateway
cd gateway && ./mvnw spring-boot:run
```

### 5. Docker Deployment (Recommended)
```bash
cd deploy/docker
docker-compose up -d
```

## 📱 Service Endpoints

### API Gateway (Port 8080)
- **Base URL**: `http://localhost:8080`
- All microservice APIs are accessible through the gateway

### Individual Services (Development)
- **User Service**: `http://localhost:8082`
- **Product Service**: `http://localhost:8081`
- **Order Service**: `http://localhost:8083`
- **Eureka Dashboard**: `http://localhost:8761`
- **Config Server**: `http://localhost:8888`

### Infrastructure Services
- **Keycloak Admin**: `http://localhost:8443` (admin/admin)
- **Zipkin Tracing**: `http://localhost:9411`
- **Grafana**: `http://localhost:3000` (admin/admin)
- **Prometheus**: `http://localhost:9090`
- **RabbitMQ Management**: `http://localhost:15672` (guest/guest)
- **PgAdmin**: `http://localhost:5050` (pgadmin4@pgadmin.org/admin)

## 📊 API Documentation

### User Service APIs
```http
# Get all users
GET /api/users

# Get user by ID
GET /api/users/{id}

# Create user
POST /api/users
Content-Type: application/json
{
  "firstName": "John",
  "lastName": "Doe",
  "email": "john@example.com",
  "phone": "1234567890",
  "address": {
    "street": "123 Main St",
    "city": "New York",
    "state": "NY",
    "country": "USA",
    "zipcode": "10001"
  }
}

# Update user
PUT /api/users/{id}
```

### Product Service APIs
```http
# Get all products
GET /api/products

# Get product by ID
GET /api/products/{id}

# Create product
POST /api/products
Content-Type: application/json
{
  "name": "iPhone 16 Pro",
  "description": "Latest iPhone with amazing features",
  "price": 1099.99,
  "stockQuantity": 50,
  "category": "Electronics",
  "imageUrl": "https://example.com/image.jpg"
}

# Search products
GET /api/products/search?keyword=iphone
```

### Order Service APIs
```http
# Place order
POST /api/orders
Headers: X-User-ID: {userId}

# Get user's cart
GET /api/cart
Headers: X-User-ID: {userId}

# Add to cart
POST /api/cart
Headers: X-User-ID: {userId}
Content-Type: application/json
{
  "productId": "1",
  "quantity": 2
}
```

## 🎯 Key Features Implemented

### Microservices Patterns
- **API Gateway Pattern** - Single entry point for all client requests
- **Service Discovery** - Automatic service registration and discovery
- **Configuration Management** - Centralized configuration with refresh capabilities
- **Circuit Breaker** - Fault tolerance and resilience
- **Event-Driven Architecture** - Asynchronous communication via Kafka
- **Database per Service** - Data isolation and independence

### Security Features
- **OAuth2 + PKCE Flow** - Secure authentication for web and mobile
- **JWT Token Authentication** - Stateless security
- **Role-Based Access Control** - Fine-grained authorization
- **API Rate Limiting** - Protection against abuse
- **CORS Configuration** - Cross-origin resource sharing

### Observability & Monitoring
- **Distributed Tracing** - Request tracking across services
- **Metrics Collection** - Prometheus integration
- **Log Aggregation** - Centralized logging with Loki
- **Health Checks** - Comprehensive service health monitoring
- **Performance Monitoring** - Application and infrastructure metrics

### Data Management
- **Polyglot Persistence** - MongoDB for users, PostgreSQL for transactional data
- **Event Sourcing** - Order events for audit trail
- **CQRS Pattern** - Command and Query separation
- **Database Migrations** - Version-controlled schema changes

## 🔄 Event-Driven Architecture

### Kafka Topics
- **order-events** - Order lifecycle events (created, updated, cancelled)
- **notification-events** - Notification triggers
- **user-events** - User registration and profile updates

### Event Flow Examples
1. **Order Placed** → Kafka → Notification Service → Email/SMS
2. **User Registered** → Kafka → Welcome Email + Profile Setup
3. **Product Stock Updated** → Cache Invalidation → Real-time Updates

## 🛡️ Resilience Patterns

### Circuit Breaker Implementation
- **Resilience4j** integration across all services
- **Fallback methods** for graceful degradation
- **Bulkhead pattern** for resource isolation
- **Configurable thresholds** and recovery times

### Retry & Timeout Strategies
- **Exponential backoff** for transient failures
- **Configurable retry policies** per service
- **Timeout configurations** for external calls
- **Dead letter queues** for failed messages

## 🐳 Container & Deployment

### Docker Configuration
- **Multi-stage builds** for optimized images
- **Distroless base images** for security
- **Health checks** integrated in containers
- **Resource limits** and constraints

### Environment Configurations
- **Development** - Local development with hot reload
- **Docker** - Containerized deployment
- **Production** - Kubernetes-ready configurations

## 🧪 Testing Strategy

### Included Test Types
- **Unit Tests** - JUnit 5 with Mockito
- **Integration Tests** - Spring Boot Test slices
- **Contract Tests** - API contract verification
- **End-to-End Tests** - Postman collections included

### Test Coverage
- **Service Layer Testing** - Business logic validation
- **Repository Testing** - Data access layer testing
- **Controller Testing** - API endpoint testing
- **Security Testing** - Authentication and authorization

## 📈 Performance Optimizations

### Caching Strategy
- **Redis caching** for frequently accessed data
- **Application-level caching** with Spring Cache
- **Database query optimization** and indexing

### Load Balancing
- **Client-side load balancing** with Spring Cloud LoadBalancer
- **Health-check based routing**
- **Weighted routing** capabilities

## 🎯 Resume Highlights

This project demonstrates expertise in:

### Technical Skills
- **Microservices Architecture** - Complete implementation with best practices
- **Spring Boot & Spring Cloud** - Latest versions with modern features
- **Event-Driven Architecture** - Kafka integration and messaging patterns
- **Security Implementation** - OAuth2, JWT, and comprehensive security
- **Container Technologies** - Docker, Docker Compose, Kubernetes-ready
- **Database Design** - Multi-database architecture and optimization
- **API Design** - RESTful APIs with proper documentation
- **Monitoring & Observability** - Complete observability stack

### Architecture Patterns
- **API Gateway Pattern** - Centralized routing and security
- **Service Discovery** - Automatic service registration
- **Configuration Management** - Externalized configuration
- **Circuit Breaker** - Fault tolerance and resilience
- **Event Sourcing** - Audit trail and event-driven design
- **CQRS** - Command Query Responsibility Segregation

### DevOps & Cloud
- **Containerization** - Docker and container orchestration
- **Infrastructure as Code** - Docker Compose configurations
- **Monitoring Stack** - Prometheus, Grafana, Loki, Zipkin
- **CI/CD Ready** - Build and deployment automation
- **Cloud-Native** - 12-factor app principles

### Quality Assurance
- **Comprehensive Testing** - Unit, integration, and E2E tests
- **Code Quality** - SonarQube integration ready
- **Security Scanning** - Dependency vulnerability checks
- **Performance Testing** - Load testing configurations

## 🚀 Getting Started for Development

### IDE Setup
1. **IntelliJ IDEA** or **VS Code** with Java extensions
2. **Lombok plugin** for annotation processing
3. **Docker Desktop** for container management

### Development Workflow
1. **Start infrastructure** - `docker-compose up -d` (databases, Kafka, etc.)
2. **Run services individually** - Use IDE or Maven commands
3. **Test with Postman** - Import provided collections
4. **Monitor with tools** - Grafana, Zipkin, Eureka dashboard

### Environment Variables
Create `.env` file in `deploy/docker/`:
```env
DB_USER=embarkx
DB_PASSWORD=embarkx
MONGO_URI=mongodb://localhost:27017
RABBITMQ_HOST=localhost
RABBITMQ_PORT=5672
RABBITMQ_USERNAME=guest
RABBITMQ_PASSWORD=guest
RABBITMQ_VHOST=guest
ZIPKIN_URL=http://zipkin:9411
```

## 📞 Contact Information

- **LinkedIn**: [Your LinkedIn Profile]
- **GitHub**: [Your GitHub Profile]  
- **Email**: [your.email@example.com]
- **Portfolio**: [Your Portfolio Website]

---

⭐ **Star this repository** if you find it helpful for your learning or projects!

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.