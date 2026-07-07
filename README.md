Certainly. Based on the complete project we built—**Appsmith UI + n8n orchestration + PostgreSQL structured-data queries + Pinecone RAG + intent-based routing + login + chat session UI**—below is a GitHub-ready `README.md`.

You can copy this directly into your repository.

````markdown
# AI-Powered Customer Support Assistant using RAG + SQL

An intelligent customer support application that dynamically routes user queries to either a **PostgreSQL structured database** or a **Pinecone vector database** based on detected intent.

The solution combines:

- Conversational AI
- Retrieval-Augmented Generation (RAG)
- SQL-based structured data retrieval
- Intent detection and intelligent routing
- Workflow automation using n8n
- PostgreSQL for transactional and structured data
- Pinecone for semantic document retrieval
- Appsmith for the user interface

The application is designed around a healthcare / medical equipment customer support scenario.

---

## Project Overview

Customer support queries can require information from very different data sources.

For example:

- "What is the status of my order?"
- "Show my maintenance history"
- "Which spare parts were ordered?"
- "Provide the user manual for HeartMate 3 LVAD"
- "What is the installation procedure?"
- "Show troubleshooting instructions"

Some questions require exact structured records from a relational database, while others require semantic retrieval from technical documents.

This project solves that problem through an intelligent routing architecture:

```text
User Question
      |
      v
Intent Detection
      |
      +-------------------+
      |                   |
      v                   v
Structured Query      Document Query
      |                   |
      v                   v
PostgreSQL             Pinecone RAG
      |                   |
      +---------+---------+
                |
                v
        Unified Response
                |
                v
          Appsmith Chat UI
````

---

## Key Features

### 1. User Registration

The application supports user registration with details such as:

* Client ID
* Full Name
* Company Name
* Email
* Password
* Phone
* Role

User information is stored in PostgreSQL.

---

### 2. User Login

Registered users can log in using:

* Email
* Password

After successful authentication, user information is stored in the Appsmith store and reused across the application.

Example session values:

```json
{
  "user_id": 1,
  "client_id": "CL001",
  "full_name": "Amit Kumar",
  "email": "amit@citycare.com",
  "role": "customer"
}
```

---

### 3. Password Hashing

Passwords are not intended to be stored as plain text.

The project uses SHA-256 hashing in the backend workflow for demonstration purposes.

```text
Plain Password
      |
      v
SHA-256 Hash
      |
      v
PostgreSQL
```

> Security Note: SHA-256 is used for this capstone implementation. For production systems, a password-specific hashing algorithm such as Argon2id, bcrypt, or scrypt with appropriate salting and cost parameters should be used.

---

### 4. Intelligent Intent Detection

Every incoming question is analyzed to determine the user's intent.

The detected intent is then used to route the request to the appropriate datasource.

Example:

```text
"Show my maintenance history"
          |
          v
Intent: maintenance
          |
          v
PostgreSQL
```

Another example:

```text
"Provide the user manual for HeartMate 3 LVAD"
          |
          v
Intent: user_manual
          |
          v
Pinecone RAG
```

---

### 5. SQL-Based Structured Data Retrieval

Structured customer and operational information is retrieved from PostgreSQL.

The SQL sub-workflow supports business areas such as:

* Orders
* Products
* Installations
* Maintenance
* Spare Parts
* Service Information
* Customer-specific records
* General structured queries

Multiple PostgreSQL nodes can retrieve different datasets based on the detected intent.

---

### 6. Retrieval-Augmented Generation (RAG)

Unstructured product and technical documentation is stored in Pinecone.

The RAG workflow:

```text
User Question
      |
      v
Semantic Search
      |
      v
Pinecone Vector Database
      |
      v
Relevant Document Context
      |
      v
AI Response Generation
      |
      v
Grounded Answer
```

---

### 7. Document Knowledge Base

The project includes technical and support documentation across eight major categories:

1. Product Specifications
2. User Manuals
3. Regulatory Documentation
4. Software / Hardware Compatibility
5. Installation Guides
6. Standard Operating Procedures (SOPs)
7. FDA / CE / ISO Certificates
8. Product Troubleshooting

These documents are ingested into Pinecone for semantic retrieval.

---

### 8. Document Ingestion Workflow

A dedicated n8n ingestion workflow processes documents before storing them in Pinecone.

Typical flow:

```text
Document
   |
   v
