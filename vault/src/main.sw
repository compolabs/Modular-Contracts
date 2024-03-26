contract;

mod errors;
mod events;
mod utils;

use events::DepositEvent;
use IVault::{User, Vault};
use std::{
    asset::transfer,
    call_frames::msg_asset_id,
    constants::ZERO_B256,
    context::msg_amount,
    hash::Hash,
    string::String,
};
use utils::firewall;

configurable {
    ACL: ContractId = ContractId::from(ZERO_B256),
}

storage {
    balances: StorageMap<Identity, StorageMap<AssetId, u64>> = StorageMap {},
}

impl Vault for Contract {
    #[payable]
    #[storage(read, write)]
    fn deposit(user: Identity) {
        firewall(String::from_ascii_str("deposit(Identity)"), ACL);

        let balance = storage.balances.get(user).get(msg_asset_id()).try_read().unwrap_or(0);
        storage
            .balances
            .get(user)
            .insert(msg_asset_id(), balance + msg_amount());

        log(DepositEvent {
            user,
            asset: msg_asset_id(),
            amount: msg_amount(),
        })
    }
}

impl User for Contract {
    #[storage(read)]
    fn balance(user: Identity, asset: AssetId) -> u64 {
        storage.balances.get(user).get(asset).try_read().unwrap_or(0)
    }
}
