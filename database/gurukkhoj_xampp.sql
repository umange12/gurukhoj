-- GuruKhoj Database - XAMPP Compatible
-- Paste this in phpMyAdmin SQL tab

SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(180) NOT NULL UNIQUE,
    password_hash VARCHAR(256) NOT NULL,
    role ENUM('admin','teacher','student') NOT NULL DEFAULT 'student',
    is_active TINYINT(1) DEFAULT 1,
    last_login DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS teachers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    teacher_code VARCHAR(20) UNIQUE,
    full_name VARCHAR(120) NOT NULL,
    email VARCHAR(180),
    phone VARCHAR(20),
    gender VARCHAR(10),
    photo_url VARCHAR(300) DEFAULT '',
    education VARCHAR(300),
    experience_years INT DEFAULT 0,
    subjects TEXT,
    classes_taught VARCHAR(100),
    teaching_mode VARCHAR(20) DEFAULT 'Both',
    area VARCHAR(150),
    city VARCHAR(100) DEFAULT 'Dehradun',
    monthly_fee INT DEFAULT 0,
    about TEXT,
    is_verified TINYINT(1) DEFAULT 0,
    is_available TINYINT(1) DEFAULT 1,
    rating FLOAT DEFAULT 0.0,
    total_reviews INT DEFAULT 0,
    joined_date DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    student_code VARCHAR(20) UNIQUE,
    full_name VARCHAR(120) NOT NULL,
    email VARCHAR(180),
    phone VARCHAR(20),
    parent_name VARCHAR(120),
    parent_phone VARCHAR(20),
    gender VARCHAR(10),
    date_of_birth DATE,
    class_grade VARCHAR(30),
    board VARCHAR(20) DEFAULT 'CBSE',
    subjects TEXT,
    area VARCHAR(150),
    city VARCHAR(100) DEFAULT 'Dehradun',
    assigned_teacher_id INT,
    photo_url VARCHAR(300) DEFAULT '',
    admission_date DATE,
    payment_status VARCHAR(20) DEFAULT 'Pending',
    is_active TINYINT(1) DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(assigned_teacher_id) REFERENCES teachers(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS teacher_ratings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id INT,
    student_id INT,
    rating FLOAT,
    feedback TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_rating (teacher_id, student_id),
    FOREIGN KEY(teacher_id) REFERENCES teachers(id) ON DELETE CASCADE,
    FOREIGN KEY(student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id INT,
    student_id INT,
    subject VARCHAR(100),
    test_name VARCHAR(200),
    test_date DATE,
    total_marks INT DEFAULT 100,
    obtained_marks FLOAT DEFAULT 0,
    percentage FLOAT DEFAULT 0,
    grade VARCHAR(5),
    remarks TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(teacher_id) REFERENCES teachers(id) ON DELETE CASCADE,
    FOREIGN KEY(student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    teacher_id INT,
    date DATE,
    status VARCHAR(20) DEFAULT 'Present',
    notes VARCHAR(200),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_att (student_id, date),
    FOREIGN KEY(student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY(teacher_id) REFERENCES teachers(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    teacher_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    due_date DATE,
    status VARCHAR(20) DEFAULT 'Pending',
    payment_method VARCHAR(30) DEFAULT 'Cash',
    transaction_id VARCHAR(100),
    month_year VARCHAR(20),
    notes TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY(teacher_id) REFERENCES teachers(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS user_sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    login_time DATETIME,
    logout_time DATETIME,
    duration_minutes INT DEFAULT 0,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ai_predictions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(100),
    scores_input TEXT,
    predicted_score FLOAT,
    trend VARCHAR(30),
    r_squared FLOAT,
    model_version VARCHAR(20) DEFAULT 'v2.0',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS notices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(300),
    content TEXT,
    posted_by INT,
    target_role VARCHAR(20) DEFAULT 'all',
    is_active TINYINT(1) DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE,
    category VARCHAR(80),
    icon VARCHAR(10) DEFAULT 'book'
) ENGINE=InnoDB;

SET FOREIGN_KEY_CHECKS=1;

-- Subjects seed data
INSERT IGNORE INTO subjects (name, category) VALUES
('Mathematics','Science'),('Physics','Science'),('Chemistry','Science'),
('Biology','Science'),('Computer Science','Technology'),('English','Language'),
('Hindi','Language'),('History','Social Studies'),('Geography','Social Studies'),
('Economics','Commerce'),('Accountancy','Commerce'),('Science','General');

-- Admin user (password: admin123)
INSERT IGNORE INTO users (name, email, password_hash, role) VALUES
('Super Admin','admin@gurukkhoj.com','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918','admin');

-- Demo Teachers (password: teacher123)
INSERT IGNORE INTO users (name, email, password_hash, role) VALUES
('Dr. Priya Sharma','priya@gurukkhoj.com','b5835974f9848d4d57c9b8695f571ef6c6f5a42af8b083e2f3d24ed28f6e1d45','teacher'),
('Mr. Rahul Verma','rahul@gurukkhoj.com','b5835974f9848d4d57c9b8695f571ef6c6f5a42af8b083e2f3d24ed28f6e1d45','teacher'),
('Ms. Anjali Singh','anjali@gurukkhoj.com','b5835974f9848d4d57c9b8695f571ef6c6f5a42af8b083e2f3d24ed28f6e1d45','teacher'),
('Mr. Vikash Negi','vikash@gurukkhoj.com','b5835974f9848d4d57c9b8695f571ef6c6f5a42af8b083e2f3d24ed28f6e1d45','teacher'),
('Mrs. Sunita Rawat','sunita@gurukkhoj.com','b5835974f9848d4d57c9b8695f571ef6c6f5a42af8b083e2f3d24ed28f6e1d45','teacher');

-- Demo Student (password: demo123)
INSERT IGNORE INTO users (name, email, password_hash, role) VALUES
('Rohan Kumar','student@demo.com','a76a9948a680c162a13c7e8b4a7e64d0e67ab3e93a3cdf0c97e5d7e6f2f45381','student');
