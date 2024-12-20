CREATE DATABASE university;
USE university;

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,  
    first_name VARCHAR(100) NOT NULL,           
    last_name VARCHAR(100) NOT NULL,            
    email VARCHAR(100) UNIQUE NOT NULL,  --  (unique)
    date_of_birth DATE,                         
    phone_number VARCHAR(15),                  
    enrollment_year YEAR                        
);

CREATE TABLE professors (
    professor_id INT AUTO_INCREMENT PRIMARY KEY, 
    first_name VARCHAR(100) NOT NULL,             
    last_name VARCHAR(100) NOT NULL,              
    email VARCHAR(100) UNIQUE NOT NULL,  --  (unique)
    department VARCHAR(100)                      
);

CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,  
    subject_name VARCHAR(100) NOT NULL,         
    subject_code VARCHAR(10) UNIQUE NOT NULL,   -- Unique subject code (e.g., CS101)
    credits INT NOT NULL,   -- Number of credits for the subject
    professor_id INT,                           
    FOREIGN KEY (professor_id) REFERENCES professors(professor_id) -- Foreign Key to 'professors' table
);
-- (Many-to-many relationship between students and subjects)
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY, 
    student_id INT,--  (foreign key)
    subject_id INT,   -- (foreign key)
    enrollment_date DATE,                         
    grade VARCHAR(2),    -- Grade (optional, could be 'A', 'B+', etc.)
    FOREIGN KEY (student_id) REFERENCES students(student_id), -- Foreign Key to 'students' table
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)  -- Foreign Key to 'subjects' table
);

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY, 
    department_name VARCHAR(100) NOT NULL         
);

ALTER TABLE subjects ADD COLUMN department_id INT;
ALTER TABLE subjects ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);

CREATE TABLE buildings (
    building_id INT AUTO_INCREMENT PRIMARY KEY,  
    building_name VARCHAR(100) NOT NULL,  -- Building name (e.g., "Engineering Block")
    location VARCHAR(255)  -- Physical location (e.g., "Main campus, 2nd floor")
);

CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,      
    room_number VARCHAR(20) NOT NULL, -- Room number or name (e.g., "Room 101")
    building_id INT,                             
    capacity INT,                                
    FOREIGN KEY (building_id) REFERENCES buildings(building_id) -- Foreign Key to 'buildings' table
);

CREATE TABLE lectures (
    lecture_id INT AUTO_INCREMENT PRIMARY KEY,   
    subject_id INT,  --  (foreign key)
    room_id INT,   -- (foreign key)
    start_time DATETIME,  -- like '2024-01-15 09:00:00'
    end_time DATETIME,                          
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday') NOT NULL, 
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),  -- Foreign Key to 'subjects' table
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)  -- Foreign Key to 'rooms' table
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,  
    title VARCHAR(255) NOT NULL,             
    author VARCHAR(255),                     
    isbn VARCHAR(13) UNIQUE, -- ISBN (International Standard Book Number)
    publisher VARCHAR(255),                  
    publication_year YEAR,                   
    total_copies INT NOT NULL,               
    available_copies INT NOT NULL            
);

-- (many-to-many relationship)
CREATE TABLE course_materials (
    course_material_id INT AUTO_INCREMENT PRIMARY KEY,  
    subject_id INT, -- Subject ID (foreign key)
    book_id INT,  -- Book ID (foreign key)
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),  -- Foreign Key to 'subjects' table
    FOREIGN KEY (book_id) REFERENCES books(book_id)  -- Foreign Key to 'library' table
);

alter table departments add column building_id int;
ALTER TABLE departments
ADD CONSTRAINT FK_departmentBuilding
FOREIGN KEY (building_id) REFERENCES buildings(building_id);

alter table professors rename column department to department_id;
alter table professors modify column department_id int;
ALTER TABLE professors
ADD CONSTRAINT FK_profDepartment
FOREIGN KEY (department_id) REFERENCES departments(department_id);

alter table students drop column enrollment_year;
alter table students add column enrollment_date date;

alter table professors rename to educators;
