library;

use ::errors::AuthError;
use IVaultACL::Info;
use std::{hash::{Hash, sha256}, string::String};

pub fn firewall(function: String, acl: ContractId) {
    let selector = sha256(function);
    let module = msg_sender().unwrap().as_contract_id();

    require(module.is_some(), AuthError::ModuleOnly);

    let acl = abi(Info, acl.into());
    require(
        acl
            .authorized(selector, module.unwrap()),
        AuthError::UnauthorizedModule,
    );
}
