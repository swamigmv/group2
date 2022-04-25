#run main.py (shared seperately) to setup aws keys in local
#change the paths in the file as per local system

#run the following command to start cloudformation
aws cloudformation create-stack  --template-body file://cloud_formation_capstone.json --region us-east-1 --stack-name gl-group2-project1

#Open nuvepro and access aws console.
#if cloud formation is success, navigate to ec2 page.
#we should see 3 ec2 instances created.

#select the first instance, copy the public ip and open winscp
#provide ip and private key in winscp and connect
#this should open the terminal,
#user name is ec2-user
#this should be either of the 3 instances (with eagleaccount1 or eagleaccount2 or bootnode
#ls command will provide the folders created and should give us idea on which node this is
ls

#open the cloud init logs to get account id created, should be opened with sudo
sudo vi /var/logs/cloud-init-output.log (check the log file might be some change)

#in the log files(above), first 2 accounts are customer account and third one is eagle account
#Below order is specific in userdata commands
#node1
#------
#account no of Swami
#account no of Vishal
#account no of EagleAccount1
#node2
#------
#account no of Pinakin
#account no of Madhavi
#account no of EagleAccount2

#--------------------------------------------------------------------------
#create genesis node with puppeth command
#run puppeth command with following inputs
#network name - group2
#option 2 - ‘Configure new genesis’
#option 1 - ‘Create new genesis from scratch’
#option 2 - ‘Clique - proof-of-authority’
#press enter(default value)
#Which accounts are allowed to seal - provide eagleAccount1 & eagleAccount2's account number
#Which accounts should be pre-funded? - provide all 6 accounts
#Should the precompile-addresses - type Yes
#Specify your chain/network ID - 54321
#in forthcoming, export the generated genesis file

#we should now see group2.json generated.
#transfer the file to other 2 nodes through winscp(easier option)

#--------------------------------------------------------------------------
#open putty of bootnode and fire below commands
geth init /home/ec2-user/genesis_node.json
bootnode -genkey boot.key
bootnode -nodekey ./boot.key  -verbosity 7 -addr 127.0.0.1:30301
#copy the enode url

#open putty of other 2 EC2 instances and fire below commands
cd Swami
geth --datadir ./data init ../group2.json
cd Vishal
geth --datadir ./data init ../group2.json
cd EagleAccount1
geth --datadir ./data init ../group2.json
cd Pinakin
geth --datadir ./data init ../group2.json
cd Madhavi
geth --datadir ./data init ../group2.json
cd EagleAccount2
geth --datadir ./data init ../group2.json

#fire below commands to start instances
#things to change
#--bootnode - change enode url and provate ip of bootnode
#--unlock - change the account no accordingly

geth --networkid 54321 --nodiscover --datadir /home/ec2-user/EagleAccount1/data --bootnodes enode://d7b9172c4d12fa91403ac0330b74c84213e559b1f1945d77021e6e825cbf639c9cd401d301043aec6eac4bacb2e21e98209c06c64e395905029e18cdac44af6f@191.0.0.92:30301 --port 30302 --http.port 8546 --syncmode 'full'  --allow-insecure-unlock --http --http.addr 0.0.0.0 --http.corsdomain '*' --unlock '0xAd193319a9D2205B1240Dd49349955D2e3548C89' --password /home/ec2-user/EagleAccount1/pwd.txt --rpc.allow-unprotected-txs --nodiscover --http.api db,web3,eth,debug,personal,admin,txpool,net --vmdebug --mine console
geth --networkid 54321 --nodiscover --datadir /home/ec2-user/Swami/data --bootnodes enode://d7b9172c4d12fa91403ac0330b74c84213e559b1f1945d77021e6e825cbf639c9cd401d301043aec6eac4bacb2e21e98209c06c64e395905029e18cdac44af6f@191.0.0.92:30301 --port 30303 --http.port 8547 --syncmode 'full'  --allow-insecure-unlock --http --http.addr 0.0.0.0 --http.corsdomain '*' --unlock '0x7Ed8E83D316C9021814DB9cAd3bf194A2Fab5b5c' --password /home/ec2-user/Swami/pwd.txt --rpc.allow-unprotected-txs  --nodiscover --http.api db,web3,eth,debug,personal,admin,txpool,net --vmdebug console
geth --networkid 54321 --nodiscover --datadir /home/ec2-user/Vishal/data --bootnodes enode://d7b9172c4d12fa91403ac0330b74c84213e559b1f1945d77021e6e825cbf639c9cd401d301043aec6eac4bacb2e21e98209c06c64e395905029e18cdac44af6f@191.0.0.92:30301 --port 30304 --http.port 8545 --syncmode 'full'  --allow-insecure-unlock --http --http.addr 0.0.0.0 --http.corsdomain '*' --unlock '0xcaB49945Ff3794BE9ea1626e29b08C561b40Ec4b' --password /home/ec2-user/Vishal/pwd.txt --rpc.allow-unprotected-txs --nodiscover --http.api db,web3,eth,debug,personal,admin,txpool,net --vmdebug console

