Write-Host "=== CI TEST START ===" -ForegroundColor Cyan

# 1. Install dependencies for service_api
Write-Host "`n[1/4] Installing dependencies for service_api..." -ForegroundColor Yellow
pip install -r service_api/requirements.txt

# 2. Install dependencies for service_worker
Write-Host "`n[2/4] Installing dependencies for service_worker..." -ForegroundColor Yellow
pip install -r service_worker/requirements.txt

# 3. Run tests
Write-Host "`n[3/4] Running tests for both services..." -ForegroundColor Yellow
pytest service_api/tests
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Tests failed in service_api" -ForegroundColor Red
    exit 1
}
pytest service_worker/tests
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Tests failed in service_worker" -ForegroundColor Red
    exit 1
}

# 4. Build Docker images
Write-Host "`n[4/4] Building Docker images..." -ForegroundColor Yellow
docker build -t local-microservice-api ./service_api
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to build API Docker image" -ForegroundColor Red
    exit 1
}
docker build -t local-microservice-worker ./service_worker
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to build Worker Docker image" -ForegroundColor Red
    exit 1
}

Write-Host "`n=== CI TEST PASSED SUCCESSFULLY ===" -ForegroundColor Green
