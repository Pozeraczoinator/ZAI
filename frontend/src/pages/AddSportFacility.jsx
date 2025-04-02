import React, { useState } from 'react';
import { createSportFacility } from '../services/sportFacilityService';
import { createOpenHour } from '../services/openHourService';
import { uploadPicture } from '../services/fileService';
import { useNavigate } from 'react-router-dom';
import "/src/index.css";

const AddSportFacility = () => {
  const navigate = useNavigate();

  const [facility, setFacility] = useState({
    name: '',
    description: '',
    address: '',
    type: '',
    membershipRequired: false,
    imageUrl: '',
  });

  const [selectedFile, setSelectedFile] = useState(null);
  const [fileName, setFileName] = useState('');

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFacility({
      ...facility,
      [name]: name === "membershipRequired" ? value === "true" : value,
    });
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
        facility.imageUrl = uploadedImageUrl;
      }

      if (!facility.imageUrl) {
        alert('Please upload an image.');
        return;
      }

      const createdFacility = await createSportFacility(facility);


      const defaultOpenHours = {
        sportFacilityId: createdFacility.id,
        mondayStart: "00:00",
        mondayEnd: "00:00",
        tuesdayStart: "00:00",
        tuesdayEnd: "00:00",
        wednesdayStart: "00:00",
        wednesdayEnd: "00:00",
        thursdayStart: "00:00",
        thursdayEnd: "00:00",
        fridayStart: "00:00",
        fridayEnd: "00:00",
        saturdayStart: "00:00",
        saturdayEnd: "00:00",
        sundayStart: "00:00",
        sundayEnd: "00:00"
      };

      await createOpenHour(defaultOpenHours);

      navigate('/sport-facilities');
    } catch (error) {
      console.error('Error adding sport facility:', error);
    }
  };

  return (
      <div className="max-w-md mx-auto mt-12 p-6 border border-gray-300 rounded-lg bg-white shadow-lg">
        <h1 className="text-2xl text-center text-gray-800 mb-6">Add New Sport Facility</h1>
        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <label className="block text-gray-700 font-semibold mb-2">Name</label>
            <input
                type="text"
                name="name"
                value={facility.name}
                onChange={handleInputChange}
                required
                className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
            />
          </div>
          <div className="mb-4">
            <label className="block text-gray-700 font-semibold mb-2">Description</label>
            <textarea
                name="description"
                value={facility.description}
                onChange={handleInputChange}
                required
                className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
            ></textarea>
          </div>
          <div className="mb-4">
            <label className="block text-gray-700 font-semibold mb-2">Address</label>
            <input
                type="text"
                name="address"
                value={facility.address}
                onChange={handleInputChange}
                required
                className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
            />
          </div>
          <div className="mb-4">
            <label className="block text-gray-700 font-semibold mb-2">Type</label>
            <input
                type="text"
                name="type"
                value={facility.type}
                onChange={handleInputChange}
                required
                className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
            />
          </div>
          <div className="mb-4">
            <label className="block text-gray-700 font-semibold mb-2">Membership Required</label>
            <select
                name="membershipRequired"
                value={facility.membershipRequired ? "true" : "false"}
                onChange={handleInputChange}
                className="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:border-green-500"
            >
              <option value="true">Yes</option>
              <option value="false">No</option>
            </select>
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
            Add Sport Facility
          </button>
        </form>
      </div>
  );
};

export default AddSportFacility;
