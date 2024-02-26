import React, { FC, useState } from 'react'; 
import { Link } from 'react-router-dom'; 
import '../stylesheets/Mint.css'; 


const Mint: FC = () => {
    const[password, setPassword] = useState(''); 
    const [country, setCountry] = useState(''); 
    const [isOver18, setIsOver18] = useState(false); 

    const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault(); 
        alert(`Form submitted:\nPassword: ${password}\nCountry: ${country}\nOver 18: ${isOver18}`);

        // ===== Handle submission / PTB here =====
    };

    return (
        <div>
            <h1>Mint Credential</h1>
            <form onSubmit={handleSubmit}>
                <div>
                    <label htmlFor="password">Password:</label>
                    <input
                        type="password"
                        id="password"
                        value={password}
                        onChange={e => setPassword(e.target.value)}
                    />
                </div>
                <div>
                    <label htmlFor="country">Country:</label>
                    <select id="country" value={country} onChange={e => setCountry(e.target.value)}>
                        <option value="">Select a country</option>
                        {/* Add options for countries as needed */}
                        <option value="USA">USA</option>
                        <option value="Canada">Canada</option>
                        <option value="UK">UK</option>
                    </select>
                </div>
                <div>
                    <label>
                        <input
                            type="checkbox"
                            checked={isOver18}
                            onChange={e => setIsOver18(e.target.checked)}
                        />
                        I am over 18 years old
                    </label>
                </div>
                <button type="submit">Mint Credential</button>
            </form>
        </div>
    );
};

export default Mint 