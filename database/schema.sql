Entity Relationship Diagram (Simplified)
users
│
├── equipment
│      │
│      ├── warranty
│      ├── amc_contracts
│      ├── maintenance
│      ├── complaints
│      ├── spare_parts
│      └── product_documents
│
├── orders
│      │
│      └── invoices
│
├── chat_logs
│
└── user_sessions



--1. Users Table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    client_id VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    company_name VARCHAR(150),
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(30) DEFAULT 'Customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--2. Equipment Table
CREATE TABLE equipment (
    equipment_id SERIAL PRIMARY KEY,
    equipment_name VARCHAR(150) NOT NULL,
    model_number VARCHAR(100),
    serial_number VARCHAR(100) UNIQUE,
    installation_date DATE,
    warranty_start DATE,
    warranty_end DATE,
    customer_id INT REFERENCES users(user_id),
    equipment_status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--3. Orders Table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_number VARCHAR(50) UNIQUE NOT NULL,
    customer_id INT REFERENCES users(user_id),
    equipment_id INT REFERENCES equipment(equipment_id),
    order_date DATE,
    expected_delivery DATE,
    delivery_date DATE,
    order_status VARCHAR(50),
    tracking_number VARCHAR(100),
    shipping_address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--4. Maintenance Table
CREATE TABLE maintenance (
    maintenance_id SERIAL PRIMARY KEY,
    equipment_id INT REFERENCES equipment(equipment_id),
    customer_id INT REFERENCES users(user_id),
    maintenance_type VARCHAR(50),
    visit_date DATE,
    engineer_name VARCHAR(100),
    maintenance_status VARCHAR(50),
    remarks TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--5. Complaints Table
CREATE TABLE complaints (
    complaint_id SERIAL PRIMARY KEY,
    ticket_number VARCHAR(50) UNIQUE NOT NULL,
    customer_id INT REFERENCES users(user_id),
    equipment_id INT REFERENCES equipment(equipment_id),
    issue_title VARCHAR(200),
    issue_description TEXT,
    priority VARCHAR(20),
    complaint_status VARCHAR(50),
    assigned_engineer VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--6. Warranty Table
CREATE TABLE warranty (
    warranty_id SERIAL PRIMARY KEY,
    equipment_id INT REFERENCES equipment(equipment_id),
    customer_id INT REFERENCES users(user_id),
    warranty_type VARCHAR(50),
    start_date DATE,
    end_date DATE,
    warranty_status VARCHAR(50),
    coverage_details TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--7. AMC (Annual Maintenance Contract) Table
CREATE TABLE amc_contracts (
    amc_id SERIAL PRIMARY KEY,
    equipment_id INT REFERENCES equipment(equipment_id),
    customer_id INT REFERENCES users(user_id),
    plan_name VARCHAR(100),
    coverage_details TEXT,
    start_date DATE,
    end_date DATE,
    amc_status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--8. Invoices Table
CREATE TABLE invoices (
    invoice_id SERIAL PRIMARY KEY,
    invoice_number VARCHAR(50) UNIQUE NOT NULL,
    customer_id INT REFERENCES users(user_id),
    order_id INT REFERENCES orders(order_id),
    invoice_date DATE,
    invoice_amount NUMERIC(12,2),
    payment_status VARCHAR(50),
    payment_date DATE,
    pdf_link TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--9. Spare Parts Table
CREATE TABLE spare_parts (
    part_id SERIAL PRIMARY KEY,
    equipment_id INT REFERENCES equipment(equipment_id),
    part_name VARCHAR(150),
    part_number VARCHAR(100),
    stock_quantity INT,
    price NUMERIC(10,2),
    compatible_models TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--10. Product Documents Table (Metadata Only)
	Note: The actual document text and embeddings will be stored in Pinecone. PostgreSQL stores metadata and document links.
CREATE TABLE product_documents (
    document_id SERIAL PRIMARY KEY,
    equipment_id INT REFERENCES equipment(equipment_id),
    document_type VARCHAR(100),
    document_name VARCHAR(200),
    document_url TEXT,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--11. Chat Logs Table
CREATE TABLE chat_logs (
    log_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES users(user_id),
    session_id VARCHAR(100),
    user_question TEXT,
    detected_intent VARCHAR(100),
    data_source VARCHAR(30),
    chatbot_response TEXT,
    response_time_ms INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--12. User Sessions Table
CREATE TABLE user_sessions (
    session_id VARCHAR(100) PRIMARY KEY,
    customer_id INT REFERENCES users(user_id),
    jwt_token TEXT,
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expiry_time TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);
