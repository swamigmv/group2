#!/bin/bash
sudo yum update -y
sudo yum -y install git
cd /home/ec2-user
git clone https://github.com/swamigmv/group2.git
export PATH=$PATH:/home/ec2-user/group2/geth/
sudo chown ec2-user /home/ec2-user/group2/geth/
chmod -R 755 /home/ec2-user/group2/geth/
mkdir -p /home/ec2-user/bnode
cat << 'EOF' > /home/ec2-user/.bashrc

if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi
export PATH=$PATH:/home/ec2-user/group2/geth/
EOF
geth init /home/ec2-user/genesis_node.json
cd /home/ec2-user/bnode

bootnode -genkey boot.key
bootnode -nodekey ./boot.key  -verbosity 7 -addr 127.0.0.1:30301 > /home/ec2-user/bnode/enode_addr.ts
