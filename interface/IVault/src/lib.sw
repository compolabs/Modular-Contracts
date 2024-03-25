library;

abi Vault {
    #[payable]
    #[storage(read, write)]
    fn deposit(user: Identity);
}

abi User {
    #[storage(read)]
    fn balance(user: Identity, asset: AssetId) -> u64;
}
