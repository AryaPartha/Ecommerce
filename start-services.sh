#!/bin/bash

# Start All Microservices Script
# This script starts all microservices in the correct order

echo "🚀 Starting E-Commerce Microservices Platform"
echo "=============================================="

# Function to start a service
start_service() {
    local service_name=$1
    local port=$2
    echo "🔄 Starting $service_name on port $port..."
    cd $service_name
    nohup ./mvnw spring-boot:run > ../logs/$service_name.log 2>&1 &
    echo $! > ../logs/$service_name.pid
    cd ..
    echo "✅ $service_name started (PID: $(cat logs/$service_name.pid))"
    sleep 10  # Wait for service to start
}

# Create logs directory
mkdir -p logs

# Check if infrastructure is running
echo "🔍 Checking infrastructure services..."
if ! curl -f http://localhost:5432 >/dev/null 2>&1; then
    echo "⚠️  PostgreSQL not detected. Please start infrastructure first:"
    echo "   cd deploy/docker && docker-compose up -d postgres mongo keycloak kafka rabbitmq zipkin"
    exit 1
fi

echo "✅ Infrastructure services detected"

# Start services in dependency order
echo "Starting microservices..."

# 1. Configuration Server (needed by all services)
start_service "configserver" "8888"

# 2. Service Discovery (needed by all business services)
start_service "eureka" "8761"

# Wait for Eureka to be fully ready
echo "⏳ Waiting for Eureka to be ready..."
sleep 15

# 3. Business Services (can start in parallel)
start_service "user" "8082" &
start_service "product" "8081" &
start_service "order" "8083" &
start_service "notification" "N/A" &

# Wait for business services to start
sleep 20

# 4. API Gateway (needs all services to be registered)
start_service "gateway" "8080"

echo ""
echo "🎉 All services started successfully!"
echo ""
echo "📊 Service Status:"
echo "==================="
echo "Config Server:     http://localhost:8888"
echo "Eureka Dashboard:  http://localhost:8761"
echo "API Gateway:       http://localhost:8080"
echo "User Service:      http://localhost:8082"
echo "Product Service:   http://localhost:8081"
echo "Order Service:     http://localhost:8083"
echo ""
echo "🔧 Management URLs:"
echo "==================="
echo "Keycloak:          http://localhost:8443"
echo "Zipkin:            http://localhost:9411"
echo "RabbitMQ:          http://localhost:15672"
echo "PgAdmin:           http://localhost:5050"
echo ""
echo "📋 To stop all services: ./stop-services.sh"
echo "📋 To view logs: tail -f logs/<service-name>.log"
