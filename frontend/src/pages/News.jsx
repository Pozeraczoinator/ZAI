import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { getSportFacilityDetails } from '../services/newsService';
import { deleteNews } from "../services/newssService.js";
import { getPicture } from "../services/fileService.js";
import "/src/index.css";
import BackButton from "../components/homebutton.jsx";

const FacilityNews = () => {
    const id = localStorage.getItem('selectedFacilityId');
    const [news, setNews] = useState([]);
    const [facilityName, setFacilityName] = useState('');
    const [newsImages, setNewsImages] = useState({});
    const navigate = useNavigate();

    useEffect(() => {
        const fetchFacilityDetails = async () => {
            try {
                const data = await getSportFacilityDetails(parseInt(id));
                setNews(data.news || []);
                setFacilityName(data.name);
                const imagePromises = data.news.map(async (item) => {
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
                setNewsImages(imageMap);
            } catch (error) {
                console.error('Error fetching facility news', error);
            }
        };

        fetchFacilityDetails();
    }, [id]);

    const handleDelete = async (newsId) => {
        try {
            await deleteNews(newsId);
            setNews(news.filter(item => item.id !== newsId));
        } catch (error) {
            console.error('Error deleting news', error);
        }
    };

    return (
        <div className="max-w-4xl mx-auto p-6 bg-white rounded-lg shadow-lg">
            <div className="absolute top-4 left-4 z-10">
                <BackButton/>
            </div>
            <h1 className="text-3xl font-bold mb-6 text-center text-gray-800">News</h1>

            <div className="mb-6 text-center">
                <button
                    className="bg-blue-500 text-white px-6 py-2 rounded-lg hover:bg-blue-600 transition duration-200"
                    onClick={() => navigate(`/add-news`)}
                >
                    Add New News
                </button>
            </div>

            <ul className="space-y-6">
                {news.map((item) => (
                    <li key={item.id} className="bg-white shadow-md rounded-lg p-4">
                        <h2 className="text-xl font-semibold text-gray-800 mb-2">{item.title}</h2>
                        {item.imageUrl && newsImages[item.id] ? (
                            <img
                                src={newsImages[item.id]}
                                alt={item.title}
                                className="w-full h-48 object-cover mb-4 rounded-lg"
                            />
                        ) : (
                            <div className="w-full h-48 bg-gray-300 mb-4 flex items-center justify-center rounded-lg">
                                <span className="text-white">No Image</span>
                            </div>
                        )}

                        <p className="text-gray-700 mb-4">{item.description}</p>

                        <div className="flex justify-between">
                            <button
                                className="bg-yellow-500 text-white px-4 py-2 rounded hover:bg-yellow-500"

                            >
                                Modify
                            </button>
                            <button
                                className="bg-red-500 text-white px-4 py-2 rounded-lg hover:bg-red-600 transition duration-200"
                                onClick={() => handleDelete(item.id)}
                            >
                                Delete
                            </button>
                        </div>
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default FacilityNews;
