# 🚀 Deployment Guide

This guide provides step-by-step instructions for deploying the E-Commerce Microservices Platform.

## 📋 Prerequisites

### System Requirements
- **Java 21+** (OpenJDK recommended)
- **Maven 3.8+**
- **Docker & Docker Compose**
- **Git**
- **8GB+ RAM** (for running all services)

### Port Requirements
Ensure the following ports are available:
- **8080** - API Gateway
- **8081** - Product Service
- **8082** - User Service  
- **8083** - Order Service
- **8761** - Eureka Server
- **8888** - Config Server
- **8443** - Keycloak
- **5432** - PostgreSQL
- **27017** - MongoDB
- **9092** - Kafka
- **5672** - RabbitMQ
- **9411** - Zipkin
- **3000** - Grafana
- **9090** - Prometheus

## 🐳 Option 1: Docker Deployment (Recommended)

### Step 1: Clone Repository
```bash
git clone <your-repo-url>
cd ecom-microservices
```

### Step 2: Create Environment File
```bash
cd deploy/docker
cp .env.sample .env
# Edit .env file with your configurations
```

### Step 3: Start All Services
```bash
docker-compose up -d
```

### Step 4: Verify Deployment
```bash
# Check service health
docker-compose ps

# View logs
docker-compose logs -f gateway-service
```

### Step 5: Access Applications
- **API Gateway**: http://localhost:8080
- **Eureka Dashboard**: http://localhost:8761
- **Keycloak**: http://localhost:8443 (admin/admin)
- **Grafana**: http://localhost:3000
- **Zipkin**: http://localhost:9411

## 🛠️ Option 2: Local Development Deployment

### Step 1: Start Infrastructure Services
```bash
cd deploy/docker
docker-compose up -d postgres mongo keycloak kafka zookeeper rabbitmq zipkin
```

### Step 2: Build All Services
```bash
cd ../..
./build-all.sh
```

### Step 3: Start Services
```bash
./start-services.sh
```

### Step 4: Stop Services (when needed)
```bash
./stop-services.sh
```

## ☸️ Option 3: Kubernetes Deployment

### Prerequisites
- Kubernetes cluster (local or cloud)
- kubectl configured
- Helm 3.x (optional)

### Step 1: Create Namespace
```bash
kubectl create namespace ecommerce
```

### Step 2: Deploy Infrastructure
```bash
# Deploy databases and messaging
kubectl apply -f k8s/infrastructure/

# Wait for infrastructure to be ready
kubectl wait --for=condition=ready pod -l app=postgres -n ecommerce --timeout=300s
```

### Step 3: Deploy Configuration
```bash
kubectl apply -f k8s/config/
```

### Step 4: Deploy Services
```bash
kubectl apply -f k8s/services/
```

### Step 5: Deploy Gateway
```bash
kubectl apply -f k8s/gateway/
```

## 🔧 Configuration Management

### Environment-Specific Configurations

#### Development
```yaml
spring:
  profiles:
    active: dev
```

#### Docker
```yaml
spring:
  profiles:
    active: docker
```

#### Production
```yaml
spring:
  profiles:
    active: prod
```

### External Configuration
All services use Spring Cloud Config Server for centralized configuration:
- Configuration files are in `configserver/src/main/resources/config/`
- Environment-specific configs: `{service-name}-{profile}.yml`
- Common configs: `{service-name}.yml`

## 🔐 Security Setup

### Keycloak Configuration

1. **Access Keycloak Admin Console**
   - URL: http://localhost:8443
   - Username: admin
   - Password: admin

2. **Import Realm Configuration**
   ```bash
   # Import realm from backup
   # File: additional/keycloak/keycloak-backups/realm-export-ecom-app.json
   ```

3. **Create Test Users**
   ```bash
   # Use Keycloak Admin API or UI to create users
   # Default test user: user/user
   ```

### OAuth2 Client Configuration
```yaml
spring:
  security:
    oauth2:
      resourceserver:
        jwt:
          issuer-uri: http://localhost:8443/realms/ecom-app
```

## 📊 Monitoring Setup

### Prometheus Configuration
```yaml
# prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'microservices'
    static_configs:
      - targets: ['gateway:8080', 'user-service:8082', 'product-service:8081']
    metrics_path: '/actuator/prometheus'
```

### Grafana Dashboards
1. **Access Grafana**: http://localhost:3000
2. **Login**: admin/admin
3. **Import Dashboards**:
   - JVM Metrics Dashboard
   - Spring Boot Dashboard
   - Custom Business Metrics

