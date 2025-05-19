# OlyPro - Weightlifting Progress Tracker

A web application for tracking weightlifting progress, creating programs, and sharing form videos.

## Features

- User registration and authentication
- Track weight, sets, and reps
- Create and manage training programs
- Share and review form videos
- Progress tracking and analytics

## Prerequisites

- Node.js (v18 or higher)
- MongoDB Atlas account
- npm or yarn package manager

## Installation

1. Clone the repository:
```bash
git clone https://github.com/Westini/OlyPro.git
cd OlyPro
```

2. Install dependencies:
```bash
npm install
```

3. Create a `.env` file in the root directory with the following variables:
```env
MONGODB_URI="your_mongodb_atlas_connection_string"
DB_NAME="weightlifting"
NODE_ENV="development"
DEV_URL="http://localhost:3000"
```

4. Start the development server:
```bash
npm run dev
```

The application will be available at `http://localhost:3000`

## Dependencies

- SvelteKit - Web framework
- MongoDB - Database
- bcrypt - Password hashing
- dotenv - Environment variable management

## Development

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run preview` - Preview production build
- `npm run check` - Type checking
- `npm run check:watch` - Watch mode for type checking

## Project Structure

```
src/
├── lib/           # Shared utilities and components
│   └── db/        # Database configuration
├── routes/        # Application routes
│   ├── users/     # User management
│   ├── account/   # User account
│   └── api/       # API endpoints
└── app.css        # Global styles
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License.
