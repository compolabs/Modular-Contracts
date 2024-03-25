library;

abi VaultACL {
    #[storage(read, write)]
    fn add(function: b256, module: ContractId);

    #[storage(read, write)]
    fn remove(function: b256, module: ContractId);
}

abi Info {
    #[storage(read)]
    fn authorized(function: b256, module: ContractId) -> bool;
}
