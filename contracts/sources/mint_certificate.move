module certificate::Certificate {
    use sui::object::{Self, ID, UID}; 
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use sui::event; 
    use std::string;

    // ===== Replace with contract owner address =====
    const OWNER: address = @0x11; 

    struct Certificate has key, store {
        id: UID, 
        age: bool, 
        country: string::String, 
    }

    struct LockedCertificate<N> has key {
        id: UID,
        inner: N,
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
    public fun mint(age: bool, country: vector<u8>, recipient: address, ctx: &mut TxContext) {
        let cert = Certificate {
            id: object::new(ctx), 
            age: age, 
            country: string::utf8(country)
        }; 

        let locked_cert = LockedCertificate {
            id: object::new(ctx),
            inner: cert,
        };

        event::emit(MintCertificateEvent {
            object_id: object::uid_to_inner(&locked_cert.id), 
            creator: recipient
        }); 

        // Transfer the locked certificate to the recipient
        transfer::transfer(locked_cert, recipient);
    }

    // ===== Unlocking Function =====
    public fun unlock_cert(cert: LockedCertificate<Certificate>, ctx: &mut TxContext): Certificate {
        // Verify contract owner
        assert!(tx_context::sender(ctx) == OWNER, 403);
        
        let LockedCertificate { id, inner } = cert;
        object::delete(id);
        inner 
    }

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
