contract;

mod events;
mod errors;

use events::{AddModuleEvent, RemoveModuleEvent};
use errors::AuthError;
use IVaultACL::{Info, VaultACL};
use std::{constants::ZERO_B256, hash::Hash,};

configurable {
    OWNER: Address = Address::from(ZERO_B256),
}

storage {
    // Map(fn => Map(module, bool))
    ACL: StorageMap<b256, StorageMap<ContractId, bool>> = StorageMap {},
}

impl VaultACL for Contract {
    #[storage(read, write)]
    fn add(function: b256, module: ContractId) {
        require(
            msg_sender()
                .unwrap()
                .as_address()
                .unwrap() == OWNER,
            AuthError::Unauthorized,
        );
        storage.ACL.get(function).insert(module, true);

        log(AddModuleEvent {
            function,
            module,
        })
    }

    #[storage(read, write)]
    fn remove(function: b256, module: ContractId) {
        require(
            msg_sender()
                .unwrap()
                .as_address()
                .unwrap() == OWNER,
            AuthError::Unauthorized,
        );
        storage.ACL.get(function).insert(module, false);

        log(RemoveModuleEvent {
            function,
            module,
        })
    }
}

impl Info for Contract {
    #[storage(read)]
    fn authorized(function: b256, module: ContractId) -> bool {
        storage.ACL.get(function).get(module).try_read().unwrap_or(false)
    }
}
