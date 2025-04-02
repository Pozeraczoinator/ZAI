import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { getAllSportFacilities, deleteSportFacility } from '../services/sportFacilityService';
import "/src/index.css";

const SportFacilities = () => {
    const [facilities, setFacilities] = useState([]);
    const [error, setError] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
        const fetchFacilities = async () => {
            try {
                const data = await getAllSportFacilities();
                setFacilities(data);
            } catch (error) {
                console.error('Error fetching sport facilities', error);
                setError('Error fetching facilities. Please try again.');
            }
        };
        fetchFacilities();
    }, []);

    const handleCardClick = (id) => {
        localStorage.setItem('selectedFacilityId', id);
        navigate(`/sport-facilities/details`);
    };

    const handleDelete = async (id) => {
        if (window.confirm("Are you sure you want to delete this facility?")) {
            try {
                await deleteSportFacility(id);
                setFacilities(facilities.filter((facility) => facility.id !== id));
            } catch (error) {
                console.error('Error deleting facility', error);
                setError('Error deleting facility. Please try again.');
            }
        }
    };

    return (
        <div className="p-5 flex flex-col items-center justify-center">
            <h1 className="text-3xl font-bold mb-6 text-center">Sport Facilities</h1>
            <button
                onClick={() => navigate('/add-sport-facility')}
                className="bg-blue-500 text-white py-2 px-4 rounded-md hover:bg-blue-600 mb-6"
            >
                Add New Facility
            </button>

            {error && <p className="text-red-500 mb-4">{error}</p>}

            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                {facilities.map((facility) => (
                    <div
                        key={facility.id}
                        className="bg-gray-100 border border-gray-300 rounded-lg p-4 transition-transform transform hover:translate-y-1 hover:shadow-lg"
                    >
                        <h2 className="text-xl font-semibold text-gray-800">{facility.name}</h2>
                        <p className="text-gray-600">{facility.description}</p>
                        <p className="text-gray-800 font-medium">
                            <strong>Address:</strong> {facility.address}
                        </p>
                        <p className="text-gray-800 font-medium">
                            <strong>Type:</strong> {facility.type}
                        </p>
                        <div className="mt-4 flex justify-between">
                            <button
                                className="bg-green-500 text-white py-1 px-3 rounded-md hover:bg-green-600"
                                onClick={() => handleCardClick(facility.id)}
                            >
                                View Details
                            </button>
                            <button
                                className="bg-red-500 text-white py-1 px-3 rounded-md hover:bg-red-600"
                                onClick={() => handleDelete(facility.id)}
                            >
                                Delete
                            </button>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
};

export default SportFacilities;
