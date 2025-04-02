import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Login from './pages/Login';
import Register from './pages/Register';

import SportFacilities from './pages/SportFacilities';
import AddSportFacility from './pages/AddSportFacility';

import Coaches from './pages/Coaches';
import AddCoach from './pages/AddCoach';
import UpdateCoach from './pages/UpdateCoach';

import ManageOpenHours from './pages/ManageOpenHours';

import SportFacilityDetails from "./pages/SportFacilityDetails.jsx";

import SportFacilityRatings from "./pages/Reviews.jsx";

import SportFacilityEquipment from "./pages/Equipment.jsx";
import AddEquipment from "./pages/AddEquipment.jsx";
import UpdateEquipment from "./pages/UpdateEquipment.jsx";

import FacilityNews from "./pages/News.jsx";
import AddNews from "./pages/AddNews.jsx";
import EditNews from "./pages/UpdateNews.jsx";

import TrainingSessions from "./pages/TrainingSessions.jsx"
import CreateTrainingSession from './pages/CreateTrainingSession';

import ManagerManagement  from "./pages/ManagersPage.jsx";

import UpdateSportFacility from "./pages/UpdateSportFacility.jsx";


import './styles/App.css';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/sport-facilities" element={<SportFacilities />} />
        <Route path="/sport-facilities/add" element={<AddSportFacility />} />
          <Route path="/sport-facilities/details" element={<SportFacilityDetails />} />
          <Route path="/sport-facilities/coaches" element={<Coaches />} />
          <Route path="/sport-facilities/open-hours" element={<ManageOpenHours />} />
        <Route path="/add-coach" element={<AddCoach />} />
        <Route path="/update-coach/:id/:sportFacilityID" element={<UpdateCoach />} />
        <Route path="/sport-facilities/reviews" element={<SportFacilityRatings />} />
        <Route path="/sport-facilities/equipment" element={<SportFacilityEquipment />} />
        <Route path="/add-equipment" element={<AddEquipment />} />
        <Route path="/update-equipment/:id" element={<UpdateEquipment />} />
        <Route path="/sport-facilities/news" element={<FacilityNews />} />
        <Route path="/add-news" element={<AddNews />} />
        <Route path="/edit-news" element={<EditNews />} />
        <Route path="/add-sport-facility" element={<AddSportFacility />} />
        <Route path="/manage-open-hours" element={<ManageOpenHours />} />
        <Route path="/sport-facilities/training-sessions" element={< TrainingSessions/>} />
        <Route path="/create-training-session" element={<CreateTrainingSession />} />
        <Route path="/sport-facilities/managers" element={<ManagerManagement />} />
        <Route path="/update-sportfacility" element={<UpdateSportFacility />} />
      </Routes>
    </Router>
  );
}

export default App;