geth --networkid 54321  --datadir /home/ec2-user/EagleAccount2/data --bootnodes enode://d7b9172c4d12fa91403ac0330b74c84213e559b1f1945d77021e6e825cbf639c9cd401d301043aec6eac4bacb2e21e98209c06c64e395905029e18cdac44af6f@191.0.0.92:30301 --port 30302 --http.port 8546 --syncmode 'full'  --allow-insecure-unlock --http --http.addr 0.0.0.0 --http.corsdomain '*' --unlock '0x1A6cDbe6314E11315014a1BFe3CaA054F38c113c' --password /home/ec2-user/EagleAccount2/pwd.txt --rpc.allow-unprotected-txs  --nodiscover --http.api db,web3,eth,debug,personal,admin,txpool,net --vmdebug --mine console
geth --networkid 54321 --nodiscover --datadir /home/ec2-user/Pinakin/data --bootnodes enode://d7b9172c4d12fa91403ac0330b74c84213e559b1f1945d77021e6e825cbf639c9cd401d301043aec6eac4bacb2e21e98209c06c64e395905029e18cdac44af6f@191.0.0.92:30301 --port 30303 --http.port 8547 --syncmode 'full'  --allow-insecure-unlock --http --http.addr 0.0.0.0 --http.corsdomain '*' --unlock '0xF6A6ff6F5A01F777F461B8a1A0c8a3c15433ba4A' --password /home/ec2-user/Pinakin/pwd.txt --rpc.allow-unprotected-txs --nodiscover --http.api db,web3,eth,debug,personal,admin,txpool,net --vmdebug console
geth --networkid 54321 --nodiscover --datadir /home/ec2-user/Madhavi/data --bootnodes enode://d7b9172c4d12fa91403ac0330b74c84213e559b1f1945d77021e6e825cbf639c9cd401d301043aec6eac4bacb2e21e98209c06c64e395905029e18cdac44af6f@191.0.0.92:30301 --port 30304 --http.port 8545 --syncmode 'full'  --allow-insecure-unlock --http --http.addr 0.0.0.0 --http.corsdomain '*' --unlock '0xf0aac361b732437320302B8EC7e1Df56D8155e85' --password /home/ec2-user/Madhavi/pwd.txt --rpc.allow-unprotected-txs --nodiscover  --http.api db,web3,eth,debug,personal,admin,txpool,net --vmdebug console

#As the nodes are started, get the enode url of individual nodes
#run below command to connect the nodes
#Change the enode and the private ip here
admin.addPeer('enode://ea996276c5d7039f783558fa9fa480e371d8c86b4689c1ad93ba8a5ffc5abe571fcaca587612597273588a0c6f7c46571227c917e1c71fef39a2a4d034c0173b@191.0.0.103:30302')
admin.addPeer('enode://c726ee937bad5c7cf831a0848a0394044553d6569e1ba310456dc06dbec7f129166c8197fb71e17130a47617891c91be1e1d3c0d753e6ed745c2715694a096b5@191.0.0.103:30303')
admin.addPeer('enode://2cd7a89a05cb717324cbd9897e3e316e408532faf2ee1dad89d1b5d9cd13e7b984de9c714dc6f6fab87033fb405769b4b02ccff0a9fdd70642497bbaa209cacf@191.0.0.103:30304')

admin.addPeer('enode://70d99c123d021489d2eb375e0317010bb24c0f503f918b0f4138fcb56f7fd70f45bae785dc68933d5977cb9dbb9f9d3c28d0607e5d6e701d6f67e4bbe2bdcd97@191.0.0.81:30302')
admin.addPeer('enode://7cfea432aea448e0651008df90a6a3c463af68ba16612e5da21f1eab14764495cbf06a4d0f13a82e5cfd20697bebc6599827c631a6bf65ea15eb2d4160f8bcab@191.0.0.81:30303')
admin.addPeer('enode://51595f51f0d0212ee440de935ea3f7418aca500183a1095e3eab4e417fe30dc3f7b0b8fd82bff359d68037d6d8d2b7d3df04e1b7089453e72b5fc7d03d8cae04@191.0.0.81:30304')

#Verification of nodes
eth.getBalance("0xAd193319a9D2205B1240Dd49349955D2e3548C89")
eth.getBalance("0xf0aac361b732437320302B8EC7e1Df56D8155e85")
eth.getBalance("0xE5356CD50de29855cd4b898eB02262C86ceCf88F")

eth.sendTransaction({from: "0xAd193319a9D2205B1240Dd49349955D2e3548C89",to: "0xf0aac361b732437320302B8EC7e1Df56D8155e85", value: "10000000000000000000000000"})
