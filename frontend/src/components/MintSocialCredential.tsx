import React, { FC, useState, useEffect } from 'react'; 
import { supabase } from '../supabaseClient'; 
import { Auth } from '@supabase/auth-ui-react'; 
import{ useHistory } from 'react-router-dom';
import '../stylesheets/MintSocialCredential.css';

const MintSocialCredential: FC = () => {
    const history = useHistory(); 
       
    // supabase.auth.onAuthStateChange(async (event, session) => {
    //     console.log(event, session);
    //     if (event === "SIGNED_IN") {
    //          history.push("/mint-social-signed-in")
    //     } 
    // })

    return (
        <div className="mint-container">
            <h1>Link Your Social Media Accounts</h1>
            <div className="social-buttons-container">
                <Auth
                    supabaseClient={supabase}
                    theme="light"
                    providers={["discord", "github", "twitter"]}
                    redirectTo={`${window.location.origin}/mint-social-signed-in`}
                    onlyThirdPartyProviders={true}
                />
            </div>
        </div>
    );
}

export default MintSocialCredential; 