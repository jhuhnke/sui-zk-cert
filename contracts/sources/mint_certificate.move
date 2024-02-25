module escrow::certificate {
    use sui::object::{Self, ID, UID}; 
    use sui::tx_context::{Self, TxContext};
    use sui::coin::{Self, Coin}; 
    use sui::transfer;
    use sui::event; 
    use std::string;
    use escrow::usdc::USDC; 

    // ===== Check Decimals of USDC =====
    const PAYMENT_AMOUNT: u64 = 40_000_000; 
    const CONTRACT_OWNER: address = @0x11; 
    const E_INSUFFICIENT_PAYMENT: u64 = 1001;
    const CORRECT_PASSWORD: u8 = 42; 

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

    struct PaymentReceivedEvent has copy, drop {
        receiver: address, 
        amount: u64,
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

    // ===== Claim Function =====
      public entry fun claim_certificate(
            age: bool, 
            country: vector<u8>, 
            payment: Coin<USDC>, 
            password: u8,
            ctx: &mut TxContext
        ) {
        assert!(password == CORRECT_PASSWORD, 1002); 
        
        assert!(coin::value(&payment) >= PAYMENT_AMOUNT, E_INSUFFICIENT_PAYMENT);

        transfer::public_transfer(payment, CONTRACT_OWNER);

        event::emit(PaymentReceivedEvent {
            receiver: CONTRACT_OWNER, 
            amount: PAYMENT_AMOUNT, 
        }); 

        let sender = tx_context::sender(ctx);
        let cert = Certificate {
            id: object::new(ctx),
            age: age,
            country: string::utf8(country),
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

    // ===== Test Init =====
    #[test_only]
    public fun test_init(ctx: &mut TxContext) {
        init(ctx)
    }
}