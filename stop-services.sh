#!/bin/bash

# Stop All Microservices Script
# This script stops all running microservices

echo "🛑 Stopping E-Commerce Microservices Platform"
echo "=============================================="

# Function to stop a service
stop_service() {
    local service_name=$1
    if [ -f "logs/$service_name.pid" ]; then
        local pid=$(cat logs/$service_name.pid)
        echo "🔄 Stopping $service_name (PID: $pid)..."
        kill $pid 2>/dev/null
        rm -f logs/$service_name.pid
        echo "✅ $service_name stopped"
    else
        echo "⚠️  $service_name PID file not found"
    fi
}

# Stop services in reverse order
echo "Stopping microservices..."

stop_service "gateway"
stop_service "notification"
stop_service "order"
stop_service "product"
stop_service "user"
stop_service "eureka"
stop_service "configserver"

# Clean up any remaining processes
echo "🧹 Cleaning up remaining processes..."
pkill -f "spring-boot:run" 2>/dev/null || true

echo ""
echo "🎉 All services stopped successfully!"
echo ""
echo "📋 To start services again: ./start-services.sh"
echo "📋 To view logs: ls -la logs/"
