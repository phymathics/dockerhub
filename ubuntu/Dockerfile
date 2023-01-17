#FROM pytorch/pytorch:1.12.1-cuda11.3-cudnn8-runtime
FROM ubuntu:22.04
LABEL maintainer="kunyuan.yao@gmail.com"
ARG CONDA_DIR=/opt/conda

#RUN sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && \
#    sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && \
#    apt update

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shangha
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN apt update
RUN apt install -y --no-install-recommends ca-certificates
RUN DEBIAN_FRONTEND=noninteractive apt install -y gcc make openssh-server curl wget git apt-utils
RUN apt install -y build-essential

# install neovim
#RUN apt add-apt-repository ppa:neovim-ppa/unstable && apt update && apt install neovim
RUN wget https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.deb && \
    apt install ./nvim-linux64.deb

# install node
RUN curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
RUN bash /tmp/nodesource_setup.sh
RUN apt install nodejs -y

# install cargo in container
#RUN curl https://sh.rustup.rs -sSf | bash

# install lunarvim
#RUN wget https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh && \
COPY ./lunarvim_install.sh ./install.sh
RUN chmod +x install.sh && \
    bash install.sh --no-install-dependencies && \
    echo 'export PATH="$HOME/.local/bin/:$PATH"' >>~/.bashrc && \
    echo "alias vim=~/.local/bin/lvim" >> ~/.bashrc

RUN ~/.local/bin/lvim +LvimUpdate +q && \
    ~/.local/bin/lvim +PackerSync +q && \
    ~/.local/bin/lvim +PackerCompile +q && \
    ~/.local/bin/lvim +PackerClean +q && \
    echo "lvim.keys.insert_mode['kj'] = '<ESC>'" >> ~/.config/lvim/config.lua

# python
ENV PATH $CONDA_DIR/bin:$PATH
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
RUN apt install -y --no-install-recommends ca-certificates && \
    echo 'export PATH=$CONDA_DIR/bin:$PATH' > /etc/profile.d/conda.sh && \
    /bin/bash /tmp/miniconda.sh -b -p $CONDA_DIR && \
    rm -rf /tmp/* && \
    apt-get clean
RUN conda && \
    echo ". ${CONDA_DIR}/bin/activate" >> ~/.bashrc
# RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/
RUN pip install --upgrade pip && \
    rm -rf ~/.cache/pip

RUN curl https://getcroc.schollz.com | bash
WORKDIR /root