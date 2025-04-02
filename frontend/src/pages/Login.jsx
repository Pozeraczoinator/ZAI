import React, {useEffect, useState} from 'react';
import { useNavigate } from 'react-router-dom';
import { login } from '../services/authService';
import '/src/index.css'
import {getPicture} from "../services/fileService.js";

const Login = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const navigate = useNavigate();

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            await login(email, password);
            navigate('/sport-facilities');
        } catch (error) {
            console.error('Login failed', error);
            setError('Login failed. Please check your email and password.');
        }
    };


    const goToRegister = () => {
        navigate('/register');
    };

    return (
        <div className="flex flex-col items-center justify-center h-screen">
            <h1 className="text-3xl font-bold mb-6">Login</h1>
            <form onSubmit={handleSubmit} className="flex flex-col items-center">
                <div className="flex items-center mb-4">
                    <label className="w-24 text-right mr-2">Email:</label>
                    <input
                        type="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        required
                        className="w-72 px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring focus:ring-green-200"
                    />
                </div>
                <div className="flex items-center mb-4">
                    <label className="w-24 text-right mr-2">Password:</label>
                    <input
                        type="password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        required
                        className="w-72 px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring focus:ring-green-200"
                    />
                </div>
                {error && <p className="text-red-500">{error}</p>}
                <button
                    type="submit"
                    className="mt-5 py-2 px-4 bg-green-500 text-white font-semibold rounded hover:bg-green-600 transition duration-200"
                >
                    Login
                </button>
            </form>
            <p className="mt-4">Don't have an account?</p>
            <a
                href="#"
                onClick={goToRegister}
                className="text-blue-500 underline cursor-pointer"
            >
                Create New Account
            </a>
        </div>
    );
};

export default Login;
