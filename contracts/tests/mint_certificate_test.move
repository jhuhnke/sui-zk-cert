#[test_only]
module certificate::mint_cert_tests {
    use sui::test_scenario as ts; 
    use certificate::Certificate::{Certificate};
    use certificate::Certificate::{
        test_init, 
        mint,
        burn
    }; 

    const OWNER: address = @0x11; 
    const ALICE: address = @0xAA; 
    
    fun init_test(): ts::Scenario {
        let scenario_val = ts::begin(OWNER); 
        let scenario = &mut scenario_val; 
        {
            test_init(ts::ctx(scenario)); 
        }; 
        scenario_val
    }

    // ===== Minting =====
    fun mint_test(age: bool, country: vector<u8>, scenario: &mut ts::Scenario) {
        ts::next_tx(scenario, ALICE); 
        {
            mint(age, country, ts::ctx(scenario)); 
        }; 
    }

    // ===== Burning =====
    fun burn_test(scenario: &mut ts::Scenario) {
        ts::next_tx(scenario, ALICE); 
        {
            let cert = ts::take_from_sender<Certificate>(scenario); 
            burn(cert); 
        }; 
    }

    // ===== Run Tests =====
    #[test]
    fun test_cert_mint() {
        let scenario_val = init_test(); 
        let scenario = &mut scenario_val; 
        mint_test(
            true, 
            b"United States", 
            scenario
        ); 
        ts::end(scenario_val); 
    }

    #[test]
    fun test_burn() {
        let scenario_val = init_test(); 
        let scenario = &mut scenario_val; 
        mint_test(
            true, 
            b"United States", 
            scenario
        ); 
        burn_test(scenario); 
        ts::end(scenario_val); 
    }
}