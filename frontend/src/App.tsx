import React, { useState, useEffect } from 'react'; 
import { WalletProvider } from '@suiet/wallet-kit'; 
import { BrowserRouter as Router, Route, Switch, Redirect } from 'react-router-dom'; 
import Home from './components/Home'; 
import Uses from './components/Uses'; 
import About from './components/About';
import Footer from './components/Footer';
import NavBar from './components/NavBar';
import Contact from './components/Contact';  
import SuccessPage from './components/SuccessPage';
import SocialCredential from './components/SocialCredential';
import IdentityCredential from './components/IdentityCredential'; 
import MintSocialCredential from './components/MintSocialCredential';
import MintIdentityCredential from './components/MintIdentityCredential';
import MintSocialCredentialSignedIn from './components/MintSocialCredentialSignedIn'; 
import './stylesheets/App.css'; 

const App = () => {
    return (
        <WalletProvider>
            <Router>
                <NavBar />
                <Switch>
                    <Route exact path='/'>
                        <Home />
                    </Route>
                    <Route exact path='/mint-id'>
                        <MintIdentityCredential />
                    </Route>
                    <Route exact path='/id-credential'>
                        <IdentityCredential />
                    </Route>
                    <Route exact path='/mint-social'>
                        <MintSocialCredential />
                    </Route>
                    <Route exact path='/mint-social-signed-in'>
                        <MintSocialCredentialSignedIn />
                    </Route>
                    <Route exact path='/social-credential'>
                        <SocialCredential />
                    </Route>
                    <Route exact path='/about'>
                        <About />
                    </Route>
                    <Route exact path = '/use-cases'>
                        <Uses />
                    </Route>
                    <Route exact path = '/success'>
                        <SuccessPage />
                    </Route>
                    <Route exact path = '/contact'>
                        <Contact />
                    </Route>
                    <Redirect to="/"></Redirect>
                </Switch>
                <Footer />
            </Router>
        </WalletProvider>
    ); 
}; 

export default App;