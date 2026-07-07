-- Sample dataset for AI Healthcare Equipment Support Chatbot
-- Run after creating the tables.

-- USERS
INSERT INTO users (user_id, client_id, full_name, company_name, email, password_hash, phone, role) VALUES
(1,'CL1001','Amit Sharma','City Care Hospital','amit@citycare.com','$2b$demo','9876500001','Customer'),
(2,'CL1002','Priya Nair','Sunrise Hospital','priya@sunrise.com','$2b$demo','9876500002','Customer'),
(3,'CL1003','Rahul Mehta','LifePlus Clinic','rahul@lifeplus.com','$2b$demo','9876500003','Customer'),
(4,'CL1004','Neha Gupta','Apollo Diagnostics','neha@apollodx.com','$2b$demo','9876500004','Customer'),
(5,'CL1005','John Dsouza','Global Heart Center','john@ghc.com','$2b$demo','9876500005','Customer');

-- EQUIPMENT
INSERT INTO equipment (equipment_id,equipment_name,model_number,serial_number,installation_date,warranty_start,warranty_end,customer_id,equipment_status) VALUES
(1,'FreeStyle Libre','FL3','FL30001','2025-01-10','2025-01-10','2028-01-09',1,'Active'),
(2,'HeartMate 3 LVAD','HM3','HM30001','2024-06-15','2024-06-15','2027-06-14',2,'Active'),
(3,'MitraClip','MC-G4','MC0001','2025-03-01','2025-03-01','2028-02-28',3,'Active'),
(4,'CardioMEMS HF System','CM1','CM0001','2025-05-12','2025-05-12','2028-05-11',4,'Active'),
(5,'Xience Stent','XS-100','XS0001','2024-11-20','2024-11-20','2027-11-19',5,'Active');

-- ORDERS
INSERT INTO orders (order_id,order_number,customer_id,equipment_id,order_date,expected_delivery,delivery_date,order_status,tracking_number,shipping_address) VALUES
(1,'ORD1001',1,1,'2026-06-01','2026-06-20',NULL,'Shipped','TRK1001','Pune'),
(2,'ORD1002',2,2,'2026-05-15','2026-06-05','2026-06-04','Delivered','TRK1002','Mumbai'),
(3,'ORD1003',3,3,'2026-06-10','2026-06-28',NULL,'Processing','TRK1003','Delhi'),
(4,'ORD1004',4,4,'2026-06-08','2026-06-22',NULL,'Shipped','TRK1004','Bengaluru'),
(5,'ORD1005',5,5,'2026-05-25','2026-06-15','2026-06-14','Delivered','TRK1005','Chennai');

-- WARRANTY
INSERT INTO warranty (warranty_id,equipment_id,customer_id,warranty_type,start_date,end_date,warranty_status,coverage_details) VALUES
(1,1,1,'Standard','2025-01-10','2028-01-09','Active','Manufacturing defects'),
(2,2,2,'Premium','2024-06-15','2027-06-14','Active','Parts and labour'),
(3,3,3,'Standard','2025-03-01','2028-02-28','Active','Device replacement'),
(4,4,4,'Premium','2025-05-12','2028-05-11','Active','Full coverage'),
(5,5,5,'Standard','2024-11-20','2027-11-19','Active','Manufacturing defects');

-- AMC
INSERT INTO amc_contracts (amc_id,equipment_id,customer_id,plan_name,coverage_details,start_date,end_date,amc_status) VALUES
(1,1,1,'Gold','Quarterly maintenance','2028-01-10','2029-01-09','Upcoming'),
(2,2,2,'Silver','Biannual maintenance','2025-06-15','2026-06-14','Active');

-- MAINTENANCE
INSERT INTO maintenance (maintenance_id,equipment_id,customer_id,maintenance_type,visit_date,engineer_name,maintenance_status,remarks) VALUES
(1,1,1,'Preventive','2026-07-10','Rakesh Singh','Scheduled','Quarterly visit'),
(2,2,2,'Corrective','2026-06-25','Anil Kumar','Completed','Pump checked');

-- COMPLAINTS
INSERT INTO complaints (complaint_id,ticket_number,customer_id,equipment_id,issue_title,issue_description,priority,complaint_status,assigned_engineer) VALUES
(1,'TKT1001',1,1,'Sensor not syncing','Libre sensor not syncing with app','Medium','Open','Rakesh Singh'),
(2,'TKT1002',2,2,'Controller alert','Unexpected controller alert','High','In Progress','Anil Kumar');

-- INVOICES
INSERT INTO invoices (invoice_id,invoice_number,customer_id,order_id,invoice_date,invoice_amount,payment_status,pdf_link) VALUES
(1,'INV1001',1,1,'2026-06-01',55000.00,'Pending','https://example.com/invoices/inv1001.pdf'),
(2,'INV1002',2,2,'2026-05-15',1500000.00,'Paid','https://example.com/invoices/inv1002.pdf');

-- SPARE PARTS
INSERT INTO spare_parts (part_id,equipment_id,part_name,part_number,stock_quantity,price,compatible_models) VALUES
(1,1,'Libre Sensor','SP1001',150,3500.00,'FL3'),
(2,2,'External Battery','SP1002',25,18000.00,'HM3');

-- PRODUCT DOCUMENTS
INSERT INTO product_documents (document_id,equipment_id,document_type,document_name,document_url) VALUES
(1,1,'User Manual','FreeStyle Libre User Manual','https://example.com/docs/libre_manual.pdf'),
(2,2,'FDA Certificate','HeartMate 3 FDA Certificate','https://example.com/docs/hm3_fda.pdf');

-- CHAT LOGS
INSERT INTO chat_logs (log_id,customer_id,session_id,user_question,detected_intent,data_source,chatbot_response,response_time_ms) VALUES
(1,1,'S001','Where is my order?','ORDER_STATUS','SQL','Your order has been shipped.',820),
(2,2,'S002','Give HeartMate 3 manual','PRODUCT_DOCUMENTATION','PINECONE','Provided manual link.',1340);

-- USER SESSIONS
INSERT INTO user_sessions (session_id,customer_id,jwt_token,expiry_time,is_active) VALUES
('S001',1,'demo-token','2026-06-30 12:00:00',TRUE),
('S002',2,'demo-token','2026-06-30 12:00:00',TRUE);
