import React, { FC, useState } from 'react'; 
import Footer from './Footer';
import NavBar from './NavBar';

const About: FC = () => {

    return(
        <div className='about-wrapper'>
            <NavBar />
            <div className='container'>
                <div className='content'>
                    <h2>Vision</h2>
                    <p>
                        To create a permissionless system for managing web3 identity credentials. 
                    </p>
                    <h2>Mission</h2>
                    <p>
                        To develop the best system for obtaining and verifying credentials with a focus on user privacy. 
                        Holders and verifiers employ identity credentials with ease and in a permissionless manner. 
                    </p>
                </div>
            </div>
            <Footer />
        </div>
    )

}; 

export default About 