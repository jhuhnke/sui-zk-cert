import React, { FC, useState } from 'react';
import { TransactionBlock } from '@mysten/sui.js/transactions';  
import { useWallet, useSuiProvider } from '@suiet/wallet-kit';
import { toast } from 'react-toastify';
import { PACKAGE_ID } from '../config/constants'; 
import '../stylesheets/MintIdentityCredential.css'; 


const MintIdentityCredential: FC = () => {
    const { address, signAndExecuteTransactionBlock } = useWallet(); 

    const[password, setPassword] = useState(''); 
    const [country, setCountry] = useState(''); 
    const [isOver18, setIsOver18] = useState(false); 

    const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault(); 
        // ===== Too annoying - throw only after mint is clicked =====
        //if(userAddress == undefined) {
        //    toast('Wallet is not connected', {autoClose: 2000, type: 'error', position:'bottom-right'});
        //    return;
        //}
        if(!address) {
            alert("Please Connect Your Wallet First"); 
            return; 
        }

        //alert(`Form submitted:\nPassword: ${password}\nCountry: ${country}\nOver 18: ${isOver18}`);

        // ===== Handle submission / PTB here =====
        const txb = new TransactionBlock(); 

        // ===== 1000 MIST Transfer for Testing =====
        const [coin] = txb.splitCoins(txb.gas, [txb.pure(1000)]); 

        // ===== Change the wallet address here to be protocol controlled wallet before mainnet launch =====
        txb.transferObjects([coin], txb.pure("0x8e0a2135568a5ff202aa0b78a7f3113fc8b68b65d4b5143261f723cc445d9809")); 
        txb.moveCall({
            target: `${PACKAGE_ID}::identity_certificate::claim_certificate`, 
            arguments: [
                txb.pure(isOver18), 
                txb.pure(country),  
                txb.pure(password)
            ],
        }); 

        const result = signAndExecuteTransactionBlock({
            transactionBlock: txb, 
        }).catch(e => {console.log(e)}); 

        const url = `https://suiexplorer.com/txblock/${result}?network=testnet`;
        console.log(url); 
    };

    return (
        <div>
            <h1>Mint Credential</h1>
            <form onSubmit={handleSubmit}>
                <div>
                    <label htmlFor="password">Password:</label>
                    <input
                        type="password"
                        id="password"
                        value={password}
                        onChange={e => setPassword(e.target.value)}
                    />
                </div>
                <div>
                    <label htmlFor="country">Country:</label>
                    <select id="country" value={country} onChange={e => setCountry(e.target.value)}>
                        <option value="">Select a country</option>
                        {/* Add options for countries as needed */}
                        <option value="USA">USA</option>
                        <option value="Canada">Canada</option>
                        <option value="UK">UK</option>
                    </select>
                </div>
                <div>
                    <label>
                        <input
                            type="checkbox"
                            checked={isOver18}
                            onChange={e => setIsOver18(e.target.checked)}
                        />
                        I am over 18 years old
                    </label>
                </div>
                <button type="submit">Mint Credential</button>
            </form>
        </div>
    );
};

export default MintIdentityCredential 