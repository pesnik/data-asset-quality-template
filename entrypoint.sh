#!/bin/bash
set -e

# Set Spark properties (can be overridden by docker run -e or spark-submit args)
# Example: export PYSPARK_SUBMIT_ARGS="--driver-memory 8g --executor-memory 8g --num-executors 10 --jars /opt/spark/jars/drivers/terajdbc4.jar --conf spark.driver.extraJavaOptions=-Dlog4j.configuration=file:/app/log4j.properties pyspark-shell"

# Ensure Spark is in PATH for spark-submit
export PATH="/home/pesnik/.local/bin:/home/pesnik/.cargo/bin:/home/pesnik/.nvm/versions/node/v24.1.0/bin:/home/pesnik/.sdkman/candidates/java/current/bin:/home/pesnik/.pyenv/shims:/home/pesnik/.pyenv/bin:/home/pesnik/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/mnt/d/Tools/InformaticaInstallation/clients/tools/datadirect:/mnt/d/Tools/InformaticaInstallation/clients/tools/odbcdrv:/mnt/d/Tools/InformaticaInstallation/clients/tools/jdbcdrv:/mnt/d/Tools/InformaticaInstallation/clients/tools/sharedlibs:/mnt/c/Program Files (x86)/Common Files/Oracle/Java/javapath:/mnt/c/WINDOWS/system32:/mnt/c/WINDOWS:/mnt/c/WINDOWS/System32/Wbem:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/:/mnt/c/WINDOWS/System32/OpenSSH/:/mnt/c/Program Files/PuTTY/:/mnt/c/Program Files/Vagrant/bin:/mnt/d/DockerInstallation/resources/bin:/mnt/c/Users/mr.hasan/.cargo/bin:/mnt/c/Users/mr.hasan/AppData/Local/Programs/Python/Python36/Scripts/:/mnt/c/Users/mr.hasan/AppData/Local/Programs/Python/Python36/:/mnt/c/Users/mr.hasan/AppData/Local/Microsoft/WindowsApps:/mnt/c/Users/mr.hasan/AppData/Local/Programs/Git/cmd:/mnt/d/Tools/apache-maven-3.9.5/bin:/mnt/c/Users/mr.hasan/AppData/Local/Programs/Microsoft VS Code/bin:/mnt/c/Tools/Graphviz/bin:/mnt/c/Users/mr.hasan/AppData/Local/Programs/Git LFS:/mnt/c/Program Files/Multipass/bin:/mnt/d/Tools/flutter/bin:/mnt/c/users/mr.hasan/.local/bin:/mnt/c/Users/mr.hasan/AppData/Local/Microsoft/WinGet/Packages/Schniz.fnm_Microsoft.Winget.Source_8wekyb3d8bbwe:/mnt/c/Users/mr.hasan/AppData/Local/Microsoft/WinGet/Packages/DenoLand.Deno_Microsoft.Winget.Source_8wekyb3d8bbwe:/mnt/c/Users/mr.hasan/AppData/Local/Programs/Ollama:/snap/bin:/bin"

# Check for a specific command prefix
case "$1" in
  marimo)
    shift # Remove "marimo" argument
    echo "Starting Marimo app: ${@}"
    # Marimo needs to be run directly with uv if not globally installed, or via python -m marimo
    uv run marimo "$@" --port ${MARIMO_PORT:-8000} --host 0.0.0.0
    ;;
  jupyter)
    shift # Remove "jupyter" argument
    echo "Starting Jupyter notebook: ${@}"
    # uv run jupyter notebook "$@" --port ${JUPYTER_PORT:-8888} --ip 0.0.0.0 --allow-root
    echo "Jupyter not implemented yet. Please install Jupyter and adjust entrypoint.sh"
    exit 1
    ;;
  *)
    # Default to running the main validation script with spark-submit
    spark-submit       --master local[*]       --py-files /app/src.zip       /app/src/main.py "$@"
    ;;
esac
