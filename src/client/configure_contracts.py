from blockchain import BlockChain
import configuration
import contract_addresses

def configure_airline_contract(block_chain):
    airline_contract = block_chain.get_contract(contract_addresses.AIRLINE, "Airline")
    #tx_hash = airline_contract.functions.setTicketAgreement(contract_addresses.TICKET_AGREEMENT).transact()
    #tx_receipt = block_chain.w3.eth.wait_for_transaction_receipt(tx_hash)
    #print(dict(tx_receipt))
    output = airline_contract.functions.getWallet().call()
    print(output)

block_chain = BlockChain()

print("Configuring airline contract...")
configure_airline_contract(block_chain)
