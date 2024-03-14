import React, { FC } from 'react'; 
import { useHistory, useLocation } from 'react-router-dom'; 
import Footer from './Footer';
import NavBar from './NavBar';
import '../stylesheets/SuccessPage.css'

interface LocationState {
    url: string; 
}

const SuccessPage: FC = () => {
    const history = useHistory(); 
    const location = useLocation<LocationState>(); 

    const handleGoHome = () => {
        history.push('/'); 
    }; 

    return (
        <div className='success-wrapper'>
            <NavBar />
            <div className="success-container">
                <h1>Credential Minted Successfully!</h1>
                <p>Your social media credential has been successfully minted.</p>
                {location.state && location.state.url && (
                    <div>
                        <p>View your transaction:</p>
                        <a href={location.state.url} target="_blank" rel="noopener noreferrer">{location.state.url}</a>
                    </div>
                )}
                <button onClick={handleGoHome}>Go to Home</button>
            </div>
            <Footer />
        </div>
    );
}

export default SuccessPage; 