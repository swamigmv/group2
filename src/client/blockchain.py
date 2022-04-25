from web3 import Web3, HTTPProvider
from web3.middleware import geth_poa_middleware
import configuration
import os


class BlockChain:
    
    def __init__(self):
        self.__w3__ = Web3(HTTPProvider(configuration.BLOCK_CHAIN_URL))
        self.__w3__.middleware_onion.inject(geth_poa_middleware, layer=0)

    @property
    def w3(self):
        return self.__w3__

    def get_contract(self, contract_address, abi_name):
        file_path = os.path.abspath(configuration.ABI_FOLDER) + "\\" + abi_name + ".abi"
        with open(file_path, "r") as f:
            abi = f.read() 
        airline_contract = self.__w3__.eth.contract(address = contract_address, abi = abi)
        return airline_contract