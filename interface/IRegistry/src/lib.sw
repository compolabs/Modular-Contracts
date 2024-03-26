library;

abi Registry {
    #[storage(read, write)]
    fn add(acl: ContractId, user: Address);

    #[storage(read, write)]
    fn remove(user: Address);
}

abi Info {
    #[storage(read)]
    fn acl(user: Address) -> Option<ContractId>;
}
