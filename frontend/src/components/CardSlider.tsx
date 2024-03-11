import React, { FC, useState, useEffect } from 'react'; 
import '../stylesheets/CardSlider.css'; 

const CardSlider: FC = () => {
    const totalCards = 6;
    const [currentIndex, setCurrentIndex] = useState(0);

    useEffect(() => {
        const intervalId = setInterval(() => {
            setCurrentIndex(prevIndex => (prevIndex + 1) % totalCards);
        }, 2000); // Change cards every 2000 milliseconds (2 seconds)

        return () => clearInterval(intervalId); // Clear interval on component unmount
    }, [totalCards]);

    const getContainerStyle = () => {
        const offset = currentIndex * (100 / totalCards); // Adjusted to consider dynamic totalCards
        return {
            transform: `translateX(-${offset}%)`,
        };
    };

    const cardData = [
        { title: "Airdrops"}, 
        { title: "Proof of Community"}, 
        { title: "NFT Launchpads"}, 
        { title: "Gaming and Gambling"}, 
        { title: "Permissioned Defi"}, 
        { title: "Influencers"}
    ]

    return (
        <div className="card-slider">
            <div className="card-container" style={getContainerStyle()}>
            {cardData.map((card, index) => (
                <div key={index} className={`card ${index % 2 === 0 ? 'even' : 'odd'}`}>
                    <div className="card-title-container">
                        <h3 className="card-title">{card.title}</h3>
                    </div>
                </div>
            ))}
            </div>
        </div>
    );
};

export default CardSlider;