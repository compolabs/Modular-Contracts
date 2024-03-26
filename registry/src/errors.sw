library;

pub enum AuthError {
    Unauthorized: (),
}

pub enum RemoveError {
    MissingACL: (),
}
