FROM nvidia/cuda:11.6.2-cudnn8-runtime-ubuntu20.04
LABEL maintainer="kunyuan.yao@gmail.com"
ARG CONDA_DIR=/opt/conda
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
RUN curl https://sh.rustup.rs -sSf -o cargo_install.sh && bash cargo_install.sh -y && rm -rf cargo_install.sh

# install lunarvim
RUN wget https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh && \
    chmod +x install.sh && \
    bash install.sh --no-install-dependencies && \
    echo 'export PATH="$HOME/.local/bin/:$PATH"' >>~/.bashrc

RUN lvim +LvimUpdate +q

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
    rm -rf ~/.cache/pip \
WORKDIR /root

ENV CUDA_HOME=/usr/local/cuda
ENV CUDA_ROOT=$CUDA_HOME
ENV PATH=$PATH:$CUDA_ROOT/bin:$HOME/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64
