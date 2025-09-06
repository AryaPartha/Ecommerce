#!/bin/bash

# Build All Microservices Script
# This script builds all microservices in the correct order

echo "🚀 Building E-Commerce Microservices Platform"
echo "=============================================="

# Function to build a service
build_service() {
    local service_name=$1
    echo "📦 Building $service_name..."
    cd $service_name
    ./mvnw clean package -DskipTests
    if [ $? -eq 0 ]; then
        echo "✅ $service_name built successfully"
    else
        echo "❌ Failed to build $service_name"
        exit 1
    fi
    cd ..
}

# Build services in dependency order
echo "Starting build process..."

# Infrastructure services first
build_service "eureka"
build_service "configserver"

# Business services
build_service "user"
build_service "product"
build_service "order"
build_service "notification"

# API Gateway last
build_service "gateway"

echo "🎉 All services built successfully!"
echo ""
echo "Next steps:"
echo "1. Start infrastructure: cd deploy/docker && docker-compose up -d postgres mongo keycloak kafka rabbitmq zipkin"
echo "2. Start services: ./start-services.sh"
echo "3. Or use Docker: cd deploy/docker && docker-compose up -d"
