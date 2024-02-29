import React, { FC, useState } from 'react'; 
import '../stylesheets/CardSlider.css'; 

const CardSlider: FC = () => {
    const totalCards = 6;
    const [currentIndex, setCurrentIndex] = useState(0);

    const handlePrevClick = () => {
        setCurrentIndex((prevIndex) => prevIndex > 0 ? prevIndex - 1 : totalCards - 1);
    };

    const handleNextClick = () => {
        setCurrentIndex((prevIndex) => prevIndex < totalCards - 1 ? prevIndex + 1 : 0);
    };

    const getContainerStyle = () => {
        const offset = currentIndex * (100 / 2.5); // Assuming each card takes up 40% of the container width
        return {
            transform: `translateX(-${offset}%)`,
        };
    };

    return (
        <div className="card-slider">
            <button className="slide-arrow left" onClick={handlePrevClick}>&lt;</button>
            <div className="card-container" style={getContainerStyle()}>
                {Array.from({ length: totalCards }, (_, index) => (
                    <div key={index} className={`card ${index % 2 === 0 ? 'even' : 'odd'}`}>
                        {/* Card Content Here */}
                        Card {index + 1}
                    </div>
                ))}
            </div>
            <button className="slide-arrow right" onClick={handleNextClick}>&gt;</button>
        </div>
    );
};

export default CardSlider;