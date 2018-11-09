FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

ARG TERRAFORM_VERSION=0.11.10
ARG TERRAFORM_CHECKSUM=43543a0e56e31b0952ea3623521917e060f2718ab06fe2b2d506cfaa14d54527

RUN \
    # Upgrade packages
    apt-get update && \
        apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    # Install packages
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        nano \
        software-properties-common \
        unzip \
        wget && \
    # Install Git & Gitflow toolset
    apt-get install -y git-flow && \
    # Install OpenStack command-line client
    apt-get install -y python-openstackclient && \
    # Install Terraform
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
        echo "${TERRAFORM_CHECKSUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform.checksum && \
        sha256sum --strict --check terraform.checksum && \
        unzip -u terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin && \
        rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip terraform.checksum && \
    # Install Ansible
    apt-add-repository -y ppa:ansible/ansible && \
        apt-get update && \
        apt-get install -y ansible && \
    # Clean
    apt-get clean && \
        rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*
