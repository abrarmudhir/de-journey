# Data Engineering Journey

## Data Engineer Roadmap
### Tier 1: Python, SQL, NoSQL
### Tier 2: ETL/ELT, Data Warehouses / Lakes / Blobs
### Tier 3: Cloud / Data Viz / DevOps
### Tier 4: Distributed Processing and Streaming

## Setup Instructions

### Prerequisites

- Docker
- [uv](https://docs.astral.sh/uv/) (for Python)

### Clone the Repository

```sh
https://github.com/abrarmudhir/de-journey.git
cd de-journey
```

### Install Dependencies
- **Python**:
  ```sh
  uv sync
  ```
  
### Running Tests
- **Python**:
    ```sh
    uv run pytest
    ```

### Formatting Python Code

Format all Python files in the project:

```sh
uv run black .
```

Install the Git pre-commit hook once after cloning. It runs Black automatically
against staged Python files whenever you commit:

```sh
uv run pre-commit install
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
