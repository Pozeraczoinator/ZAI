import React from 'react';
import { useNavigate } from 'react-router-dom';

const HomeButton = () => {
    const navigate = useNavigate();

    const handleBack = () => {
        navigate('/sport-facilities');
    };

    return (
        <button
            onClick={handleBack}
            className="py-2 px-4 bg-gray-600 text-white font-semibold rounded-md shadow hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-opacity-50"
        >
            Go Back
        </button>
    );
};

export default HomeButton;