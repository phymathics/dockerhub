TORCH_IMAGE=beidongjiedeguang/pytorch:cuda11.3-cudnn8-ubuntu2004
PADDLE_IMAGE=beidongjiedeguang/paddle:cuda11.3-cudnn8-ubuntu2004
ALL_IN_ONE_IMAGE=beidongjiedeguang/pytorch-paddlenlpe-node:cuda11.3-cudnn8-ubuntu2004
UBUNTU_IMAGE=beidongjiedeguang/ubuntu:22.04
CONTAINER=torch-gpu-container


build-torch:
	docker build -t $(TORCH_IMAGE) -f ./torch/Dockerfile .

build-paddle:
	docker build -t $(PADDLE_IMAGE) -f ./torch/Dockerfile .

build-all:
	docker build -t $(ALL_IN_ONE_IMAGE) -f ./all/Dockerfile .

build-node:
	docker build -t $(ALL_IN_ONE_IMAGE) -f ./node/Dockerfile .

build-ubuntu:
	wget https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh -O ./lunarvim_install.sh
	docker build -t $(UBUNTU_IMAGE) -f ./ubuntu/Dockerfile .

run:
	docker run --rm --gpus all -it -v $(shell pwd):/home/ $(TORCH_IMAGE)  bash

start: 
	docker run -itd --gpus all --name $(CONTAINER) -v $(shell pwd):/home/ $(TORCH_IMAGE) bash

restart: 
	docker rm -f $(CONTAINER)
	docker run -itd --gpus all --name $(CONTAINER) $(TORCH_IMAGE) bash