File Loading
   |
   v
Document Processing
   |
   v
Text Splitting / Chunking
   |
   v
Embedding Generation
   |
   v
Pinecone Vector Store
```

Documents can be ingested individually or extended later to support automated multi-document ingestion.

---

### 9. SQL Sub-Workflow

The SQL workflow handles structured queries.

```text
Execute Sub-Workflow Trigger
          |
          v
Prepare Request
          |
          v
Route by Intent
          |
          v
PostgreSQL Query Nodes
          |
          v
Merge / Normalize Results
          |
          v
AI Formatter
          |
          v
Return Result to Main Workflow
```

The SQL sub-workflow returns normalized responses to the main orchestration workflow.

---

### 10. RAG Sub-Workflow

The RAG workflow handles documentation and knowledge-based questions.

```text
Execute Sub-Workflow Trigger
          |
          v
Prepare Request
          |
          v
AI Agent / Retrieval Chain
          |
          v
Pinecone Vector Search
          |
          v
Relevant Context Retrieval
          |
          v
AI-Generated Answer
          |
          v
Format Response
          |
          v
Return Result to Main Workflow
```

---

### 11. Unified Main Workflow

The main n8n workflow acts as the central orchestration layer.

```text
Webhook
   |
   v
Prepare Request
   |
   v
Intent Detection
   |
   v
Routing Logic
   |
   +-----------------------+
   |                       |
   v                       v
SQL Sub-Workflow       RAG Sub-Workflow
   |                       |
   v                       v
PostgreSQL              Pinecone
   |                       |
   +-----------+-----------+
               |
               v
        Unified Response
               |
               v
      Respond to Webhook
```

---

### 12. Unified API Response

Regardless of whether the answer comes from PostgreSQL or Pinecone, the application returns a consistent response format.

Example:

```json
{
  "success": true,
  "datasource": "Pinecone",
  "user_id": 1,
  "question": "Provide the user manual for HeartMate 3 LVAD",
  "intent": "user_manual",
  "response": "The HeartMate 3 LVAD user manual provides..."
}
```

For SQL queries:

```json
{
  "success": true,
  "datasource": "PostgreSQL",
  "user_id": 1,
  "question": "Show my maintenance history",
  "intent": "maintenance",
  "response": "The maintenance history shows..."
}
```

---

## Appsmith User Interface

The frontend is built using Appsmith.

The application contains:

* Login Screen
* Chat Screen
* User Session Handling
* New Chat
* Logout
* Dynamic Welcome Message
* AI Response Display
* Datasource Information
* Intent Information

---

## Login Screen

The login screen allows users to enter:

* Email
* Password

Flow:

```text
User Credentials
      |
      v
Appsmith Login API
      |
      v
n8n Login Workflow
      |
      v
PostgreSQL Validation
      |
      v
Successful Login
      |
      v
Store User Session
      |
      v
Navigate to Chat Page
```

---

## Chat Screen

The chat interface allows users to interact with the AI-powered support assistant.

Example:

```text
Support Assistant

Hello Amit Kumar!
How can I help you today?


                         You

Provide the user manual for
HeartMate 3 LVAD


Support Assistant

The HeartMate 3 LVAD user manual
provides detailed information about
operation, maintenance, alarms,
troubleshooting, and safety...

Source: Pinecone
Intent: user_manual
```

---

## Custom Chat Widget

A Custom widget is used instead of the standard Appsmith List widget.

This provides:

* Vertical message rendering
* Dynamic response length
* Automatic text wrapping
* User / assistant alignment
* Long RAG response support
* Vertical scrolling
* Datasource display
* Intent display

The Custom widget receives messages from:

```javascript
appsmith.store.chatMessages
```

Example structure:

```json
[
  {
    "id": "user-123",
    "sender": "user",
    "message": "Provide the user manual for HeartMate 3 LVAD"
  },
  {
    "id": "assistant-124",
    "sender": "assistant",
    "message": "The HeartMate 3 LVAD user manual provides...",
    "datasource": "Pinecone",
    "intent": "user_manual"
  }
]
```

---

## New Chat Functionality

Users can start a fresh conversation using the New Chat button.

The old UI chat history is cleared and a new welcome message is initialized.

Example:

```text
Support Assistant

