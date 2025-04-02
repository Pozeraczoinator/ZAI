import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { getSportFacilityById } from '../services/sportFacilityService';
import "/src/index.css";
import { getPicture } from "../services/fileService.js";
import Homebutton from "../components/BackButton.jsx";

const SportFacilityDetails = () => {
    const id = localStorage.getItem('selectedFacilityId');
    const [facility, setFacility] = useState(null);
    const [imageUrl, setImageUrl] = useState('');

    useEffect(() => {
        const fetchFacility = async () => {
            try {
                const data = await getSportFacilityById(id);
                setFacility(data);

                if (data.imageUrl) {
                    const url = await getPicture(data.imageUrl);
                    setImageUrl(url);
                }
            } catch (error) {
                console.error('Error fetching facility details', error);
            }
        };

        fetchFacility();
    }, [id]);

    if (!facility) {
        return <div className="flex justify-center items-center h-screen text-lg">Loading...</div>;
    }

    return (
        <div className="container mx-auto p-10 rounded-lg shadow-md">
            <div className="absolute top-4 left-4 z-10">
                <Homebutton/>
            </div>
            <div className="flex flex-col items-center mb-6">
                <h1 className="text-3xl font-bold text-white mb-4">{facility.name}</h1>
                <Link to={'/update-sportfacility'}>
                {imageUrl ? (
                    <img
                        src={imageUrl}
                        alt={facility.name}
                        className="w-48 h-48 rounded-full object-cover mb-4"
                    />
                ) : (
                    <div className="w-48 h-48 rounded-full bg-gray-300 mb-4 flex items-center justify-center">
                        <span className="text-white">No Image</span>
                    </div>
                )}
                    </Link>

                <Link
                    to={`/sport-facilities/managers`}
                    className="bg-blue-500 text-white px-4 py-2 rounded-lg shadow hover:bg-blue-600 transition-colors"
                >
                    Managers
                </Link>
            </div>

            <div className="container mx-auto flex flex-col items-center text-center">
                <p className="text-white mb-2">{facility.description}</p>
                <p className="text-white mb-2"><strong>Address:</strong> {facility.address}</p>
                <p className="text-white mb-2"><strong>Type:</strong> {facility.type}</p>
                <p className="text-white mb-4"><strong>Membership
                    Required:</strong> {facility.membershipRequired ? 'Yes' : 'No'}</p>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
                <Link to={`/sport-facilities/coaches`}
                      className="bg-white p-4 rounded-lg flex flex-col items-center text-center shadow hover:shadow-lg transition-shadow">
                    <h3 className="text-xl font-semibold text-gray-800">Coaches</h3>
                    <p className="text-gray-600">Manage Coaches.</p>
                </Link>

                <Link to={`/sport-facilities/open-hours`}
                      className="bg-white p-4 rounded-lg flex flex-col items-center text-center shadow hover:shadow-lg transition-shadow">
                    <h3 className="text-xl font-semibold text-gray-800">Open Hours</h3>
                    <p className="text-gray-600">Change Open Hours.</p>
                </Link>

                <Link to={`/sport-facilities/reviews`}
                      className="bg-white p-4 rounded-lg flex flex-col items-center text-center shadow hover:shadow-lg transition-shadow">
                    <h3 className="text-xl font-semibold text-gray-800">Ratings</h3>
                    <p className="text-gray-600">Check Rating.</p>
                </Link>

                <Link to={`/sport-facilities/equipment`}
                      className="bg-white p-4 rounded-lg flex flex-col items-center text-center shadow hover:shadow-lg transition-shadow">
                    <h3 className="text-xl font-semibold text-gray-800">Equipment</h3>
                    <p className="text-gray-600">Manage Equipment.</p>
                </Link>

                <Link to={`/sport-facilities/news`}
                      className="bg-white p-4 rounded-lg flex flex-col items-center text-center shadow hover:shadow-lg transition-shadow">
                    <h3 className="text-xl font-semibold text-gray-800">News</h3>
                    <p className="text-gray-600">Add News.</p>
                </Link>

                <Link to={`/sport-facilities/training-sessions`}
                      className="bg-white p-4 rounded-lg flex flex-col items-center text-center shadow hover:shadow-lg transition-shadow">
                    <h3 className="text-xl font-semibold text-gray-800">Training Sessions</h3>
                    <p className="text-gray-600">Manage Training Sessions.</p>
                </Link>
            </div>
        </div>
    );
};

export default SportFacilityDetails;
