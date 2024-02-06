#[test_only]
module escrow::escrow_tests {
    use sui::object::{Self, UID};
    use sui::test_scenario as ts; 
    use escrow::owned_escrow::{Escrow}; 
    use escrow::owned_escrow::{
        test_init, 
        new, 
        transfer_to_sender, 
        transfer_to_receiver, 
        destroy
    };

    struct T has key, store {
        id: UID, 
        value: u8
    }
    
    const OWNER: address = @0x11; 
    const MINT: address = @0x22; 
    const ALICE: address = @0xAA; 

    // ===== Initialize =====

    fun init_test(): ts::Scenario {
        let scenario_val = ts::begin(OWNER); 
        let scenario = &mut scenario_val; 
        {
            test_init(ts::ctx(scenario)); 
        }; 
        scenario_val
    }

    // ===== Create Test Item =====
    fun create_item(scenario: &mut ts::Scenario, owner: address, value: u8): T {
        let ctx = ts::ctx(scenario); 
        T {
            id: object::new(ctx), 
            value
        }
    }

    // ===== New Escrow =====
    fun new_test<T: store>(item: T, agent: address, receiver: address, scenario: &mut ts::Scenario) {
        ts::next_tx(scenario, OWNER); 
        {
            new(item, agent, receiver, ts::ctx(scenario)); 
        }; 
    }

    // ===== Transfer Functions =====
    fun transfer_to_sender_test<T: store>(self: Escrow<T>) {
        //ts::next_tx(scenario, OWNER); 
        {
            transfer_to_sender(self); 
        }; 
    }

    fun transfer_to_receiver_test<T: store>(self: Escrow<T>) {
       // ts::next_tx(scenario, OWNER); 
        {
            transfer_to_receiver(self); 
        }; 
    }

    // ===== Destroy =====
    //fun destroy_test<T: store>(self: Escrow<T>, scenario: &mut ts::Scenario) {
    //    ts::next_tx(scenario, OWNER); 
    //    {
    //        destroy(self, ts::ctx(scenario)); 
    //    }
    //}

    // ===== Run Tests =====
    #[test]
    fun test_new_escrow() {
        let scenario_val = init_test(); 
        let scenario = &mut scenario_val; 
        let item = create_item(scenario, OWNER, 3); 
        new_test(item, OWNER, ALICE, scenario); 
        ts::end(scenario_val); 
    }

    #[test]
    fun test_transfers() {
        let scenario_val = init_test(); 
        let scenario = &mut scenario_val; 
        let item = create_item(scenario, OWNER, 3); 
        new_test(item, OWNER, ALICE, scenario); 
        let escrow_object = ts::take_from_sender<Escrow<T>>(scenario); 
        transfer_to_sender_test(escrow_object); 
        ts::end(scenario_val); 
    }

    //#[test]
     //fun test_burn() {
    //    let scenario_val = init_test(); 
    //    let scenario = &mut scenario_val; 
    //    let item = create_item(scenario, OWNER, 3); 
    //    new_test(item, OWNER, ALICE, scenario); 
    //    let escrow_object = ts::take_shared<Escrow<T>>(scenario); 
    //    destroy_test(escrow_object, scenario); 
    //    ts::end(scenario_val);
    //}
}