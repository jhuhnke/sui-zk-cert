import React, { FC, useState } from 'react';
import { Link } from 'react-router-dom';
import '../stylesheets/Home.css'; 

const Home: FC = () => {

    return (
        <div className="container">
          <div className="content">
            <h1>The SUI zk-Identity Layer</h1>
            <p>zkRep leverages the power of zero-knowledge proofs to enable secure, self-sovereign, and private credential verifications.</p>
            <Link to='/mint' className="button">Identity Credential</Link>
          </div>
        </div>
    );
}; 

export default Home