import React, { useEffect, useState } from 'react';
import { getManagersByFacility, addManager, deleteManager, getUsers } from '../services/managerService';
import "/src/index.css";
import BackButton from "../components/homebutton.jsx";

const ManagerManagement = () => {
    const facilityId = localStorage.getItem('selectedFacilityId');
    const [managers, setManagers] = useState([]);
    const [users, setUsers] = useState([]);
    const [newManagerId, setNewManagerId] = useState('');

    const fetchManagers = async () => {
        try {
            const data = await getManagersByFacility(facilityId);
            setManagers(data);
        } catch (error) {
            console.error('Error fetching managers:', error);
        }
    };

    const fetchUsers = async () => {
        try {
            const usersData = await getUsers();
            setUsers(usersData);
        } catch (error) {
            console.error('Error fetching users:', error);
        }
    };

    useEffect(() => {
        fetchManagers();
        fetchUsers();
    }, [facilityId]);

    const handleAddManager = async () => {
        try {
            const managerDTO = {
                userId: parseInt(newManagerId, 10),
                sportFacilityId: parseInt(facilityId, 10),
            };
            await addManager(managerDTO);
            setNewManagerId('');
            await fetchManagers();
        } catch (error) {
            console.error('Error adding manager:', error);
        }
    };

    const handleDeleteManager = async (managerId) => {
        try {
            await deleteManager({ userId: managerId, sportFacilityId: parseInt(facilityId, 10) });
            setManagers(managers.filter(manager => manager.id !== managerId));
            await fetchManagers();
        } catch (error) {
            console.error('Error deleting manager:', error);
        }
    };

    return (
        <div className="container mx-auto mt-16 p-4 bg-gray-100 rounded">
            <div className="absolute top-4 left-4 z-10">
                <BackButton />
            </div>
            <h1 className="text-3xl font-bold text-black mt-5 mb-3">Manage Managers</h1>

            <div className="mb-6">
                <h2 className="text-xl text-black font-semibold mb-4">Add New Manager</h2>
                <div className="flex flex-col md:flex-row gap-4">
                    <select
                        value={newManagerId}
                        onChange={(e) => setNewManagerId(e.target.value)}
                        className="border p-2 rounded-md w-full bg-gray-800 text-white"
                    >
                        <option value="" disabled>Select User ID</option>
                        {users.map((user) => (
                            <option key={user.id} value={user.id}>
                                {user.username} ({user.name} {user.surname})
                            </option>
                        ))}
                    </select>
                    <button
                        onClick={handleAddManager}
                        className="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600 transition"
                    >
                        Add
                    </button>
                </div>
            </div>
            <h2 className="text-xl font-semibold text-black mb-4">Existing Managers</h2>
            {managers.length === 0 ? (
                <p className="text-gray-400">No managers found for this facility.</p>
            ) : (
                <ul className="space-y-4">
                    {managers.map(manager => (
                        <li key={manager.id}
                            className="flex justify-between items-center p-4 bg-gray-800 rounded-md shadow">
                            <div>
                                <p className="text-lg font-semibold">
                                    {manager.name} {manager.surname}
                                </p>
                                <p className="text-gray-400">Email: {manager.email}</p>
                                <p className="text-gray-400">Username: {manager.username}</p>
                                <p className="text-gray-400">
                                    Authorities: {manager.authorities ? manager.authorities.join(', ') : 'No authorities'}
                                </p>
                            </div>
                            <button
                                onClick={() => handleDeleteManager(manager.id)}
                                className="bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600 transition"
                            >
                                Delete
                            </button>
                        </li>
                    ))}
                </ul>
            )}
        </div>
    );
};

export default ManagerManagement;
