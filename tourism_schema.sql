-- Схема базы данных «Туризм»
-- MySQL 8.0

CREATE DATABASE IF NOT EXISTS tourism_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE tourism_db;

-- Справочник клиентов
CREATE TABLE clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(255)
) ENGINE=InnoDB;

-- Справочник туров
CREATE TABLE tours (
    tour_id INT AUTO_INCREMENT PRIMARY KEY,
    tour_name VARCHAR(150) NOT NULL,
    description TEXT,
    destination VARCHAR(100),
    duration_days INT,
    base_price DECIMAL(10,2)
) ENGINE=InnoDB;

-- Справочник услуг
CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2)
) ENGINE=InnoDB;

-- Таблица переменной информации (заказы)
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_date DATE NOT NULL,
    client_id INT NOT NULL,
    tour_id INT NOT NULL,
    service_id INT NULL,
    total_price DECIMAL(10,2),
    status ENUM('pending','confirmed','cancelled') DEFAULT 'pending',
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (tour_id) REFERENCES tours(tour_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE SET NULL
) ENGINE=InnoDB;
