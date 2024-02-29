import React, { FC } from 'react'; 
import CardSlider from './CardSlider';
import '../stylesheets/Uses.css'; 

const Uses: FC = () => {
    return (
        <div className="uses-container">
            <h2 className="uses-header">zkRep KYC Use Cases</h2>
            <CardSlider />
        </div>
    );
};

export default Uses