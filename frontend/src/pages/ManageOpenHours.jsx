import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { getOpenHourById, updateOpenHour } from '../services/OpenHourService';
import '/src/index.css';
import BackButton from "../components/homebutton.jsx";

const ManageOpenHours = () => {
  const facilityId = localStorage.getItem('selectedFacilityId');
  const [openingHours, setOpeningHours] = useState({});
  const [isEditing, setIsEditing] = useState(false);
  const [editedHours, setEditedHours] = useState({});

  useEffect(() => {
    const fetchOpeningHours = async () => {
      try {
        const data = await getOpenHourById(facilityId);
        setOpeningHours(data);
        setEditedHours(data);
      } catch (error) {
        console.error('Error fetching opening hours', error);
      }
    };
    fetchOpeningHours();
  }, [facilityId]);

  if (!openingHours) {
    return <div>Loading...</div>;
  }

  const daysOfWeek = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];

  const handleInputChange = (e, day, timeType) => {
    const { value } = e.target;
    setEditedHours({
      ...editedHours,
      [day]: {
        ...editedHours[day],
        [timeType]: value,
      },
    });
  };

  const handleSave = async () => {
    try {
      const updatedHours = {};
      daysOfWeek.forEach((day) => {
        updatedHours[`${day}Start`] = editedHours[day]?.start || '00:00:00';
        updatedHours[`${day}End`] = editedHours[day]?.end || '00:00:00';
      });

      updatedHours.sportFacilityId = parseInt(facilityId);

      await updateOpenHour(updatedHours);

      const data = await getOpenHourById(facilityId);
      setOpeningHours(data);
      setIsEditing(false);
    } catch (error) {
      console.error('Error updating opening hours', error);
    }
  };

  return (
      <div className="container mx-auto mt-16 p-4 bg-gray-100"> {}
        <div className="absolute top-4 left-4 z-10">
          <BackButton/>
        </div>
        <h1 className="text-2xl font-bold mb-4 text-black">Godziny Otwarcia</h1>
        <table className="min-w-full bg-white border border-gray-200">
          <thead>
          <tr>
            <th className="py-2 border-b text-left text-gray-600">Dzień</th>
            <th className="py-2 border-b text-left text-gray-600">Godzina Otwarcia</th>
            <th className="py-2 border-b text-left text-gray-600">Godzina Zamknięcia</th>
          </tr>
          </thead>
          <tbody>
          {daysOfWeek.map((day) => (
              <tr key={day} className="hover:bg-gray-100">
                <td className="py-2 border-b text-black">{day.charAt(0).toUpperCase() + day.slice(1)}</td>
                <td className="py-2 border-b text-black">
                  {isEditing ? (
                      <input
                          type="time"
                          value={editedHours[day]?.start || ''}
                          onChange={(e) => handleInputChange(e, day, 'start')}
                          className="border border-gray-300 p-1 rounded text-white bg-gray-800"
                      />
                  ) : (
                      openingHours[day]?.start || 'Zamknięte'
                  )}
                </td>
                <td className="py-2 border-b text-black">
                  {isEditing ? (
                      <input
                          type="time"
                          value={editedHours[day]?.end || ''}
                          onChange={(e) => handleInputChange(e, day, 'end')}
                          className="border border-gray-300 p-1 rounded text-white bg-gray-800"
                      />
                  ) : (
                      openingHours[day]?.end || 'Zamknięte'
                  )}
                </td>
              </tr>
          ))}
          </tbody>
        </table>

        {isEditing ? (
            <div className="mt-4">
              <button onClick={handleSave} className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
                Zapisz
              </button>
              <button onClick={() => setIsEditing(false)}
                      className="ml-2 bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">
                Anuluj
              </button>
            </div>
        ) : (
            <button onClick={() => setIsEditing(true)}
                    className="mt-4 bg-yellow-500 text-white px-4 py-2 rounded hover:bg-yellow-600">
              Edytuj Godziny Otwarcia
            </button>
        )}
      </div>
  );
};

export default ManageOpenHours;
