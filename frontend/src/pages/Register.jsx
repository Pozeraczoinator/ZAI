import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { register } from '../services/authService';
import '/src/index.css'

const Register = () => {
  const [userData, setUserData] = useState({
    name: '',
    surname: '',
    email: '',
    password: '',
    imageUrl: ''
  });
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleChange = (e) => {
    setUserData({ ...userData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await register(userData);
      navigate('/login');
    } catch (error) {
      console.error('Registration failed', error);
      setError('Registration failed. Please try again.');
    }
  };

  return (
      <div className="flex flex-col items-center justify-start h-screen">
        <h1 className="text-3xl font-bold mb-6">Register</h1>
        <form onSubmit={handleSubmit} className="flex flex-col items-center">
          <div className="flex items-center mb-4">
            <label className="w-32 text-right mr-2">Name:</label>
            <input
                type="text"
                name="name"
                value={userData.name}
                onChange={handleChange}
                required
                className="w-72 px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring focus:ring-green-200"
            />
          </div>
          <div className="flex items-center mb-4">
            <label className="w-32 text-right mr-2">Surname:</label>
            <input
                type="text"
                name="surname"
                value={userData.surname}
                onChange={handleChange}
                required
                className="w-72 px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring focus:ring-green-200"
            />
          </div>
          <div className="flex items-center mb-4">
            <label className="w-32 text-right mr-2">Email:</label>
            <input
                type="email"
                name="email"
                value={userData.email}
                onChange={handleChange}
                required
                className="w-72 px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring focus:ring-green-200"
            />
          </div>
          <div className="flex items-center mb-4">
            <label className="w-32 text-right mr-2">Password:</label>
            <input
                type="password"
                name="password"
                value={userData.password}
                onChange={handleChange}
                required
                className="w-72 px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring focus:ring-green-200"
            />
          </div>

          {error && <p className="text-red-500 mb-4">{error}</p>}
          <button
              type="submit"
              className="mt-5 py-2 px-4 bg-green-500 text-white font-semibold rounded hover:bg-green-600 transition duration-200"
          >
            Register
          </button>
        </form>
      </div>
  );
};

export default Register;
