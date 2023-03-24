#!/usr/bin/env bash
set -eo pipefail

sudo apt install -y gcc make openssh-server curl wget git apt-utils
sudo apt install -y build-essential

# install python
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh
/bin/bash /tmp/miniconda.sh -b -p /opt/conda
rm -rf /tmp/*
sudo apt clean
echo ". /opt/conda/bin/activate" >> ~/.bashrc

# install node 16
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
bash /tmp/nodesource_setup.sh
sudo apt install nodejs -y

# or install node with nvm
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# nvm install v16

# Optional: use and uninstall
# nvm use v16
# nvm uninstall v16


# install lunarvim
curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh | bash

echo 'export PATH="$HOME/.local/bin/:$PATH"' >> ~/.bashrc
echo "alias vim=~/.local/bin/lvim" >> ~/.bashrc
echo "lvim.keys.insert_mode['kj'] = '<ESC>'" >> ~/.config/lvim/config.lua

# need install black: pip install black
echo 'local formatters = require "lvim.lsp.null-ls.formatters"'  >> ~/.config/lvim/config.lua
echo 'formatters.setup {{ name = "black" }}' >> ~/.config/lvim/config.lua

RUN curl https://getcroc.schollz.com | bash