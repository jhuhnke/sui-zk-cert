import React, { FC } from 'react'; 
import CardSlider from './CardSlider';
import Footer from './Footer';
import NavBar from './NavBar';
import '../stylesheets/Uses.css'; 

const Uses: FC = () => {
    return (
        <div className='uses-wrapper'>
            <NavBar />
            <div className="uses-container">
                <h2 className="uses-header">zkRep KYC Use Cases</h2>
                <CardSlider />
            </div>
            <Footer />
        </div>
    );
};

export default Uses