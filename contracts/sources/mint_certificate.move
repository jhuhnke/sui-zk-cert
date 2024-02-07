module certificate::Certificate {
    use sui::object::{Self, ID, UID}; 
    use sui::tx_context::{Self, TxContext};
    use sui::transfer; 
    use std::string;

    // ===== Structs =====
    struct Certificate has key {
        id: UID, 
        age: bool, 
        country: string::String, 
    }

    struct MintCertificateEvent has copy, drop {
        object_id: ID, 
        creator: address
    }

    struct Ownership has key {
        id: UID
    }

    // ===== Initializer =====
    fun init(ctx: &mut TxContext) {
        let ownership = Ownership {
            id: object::new(ctx)
        }; 

        transfer::transfer(ownership, tx_context::sender(ctx)); 
    }

    // ===== Minting Function =====
    entry fun mint(age: bool, country: vector<u8>, ctx: &mut TxContext) {
        let sender = tx_context::sender(ctx); 

        let cert = Certificate {
            id: object::new(ctx), 
            age: age, 
            country: string::utf8(country)
        }; 

        event::emit(MintCertificateEvent {
            object_id: object::uid_to_inner(&cert.id), 
            creator: sender
        }); 

        transfer::transfer(cert, sender)
    }

    // ===== Burn Function =====
    entry fun burn(cert: Certificate) {
        let Certificate { id, age: _, country: _ } = cert; 
        object::delete(id); 
    }

    // ===== Getters =====
    public fun age(cert: &Certificate): &bool {
        &cert.age
    }
    
    public fun country(cert: &Certificate): &string::String {
        &cert.country
    }

    // ===== Test Init =====
    #[test_only]
    public fun test_init(ctx: &mut TxContext) {
        init(ctx)
    }
}