Hello Amit Kumar!
How can I help you today?
```

---

## Logout Functionality

The Logout action clears stored session information and redirects the user to the Login page.

Conceptually:

```text
Logout
   |
   v
Clear Appsmith Store
   |
   v
Navigate to Login
```

---

## Technology Stack

| Layer                   | Technology             |
| ----------------------- | ---------------------- |
| Frontend                | Appsmith               |
| Workflow Orchestration  | n8n                    |
| Structured Database     | PostgreSQL             |
| Vector Database         | Pinecone               |
| AI / LLM                | Configured AI Model    |
| Embeddings              | Embedding Model        |
| RAG                     | Pinecone + AI Workflow |
| Containerization        | Docker                 |
| Database Administration | pgAdmin                |
| API Communication       | REST / Webhooks        |

---

## Docker Architecture

The project runs using Docker containers.

Main services:

```text
cpsp4_appsmith
cpsp4_n8n
cpsp4_postgres
cpsp4_pgadmin
```

Example port mapping:

| Service    | Host Port | Container Port |
| ---------- | --------: | -------------: |
| Appsmith   |      8081 |             80 |
| n8n        |      5679 |           5678 |
| PostgreSQL |      5433 |           5432 |
| pgAdmin    |      5050 |             80 |

---

## Docker Network

The services communicate through the Docker network:

```text
capstone_project4_default
```

Example internal service communication:

```text
Appsmith
   |
   v
n8n
   |
   v
PostgreSQL
```

---

## Application URLs

For the local Docker setup:

### Appsmith

```text
http://localhost:8081
```

### n8n

```text
http://localhost:5679
```

### pgAdmin

```text
http://localhost:5050
```

### PostgreSQL

```text
localhost:5433
```

---

## Project Workflows

The solution contains the following major workflows:

### 1. User Registration Workflow

```text
Webhook
   |
   v
Prepare Request
   |
   v
Password Hashing
   |
   v
Validate User
   |
   v
Insert User into PostgreSQL
   |
   v
Return Response
```

### 2. Login Workflow

```text
Webhook
   |
   v
Prepare Request
   |
   v
SHA-256 Hashing
   |
   v
PostgreSQL User Validation
   |
   v
Success / Failure
   |
   v
Return Response
```

### 3. Main Chat Workflow

```text
Webhook
   |
   v
Prepare Request
   |
   v
Intent Detection
   |
   v
Route Request
   |
   +----------------+
   |                |
   v                v
SQL Workflow     RAG Workflow
   |                |
   +-------+--------+
           |
           v
    Unified Response
```

### 4. SQL Sub-Workflow

Handles structured business queries using PostgreSQL.

### 5. RAG Sub-Workflow

Handles document-based semantic questions using Pinecone.

### 6. Document Ingestion Workflow

Processes and stores documents in the vector database.

---

## Sample Questions

### SQL / Structured Queries

```text
Show my order details
```

```text
What is the installation status of my equipment?
```

```text
Show maintenance history
```

```text
Which spare parts were ordered?
```

```text
Show my product details
```

### RAG / Document Queries

```text
Provide the user manual for HeartMate 3 LVAD
```

```text
What is the installation procedure?
```

```text
Show troubleshooting steps
```

```text
What regulatory certifications are available?
```

```text
Is this product FDA approved?
```

```text
What hardware and software versions are compatible?
```

---

## Example End-to-End Flow

User asks:

```text
Provide the user manual for HeartMate 3 LVAD
```

Processing:

```text
1. Appsmith sends question to n8n
2. Main workflow receives request
3. Intent detection identifies user_manual
4. Request is routed to RAG sub-workflow
5. Pinecone performs semantic search
6. Relevant document chunks are retrieved
7. AI generates a grounded response
8. Response returns to main workflow
9. Main workflow returns unified JSON
10. Appsmith displays response in chat
```

---

## Key Design Decisions

### Intent-Based Routing

The system does not send every question to the same datasource.

Instead:

```text
Structured Data
      |
      v
