import React, { useEffect, useState } from 'react';
import { getEqBySportId, deleteEquipment } from '../services/equipmentService';
import { useNavigate } from 'react-router-dom';
import BackButton from '../components/homebutton.jsx';
import "/src/index.css";
import { getPicture } from "../services/fileService";


const Equipment = () => {
    const id = localStorage.getItem('selectedFacilityId');
    const [equipment, setEquipment] = useState([]);
    const [loading, setLoading] = useState(true);
    const [equipmentImages, setEquipmentImages] = useState({});
    const navigate = useNavigate();

    useEffect(() => {
        const fetchEquipment = async () => {
            try {
                const data = await getEqBySportId(id);
                setEquipment(data);
                setLoading(false);

                const imagePromises = data.map(async (item) => {
                    if (item.imageUrl) {
                        const url = await getPicture(item.imageUrl);
                        return { id: item.id, url };
                    }
                    return { id: item.id, url: null };
                });

                const images = await Promise.all(imagePromises);
                const imageMap = images.reduce((acc, { id, url }) => {
                    acc[id] = url;
                    return acc;
                }, {});

                setEquipmentImages(imageMap);
            } catch (error) {
                console.error('Error fetching equipment', error);
                setLoading(false);
            }
        };
        fetchEquipment();
    }, [id]);

    const handleDelete = async (equipmentId) => {
        try {
            await deleteEquipment(equipmentId);
            setEquipment(equipment.filter(item => item.id !== equipmentId));
        } catch (error) {
            console.error('Error deleting equipment', error);
        }
    };

    return (
        <div className="container mx-auto p-4">
            <div className="absolute top-4 left-4 z-10">
                <BackButton/>
            </div>
            <h1 className="text-2xl font-bold mb-4 text-center">Equipment</h1>
            <button
                className="mb-4 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 mx-auto block"
                onClick={() => navigate(`/add-equipment`)}>
                Add New Equipment
            </button>

            {loading ? (
                <p className="text-center text-gray-500">Loading equipment...</p>
            ) : (
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                    {equipment.map((item) => (
                        <div key={item.id}
                             className="bg-white shadow-md rounded-lg overflow-hidden p-4 flex flex-col items-center">
                            {item.imageUrl && equipmentImages[item.id] ? (
                                <img
                                    src={equipmentImages[item.id]}
                                    alt={`${item.type} ${item.brand}`}
                                    className="w-48 h-48 object-cover mb-4"
                                />
                            ) : (
                                <div
                                    className="w-48 h-48 rounded-full bg-gray-300 mb-4 flex items-center justify-center">
                                    <span className="text-white">No Image</span>
                                </div>
                            )}
                            <h3 className="text-lg font-semibold text-center">{item.type} {item.brand}</h3>
                            <p className="text-gray-600 text-center mb-2">{item.description}</p>
                            <p className="text-gray-800 text-center">Amount: {item.amount}</p>
                            <div className="flex justify-between mt-4 w-full">
                                <button
                                    className="bg-yellow-500 text-white px-4 py-2 rounded hover:bg-yellow-500"
                                    onClick={() => navigate(`/update-equipment/${item.id}`)}
                                >
                                    Modify
                                </button>
                                <button
                                    className="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600"
                                    onClick={() => handleDelete(item.id)}>
                                    Delete
                                </button>
                            </div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
};

export default Equipment;
