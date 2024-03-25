library;

pub struct AddModuleEvent {
    function: b256,
    module: ContractId,
}

pub struct RemoveModuleEvent {
    function: b256,
    module: ContractId,
}