PostgreSQL

Unstructured Knowledge
      |
      v
Pinecone RAG
```

This improves:

* Accuracy
* Query efficiency
* Maintainability
* Scalability
* Explainability

---

### Sub-Workflow Architecture

SQL and RAG logic are implemented as separate sub-workflows.

Benefits:

* Modular design
* Easier debugging
* Independent testing
* Better maintainability
* Future extensibility

---

### Unified Response Contract

Both SQL and RAG workflows return a standardized response structure.

This allows Appsmith to remain independent of backend routing details.

---

### Session-Aware UI

After login, user information is stored in Appsmith and reused by the Chat API.

This avoids repeatedly asking for:

* User ID
* Client ID
* Email
* User Name

---

## Challenges Solved During Development

Several practical integration challenges were addressed during implementation:

* Docker container networking
* PostgreSQL recovery after improper shutdown
* n8n database connection timeouts
* Docker service restart issues
* Internal vs external Docker ports
* Appsmith-to-n8n connectivity
* Docker DNS resolution behavior
* PostgreSQL parameter binding
* Primary-key sequence conflicts
* n8n IF node datatype mismatches
* Webhook test vs production URLs
* Multiple SQL result normalization
* SQL and RAG sub-workflow integration
* JSON response formatting
* Long-running AI workflow timeout handling
* Appsmith API timeout configuration
* Chat history state management
* Long RAG response rendering
* Dynamic welcome messages
* New Chat session initialization

---

## Known Limitations

The current capstone implementation has several areas for future enhancement:

* SHA-256 is used for password hashing in the demonstration implementation; production systems should use Argon2id, bcrypt, or scrypt.
* Full JWT-based authentication is not currently implemented.
* Container IP addresses should not be hardcoded for production deployment.
* Document ingestion can be enhanced for automated bulk processing.
* Chat history persistence can be moved from browser storage to PostgreSQL.
* New Chat can be extended with backend session IDs.
* Role-based access control can be expanded.
* Production deployment should use HTTPS.
* Secrets should be managed through environment variables or a dedicated secrets manager.

---

## Future Enhancements

Planned enhancements include:

* JWT Authentication
* Refresh Tokens
* Role-Based Access Control
* Automated Bulk Document Ingestion
* Duplicate Document Detection
* Document Version Management
* Persistent Conversation History
* Backend Session Management
* Multi-Tenant Support
* Conversation Memory
* Streaming AI Responses
* Source Citations
* Document-Level Access Control
* RAG Evaluation
* Query Analytics
* User Feedback Collection
* Response Quality Monitoring
* Automated Testing
* CI/CD Pipeline
* Cloud Deployment

---

## Recommended Production Improvements

For a production-grade implementation:

```text
Authentication
→ JWT / OAuth 2.0 / OIDC

Password Storage
→ Argon2id / bcrypt / scrypt

Transport Security
→ HTTPS / TLS

Secrets
→ Secret Manager

Database
→ Managed PostgreSQL

Vector Database
→ Production Pinecone Index

Observability
→ Centralized Logging + Monitoring

Authorization
→ RBAC / ABAC

Document Security
→ Tenant-Level Metadata Filtering

