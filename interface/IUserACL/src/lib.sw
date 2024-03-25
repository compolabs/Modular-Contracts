library;

abi UserACL {
    #[storage(read, write)]
    fn add(module: ContractId);

    #[storage(read, write)]
    fn remove(module: ContractId);
}

abi Info {
    #[storage(read)]
    fn authorized(module: ContractId) -> bool;
}
