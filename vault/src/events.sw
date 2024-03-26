library;

pub struct DepositEvent {
    amount: u64,
    asset: AssetId,
    user: Identity,
}
