# Data Engineering Journey

## Data Engineer Roadmap
### Tier 1: Python, SQL, NoSQL
### Tier 2: ETL/ELT, Data Warehouses / Lakes / Blobs
### Tier 3: Cloud / Data Viz / DevOps
### Tier 4: Distributed Processing and Streaming

## Setup Instructions

### Prerequisites

- Docker
- Poetry (for Python)

### Clone the Repository

```sh
https://github.com/abrarmudhir/de-journey.git
cd de-journey
```

### Install Dependencies
- **Python**:
  ```sh
  poetry install
  ```
  
### Running Tests
- **Python**:
    ```sh
    poetry run pytest
    ```
  
## Run Locally with Docker

1. Navigate to the server directory:
   ```sh
   cd server
   ```

2. Build the Docker image:
   ```sh
   docker-compose -f docker-compose.yml build
   ```

3. Start the Docker containers:
   ```sh
   docker-compose up -d
   ```

4. View logs:
   ```sh
   docker-compose logs -f --tail=200
   ```

5. Rebuild if needed:
   ```sh
   docker-compose up --build
   ```
