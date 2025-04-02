import React, { useState } from 'react';
import { createCoach } from '../services/coachService';
import { useNavigate } from 'react-router-dom';
import { uploadPicture } from '../services/fileService';
import "/src/index.css";

const AddCoach = () => {
  const id = localStorage.getItem('selectedFacilityId');
  const navigate = useNavigate();

  const [coach, setCoach] = useState({
    name: '',
    surname: '',
    imageUrl: '',
    sportFacilitiesId: id,
  });

  const [selectedFile, setSelectedFile] = useState(null);
  const [fileName, setFileName] = useState('');

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

      if (selectedFile) {
        const uploadedImageUrl = await uploadPicture(selectedFile);
        setCoach({ ...coach, imageUrl: uploadedImageUrl });
      }

      if (!coach.imageUrl) {
        alert('Please upload an image.');
        return;
      }


      await createCoach(coach);
      navigate(`/sport-facilities/coaches`); // Przekierowanie po sukcesie
    } catch (error) {
      console.error('Error adding coach', error);
    }
  };

  return (
      <div className="max-w-md mx-auto mt-12 p-6 border border-gray-300 rounded-lg bg-white shadow-lg">
        <h1 className="text-2xl text-center text-gray-800 mb-6">Add New Coach</h1>
        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <label className="block text-gray-700 font-semibold mb-2">Name</label>
            <input
                type="text"
                name="name"
                value={coach.name}
                onChange={handleInputChange}
                required
                className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
            />
          </div>
          <div className="mb-4">
            <label className="block text-gray-700 font-semibold mb-2">Surname</label>
            <input
                type="text"
                name="surname"
                value={coach.surname}
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
                className="w-full px-3 py-2 border border-gray-300 rounded"
            />
          </div>

          {fileName && (
              <div className="mb-4 text-gray-700">
                <p>Selected file: <strong>{fileName}</strong></p>
              </div>
          )}

          <button
              type="submit"
              className="w-full py-2 bg-green-500 text-white font-semibold rounded hover:bg-green-600 transition duration-200"
          >
            Add Coach
          </button>
        </form>
      </div>
  );
};

export default AddCoach;
