import { getFullnodeUrl, SuiClient } from '@mysten/sui.js/client'; 

// ===== Define Devnet RPC =====
const rpcUrl = getFullnodeUrl('devnet'); 

// ===== Connect =====
export const providerSuiDevnet = () => {
    const client = new SuiClient({ url: rpcUrl }); 
    return client;
}