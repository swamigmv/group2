#!/bin/bash
sudo yum update -y
sudo yum -y install git
MINER_NAME="EagleAccount1"
cd /home/ec2-user
git clone https://github.com/swamigmv/group2.git
export PATH=$PATH:/home/ec2-user/group2/geth/
chown ec2-user /home/ec2-user/group2/geth/
chmod -R 755 /home/ec2-user/group2/geth/
mkdir -p /home/ec2-user/Swami
mkdir -p /home/ec2-user/Vishal
mkdir -p /home/ec2-user/EagleAccount1

cat << 'EOF' > /home/ec2-user/Swami/pwd.txt
node
EOF
cat << 'EOF' > /home/ec2-user/Vishal/pwd.txt
node
EOF
cat << 'EOF' > /home/ec2-user/EagleAccount1/pwd.txt
acct1
EOF
cat << 'EOF' > /home/ec2-user/.bashrc

if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi
export PATH=$PATH:/home/ec2-user/group2/geth/
EOF
cd /home/ec2-user/Swami
geth --datadir ./data account new  --password /home/ec2-user/Swami/pwd.txt
cd /home/ec2-user/Vishal
geth --datadir ./data account new --password /home/ec2-user/Vishal/pwd.txt
cd /home/ec2-user/EagleAccount1
geth --datadir ./data account new --password /home/ec2-user/EagleAccount1/pwd.txt

sudo chown -R ec2-user /home/ec2-user/Swami
sudo chown -R ec2-user /home/ec2-user/Vishal
sudo chown -R ec2-user /home/ec2-user/EagleAccount1

#!/bin/bash
sudo yum update -y
sudo yum -y install git
MINER_NAME="EagleAccount1"
cd /home/ec2-user
git clone https://github.com/swamigmv/group2.git
export PATH=$PATH:/home/ec2-user/group2/geth/
chown ec2-user /home/ec2-user/group2/geth/
chmod -R 755 /home/ec2-user/group2/geth/
mkdir -p /home/ec2-user/Pinakin
mkdir -p /home/ec2-user/Madhavi
mkdir -p /home/ec2-user/EagleAccount2
cat << 'EOF' > /home/ec2-user/Pinakin/pwd.txt
node
EOF
cat << 'EOF' > /home/ec2-user/Madhavi/pwd.txt
node
EOF
cat << 'EOF' > /home/ec2-user/EagleAccount2/pwd.txt
acct2
EOF
cat << 'EOF' > /home/ec2-user/.bashrc

if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi
export PATH=$PATH:/home/ec2-user/group2/geth/
EOF
cd /home/ec2-user/Pinakin
geth --datadir ./data account new  --password /home/ec2-user/Pinakin/pwd.txt
cd /home/ec2-user/Madhavi
geth --datadir ./data account new --password /home/ec2-user/Madhavi/pwd.txt
cd /home/ec2-user/EagleAccount2
geth --datadir ./data account new --password /home/ec2-user/EagleAccount2/pwd.txt
sudo chown -R ec2-user /home/ec2-user/Pinakin
sudo chown -R ec2-user /home/ec2-user/Madhavi
sudo chown -R ec2-user /home/ec2-user/EagleAccount2