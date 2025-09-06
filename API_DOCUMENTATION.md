# 📚 API Documentation

Complete API documentation for the E-Commerce Microservices Platform.

## 🌐 Base URLs

### Production
- **API Gateway**: `https://api.ecommerce.com`

### Development
- **API Gateway**: `http://localhost:8080`
- **User Service**: `http://localhost:8082`
- **Product Service**: `http://localhost:8081`
- **Order Service**: `http://localhost:8083`

## 🔐 Authentication

All APIs use JWT-based authentication with OAuth2 + PKCE flow.

### Authentication Flow
1. **Obtain Access Token** from Keycloak
2. **Include Token** in Authorization header: `Bearer {token}`
3. **Token Validation** happens at API Gateway level

### Example Authentication
```bash
# Get access token
curl -X POST http://localhost:8443/realms/ecom-app/protocol/openid-connect/token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=authorization_code_with_pkce&client_id=oauth2-pkce&code={auth_code}&code_verifier={verifier}"

# Use token in API calls
curl -H "Authorization: Bearer {access_token}" http://localhost:8080/api/users
```

## 👥 User Service API

Base Path: `/api/users`

### Get All Users
```http
GET /api/users
```

**Response:**
```json
[
  {
    "id": "507f1f77bcf86cd799439011",
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
    },
    "createdAt": "2024-01-15T10:30:00Z",
    "updatedAt": "2024-01-15T10:30:00Z"
  }
]
```

### Get User by ID
```http
GET /api/users/{id}
```

**Parameters:**
- `id` (string, required) - User ID

**Response:**
```json
{
  "id": "507f1f77bcf86cd799439011",
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
  },
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-15T10:30:00Z"
}
```

### Create User
```http
POST /api/users
```

**Request Body:**
```json
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
```

**Response:**
```json
{
  "message": "User created successfully",
  "userId": "507f1f77bcf86cd799439011"
}
```

### Update User
```http
PUT /api/users/{id}
```

**Parameters:**
- `id` (string, required) - User ID

**Request Body:**
```json
{
  "firstName": "John Updated",
  "lastName": "Doe Updated",
  "email": "john.updated@example.com",
  "phone": "9876543210",
  "address": {
    "street": "456 Oak St",
    "city": "Los Angeles",
    "state": "CA",
    "country": "USA",
    "zipcode": "90210"
  }
}
```

**Response:**
```json
{
  "message": "User updated successfully"
}
```

## 🛍️ Product Service API

Base Path: `/api/products`

### Get All Products
```http
GET /api/products
```

**Query Parameters:**
- `page` (integer, optional) - Page number (default: 0)
- `size` (integer, optional) - Page size (default: 20)
- `sort` (string, optional) - Sort field (default: id)

**Response:**
```json
{
  "content": [
    {
      "id": 1,
      "name": "iPhone 16 Pro",
      "description": "Latest iPhone with amazing features",
      "price": 1099.99,
      "stockQuantity": 50,
      "category": "Electronics",
      "imageUrl": "https://example.com/iphone16.jpg",
      "createdAt": "2024-01-15T10:30:00Z",
      "updatedAt": "2024-01-15T10:30:00Z"
    }
  ],
  "pageable": {
    "pageNumber": 0,
    "pageSize": 20,
    "totalElements": 1,
    "totalPages": 1
  }
}
```

### Get Product by ID
```http
GET /api/products/{id}
```

**Parameters:**
- `id` (integer, required) - Product ID

**Response:**
```json
{
  "id": 1,
  "name": "iPhone 16 Pro",
  "description": "Latest iPhone with amazing features",
  "price": 1099.99,
  "stockQuantity": 50,
  "category": "Electronics",
  "imageUrl": "https://example.com/iphone16.jpg",
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-15T10:30:00Z"
}
```

### Create Product
```http
POST /api/products
```

**Request Body:**
```json
{
  "name": "iPhone 16 Pro",
  "description": "Latest iPhone with amazing features",
  "price": 1099.99,
  "stockQuantity": 50,
  "category": "Electronics",
  "imageUrl": "https://example.com/iphone16.jpg"
}
```

**Response:**
```json
{
  "id": 1,
  "name": "iPhone 16 Pro",
  "description": "Latest iPhone with amazing features",
  "price": 1099.99,
  "stockQuantity": 50,
  "category": "Electronics",
  "imageUrl": "https://example.com/iphone16.jpg",
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-15T10:30:00Z"
}
```

### Update Product
```http
PUT /api/products/{id}
```

**Parameters:**
- `id` (integer, required) - Product ID

**Request Body:**
```json
{
  "name": "iPhone 16 Pro Updated",
  "description": "Updated description",
  "price": 999.99,
  "stockQuantity": 75,
  "category": "Electronics",
  "imageUrl": "https://example.com/iphone16-updated.jpg"
}
```

**Response:**
```json
{
  "id": 1,
  "name": "iPhone 16 Pro Updated",
  "description": "Updated description",
  "price": 999.99,
  "stockQuantity": 75,
  "category": "Electronics",
  "imageUrl": "https://example.com/iphone16-updated.jpg",
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-15T11:00:00Z"
}
```

