import React, { FC, useState, useEffect } from 'react'; 
import { supabase } from '../supabaseClient'; 
import { useHistory } from 'react-router-dom'; 
import { Auth } from '@supabase/auth-ui-react'; 

const MintSocialCredentialSignedIn: FC = () => {
    const history = useHistory(); 
    const [user, setUser] = useState({}); 

    useEffect(() => {
        async function getUserData() {
            await supabase.auth.getUser().then((value) => {
                if(value.data?.user) {
                    console.log(value.data.user);
                    setUser(value.data.user); 
                }
            })
        }
        getUserData();
    }, []); 

    async function signOutUser() {
        const { error } = await supabase.auth.signOut(); 
        if (!error) {
            history.push('/'); 
        }
    }

    const handleMint = () => {
        if (!twitterHandle && !discordUsername) {
            alert('Please sign in to at least one account.');
            return;
        }
        alert(`Twitter Handle: ${twitterHandle || 'null'}\nDiscord Username: ${discordUsername || 'null'}`);
        // Here you would handle the minting process
    };

    return (
        <div className="mint-container">
            <div className="social-buttons-container">
                
                <h1>Success</h1>
                <button onClick={() => signOutUser()}>Sign Out</button>
            </div>
            <button onClick={handleMint} className="mint-button">Mint</button>
        </div>
    );
}

export default MintSocialCredentialSignedIn; 

// { Object.keys(user) !== 0 ? }