## 🧪 Testing Deployment

### Health Checks
```bash
# Check service health
curl http://localhost:8080/actuator/health
curl http://localhost:8082/actuator/health
curl http://localhost:8081/actuator/health
curl http://localhost:8083/actuator/health
```

### API Testing
```bash
# Test user creation
curl -X POST http://localhost:8080/api/users \
  -H "Content-Type: application/json" \
  -d '{
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
  }'

# Test product creation
curl -X POST http://localhost:8080/api/products \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test Product",
    "description": "Test Description",
    "price": 99.99,
    "stockQuantity": 10,
    "category": "Test",
    "imageUrl": "https://example.com/image.jpg"
  }'
```

### Load Testing
```bash
# Using Apache Bench
ab -n 1000 -c 10 http://localhost:8080/api/products

# Using wrk
wrk -t12 -c400 -d30s http://localhost:8080/api/products
```

## 🔍 Troubleshooting

### Common Issues

#### Services Not Starting
1. **Check port availability**
   ```bash
   netstat -tulpn | grep :8080
   ```

2. **Check Docker resources**
   ```bash
   docker system df
   docker system prune -f
   ```

3. **Check service dependencies**
   ```bash
   docker-compose logs config-server
   docker-compose logs eureka
   ```

#### Database Connection Issues
1. **Check database status**
   ```bash
   docker-compose ps postgres mongo
   ```

2. **Check connection strings**
   ```bash
   docker-compose exec postgres psql -U embarkx -d ecom_product -c "\dt"
   docker-compose exec mongo mongosh --eval "show dbs"
   ```

#### Memory Issues
1. **Increase Docker memory allocation**
   - Docker Desktop → Settings → Resources → Memory

2. **Adjust JVM heap sizes**
   ```yaml
   environment:
     - JAVA_OPTS=-Xmx512m -Xms256m
   ```

### Log Analysis
```bash
# View service logs
docker-compose logs -f gateway-service
docker-compose logs -f user-service
docker-compose logs -f product-service

# View all logs
docker-compose logs -f

# Filter logs by error level
docker-compose logs | grep ERROR
```

### Performance Monitoring
```bash
# Check resource usage
docker stats

# Monitor JVM metrics
curl http://localhost:8080/actuator/metrics/jvm.memory.used
curl http://localhost:8080/actuator/metrics/http.server.requests
```

## 🚀 Production Deployment Considerations

### Security Hardening
- [ ] Change default passwords
- [ ] Enable HTTPS/TLS
- [ ] Configure firewall rules
- [ ] Enable audit logging
- [ ] Implement rate limiting
- [ ] Use secrets management

### Performance Optimization
- [ ] Configure connection pooling
- [ ] Enable caching (Redis)
- [ ] Optimize database queries
- [ ] Configure load balancing
- [ ] Implement CDN for static assets

### High Availability
- [ ] Deploy multiple instances
- [ ] Configure health checks
- [ ] Implement circuit breakers
- [ ] Set up database replication
- [ ] Configure auto-scaling

### Monitoring & Alerting
- [ ] Set up log aggregation
- [ ] Configure metric collection
- [ ] Create monitoring dashboards
- [ ] Set up alerting rules
- [ ] Implement distributed tracing

## 📈 Scaling Strategies

### Horizontal Scaling
```yaml
# Docker Compose
services:
  user-service:
    scale: 3
    
# Kubernetes
spec:
  replicas: 3
```

### Database Scaling
- **Read Replicas** for read-heavy workloads
- **Sharding** for write-heavy workloads
- **Connection Pooling** optimization

### Caching Strategy
- **Application-level caching** with Spring Cache
- **Distributed caching** with Redis
- **Database query caching**

## 🔄 CI/CD Pipeline

### Build Pipeline
```yaml
# .github/workflows/build.yml
name: Build and Test
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-java@v2
        with:
          java-version: '21'
      - run: ./build-all.sh
      - run: docker-compose -f deploy/docker/docker-compose.test.yml up --abort-on-container-exit
```

### Deployment Pipeline
```yaml
# .github/workflows/deploy.yml
name: Deploy to Production
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Deploy to Kubernetes
        run: |
          kubectl apply -f k8s/
```

## 📞 Support

For deployment issues:
1. Check the troubleshooting section
2. Review service logs
3. Consult the README.md for architecture details
4. Open an issue on GitHub

---

🎯 **Remember**: This is a showcase project demonstrating production-ready microservices architecture patterns!