Deployment
→ Kubernetes / Managed Containers / Cloud Platform
```

---

## Project Learning Outcomes

This project demonstrates practical implementation of:

* AI application architecture
* Retrieval-Augmented Generation
* Vector databases
* Semantic search
* SQL integration
* Intent detection
* Dynamic workflow routing
* n8n sub-workflows
* REST API integration
* Appsmith application development
* PostgreSQL integration
* Docker networking
* Stateful chat interfaces
* AI workflow orchestration
* Structured and unstructured data integration

---

## Repository Structure

A recommended repository structure is:

```text
Capstone_Project4/
│
├── README.md
├── docker-compose.yml
├── .env.example
│
├── n8n-workflows/
│   ├── user-registration.json
│   ├── user-login.json
│   ├── main-chat-workflow.json
│   ├── sql-sub-workflow.json
│   ├── rag-sub-workflow.json
│   └── document-ingestion.json
│
├── database/
│   ├── schema.sql
│   ├── sample-data.sql
│   └── queries.sql
│
├── documents/
│   ├── product-specifications/
│   ├── user-manuals/
│   ├── regulatory-documentation/
│   ├── compatibility/
│   ├── installation-guides/
│   ├── sops/
│   ├── certificates/
│   └── troubleshooting/
│
├── appsmith/
│   └── application-export/
│
└── screenshots/
    ├── login-screen.png
    ├── chat-screen.png
    ├── main-workflow.png
    ├── sql-workflow.png
    ├── rag-workflow.png
    └── ingestion-workflow.png
```

---

## Getting Started

### Prerequisites

Ensure the following are installed:

* Docker Desktop
* Docker Compose
* Git

You will also need access credentials for the AI and vector database services used by the workflows.

---

### Clone the Repository

```bash
git clone <your-repository-url>
cd Capstone_Project4
```

---

### Configure Environment Variables

Create a `.env` file from the example:

```bash
cp .env.example .env
```

Configure required values such as:

```env
POSTGRES_DB=cpsp4_db
POSTGRES_USER=admin
POSTGRES_PASSWORD=your_secure_password

PGADMIN_DEFAULT_EMAIL=your_email
PGADMIN_DEFAULT_PASSWORD=your_secure_password
```

Do not commit real passwords, API keys, or credentials to GitHub.

---

### Start the Application

```bash
docker compose up -d
```

Check container status:

```bash
docker ps
```

Expected services:

```text
cpsp4_appsmith
cpsp4_n8n
cpsp4_postgres
cpsp4_pgadmin
```

---

### Stop the Application

```bash
docker compose down
```

---

## Troubleshooting

### n8n Returns 503

Check PostgreSQL readiness:

```bash
docker exec -it cpsp4_postgres pg_isready -U admin -d cpsp4_db
```

Check n8n health:

```bash
curl http://localhost:5679/healthz
```

Inspect n8n logs:

```bash
docker logs cpsp4_n8n --tail 100
```

If PostgreSQL is healthy and n8n logs show connection timeout errors such as:

```text
timeout exceeded when trying to connect
```

restart only the n8n container:

```bash
docker restart cpsp4_n8n
```

---

### Appsmith Cannot Reach n8n

Verify connectivity from the Appsmith container:

```bash
docker exec -it cpsp4_appsmith sh
```

Then:

```bash
curl http://cpsp4_n8n:5678/healthz
```

Expected:

```json
{
  "status": "ok"
}
```

---

### Long AI Requests Fail in Appsmith

RAG workflows may take longer than normal REST requests.

Increase the Appsmith API timeout to accommodate the full n8n workflow execution time.

Example:

```text
120000 ms
```

or:

```text
180000 ms
```

depending on workflow latency.

---

## Security Notes

* Never commit `.env` files containing secrets.
* Never commit OpenAI, Pinecone, PostgreSQL, or other API credentials.
* Use HTTPS in production.
* Replace SHA-256 password handling with a password-specific hashing algorithm.
* Implement JWT/OAuth/OIDC for production authentication.
* Restrict database and vector-store access.
* Apply tenant-level authorization before returning customer data.
* Validate and sanitize all incoming requests.

---

## Author

**Gaurav Kumar Gupta**

AI Consultant, working on:

* Conversational AI
* RAG Applications
* AI Workflow Automation
* n8n
* API Development
* OpenAI
* Gemini
* Hugging Face
* Ollama
* Open-Source Models
* AI-Powered Business Solutions

## Acknowledgements

This project demonstrates the integration of modern AI, workflow automation, relational databases, vector databases, and low-code UI development into a unified intelligent customer support solution.
