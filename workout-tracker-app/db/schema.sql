-- Users table for authentication and profile
CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    last_login TEXT
);

-- Exercise library (predefined exercises)
CREATE TABLE IF NOT EXISTS exercises (
    exercise_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    category TEXT CHECK(category IN ('strength', 'cardio', 'flexibility', 'other')),
    muscle_group TEXT,
    is_compound BOOLEAN DEFAULT FALSE,
    equipment_needed TEXT
);

-- Workout templates (reusable workout plans)
CREATE TABLE IF NOT EXISTS workout_templates (
    template_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    name TEXT NOT NULL,
    description TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Exercise details for templates
CREATE TABLE IF NOT EXISTS template_exercises (
    template_exercise_id INTEGER PRIMARY KEY,
    template_id INTEGER,
    exercise_id INTEGER,
    order_index INTEGER,
    target_sets INTEGER,
    target_reps INTEGER,
    target_weight REAL,
    rest_period INTEGER, -- in seconds
    FOREIGN KEY (template_id) REFERENCES workout_templates(template_id),
    FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id)
);

-- Actual workout sessions
CREATE TABLE IF NOT EXISTS workout_sessions (
    session_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    template_id INTEGER NULL, -- NULL if it's a freestyle workout
    start_time TEXT NOT NULL,
    end_time TEXT,
    notes TEXT,
    mood_rating INTEGER CHECK(mood_rating BETWEEN 1 AND 5),
    energy_level INTEGER CHECK(energy_level BETWEEN 1 AND 5),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (template_id) REFERENCES workout_templates(template_id)
);

-- Sets performed during workouts
CREATE TABLE IF NOT EXISTS workout_sets (
    set_id INTEGER PRIMARY KEY,
    session_id INTEGER,
    exercise_id INTEGER,
    set_number INTEGER,
    weight REAL,
    reps INTEGER,
    rpe INTEGER CHECK(rpe BETWEEN 1 AND 10), -- Rate of Perceived Exertion
    completed_at TEXT DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (session_id) REFERENCES workout_sessions(session_id),
    FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id)
);

-- Personal records
CREATE TABLE IF NOT EXISTS personal_records (
    pr_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    exercise_id INTEGER,
    record_type TEXT CHECK(record_type IN ('weight', '1rm', 'reps', 'time')),
    record_value REAL,
    achieved_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id)
);

-- Progress tracking metrics
CREATE TABLE IF NOT EXISTS progress_metrics (
    metric_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    metric_type TEXT CHECK(metric_type IN ('weight', 'body_fat', 'muscle_mass', 'custom')),
    metric_value REAL,
    recorded_at TEXT DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Calculated 1RM history (One Rep Max)
CREATE TABLE IF NOT EXISTS one_rep_max_history (
    orm_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    exercise_id INTEGER,
    calculated_1rm REAL,
    calculation_method TEXT CHECK(calculation_method IN ('brzycki', 'epley', 'actual')),
    recorded_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id)
);

-- Training goals
CREATE TABLE IF NOT EXISTS training_goals (
    goal_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    exercise_id INTEGER NULL, -- NULL if it's a general goal
    goal_type TEXT CHECK(goal_type IN ('weight', 'reps', '1rm', 'frequency')),
    target_value REAL,
    deadline TEXT,
    achieved BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id)
);

-- Insert some initial exercise data
INSERT OR IGNORE INTO exercises (name, description, category, muscle_group, is_compound, equipment_needed) VALUES
('Barbell Bench Press', 'Classic chest exercise performed on a flat bench', 'strength', 'chest', TRUE, 'barbell, bench'),
('Squat', 'Compound lower body exercise', 'strength', 'legs', TRUE, 'barbell, squat rack'),
('Deadlift', 'Full body pulling exercise', 'strength', 'back', TRUE, 'barbell'),
('Pull-up', 'Upper body pulling exercise', 'strength', 'back', TRUE, 'pull-up bar'),
('Running', 'Cardiovascular exercise', 'cardio', 'full body', FALSE, 'none'),
('Dumbbell Rows', 'Back exercise with dumbbells', 'strength', 'back', FALSE, 'dumbbells'); 