// pages/TrainingSessions.js
import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import {deleteTrainingSession, getTrainingSessionById} from '../services/trainingSessionService';
import {deleteEquipment} from "../services/equipmentService.js";
import BackButton from "../components/homebutton.jsx";

const TrainingSessions = () => {
    const [sessions, setSessions] = useState([]);
    const [loading, setLoading] = useState(true);
    const id = localStorage.getItem('selectedFacilityId');
    const navigate = useNavigate();

    useEffect(() => {
        const fetchTrainingSessions = async () => {
            try {
                const data = await getTrainingSessionById(id);
                setSessions(data);
            } catch (error) {
                console.error('Error fetching training sessions:', error);
            } finally {
                setLoading(false);
            }
        };

        fetchTrainingSessions();
    }, [id]);

    const handleCreateSession = () => {
        navigate('/create-training-session');
    };
    const handleDelete = async (sessionID) => {
        try {
            await deleteTrainingSession(sessionID);
            setSessions(sessions.filter(item => item.id !== sessionID));
        } catch (error) {
            console.error('Error deleting equipment', error);
        }
    };

    return (
        <div className="container mx-auto p-6 text-center">
            <div className="absolute top-4 left-4 z-10">
                <BackButton/>
            </div>
            <h1 className="text-3xl font-bold mb-4 text-white">Training Sessions</h1>

            <button
                onClick={handleCreateSession}
                className="mb-6 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors duration-200"
            >
                Add Training Session
            </button>

            {loading ? (
                <p className="text-gray-500">Loading training sessions...</p>
            ) : (
                <div
                    className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 place-items-center">
                    {sessions.length > 0 ? (
                        sessions.map((session) => (
                            <div
                                key={session.id}
                                className="bg-white p-4 rounded-lg shadow hover:shadow-lg transition-shadow duration-200 w-80"
                            >
                                <h2 className="text-xl font-semibold text-gray-700">{session.name}</h2>
                                <p className="text-gray-600 mt-2">Date: {new Date(session.trainingDate).toLocaleDateString()}</p>
                                <p className="text-gray-600">Time: {session.startHour}</p>
                                <p className="text-gray-600">Duration: {session.duration} mins</p>
                                <p className="text-gray-600">Capacity: {session.capacity}</p>
                                <p className="text-gray-600">Free Slots: {session.freeBooked}</p>
                                <div className="flex justify-between">
                                    <button
                                        className="bg-yellow-500 text-white px-4 py-2 rounded hover:bg-yellow-500"

                                    >
                                        Modify
                                    </button>
                                    <button
                                        className="bg-red-500 text-white px-4 py-2 rounded-lg hover:bg-red-600 transition duration-200"
                                        onClick={() => handleDelete(session.id)}>

                                        Delete
                                    </button>
                                </div>
                            </div>
                        ))
                    ) : (
                        <p className="text-gray-500">No training sessions available.</p>
                    )}

                </div>
            )}
        </div>
    );
};

export default TrainingSessions;
