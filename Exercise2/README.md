# Exercise 2: NestJS E-Commerce Application

## Task
Dockerize a NestJS e-commerce application with PostgreSQL database, Redis cache, and all necessary configurations.

## Solution Overview

This is a complete e-commerce backend API built with NestJS featuring:
- User authentication with JWT tokens
- Email verification system
- Order management with Stripe payments
- PostgreSQL database with Prisma ORM
- Redis for caching verification codes
- Docker containerization

## Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   PostgreSQL    │    │      Redis      │    │   NestJS API    │
│   (Database)    │◄───┤     (Cache)     │◄───┤   (Backend)     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## Features

### Authentication
- User registration with email verification
- JWT access tokens (2h) and refresh tokens (7d)
- Password hashing with bcrypt
- Redis-based verification code storage

### Order Management
- Create orders with multiple products
- Stripe payment integration
- Real-time inventory management
- Order status tracking

### Email System
- Verification emails with custom templates
- Welcome emails after registration
- Order confirmation emails

## Quick Start

### Prerequisites
- Docker and Docker Compose
- Node.js 20+ (for local development)

### Using Docker (Recommended)

1. **Clone and navigate to the project:**
   ```bash
   cd Exercise2
   ```

2. **Start all services:**
   ```bash
   docker-compose up -d
   ```

3. **The API will be available at:**
   - Backend: `http://localhost:4000`
   - Database: `localhost:5532`
   - Redis: `localhost:6389`

### Environment Variables

Create a `.env` file in the NestJS-E-Commerce-Test directory:

```env
# Database
DATABASE_URL="postgresql://basit:bece2018@database:5432/E-Commerce-test"

# Redis
REDIS_URL="redis://redis:6379"

# JWT
JWT_SECRET="your-jwt-secret-key"
JWT_REFRESH_SECRET="your-jwt-refresh-secret-key"

# Email (Gmail)
EMAIL_USER="your-email@gmail.com"
EMAIL_PASS="your-app-password"

# Stripe
STRIPE_SECRET_KEY="sk_test_your_stripe_secret_key"
STRIPE_WEBHOOK_SECRET="whsec_your_webhook_secret"

# Server
PORT=4000
NODE_ENV="development"
```

## API Endpoints

### Authentication
- `POST /auth/register` - User registration
- `POST /auth/verify` - Email verification
- `POST /auth/login` - User login
- `POST /auth/logout` - User logout
- `POST /auth/refresh-token` - Refresh access token

### Orders
- `GET /orders/products` - Get all products
- `POST /orders/create` - Create new order
- `POST /orders/checkout` - Create Stripe checkout session
- `POST /orders/get-orders` - Get user orders

### Webhooks
- `POST /webhook/stripe` - Stripe payment webhooks

## Docker Configuration

### Services

1. **PostgreSQL Database**
   - Image: `postgres:latest`
   - Port: `5532:5432`
   - Database: `E-Commerce-test`

2. **Redis Cache**
   - Image: `redis:latest`
   - Port: `6389:6379`

3. **NestJS Backend**
   - Built from local Dockerfile
   - Port: `4000:4000`
   - Auto-runs migrations and seeds

### Key Docker Features
- Multi-stage build for optimization
- Health checks for all services
- Persistent data volumes
- Network isolation
- Automatic dependency management

## Database Schema

```sql
User {
  id        String   @id @default(cuid())
  email     String   @unique
  password  String
  name      String
  isVerified Boolean @default(false)
  orders    Order[]
}

Product {
  id          String @id @default(cuid())
  name        String
  description String?
  price       Float
  stock       Int
  orderItems  OrderItem[]
}

Order {
  id            String @id @default(cuid())
  userId        String
  totalPrice    Float
  status        String @default("pending")
  paymentMethod String
  orderItems    OrderItem[]
  user          User @relation(fields: [userId], references: [id])
}
```

## Development

### Local Development Setup

1. **Install dependencies:**
   ```bash
   cd NestJS-E-Commerce-Test
   npm install
   ```

2. **Setup database:**
   ```bash
   npx prisma generate
   npx prisma migrate dev
   npm run seed-products
   ```

3. **Start development server:**
   ```bash
   npm run start:dev
   ```

### Testing the API

1. **Register a user:**
   ```bash
   curl -X POST http://localhost:4000/auth/register \
     -H "Content-Type: application/json" \
     -d '{"email":"test@example.com","password":"Test123!","name":"Test User"}'
   ```

2. **Verify email** (check your email for the code)

3. **Login and get access token**

4. **Create an order** using the access token

## Production Deployment

### Docker Production Build

```bash
# Build production image
docker build -t nestjs-ecommerce:prod .

# Run with production environment
docker-compose -f docker-compose.prod.yml up -d
```

### Security Considerations

- Use strong JWT secrets in production
- Enable HTTPS/TLS
- Use environment-specific database credentials
- Configure proper CORS settings
- Set up proper logging and monitoring

## Troubleshooting

### Common Issues

1. **Database connection failed:**
   - Check if PostgreSQL container is running
   - Verify DATABASE_URL in .env file

2. **Email not sending:**
   - Verify Gmail app password
   - Check EMAIL_USER and EMAIL_PASS

3. **Stripe payments failing:**
   - Verify STRIPE_SECRET_KEY
   - Check webhook endpoint configuration

### Logs

```bash
# View all service logs
docker-compose logs -f

# View specific service logs
docker-compose logs -f backend
docker-compose logs -f database
docker-compose logs -f redis
```

## Technology Stack

- **Backend:** NestJS, TypeScript
- **Database:** PostgreSQL with Prisma ORM
- **Cache:** Redis
- **Authentication:** JWT tokens
- **Payments:** Stripe
- **Email:** Nodemailer with Handlebars templates
- **Containerization:** Docker & Docker Compose
- **Validation:** Zod schemas

## File Structure

```
Exercise2/
├── docker-compose.yaml          # Docker services configuration
├── NestJS-E-Commerce-Test/       # Main application
│   ├── Dockerfile               # Container build instructions
│   ├── src/                     # Source code
│   │   ├── auth/               # Authentication module
│   │   ├── orders/             # Order management
│   │   ├── shared/             # Shared utilities
│   │   └── main.ts             # Application entry point
│   ├── prisma/                 # Database schema & migrations
│   ├── package.json            # Dependencies
│   └── .env                    # Environment variables
└── README.md                   # This documentation
```