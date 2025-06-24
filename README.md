# 🧪 Data Asset Quality Template

> A universal template and framework for ensuring the **quality and integrity** of data assets during migrations, ingestions, and ongoing operations.

---

## ✨ Why Use This Template?

In modern data ecosystems, **data moves constantly**. This template helps ensure data **accuracy, completeness, and consistency** by providing:

* ✅ **Standardized Data Validation**
  A consistent methodology for quality checks across all projects.

* 🚀 **Accelerated UAT & QC**
  Rapid validation for data migration and ingestion pipelines.

* 🛠️ **Robust Design**
  Built with containerization, strong error handling, and distributed PySpark execution.

* 🔌 **Future-Proofing**
  Easily extend to support new sources, validation types, or DQ frameworks.

* 🔁 **CI/CD Ready**
  Integrates with GitHub Actions and GitLab CI for automation.

* 🤝 **Team Collaboration**
  Clear structure and docs support knowledge sharing and onboarding.

---

## 🚀 Key Features

* 🧩 **Configurable Validations**
  YAML-driven rules: schema, row counts, aggregates, checksums.

* 🔌 **Pluggable Connectors**
  Easily support Teradata, Hive, Delta Lake, SQL Server, PostgreSQL, etc.

* 🔍 **Data Quality Frameworks**

  * [Great Expectations](https://greatexpectations.io): Declarative validation.
  * [Deequ](https://github.com/awslabs/deequ): Spark-native metrics.

* ⚡ **PySpark-Powered**
  Distributed and scalable data processing.

* 🐳 **Containerized Environment**
  Consistent setup with Docker.

* 📚 **Comprehensive Documentation**
  From setup to mapping to report generation.

* 🔐 **Secure Credential Handling**
  Uses env vars or external secret stores.

* 📓 **Notebook Support**
  Compatible with Marimo and Jupyter for interactive reporting.

* 🛠️ **Makefile Driven**
  Centralized commands for developer productivity.

---

## ⚙️ Technologies Used

* Python 3.9+
* PySpark
* [uv](https://github.com/astral-sh/uv)
* Docker
* YAML
* Great Expectations (optional)
* Deequ (optional)
* Jupyter / Marimo (optional)
* `make`
* GitHub Actions / GitLab CI

---

## 🏗️ Repository Structure

```
data-asset-quality-template/
├── .github/
│   └── workflows/
│       ├── build_and_push_docker.yml         # GitHub Actions: Build & push Docker image
│       └── validate_data.yml                 # GitHub Actions: Orchestrate validation run
├── .gitlab-ci.yml                            # GitLab CI/CD configuration
├── config/
│   ├── environments/                         # Environment-specific config (dev, uat, prod)
│   │   ├── dev.yaml
│   │   ├── uat.yaml
│   │   └── prod.yaml
│   ├── connectors.yaml                       # DB connection placeholders
│   ├── validation_rules.yaml                 # YAML-based validation rules
│   └── table_mappings.yaml                   # Source-target table mappings
├── data/
│   └── sample_data/                          # Optional sample data for testing
│       ├── source_sample.csv
│       └── target_sample.csv
├── docs/                                     # Full documentation set
│   ├── TEMPLATE_GUIDE.md                     # 🔥 How to use this as a template
│   ├── PROJECT_SETUP.md                      # Step-by-step setup guide
│   ├── UAT_Process_Guide.md                  # UAT phase procedures
│   ├── Data_Validation_Methods.md            # Validation logic explained
│   ├── Data_Type_Mapping_Guide.md            # Mapping strategy reference
│   ├── Discrepancy_Log_Template.md           # Template to log validation issues
│   ├── Known_Issues_Template.md              # Template for accepted discrepancies
│   └── Reporting_Templates/
│       └── UAT_Report_Template.docx          # Final reporting format
├── expectations/
│   ├── deequ_expectations/
│   │   ├── my_table_expectations.py
│   │   └── another_table_expectations.py
│   └── great_expectations/
│       ├── checkpoints/
│       ├── expectations/
│       │   └── my_table_suite.json
│       └── uncommitted/                      # Local validation results
├── notebooks/
│   ├── template_eda.py
│   ├── template_validation_report.py
│   └── template_expectation_profiling.py
├── src/
│   ├── connectors/
│   │   ├── __init__.py
│   │   ├── base_connector.py
│   │   ├── jdbc_connector.py
│   │   └── hive_connector.py
│   ├── validators/
│   │   ├── __init__.py
│   │   ├── base_validator.py
│   │   ├── schema_validator.py
│   │   ├── count_validator.py
│   │   ├── aggregation_validator.py
│   │   └── checksum_validator.py
│   ├── data_expectations/
│   │   ├── __init__.py
│   │   ├── ge_integration.py
│   │   └── deequ_integration.py
│   ├── reports/
│   │   ├── __init__.py
│   │   └── html_reporter.py
│   ├── main.py
│   └── utils.py
├── tests/
│   ├── unit/
│   │   ├── test_connectors.py
│   │   └── test_validators.py
│   └── integration/
│       └── test_e2e_validation.py
├── Dockerfile
├── entrypoint.sh
├── Makefile
├── pyproject.toml
├── .dockerignore
├── .gitignore
├── README.md
├── requirements.txt
└── LICENSE
```

---

## 🚀 Getting Started

### 🧪 Create a New Project from the Template

**GitHub**
Click the **"Use this template"** button on the repository page.

**GitLab**
Create a new project → *Import Project* → *Repo by URL*.

**Manual Setup**

```bash
git clone https://github.com/pesnik/data-asset-quality-template.git <your-new-project-name>
cd <your-new-project-name>
rm -rf .git
git init -b main
```

👉 See `docs/TEMPLATE_GUIDE.md` for:

* Source/target DB config
* Validation rules setup
* Secure credentials management
* CI/CD pipeline integration

---

## 🐳 Local Development (Docker + uv)

### 🔧 Prerequisites

* Docker Desktop
* Git
* Python 3.9+
* `make`
* `uv` (install via `pip install uv`)

### 📦 Install Python Dependencies

```bash
make install-deps-local
```

### 🏗️ Build Docker Image

```bash
make build-docker
```

### ✅ Run Validations

```bash
make run-validation-local VALIDATION_ENV=uat \
  TERADATA_HOST="your_td_host" \
  TERADATA_PORT="your_td_port" \
  TERADATA_USER="your_td_user" \
  TERADATA_PASSWORD="your_td_password" \
  CLOUD_HIVE_HOST="your_cloud_host" \
  CLOUD_HIVE_PORT="your_cloud_port" \
  CLOUD_HIVE_USER="your_cloud_user" \
  CLOUD_HIVE_PASSWORD="your_cloud_password"
```

> Use secrets manager for production credentials.

---

## 📓 Interactive Notebooks

### Run Marimo or Jupyter notebooks:

```bash
make run-notebook NOTEBOOK_PATH=notebooks/template_validation_report.py
# OR
make run-marimo MARIMO_APP=template_validation_report.py
# OR
make run-jupyter NOTEBOOK_PATH=notebooks/my_jupyter_report.ipynb
```

> *Add `run-jupyter` to the `Makefile` and install Jupyter if needed.*

---

## 📈 Running Validations in CI/CD

### GitHub Actions

Configured in `.github/workflows/`

### GitLab CI

Configured in `.gitlab-ci.yml`

#### CI/CD Pipeline Flow:

1. Build Docker image
2. Push to registry
3. Run validation inside container
4. Save output as artifact

---

## 📊 Reporting

* Outputs visible in logs & artifacts
* Use `src/reports/` to generate HTML/CSV reports
* Use `notebooks/` for EDA dashboards via Marimo/Jupyter

---

## 🤝 Contributing

We welcome contributions and improvements!
*Contribution guide coming soon in `CONTRIBUTING.md`.*

---

## 📄 License

This project is licensed under the **MIT License**.
See [`LICENSE`](./LICENSE) for more information.
