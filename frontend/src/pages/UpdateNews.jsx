// pages/EditNews.js
import React, { useState } from 'react';
import { updateNews } from "../services/newssService.js";
import { useNavigate } from 'react-router-dom';

const EditNews = () => {
    const newsId = localStorage.getItem('NewsId');
    const sportFacilityId = localStorage.getItem('selectedFacilityId');
    const navigate = useNavigate();

    const [news, setNews] = useState({
        sportFacilityNewsID: parseInt(newsId),
        title: '',
        description: '',
        imageUrl: '',
        sportFacilityId: parseInt(sportFacilityId),
    });

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setNews({ ...news, [name]: value });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            await updateNews(news);
            navigate(`/sport-facilities/news`);
        } catch (error) {
            console.error('Error updating news', error);
        }
    };

    return (
        <div className="max-w-2xl mx-auto p-6 bg-white shadow-lg rounded-lg mt-10">
            <h1 className="text-2xl font-semibold text-gray-800 mb-6">Edit News</h1>
            <form onSubmit={handleSubmit} className="space-y-6">
                <div className="form-group">
                    <label htmlFor="title" className="block text-sm font-medium text-gray-700">Title</label>
                    <input
                        id="title"
                        type="text"
                        name="title"
                        value={news.title}
                        onChange={handleInputChange}
                        required
                        className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                    />
                </div>

                <div className="form-group">
                    <label htmlFor="description" className="block text-sm font-medium text-gray-700">Description</label>
                    <textarea
                        id="description"
                        name="description"
                        value={news.description}
                        onChange={handleInputChange}
                        required
                        className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                    />
                </div>

                <div className="form-group">
                    <label htmlFor="imageUrl" className="block text-sm font-medium text-gray-700">Image URL</label>
                    <input
                        id="imageUrl"
                        type="text"
                        name="imageUrl"
                        value={news.imageUrl}
                        onChange={handleInputChange}
                        className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                    />
                </div>

                <button
                    type="submit"
                    className="w-full py-2 px-4 bg-indigo-600 text-white font-semibold rounded-md shadow hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-opacity-50"
                >
                    Update News
                </button>
            </form>
        </div>
    );
};

export default EditNews;
