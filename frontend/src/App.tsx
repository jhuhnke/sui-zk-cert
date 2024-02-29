import React, { useState, useEffect } from 'react'; 
import { BrowserRouter as Router, Route, Switch, Redirect } from 'react-router-dom'; 
import Home from './components/Home'; 
import Mint from './components/Mint';
import Uses from './components/Uses'; 
import About from './components/About';
import Footer from './components/Footer';
import NavBar from './components/NavBar'; 
import Credential from './components/Credential'; 
import { WalletProvider } from '@suiet/wallet-kit'; 

const App = () => {
    return (
        <WalletProvider>
            <Router>
                <NavBar />
                <Switch>
                    <Route exact path='/'>
                        <Home />
                    </Route>
                    <Route exact path='/mint'>
                        <Mint />
                    </Route>
                    <Route exact path='/credential'>
                        <Credential />
                    </Route>
                    <Route exact path='/about'>
                        <About />
                    </Route>
                    <Route exact path = '/use-cases'>
                        <Uses />
                    </Route>
                    <Redirect to="/"></Redirect>
                </Switch>
                <Footer />
            </Router>
        </WalletProvider>
    ); 
}; 

export default App;