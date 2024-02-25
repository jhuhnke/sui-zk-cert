module escrow::usdc {
    use std::option; 

    use sui::transfer; 
    use sui::coin::{Self, TreasuryCap}; 
    use sui::tx_context::{Self, TxContext}; 

    // ===== Structs =====
    struct USDC has drop {}

    // ===== Initializer =====
    #[lint_allow(share_owned)]
    fun init(witness: USDC, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<USDC>(
            witness, 
            6, 
            b"USDC", 
            b"USD Coin", 
            b"USD Stable Coin by Circle", 
            option::none(), 
            ctx
        ); 

        transfer::public_transfer(treasury_cap, tx_context::sender(ctx)); 
        transfer::public_share_object(metadata); 
    }

    // ===== Minting for Testing =====
    public fun mint_usdc(
        treasury_cap: &mut TreasuryCap<USDC>, 
        amount: u64, 
        recipient: address, 
        ctx: &mut TxContext, 
    ) {
        let coin = coin::mint(treasury_cap, amount, ctx); 
        transfer::public_transfer(coin, recipient)
    }

    // ===== Test Init =====
    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        init(USDC {}, ctx); 
    }
}