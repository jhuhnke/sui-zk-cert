import React, { FC } from 'react'; 
import { Link } from 'react-router-dom'; 
import { ConnectButton } from '@suiet/wallet-kit'; 

const NavBar: FC = () => {
    return (
        <nav>
            <Link to="/">
                Home
            </Link>
        </nav>
    ); 
}; 

export default NavBar;