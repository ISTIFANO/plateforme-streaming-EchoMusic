# EchoMusic Streaming Platform - Authentication API

## Overview

This documentation outlines the authentication endpoints for the EchoMusic streaming platform. These endpoints allow users to register, login, and logout from the platform.

## Base URL

```
http://localhost:8000/api/
```

## Authentication

The API uses Laravel Sanctum for token-based authentication. After successful login or registration, you'll receive a token that must be included in the Authorization header for protected routes:

```
Authorization: Bearer {your_token}
```

## Endpoints

### 1. Register User

Creates a new user account and returns both user data and an authentication token.

**URL**: `/register`

**Method**: `POST`

**Auth Required**: No

**Request Body Parameters**:

| Parameter  | Type   | Required | Description                      |
|------------|--------|----------|----------------------------------|
| firstname  | string | Yes      | User's first name                |
| lastname   | string | Yes      | User's last name                 |
| email      | string | Yes      | User's email address             |
| password   | string | Yes      | User's password                  |
| image      | string | Yes      | User's profile image (URL/path)  |
| phone      | string | Yes      | User's phone number              |

**Example Request**:
```json
{
  "firstname": "John",
  "lastname": "Doe",
  "email": "john.doe@example.com",
  "password": "securePassword123",
  "image": "profile_images/default.jpg",
  "phone": "+1234567890"
}
```

**Success Response**:
- **Status Code**: 201 (Created)
- **Content**:
```json
{
  "createWallet": null,
  "user": {
    "user": {
      "id": 1,
      "firstname": "John",
      "lastname": "Doe",
      "email": "john.doe@example.com",
      "image": "profile_images/default.jpg",
      "phone": "+1234567890",
      "created_at": "2025-03-13T10:00:00.000000Z",
      "updated_at": "2025-03-13T10:00:00.000000Z"
    },
    "token": "1|a1b2c3d4e5f6g7h8i9j0..."
  }
}
```

**Error Response**:
- **Status Code**: 422 (Unprocessable Entity)
- **Content**:
```json
{
  "message": "Not woking",
  "errors": {
    "firstname": ["The firstname field is required."],
    "lastname": ["The lastname field is required."],
    "email": ["The email field is required."],
    "password": ["The password field is required."],
    "image": ["The image field is required."],
    "phone": ["The phone field is required."]
  }
}
```

### 2. Login User

Authenticates a user and provides an access token.

**URL**: `/login`

**Method**: `POST`

**Auth Required**: No

**Request Body Parameters**:

| Parameter | Type   | Required | Description          |
|-----------|--------|----------|----------------------|
| email     | string | Yes      | User's email address |
| password  | string | Yes      | User's password      |

**Example Request**:
```json
{
  "email": "john.doe@example.com",
  "password": "securePassword123"
}
```

**Success Response**:
- **Status Code**: 201 (Created)
- **Content**:
```json
{
  "user": {
    "id": 1,
    "firstname": "John",
    "lastname": "Doe",
    "email": "john.doe@example.com",
    "image": "profile_images/default.jpg",
    "phone": "+1234567890",
    "created_at": "2025-03-13T10:00:00.000000Z",
    "updated_at": "2025-03-13T10:00:00.000000Z"
  },
  "token": "1|a1b2c3d4e5f6g7h8i9j0..."
}
```

**Error Response**:
- **Status Code**: 422 (Unprocessable Entity)
- **Content**:
```json
{
  "message": "Not woking"
}
```

### 3. Logout User

Invalidates the current user's token.

**URL**: `/user/user/logout`

**Method**: `POST`

**Auth Required**: Yes (Bearer Token)

**Headers**:
```
Authorization: Bearer {your_token}
```

**Success Response**:
- **Status Code**: 200 (OK)
- **Content**:
```json
{
  "message": "is logout"
}
```

### 4. Get Current User

Retrieves information about the currently authenticated user.

**URL**: `/user`

**Method**: `GET`

**Auth Required**: Yes (Bearer Token)

**Headers**:
```
Authorization: Bearer {your_token}
```

**Success Response**:
- **Status Code**: 200 (OK)
- **Content**:
```json
{
  "id": 1,
  "firstname": "John",
  "lastname": "Doe",
  "email": "john.doe@example.com",
  "image": "profile_images/default.jpg",
  "phone": "+1234567890",
  "created_at": "2025-03-13T10:00:00.000000Z",
  "updated_at": "2025-03-13T10:00:00.000000Z"
}
```

## Error Handling

The API returns appropriate HTTP status codes and error messages for various scenarios:

- **400** - Bad Request: Invalid input data
- **401** - Unauthorized: Invalid or missing authentication token
- **422** - Unprocessable Entity: Validation errors
- **500** - Internal Server Error: Unexpected server error

## Notes for Developers

1. All requests should include the `Content-Type: application/json` header when sending JSON data.
2. Token expiration is set to the Laravel Sanctum default configuration.
3. There appears to be a potential issue in the login method where the response message is "Not woking" when authentication succeeds.
4. The registration method references a `$response` variable that is not defined before being used in the return statement.
