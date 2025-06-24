.PHONY: install-deps-local build-docker run-validation-local generate-reqs clean run-notebook run-marimo

# Define a variable for the Docker image name
DOCKER_IMAGE_NAME := data-validation-app

# Default Python environment to use, relative to Makefile
PYTHON := .venv/bin/python
UV := .venv/bin/uv

# Target to install Python dependencies locally using uv
install-deps-local: pyproject.toml
	@echo "Installing Python dependencies locally with uv..."
	uv venv --seed # Create a virtual environment if it doesn't exist
	$(UV) sync
	@echo "Dependencies installed. Activate with 'source .venv/bin/activate'"

# Target to generate requirements.txt from pyproject.toml using uv
# This ensures consistency for Docker builds and easy readability
generate-reqs: pyproject.toml
	@echo "Generating requirements.txt from pyproject.toml using uv..."
	uv pip compile pyproject.toml --output-file requirements.txt

# Target to build the Docker image
build-docker: generate-reqs Dockerfile
	@echo "Building Docker image: $(DOCKER_IMAGE_NAME):latest..."
	docker build -t $(DOCKER_IMAGE_NAME):latest .

# Target to run the validation script locally via Docker
# Pass environment variables and target environment (e.g., VALIDATION_ENV=uat)
# Example: make run-validation-local VALIDATION_ENV=dev TERADATA_HOST=...
run-validation-local: build-docker
	@echo "Running data validation locally via Docker..."
	docker run --rm 		-e VALIDATION_ENV=$(VALIDATION_ENV) 		-e TERADATA_HOST=$(TERADATA_HOST) 		-e TERADATA_PORT=$(TERADATA_PORT) 		-e TERADATA_USER=$(TERADATA_USER) 		-e TERADATA_PASSWORD=$(TERADATA_PASSWORD) 		-e MRS_HIVE_HOST=$(MRS_HIVE_HOST) 		-e MRS_HIVE_PORT=$(MRS_HIVE_PORT) 		-e MRS_HIVE_USER=$(MRS_HIVE_USER) 		-e MRS_HIVE_PASSWORD=$(MRS_HIVE_PASSWORD) 		$(DOCKER_IMAGE_NAME):latest

# Generic target to run any Python notebook/script from the notebooks folder
# Example: make run-notebook NOTEBOOK_PATH=notebooks/template_eda.py
run-notebook:
	@echo "Running notebook: $(NOTEBOOK_PATH)..."
	$(PYTHON) $(NOTEBOOK_PATH)

# Specific target for running a Marimo app
# Example: make run-marimo MARIMO_APP=template_validation_report.py
run-marimo:
	@echo "Running Marimo app: notebooks/$(MARIMO_APP) (http://localhost:$(MARIMO_PORT))"
	$(UV) run marimo edit notebooks/$(MARIMO_APP) --port $(MARIMO_PORT:-8000) --host 0.0.0.0

# Target to clean up generated files
clean:
	@echo "Cleaning up generated files and Docker images..."
	rm -f requirements.txt
	rm -rf .venv/
	docker rmi $(DOCKER_IMAGE_NAME):latest || true
	# Clean up any generated validation reports or logs
	rm -rf validation_results/
