# Use a base image with Python and Java (for PySpark and JDBC)
FROM openjdk:11-jre-slim-buster

# Install Python and uv
RUN apt-get update && apt-get install -y --no-install-recommends     python3     python3-pip     python3-venv     && rm -rf /var/lib/apt/lists/*

# Install uv globally for project management
RUN pip install uv

# Set environment variables for Spark (adjust as needed)
ENV SPARK_HOME="/opt/spark"
ENV PATH="${PATH}:${SPARK_HOME}/bin:${SPARK_HOME}/sbin"
ENV PYTHONPATH="${PYTHONPATH}:${SPARK_HOME}/python:${SPARK_HOME}/python/lib/py4j-0.10.9.5-src.zip"

# Download and extract Spark (adjust version as needed)
ARG SPARK_VERSION=3.4.0
ARG HADOOP_VERSION=3
RUN wget -qO /tmp/spark.tgz https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz     && tar -xzf /tmp/spark.tgz -C /opt     && mv /opt/spark-${SPSPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME}     && rm /tmp/spark.tgz

# Copy JDBC drivers (example: Teradata. You'll need to provide your actual driver)
# Place your JDBC driver JARs in a 'drivers' directory next to the Dockerfile
# RUN mkdir -p ${SPARK_HOME}/jars/drivers
# COPY drivers/terajdbc4.jar ${SPARK_HOME}/jars/drivers/
# ENV SPARK_CLASSPATH="${SPARK_HOME}/jars/drivers/*" # Add to Spark classpath

# Set working directory
WORKDIR /app

# Copy dependency lock file and install dependencies
# This is crucial for Docker caching. requirements.txt is generated from pyproject.toml by uv.
COPY requirements.txt .
RUN uv sync --system # --system for global installation within Docker image, if needed or can use venv

COPY . .

# Ensure entrypoint script is executable
RUN chmod +x entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["./entrypoint.sh"]
