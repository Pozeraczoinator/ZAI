import axios from 'axios';
import config from '../config';

const API_URL = `${config.proxy}/api/coach`;
const PICTURE_URL = `${config.proxy}/uploads`

export const getAllCoaches = async () => {
  const response = await axios.get(`${API_URL}/all`);
  return response.data;
};

export const getCoachById = async (id) => {
  const response = await axios.get(`${API_URL}/${id}`);
  return response.data;
};

export const getCoachesBySportFacility = async (sportFacilityID) => {
  const response = await axios.get(`${API_URL}/allBySportFacility`, {
    params: { sportFacilityID }
  });
  return response.data;
};

export const getCoachImageUrl = (imageUrl) => {
  return `${PICTURE_URL}/${imageUrl}`;
};


export const createCoach = async (coach) => {
  const response = await axios.post(`${API_URL}/create`, coach);
  return response.data;
};

export const updateCoach = async (coach) => {
  const response = await axios.put(`${API_URL}/update`, coach);
  return response.data;
};

export const deleteCoach = async (id) => {
  const response = await axios.delete(`${API_URL}/delete/${id}`);
  return response.data;
};
