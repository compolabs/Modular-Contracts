contract;

mod events;
mod errors;

use events::{AddModuleEvent, RemoveModuleEvent};
use errors::AuthError;
use IUserACL::{Info, UserACL};
use std::{constants::ZERO_B256, hash::Hash,};

configurable {
    OWNER: Address = Address::from(ZERO_B256),
}

storage {
    // Map(module, bool)
    ACL: StorageMap<ContractId, bool> = StorageMap {},
}

impl UserACL for Contract {
    #[storage(read, write)]
    fn add(module: ContractId) {
        require(
            msg_sender()
                .unwrap()
                .as_address()
                .unwrap() == OWNER,
            AuthError::Unauthorized,
        );
        storage.ACL.insert(module, true);

        log(AddModuleEvent { module })
    }

    #[storage(read, write)]
    fn remove(module: ContractId) {
        require(
            msg_sender()
                .unwrap()
                .as_address()
                .unwrap() == OWNER,
            AuthError::Unauthorized,
        );
        storage.ACL.insert(module, false);

        log(RemoveModuleEvent { module })
    }
}

impl Info for Contract {
    #[storage(read)]
    fn authorized(module: ContractId) -> bool {
        storage.ACL.get(module).try_read().unwrap_or(false)
    }
}
