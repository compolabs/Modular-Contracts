library;

pub struct AddACLEvent {
    acl: ContractId,
    user: Address,
}

pub struct RemoveACLEvent {
    acl: ContractId,
    user: Address,
}
