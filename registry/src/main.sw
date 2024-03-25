contract;

mod events;
mod errors;

use events::{AddACLEvent, RemoveACLEvent};
use errors::{AuthError, RemoveError};
use IRegistry::{Info, Registry};
use std::{constants::ZERO_B256, hash::Hash};

configurable {
    OWNER: Address = Address::from(ZERO_B256),
}

storage {
    // Map(user => acl)
    registry: StorageMap<Address, Option<ContractId>> = StorageMap {},
}

impl Registry for Contract {
    #[storage(read, write)]
    fn add(acl: ContractId, user: Address) {
        require(
            msg_sender()
                .unwrap()
                .as_address()
                .unwrap() == OWNER,
            AuthError::Unauthorized,
        );
        storage.registry.insert(user, Some(acl));

        log(AddACLEvent { acl, user })
    }

    #[storage(read, write)]
    fn remove(user: Address) {
        require(
            msg_sender()
                .unwrap()
                .as_address()
                .unwrap() == OWNER,
            AuthError::Unauthorized,
        );

        let acl = storage.registry.get(user).read();
        require(acl.is_some(), RemoveError::MissingACL);

        storage.registry.insert(user, None);

        log(RemoveACLEvent {
            acl: acl.unwrap(),
            user,
        })
    }
}

impl Info for Contract {
    #[storage(read)]
    fn acl(user: Address) -> Option<ContractId> {
        storage.registry.get(user).try_read().unwrap_or(None)
    }
}
