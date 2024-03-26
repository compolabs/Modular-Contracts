contract;

mod interface;

use interface::Deposit;
use IVault::Vault;
use std::{call_frames::msg_asset_id, context::msg_amount};

impl Deposit for Contract {
    #[payable]
    fn deposit(vault: ContractId) {
        let target = abi(Vault, vault.into());

        // additional module logic before calling the target to deposit
        target.deposit {
            asset_id: msg_asset_id().into(),
            coins: msg_amount(),
        }(msg_sender().unwrap())
    }
}
