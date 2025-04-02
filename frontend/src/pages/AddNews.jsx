import React, { useState } from 'react';
import { createNews } from "../services/newssService.js";
import { uploadPicture } from '../services/fileService';
import { useNavigate } from 'react-router-dom';
import "/src/index.css";

const AddNews = () => {
    const id = localStorage.getItem('selectedFacilityId');
    const navigate = useNavigate();

    const [news, setNews] = useState({
        title: '',
        description: '',
        imageUrl: '',
        sportFacilityId: parseInt(id),
    });

    const [selectedFile, setSelectedFile] = useState(null);
    const [fileName, setFileName] = useState('');
    const [uploading, setUploading] = useState(false);

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setNews({ ...news, [name]: value });
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
                setNews((prevState) => ({ ...prevState, imageUrl: uploadedImageUrl }));
            }


            if (!news.imageUrl) {
                alert('Please upload an image.');
                return;
            }

            await createNews(news);
            navigate(`/sport-facilities/news`);

        } catch (error) {
            console.error('Error adding news', error);
        } finally {
            setUploading(false);
        }
    };

    return (
        <div className="max-w-md mx-auto mt-12 p-6 border border-gray-300 rounded-lg bg-white shadow-lg">
            <h1 className="text-2xl text-center text-gray-800 mb-6">Add News</h1>
            <form onSubmit={handleSubmit}>
                <div className="mb-4">
                    <label className="block text-gray-700 font-semibold mb-2">Title</label>
                    <input
                        type="text"
                        name="title"
                        value={news.title}
                        onChange={handleInputChange}
                        required
                        className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-gray-700 font-semibold mb-2">Description</label>
                    <textarea
                        name="description"
                        value={news.description}
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
                    {uploading ? 'Uploading...' : 'Add News'}
                </button>
            </form>
        </div>
    );
};

export default AddNews;
