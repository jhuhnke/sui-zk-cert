import React, { useState } from 'react';
import emailjs from 'emailjs-com';
import '../stylesheets/Contact.css'; 
import { 
    SERVICE_ID, 
    TEMPLATE_ID, 
    USER_ID
} from '../config/constants'; 

const Contact = () => {
    const [submitted, setSubmitted] = useState(false);

    const handleSubmit = (e) => {
        e.preventDefault(); 

        // ===== Move these into config file =====
        emailjs.sendForm(SERVICE_ID, TEMPLATE_ID, e.target, USER_ID) 
            .then((result) => {
                console.log(result.text);
                setSubmitted(true);
            }, (error) => {
                console.log(error.text);
            });
    };

    if (submitted) {
        return <div className="form-container"><p>Thank you for reaching out. You can expect a response in 48-72 business hours.</p></div>;
    }

    return (
        <div className="form-container">
            <h1>Contact Us</h1>
            <p className="form-description">Please fill out the form below to reach out with any inquiries or partnership opportunities.</p>
            <form onSubmit={handleSubmit}>
                <label>Name:</label>
                <input type="text" name="name" required />
                <label>Email:</label>
                <input type="email" name="email" required />
                <label>Company:</label>
                <input type="text" name="company" required />
                <label>Message:</label>
                <textarea name="message" required></textarea>
                <button type="submit">Submit</button>
            </form>
        </div>
    );
};

export default Contact;
