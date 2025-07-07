# MeroCareer

MeroCareer is a comprehensive job portal platform designed to connect job seekers and recruiters, providing a seamless experience for job applications, recruitment, and career development. The project consists of a robust Django backend API and a modern cross-platform frontend built with Flutter, along with a web frontend using Vite and Tailwind CSS.

## Table of Contents
- [Features](#features)
- [Project Structure](#project-structure)
- [Backend Setup](#backend-setup)
- [Frontend Setup](#frontend-setup)
- [Contributing](#contributing)
- [License](#license)

## Features
- User authentication and authorization (job seekers & recruiters)
- Job posting and application management
- Real-time chat between job seekers and recruiters
- Notifications system
- Resume and profile management
- Advanced job filtering and search
- Admin dashboard for platform management

## Project Structure

```
MeroCareer/
├── backend/         # Django REST API backend
│   ├── api/         # Core API logic
│   ├── applications/ # Job application logic
│   ├── base/        # Base models and utilities
│   ├── chat/        # Real-time chat features
│   ├── job_seeker/  # Job seeker features
│   ├── jobs/        # Job posting and management
│   ├── notification/# Notification system
│   ├── recruiter/   # Recruiter features
│   ├── utils/       # Utility scripts
│   └── ...
├── mero_career/     # Flutter mobile app
├── web/             # Web frontend (Vite + Tailwind CSS)
└── README.md
```


## Getting Started

### Clone the Repository

To get started, first clone the repository:

```sh
git clone https://github.com/romanhumagain/MeroCareer.git
cd MeroCareer
```

## Backend Setup

1. **Navigate to the backend directory:**
   ```sh
   cd backend
   ```
2. **Create a virtual environment and activate it:**
   ```sh
   python -m venv venv
   .\venv\Scripts\activate
   ```
3. **Install dependencies:**
   ```sh
   pip install -r requirements.txt
   ```
4. **Apply migrations:**
   ```sh
   python manage.py migrate
   ```
5. **Run the development server:**
   ```sh
   python manage.py runserver
   ```

## Frontend Setup

### Flutter Mobile App
1. **Navigate to the Flutter app directory:**
   ```sh
   cd mero_career
   ```
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```
3. **Run the app:**
   ```sh
   flutter run
   ```

### Web Frontend
1. **Navigate to the web directory:**
   ```sh
   cd web
   ```
2. **Install dependencies:**
   ```sh
   npm install
   ```
3. **Run the development server:**
   ```sh
   npm run dev
   ```

## Contributing

Contributions are welcome! Please open issues and submit pull requests for improvements or bug fixes. Make sure to follow the code style and best practices used in the project.

## License

This project is licensed under the MIT License.
