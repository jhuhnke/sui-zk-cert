import React, { FC, useState } from 'react';
import { Link } from 'react-router-dom';
import '../stylesheets/Home.css'; 

const Home: FC = () => {

    return (
        <div className="container">
          <div className="content">
            <h1>Your Title Here</h1>
            <p>This is a paragraph below the title. It can contain more detailed information or a brief introduction.</p>
            <Link to='/credential' className="button">Get Credential</Link>
          </div>
        </div>
    );
}; 

export default Home