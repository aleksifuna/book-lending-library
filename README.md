# Book Lending Library Application

This is a simple book lending library application built using Ruby on Rails 8. It allows registered users to browse available books, borrow books, return books, and view their currently borrowed books.

## Features
- User registration and login using Rails' default authentication system.
- Book listing page showing availability status.
- Book details page with a borrow button (if available).
- User profile page listing currently borrowed books.
- Ability to return books.
- Model validations (e.g., title, author, ISBN presence, unique ISBN).
- Error handling (e.g., preventing borrowing an already borrowed book).

---

## Prerequisites

Before you begin, ensure you have the following installed on your system:
- **Ruby** (version 3.2 or later)
- **Rails** (version 8)
  
---

## Setup Instructions

### 1. Clone the Repository
Clone the repository to your local machine:
```bash
git https://github.com/aleksifuna/book-lending-library.git
cd book-lending-library
```
### 2. Install dependencies
```bash
bundle install
```

### 3. Setup the database:
```bash
rails db:create
rails db:migrate
```

## Running the Application
1. Start the Rails server:
```bash
rails server
```
2. Open your browser and visit http://localhost:3000

## Running Tests
Run tests using the Rails default testing framework(Minitest):
```bash
rails test
```
