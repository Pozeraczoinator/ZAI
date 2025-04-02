import React, { useState } from 'react';
import { createEquipment } from '../services/equipmentService';
import { uploadPicture } from '../services/fileService';
import { useNavigate } from 'react-router-dom';
import "/src/index.css";

const AddEquipment = () => {
    const id = localStorage.getItem('selectedFacilityId');
    const navigate = useNavigate();

    const [equipment, setEquipment] = useState({
        type: '',
        brand: '',
        model: '',
        description: '',
        imageUrl: '',
        amount: 1,
        sportFacilityId: id,
    });

    const [selectedFile, setSelectedFile] = useState(null);
    const [fileName, setFileName] = useState('');
    const [uploading, setUploading] = useState(false);

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setEquipment({ ...equipment, [name]: value });
    };

    const handleFileChange = (e) => {
        const file = e.target.files[0];
        setSelectedFile(file);
        setFileName(file.name);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            setUploading(true);


            if (selectedFile) {
                const uploadedImageUrl = await uploadPicture(selectedFile);
                setEquipment((prevState) => ({ ...prevState, imageUrl: uploadedImageUrl }));
            }

            if (!equipment.imageUrl) {
                alert('Please upload an image.');
                return;
            }


            await createEquipment(equipment);

            navigate(`/sport-facilities/equipment`);
        } catch (error) {
            console.error('Error adding equipment', error);
        } finally {
            setUploading(false);
        }
    };

    return (
        <div className="max-w-md mx-auto mt-12 p-6 border border-gray-300 rounded-lg bg-white shadow-lg">
            <h1 className="text-2xl text-center text-gray-800 mb-6">Add New Equipment</h1>
            <form onSubmit={handleSubmit}>
                <div className="mb-4">
                    <label className="block text-gray-700 font-semibold mb-2">Type</label>
                    <input
                        type="text"
                        name="type"
                        value={equipment.type}
                        onChange={handleInputChange}
                        required
                        className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700 font-semibold mb-2">Brand</label>
                    <input
                        type="text"
                        name="brand"
                        value={equipment.brand}
                        onChange={handleInputChange}
                        required
                        className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700 font-semibold mb-2">Model</label>
                    <input
                        type="text"
                        name="model"
                        value={equipment.model}
                        onChange={handleInputChange}
                        required
                        className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700 font-semibold mb-2">Description</label>
                    <textarea
                        name="description"
                        value={equipment.description}
                        onChange={handleInputChange}
                        className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
                    ></textarea>
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700 font-semibold mb-2">Amount</label>
                    <input
                        type="number"
                        name="amount"
                        value={equipment.amount}
                        onChange={handleInputChange}
                        required
                        className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700 font-semibold mb-2">Upload Image</label>
                    <input
                        type="file"
                        accept="image/jpeg, image/png"
                        onChange={handleFileChange}
                        className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
                    />
                </div>

                {fileName && (
                    <div className="mb-4 text-gray-700">
                        <p>Selected file: <strong>{fileName}</strong></p>
                    </div>
                )}

                <button
                    type="submit"
                    className={`w-full py-2 ${uploading ? 'bg-gray-400' : 'bg-green-500'} text-white font-semibold rounded hover:bg-green-600 transition duration-200`}
                    disabled={uploading}
                >
                    {uploading ? 'Uploading...' : 'Add Equipment'}
                </button>
            </form>
        </div>
    );
};

export default AddEquipment;
