import React, { useState, useEffect } from 'react'; 
import { BrowserRouter as Router, Route, Switch, Redirect } from 'react-router-dom'; 
import Home from './components/Home'; 
import NavBar from './components/NavBar'; 

const App = () => {
    return (
        <Router>
            <NavBar />
            <Switch>
                <Route exact path='/'>
                    <Home />
                </Route>
                <Redirect to="/"></Redirect>
            </Switch>
        </Router>
    ); 
}; 

export default App;