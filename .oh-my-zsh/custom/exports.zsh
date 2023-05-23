# EXPORTS & PATHS

# PHP
#export PATH="/usr/local/opt/php@8.1/bin:$PATH"
#export PATH="/usr/local/opt/php@8.1/sbin:$PATH"

# Dynamic path for Node.
export NODE_PATH=`which node`

# Set path for NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
