import React, { useState, useEffect } from 'react';
import { createTrainingSession } from '../services/trainingSessionService';
import { getCoachesBySportFacility } from '../services/coachService';
import { useNavigate } from 'react-router-dom';
import "/src/index.css";

const AddTrainingSession = () => {
    const id = localStorage.getItem('selectedFacilityId');
    const navigate = useNavigate();

    const [trainingSession, setTrainingSession] = useState({
        coachId: '',
        sportFacilityId: id,
        name: '',
        startHour: '',
        duration: 1,
        isWeekly: 1,
        trainingDate: '',
        capacity: 1,
    });

    const [coaches, setCoaches] = useState([]);
    const [error, setError] = useState('');

    useEffect(() => {

        const fetchCoaches = async () => {
            try {
                const response = await getCoachesBySportFacility(id);
                console.log(response)
                setCoaches(response);
            } catch (err) {
                console.error('Error fetching coaches', err);
                setError('Could not fetch coaches. Please try again later.');
            }
        };

        fetchCoaches();
    }, [id]);

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setTrainingSession({ ...trainingSession, [name]: value });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();

        try {
            if (!trainingSession.coachId || !trainingSession.name || !trainingSession.startHour || !trainingSession.trainingDate || !trainingSession.capacity) {
                setError('Please fill in all required fields.');
                return;
            }

            await createTrainingSession(trainingSession);
            navigate(`/sport-facilities/training-sessions`);
        } catch (err) {
            console.error('Error adding training session', err);
            setError('Error adding training session. Please try again.');
        }
    };

    return (
        <div className="max-w-md mx-auto mt-12 p-6 border border-gray-300 rounded-lg bg-white shadow-lg">
            <h1 className="text-2xl text-center text-gray-800 mb-6">Add New Training Session</h1>
            <form onSubmit={handleSubmit}>
                {error && <div className="mb-4 text-red-600 text-center">{error}</div>}

                <div className="mb-4">
                    <label className="block text-gray-700 font-semibold mb-2">Session Name</label>
                    <input
                        type="text"
                        name="name"
                        value={trainingSession.name}
                        onChange={handleInputChange}
                        required
                        className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
                    />
                </div>

                <div className="mb-4">
                    <label className="block text-gray-700 font-semibold mb-2">Start Hour</label>
                    <input
                        type="time"
                        name="startHour"
                        value={trainingSession.startHour}
                        onChange={handleInputChange}
                        required
                        className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
                    />
                </div>

                <div className="mb-4">
                    <label className="block text-gray-700 font-semibold mb-2">Duration (minutes)</label>
                    <input
                        type="number"
                        name="duration"
                        value={trainingSession.duration}
                        onChange={handleInputChange}
                        min="1"
                        required
                        className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
                    />
                </div>

                <div className="mb-4">
                    <label className="block text-gray-700 font-semibold mb-2">Training Date</label>
                    <input
                        type="date"
                        name="trainingDate"
                        value={trainingSession.trainingDate}
                        onChange={handleInputChange}
                        required
                        className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
                    />
                </div>

                <div className="mb-4">
                    <label className="block text-gray-700 font-semibold mb-2">Capacity</label>
                    <input
                        type="number"
                        name="capacity"
                        value={trainingSession.capacity}
                        onChange={handleInputChange}
                        min="1"
                        required
                        className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
                    />
                </div>

                <div className="mb-4">
                    <label className="block text-gray-700 font-semibold mb-2">Is Weekly</label>
                    <select
                        name="isWeekly"
                        value={trainingSession.isWeekly}
                        onChange={handleInputChange}
                        className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
                    >
                        <option value={0}>No</option>
                        <option value={1}>Yes</option>
                    </select>
                </div>

                <div className="mb-4">
                    <label className="block text-gray-700 font-semibold mb-2">Coach</label>
                    <select
                        name="coachId"
                        value={trainingSession.coachId}
                        onChange={handleInputChange}
                        required
                        className="w-full px-3 py-2 color white border border-gray-300 rounded focus:outline-none focus:border-green-500"
                    >
                        <option value="" disabled>Select a coach</option>
                        {coaches.map((coach) => (
                            <option key={coach.id} value={coach.id}>
                                {coach.name} {coach.surname}
                            </option>
                        ))}
                    </select>
                </div>

                <button
                    type="submit"
                    className="w-full py-2 bg-green-500 text-white font-semibold rounded hover:bg-green-600 transition duration-200"
                >
                    Add Training Session
                </button>
            </form>
        </div>
    );
};

export default AddTrainingSession;
