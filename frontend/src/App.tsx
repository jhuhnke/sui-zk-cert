import React, { useState, useEffect } from 'react'; 
import { BrowserRouter as Router, Route, Switch, Redirect } from 'react-router-dom'; 
import Home from './components/Home'; 
import Mint from './components/Mint';
import NavBar from './components/NavBar'; 
import Credential from './components/Credential'; 

const App = () => {
    return (
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
                <Redirect to="/"></Redirect>
            </Switch>
        </Router>
    ); 
}; 

export default App;