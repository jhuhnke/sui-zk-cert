module escrow::social_certificate {
    use sui::object::{Self, ID, UID}; 
    use sui::tx_context::{Self, TxContext}; 
    use sui::transfer; 
    use sui::event; 
    use std::string; 

    const CORRECT_PASSWORD: u8 = 42; 

    // ===== Structs =====
    struct Certificate has key {
        id: UID, 
        twitter: string::String, 
        discord: string::String, 
        image_url: string::String, 
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
    entry fun mint(twitter: vector<u8>, discord: vector<u8>, image_url: vector<u8>, ctx: &mut TxContext ) {
        let sender = tx_context::sender(ctx); 

        let cert = Certificate {
            id: object::new(ctx), 
            twitter: string::utf8(twitter), 
            discord: string::utf8(discord), 
            image_url: string::utf8(image_url), 
        }; 

        event::emit(MintCertificateEvent {
            object_id: object::uid_to_inner(&cert.id), 
            creator: sender
        }); 

        transfer::transfer(cert, sender) 
    }

    // ===== Burn Function =====
    entry fun burn(cert: Certificate) {
        let Certificate{ id, twitter: _, discord: _, image_url: _, } = cert; 
        object::delete(id); 
    }

    // ===== Claim Function =====
    public entry fun claim_certificate(
        twitter: vector<u8>, 
        discord: vector<u8>, 
        password: u8, 
        image_url: vector<u8>, 
        ctx: &mut TxContext
    ) {
        assert!(password == CORRECT_PASSWORD, 1002); 

        let sender = tx_context::sender(ctx); 
        let cert = Certificate {
            id: object::new(ctx), 
            twitter: string::utf8(twitter), 
            discord: string::utf8(discord), 
            image_url: string::utf8(image_url), 
        }; 

        event::emit(MintCertificateEvent {
            object_id: object::uid_to_inner(&cert.id), 
            creator: sender, 
        }); 

        transfer::transfer(cert, sender); 
    }

    // ===== Getters =====
    public fun twitter(cert: &Certificate): &string::String {
        &cert.twitter
    }

    public fun discord(cert: &Certificate): &string::String {
        &cert.discord
    }

    public fun image_url(cert: &Certificate): &string::String {
        &cert.image_url
    }

    // ===== Test Init =====
    #[test_only]
    public fun test_init(ctx: &mut TxContext) {
        init(ctx)
    }
}