### Delete Product
```http
DELETE /api/products/{id}
```

**Parameters:**
- `id` (integer, required) - Product ID

**Response:**
```http
204 No Content
```

### Search Products
```http
GET /api/products/search
```

**Query Parameters:**
- `keyword` (string, required) - Search keyword
- `category` (string, optional) - Filter by category
- `minPrice` (number, optional) - Minimum price filter
- `maxPrice` (number, optional) - Maximum price filter

**Response:**
```json
[
  {
    "id": 1,
    "name": "iPhone 16 Pro",
    "description": "Latest iPhone with amazing features",
    "price": 1099.99,
    "stockQuantity": 50,
    "category": "Electronics",
    "imageUrl": "https://example.com/iphone16.jpg",
    "createdAt": "2024-01-15T10:30:00Z",
    "updatedAt": "2024-01-15T10:30:00Z"
  }
]
```

## 🛒 Order Service API

Base Path: `/api/orders` and `/api/cart`

### Shopping Cart APIs

#### Get User Cart
```http
GET /api/cart
```

**Headers:**
- `X-User-ID` (string, required) - User ID

**Response:**
```json
{
  "userId": "507f1f77bcf86cd799439011",
  "items": [
    {
      "productId": "1",
      "productName": "iPhone 16 Pro",
      "quantity": 2,
      "price": 1099.99,
      "totalPrice": 2199.98
    }
  ],
  "totalAmount": 2199.98,
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-15T11:00:00Z"
}
```

#### Add Item to Cart
```http
POST /api/cart
```

**Headers:**
- `X-User-ID` (string, required) - User ID

**Request Body:**
```json
{
  "productId": "1",
  "quantity": 2
}
```

**Response:**
```json
{
  "message": "Item added to cart successfully",
  "cartItem": {
    "productId": "1",
    "quantity": 2,
    "addedAt": "2024-01-15T11:00:00Z"
  }
}
```

#### Update Cart Item
```http
PUT /api/cart/items/{productId}
```

**Headers:**
- `X-User-ID` (string, required) - User ID

**Parameters:**
- `productId` (string, required) - Product ID

**Request Body:**
```json
{
  "quantity": 3
}
```

**Response:**
```json
{
  "message": "Cart item updated successfully"
}
```

#### Remove Item from Cart
```http
DELETE /api/cart/items/{productId}
```

**Headers:**
- `X-User-ID` (string, required) - User ID

**Parameters:**
- `productId` (string, required) - Product ID

**Response:**
```http
204 No Content
```

### Order APIs

#### Place Order
```http
POST /api/orders
```

**Headers:**
- `X-User-ID` (string, required) - User ID

**Request Body:**
```json
{
  "shippingAddress": {
    "street": "123 Main St",
    "city": "New York",
    "state": "NY",
    "country": "USA",
    "zipcode": "10001"
  },
  "paymentMethod": "CREDIT_CARD"
}
```

**Response:**
```json
{
  "orderId": "order_123456789",
  "status": "PENDING",
  "totalAmount": 2199.98,
  "items": [
    {
      "productId": "1",
      "productName": "iPhone 16 Pro",
      "quantity": 2,
      "price": 1099.99,
      "totalPrice": 2199.98
    }
  ],
  "shippingAddress": {
    "street": "123 Main St",
    "city": "New York",
    "state": "NY",
    "country": "USA",
    "zipcode": "10001"
  },
  "createdAt": "2024-01-15T11:30:00Z"
}
```

#### Get User Orders
```http
GET /api/orders
```

**Headers:**
- `X-User-ID` (string, required) - User ID

**Query Parameters:**
- `status` (string, optional) - Filter by order status
- `page` (integer, optional) - Page number
- `size` (integer, optional) - Page size

**Response:**
```json
{
  "content": [
    {
      "orderId": "order_123456789",
      "status": "PENDING",
      "totalAmount": 2199.98,
      "items": [
        {
          "productId": "1",
          "productName": "iPhone 16 Pro",
          "quantity": 2,
          "price": 1099.99,
          "totalPrice": 2199.98
        }
      ],
      "createdAt": "2024-01-15T11:30:00Z"
    }
  ],
  "pageable": {
    "pageNumber": 0,
    "pageSize": 20,
    "totalElements": 1,
    "totalPages": 1
  }
}
```

#### Get Order by ID
```http
GET /api/orders/{orderId}
```

**Headers:**
- `X-User-ID` (string, required) - User ID

**Parameters:**
- `orderId` (string, required) - Order ID

**Response:**
```json
{
  "orderId": "order_123456789",
  "status": "PENDING",
  "totalAmount": 2199.98,
  "items": [
    {
      "productId": "1",
      "productName": "iPhone 16 Pro",
      "quantity": 2,
      "price": 1099.99,
      "totalPrice": 2199.98
    }
  ],
  "shippingAddress": {
    "street": "123 Main St",
    "city": "New York",
    "state": "NY",
    "country": "USA",
    "zipcode": "10001"
  },
  "createdAt": "2024-01-15T11:30:00Z",
  "updatedAt": "2024-01-15T11:30:00Z"
}
```

