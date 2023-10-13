# Set the path to your Conda environments directory
CONDA_ENVS_DIR="$HOME/miniconda3/envs"

# Set the path to your venv environments directory
VENV_ENVS_DIR="$HOME/.virtualenvs"

# Function to activate a Conda environment
activate_conda_env() {
    conda activate "$CONDA_ENVS_DIR/$1"
}

# Function to activate a venv environment
activate_venv_env() {
    if [ -d ".venv" ]; then
        source .venv/bin/activate
    else
        echo "Error: no .venv folder found"
    fi
}

# Function to list all Conda and venv environments
list_environments() {
    echo "Conda Environments:"
    echo "$(ls -1 "$CONDA_ENVS_DIR")"
}

# Define an alias to activate a Conda environment
alias ca='activate_conda_env'

# Define an alias to activate a venv environment
alias va='activate_venv_env'

# Define an alias to list all Conda and venv environments
alias le='list_environments'

alias de='conda deactivate && deactivate'

