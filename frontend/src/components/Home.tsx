import React, { FC, useState } from 'react';
import { WalletProvider } from '@suiet/wallet-kit'; 
import { BrowserRouter as Router, Route, Switch, Redirect } from 'react-router-dom'; 
import { Link } from 'react-router-dom';
import Footer from './Footer';
import NavBar from './NavBar';
import '../stylesheets/Home.css'; 

const Home: FC = () => {

    return (
      <div className="home-wrapper">
        <NavBar />
        <div className="container">
          <div className="content">
            <h1>The SUI Identity Layer</h1>
            <p>Unlocking fair airdrops, secure credit, and compliant DeFi is as simple as minting an NFT.</p>
            <Link to='/mint-id' className="button">Identity Credential</Link>
            <Link to='/mint-social' className='button'>Social Credential</Link>
          </div>
        </div>
        <Footer />
      </div>
    );
}; 

export default Home