import axios from 'axios';
import config from '../config';

const API_URL = `${config.proxy}/api/openhour`;

export const getAllOpenHours = async () => {
  const response = await axios.get(`${API_URL}/all`);
  return response.data;
};

export const getOpenHourById = async (id) => {
  const response = await axios.get(`${API_URL}/${id}`);
  return response.data;
};

export const createOpenHour = async (openHour) => {
  const response = await axios.post(`${API_URL}/create`, openHour);
  return response.data;
};

export const updateOpenHour = async (openHour) => {
  const response = await axios.put(`${API_URL}/update`, openHour);
  return response.data;
};

export const deleteOpenHour = async (id) => {
  const response = await axios.delete(`${API_URL}/delete/${id}`);
  return response.data;
};
