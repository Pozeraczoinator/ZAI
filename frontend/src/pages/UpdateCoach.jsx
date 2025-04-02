import React, { useState, useEffect } from 'react';
import { getCoachById, updateCoach } from '../services/coachService';
import { uploadPicture } from '../services/fileService';
import { useParams, useNavigate } from 'react-router-dom';

const UpdateCoach = () => {
    const { id } = useParams();
    const sportFacilityID = localStorage.getItem('selectedFacilityId');
    const navigate = useNavigate();
    const [coach, setCoach] = useState({
        name: '',
        surname: '',
        imageUrl: '',
        sportFacilitiesId: sportFacilityID,
    });
    const [selectedFile, setSelectedFile] = useState(null);
    const [fileName, setFileName] = useState('');

    useEffect(() => {
        const fetchCoach = async () => {
            try {
                const coachData = await getCoachById(id);
                setCoach(coachData);
                setFileName(coachData.imageUrl);
            } catch (error) {
                console.error('Error fetching coach data', error);
            }
        };

        fetchCoach();
    }, [id]);

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setCoach({ ...coach, [name]: value });
    };

    const handleFileChange = (e) => {
        const file = e.target.files[0];
        setSelectedFile(file);
        setFileName(file.name);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            let updatedImageUrl = coach.imageUrl;

            if (selectedFile) {
                updatedImageUrl = await uploadPicture(selectedFile);
            }

            const updatedCoach = {
                ...coach,
                imageUrl: updatedImageUrl,
                sportFacilitiesId: sportFacilityID,
            };

            await updateCoach(updatedCoach);
            navigate(`/sport-facilities/coaches`);
        } catch (error) {
            console.error('Error updating coach', error);
        }
    };

    return (
        <div className="max-w-2xl mx-auto p-6 bg-white shadow-lg rounded-lg mt-10">
            <h1 className="text-2xl font-semibold text-gray-800 mb-6">Update Coach</h1>
            <form onSubmit={handleSubmit} className="space-y-4">
                <div className="form-group">
                    <label htmlFor="name" className="block text-sm font-medium text-gray-700">Name</label>
                    <input
                        id="name"
                        type="text"
                        name="name"
                        value={coach.name}
                        onChange={handleInputChange}
                        required
                        className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                    />
                </div>

                <div className="form-group">
                    <label htmlFor="surname" className="block text-sm font-medium text-gray-700">Surname</label>
                    <input
                        id="surname"
                        type="text"
                        name="surname"
                        value={coach.surname}
                        onChange={handleInputChange}
                        required
                        className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                    />
                </div>

                <div className="form-group">
                    <label htmlFor="imageUrl" className="block text-sm font-medium text-gray-700">Upload Image</label>
                    <input
                        id="imageUrl"
                        type="file"
                        accept="image/jpeg, image/png"
                        onChange={handleFileChange}
                        className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded"
                    />
                </div>

                {fileName && (
                    <div className="mb-4 text-gray-700">
                        <p>Selected file: <strong>{fileName}</strong></p>
                    </div>
                )}

                <button
                    type="submit"
                    className="w-full py-2 px-4 bg-indigo-600 text-white font-semibold rounded-md shadow hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-opacity-50"
                >
                    Update Coach
                </button>
            </form>
        </div>
    );
};

export default UpdateCoach;
