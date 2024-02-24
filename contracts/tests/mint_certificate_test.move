#[test_only]
module certificate::mint_cert_tests {
    use sui::test_scenario as ts; 
    use certificate::Certificate::{
        Certificate, 
        LockedCertificate
    };
    use certificate::Certificate::{
        test_init, 
        mint,
        burn, 
        unlock_cert, 
        age
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
    fun mint_test(age: bool, country: vector<u8>, scenario: &mut ts::Scenario, by_owner: bool) {
        let actor = if (by_owner) { OWNER } else { ALICE }; 
        ts::next_tx(scenario, actor); 
        {
            mint(age, country, actor, ts::ctx(scenario)); 
        }; 
    }

    // ===== Burning =====
    fun burn_test(scenario: &mut ts::Scenario, by_owner: bool) {
        let actor = if (by_owner) { OWNER } else { ALICE }; 
        ts::next_tx(scenario, actor); 
        {
            let cert = ts::take_from_sender<LockedCertificate<Certificate>>(scenario);  
            let unlocked_cert = unlock_cert(cert, ts::ctx(scenario)); 
            burn(unlocked_cert); 
        }; 
    }

    // ===== Unlocking =====
    fun unlock_test(scenario: &mut ts::Scenario, by_owner: bool) {
        let actor = if (by_owner) { OWNER } else { ALICE }; 
        ts::next_tx(scenario, actor); 
        {
            let locked_cert = ts::take_from_sender<LockedCertificate<Certificate>>(scenario); 
            let unlocked_cert = unlock_cert(locked_cert, ts::ctx(scenario));
            assert!(*age(&unlocked_cert) == true, 999); 
            burn(unlocked_cert);
        }
    }

    // ===== Run Tests =====
    #[test]
    fun test_cert_mint() {
        let scenario_val = init_test(); 
        let scenario = &mut scenario_val; 
        mint_test(
            true, 
            b"United States", 
            scenario, 
            false
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
            scenario, 
            true
        ); 
        burn_test(scenario, true); 
        ts::end(scenario_val); 
    }

    #[test]
    #[expected_failure]
    fun test_burn_nonowner() {
        let scenario_val = init_test(); 
        let scenario = &mut scenario_val; 
        mint_test(
            true, 
            b"United States", 
            scenario, 
            false
        ); 
        burn_test(scenario, false); 
        ts::end(scenario_val); 
    }

    #[test]
    fun test_unlock_by_owner() {
        let scenario_val = init_test(); 
        let scenario = &mut scenario_val; 

        mint_test(true, b"United States", scenario, true); 
        unlock_test(scenario, true); 
        
        ts::end(scenario_val); 
    }

    #[test]
    #[expected_failure]
    fun test_unlock_by_non_owner() {
        let scenario_val = init_test(); 
        let scenario = &mut scenario_val; 

        mint_test(true, b"United States", scenario, false); 
        unlock_test(scenario, false); 
        
        ts::end(scenario_val); 
    }
}