#### Cancel Order
```http
PUT /api/orders/{orderId}/cancel
```

**Headers:**
- `X-User-ID` (string, required) - User ID

**Parameters:**
- `orderId` (string, required) - Order ID

**Response:**
```json
{
  "message": "Order cancelled successfully",
  "orderId": "order_123456789",
  "status": "CANCELLED"
}
```

## 📊 Health Check APIs

### Service Health
```http
GET /actuator/health
```

**Response:**
```json
{
  "status": "UP",
  "components": {
    "db": {
      "status": "UP",
      "details": {
        "database": "PostgreSQL",
        "validationQuery": "isValid()"
      }
    },
    "diskSpace": {
      "status": "UP",
      "details": {
        "total": 250685575168,
        "free": 100000000000,
        "threshold": 10485760,
        "path": "/Users/user/."
      }
    }
  }
}
```

### Service Info
```http
GET /actuator/info
```

**Response:**
```json
{
  "app": {
    "name": "E-Commerce Microservices",
    "version": "1.0.0",
    "description": "Production-ready microservices platform"
  },
  "java": {
    "version": "21.0.1"
  },
  "spring": {
    "version": "3.4.3"
  }
}
```

### Metrics
```http
GET /actuator/metrics
```

**Response:**
```json
{
  "names": [
    "jvm.memory.used",
    "jvm.memory.max",
    "http.server.requests",
    "system.cpu.usage",
    "process.uptime"
  ]
}
```

## 🔍 Error Responses

### Standard Error Format
```json
{
  "timestamp": "2024-01-15T12:00:00Z",
  "status": 400,
  "error": "Bad Request",
  "message": "Validation failed for request",
  "path": "/api/users",
  "details": [
    {
      "field": "email",
      "message": "Email format is invalid"
    }
  ]
}
```

### Common HTTP Status Codes
- **200 OK** - Successful GET request
- **201 Created** - Successful POST request
- **204 No Content** - Successful DELETE request
- **400 Bad Request** - Invalid request data
- **401 Unauthorized** - Authentication required
- **403 Forbidden** - Insufficient permissions
- **404 Not Found** - Resource not found
- **409 Conflict** - Resource already exists
- **500 Internal Server Error** - Server error

## 📝 Rate Limiting

### Rate Limit Headers
```http
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1642248000
```

### Rate Limit Response
```json
{
  "timestamp": "2024-01-15T12:00:00Z",
  "status": 429,
  "error": "Too Many Requests",
  "message": "Rate limit exceeded. Try again later.",
  "retryAfter": 60
}
```

## 🧪 Testing with Postman

### Import Collection
1. Import the provided Postman collection: `Spring Boot Microservices Professional eCommerce Masterclass.postman_collection.json`
2. Set up environment variables:
   - `baseUrl`: `http://localhost:8080`
   - `authToken`: Your JWT token

### Example Test Scenarios
1. **User Management Flow**
   - Create user → Get user → Update user
2. **Product Management Flow**
   - Create product → Search products → Update product
3. **Shopping Flow**
   - Add to cart → View cart → Place order → View orders

## 📱 SDK Examples

### JavaScript/Node.js
```javascript
const axios = require('axios');

class ECommerceAPI {
  constructor(baseURL, authToken) {
    this.client = axios.create({
      baseURL,
      headers: {
        'Authorization': `Bearer ${authToken}`,
        'Content-Type': 'application/json'
      }
    });
  }

  async getProducts() {
    const response = await this.client.get('/api/products');
    return response.data;
  }

  async createUser(userData) {
    const response = await this.client.post('/api/users', userData);
    return response.data;
  }
}

// Usage
const api = new ECommerceAPI('http://localhost:8080', 'your-jwt-token');
const products = await api.getProducts();
```

### Python
```python
import requests

class ECommerceAPI:
    def __init__(self, base_url, auth_token):
        self.base_url = base_url
        self.headers = {
            'Authorization': f'Bearer {auth_token}',
            'Content-Type': 'application/json'
        }

    def get_products(self):
        response = requests.get(f'{self.base_url}/api/products', headers=self.headers)
        return response.json()

    def create_user(self, user_data):
        response = requests.post(f'{self.base_url}/api/users', 
                               json=user_data, headers=self.headers)
        return response.json()

# Usage
api = ECommerceAPI('http://localhost:8080', 'your-jwt-token')
products = api.get_products()
```

## 📞 Support

For API-related questions:
1. Check this documentation
2. Review the Postman collection
3. Check service health endpoints
4. Consult the main README.md

---

🔗 **Related Documentation:**
- [README.md](README.md) - Project overview and setup
- [DEPLOYMENT.md](DEPLOYMENT.md) - Deployment guide
- [Postman Collection](Spring Boot Microservices Professional eCommerce Masterclass.postman_collection.json) - API testing
