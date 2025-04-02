import axios from 'axios';
import config from '../config';

const API_URL = `${config.proxy}/api/sportFacility`;

export const getAllSportFacilities = async () => {
  const response = await axios.get(`${API_URL}/all`);
  return response.data;
};

export const getSportFacilityById = async (id) => {
  const response = await axios.get(`${API_URL}/${id}`);
  return response.data;
};

export const createSportFacility = async (facility) => {
  const response = await axios.post(`${API_URL}/create`, facility);
  return response.data;
};

export const updateSportFacility = async (facility) => {
  const response = await axios.put(`${API_URL}/update`, facility);
  return response.data;
};

export const deleteSportFacility = async (id) => {
  const response = await axios.delete(`${API_URL}/delete/${id}`);
  return response.data;
};
