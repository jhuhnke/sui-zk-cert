module escrow::owned_escrow {
    use sui::transfer; 
    use sui::object::{Self, UID}; 
    use sui::tx_context::{Self, TxContext}; 

    
    // ===== Structs =====

    struct Escrow<T: store> has key {
        id: UID, 
        sender: address, 
        receiver: address, 
        item: T
    }

    struct Ownership has key {
        id: UID
    }
    
    // ===== Errors =====
    const EAgentCannotDestroyItem: u64 = 0; 

    // ===== Initialize =====
    fun init(ctx: &mut TxContext) {
        let ownership = Ownership {
            id: object::new(ctx)
        }; 

        transfer::transfer(ownership, tx_context::sender(ctx)); 
    }

    // ===== Public Functions =====
    public fun new<T: store>(item: T, agent: address, receiver: address, ctx: &mut TxContext) {
        let escrow = Escrow {
            id: object::new(ctx), 
            sender: tx_context::sender(ctx), 
            receiver, 
            item
        }; 

        transfer::transfer(escrow, agent); 
    }

    public fun transfer_to_sender<T:store>(self: Escrow<T>) {
        let sender = self.sender; 
        transfer::transfer(self, sender); 
    }

    public fun transfer_to_receiver<T: store>(self: Escrow<T>) {
        let receiver = self.receiver; 
        transfer::transfer(self, receiver); 
    }

    public fun destroy<T: store>(self: Escrow<T>, ctx: &mut TxContext): T {
        let Escrow { id, sender, receiver, item } = self; 
        assert!(sender == tx_context::sender(ctx) || receiver == tx_context::sender(ctx), EAgentCannotDestroyItem); 

        object::delete(id); 

        item
    }

    // ===== Getters =====
    public fun sender<T: store>(self: &Escrow<T>): address {
        self.sender
    }

    public fun receiver<T: store>(self: &Escrow<T>): address {
        self.receiver
    }

    public fun item<T: store>(self: &Escrow<T>): &T {
        &self.item
    }

    // ===== Test Init =====
    #[test_only]
    public fun test_init(ctx: &mut TxContext) {
        init(ctx)
    }
}