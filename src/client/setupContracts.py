from blockchain import BlockChain
import configuration
from solcx import compile_source
import os

def compile_source_file(file_path):
   file_path = os.path.abspath(file_path)
   with open(file_path, 'r') as f:
      source = f.read()
   return compile_source(source, output_values = ['abi', 'bin'], base_path = os.path.abspath(configuration.CONTRACT_FOLDER + "//.."))

def deploy_contract(contract_name, file_handle, contract_file = ""):
    if contract_file == "":
        contract_file = contract_name

    compiler_output = compile_source_file(configuration.CONTRACT_FOLDER + "/" + contract_file + ".sol")
    contract_id, contract_interface = compiler_output.popitem()

    contract = block_chain.w3.eth.contract(abi = contract_interface["abi"], bytecode = contract_interface["bin"])
    tx_hash = contract.constructor().transact()
    tx_receipt = block_chain.w3.eth.wait_for_transaction_receipt(tx_hash)
    
    if file_handle:
        file_handle.write(contract_name.upper() + " = \"" + tx_receipt.contractAddress + "\"\n")

    return tx_receipt.contractAddress

block_chain = BlockChain()

#print ("Latest Ethereum block number" , w3.eth.blockNumber)
#print ("Balance => " , w3.eth.getBalance("0xddAC623A4334cBF3202589377B239f097D41f0F0"))
block_chain.w3.eth.default_account = configuration.ADMIN_ADDRESS

contract_address_file = open("contract_addresses.py", "w")

print("Deploying Ticket Agreement contract...")
deploy_contract("Ticket_Agreement", contract_address_file, "TicketAgreementV202204")
print("Ticket Agreement contract deployed successfully")
print("Deploying Airline contract...")
deploy_contract("Airline", contract_address_file)
print("Airline contract deployed successfully")
print("Deploying Customer contract...")
deploy_contract("Customer", contract_address_file)
print("Customer contract deployed successfully")

contract_address_file.close()
