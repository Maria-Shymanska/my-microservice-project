

# ========== CONFIG ==========
TOOLS_TO_INSTALL=("docker.io" "docker-compose" "python3" "python3-venv" "python3-pip")
PYTHON_TOOLS=("Django")
PYTHON_VENV_PATH="$HOME/project-env"
LOG_FILE="$HOME/install_dev_tools.log"

# ========== LOGGING FUNCTION ==========
log() {
    local level=$1
    local msg=$2
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $msg" | tee -a "$LOG_FILE"
}

# ========== INSTALL FUNCTION ==========
install_tool() {
    local tool=$1
    if ! dpkg -l | grep -q "$tool"; then
        log "INFO" "Installing $tool..."
        sudo apt-get install -y "$tool"
        if [ $? -eq 0 ]; then
            log "INFO" "$tool installed successfully."
        else
            log "ERROR" "Failed to install $tool."
            exit 1
        fi
    else
        log "INFO" "$tool is already installed."
    fi
}

# ========== MAIN ==========
log "INFO" "Starting installation process..."
sudo apt-get update -y
sudo apt-get upgrade -y

for tool in "${TOOLS_TO_INSTALL[@]}"; do
    install_tool "$tool"
done

# ========== PYTHON ENVIRONMENT ==========
if [ ! -d "$PYTHON_VENV_PATH" ]; then
    log "INFO" "Creating Python virtual environment at $PYTHON_VENV_PATH ..."
    python3 -m venv "$PYTHON_VENV_PATH"
else
    log "INFO" "Virtual environment already exists."
fi

# Activate venv
# shellcheck disable=SC1090
source "$PYTHON_VENV_PATH/bin/activate"

for pkg in "${PYTHON_TOOLS[@]}"; do
    if ! pip show "$pkg" &> /dev/null; then
        log "INFO" "Installing Python package: $pkg..."
        pip install "$pkg"
        log "INFO" "$pkg installed successfully."
    else
        log "INFO" "$pkg is already installed."
    fi
done

log "INFO" "Installation completed successfully."

# Print quick verification
echo
echo "=== Quick verification ==="
if command -v docker &> /dev/null; then docker --version; else echo "docker: not found"; fi
if command -v docker-compose &> /dev/null; then docker-compose --version; else echo "docker-compose: not found (try: docker compose version)"; fi
python3 --version || true
django-admin --version || true
echo "=========================="
