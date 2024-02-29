module escrow::certificate {
    use sui::object::{Self, ID, UID}; 
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use sui::event; 
    use std::string;

    // ===== Check Decimals of USDC =====
    const CORRECT_PASSWORD: u8 = 42; 

    // ===== Structs =====
    struct Certificate has key {
        id: UID, 
        age: bool, 
        country: string::String, 
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
    entry fun mint(age: bool, country: vector<u8>, image_url: vector<u8>, ctx: &mut TxContext) {
        let sender = tx_context::sender(ctx); 

        let cert = Certificate {
            id: object::new(ctx), 
            age: age, 
            country: string::utf8(country), 
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
        let Certificate { id, age: _, country: _, image_url: _, } = cert; 
        object::delete(id); 
    }

    // ===== Claim Function =====
      public entry fun claim_certificate(
            age: bool, 
            country: vector<u8>, 
            password: u8,
            image_url: vector<u8>,
            ctx: &mut TxContext
        ) {
        assert!(password == CORRECT_PASSWORD, 1002); 

        let sender = tx_context::sender(ctx);
        let cert = Certificate {
            id: object::new(ctx),
            age: age,
            country: string::utf8(country),
            image_url: string::utf8(image_url),
        };

        event::emit(MintCertificateEvent {
            object_id: object::uid_to_inner(&cert.id),
            creator: sender,
        });

        transfer::transfer(cert, sender);
    }

    // ===== Getters =====
    public fun age(cert: &Certificate): &bool {
        &cert.age
    }
    
    public fun country(cert: &Certificate): &string::String {
        &cert.country
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

// ===== IPFS URL =====
// https://ipfs.io/ipns/k51qzi5uqu5dkeq8e8ixhyw1yrro0wfc5qo1xjsnlbbe5ztsvhz0mkb08qymjq