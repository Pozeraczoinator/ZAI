import axios from 'axios';
import config from '../config';

const API_URL = `${config.proxy}/api/training`;

export const getAllTrainingSessions = async () => {
  const response = await axios.get(`${API_URL}/all`);
  return response.data;
};

export const getTrainingSessionById = async (id) => {
  const response = await axios.get(`${API_URL}/facility/${id}`);
  return response.data;
};

export const createTrainingSession = async (trainingSession) => {
  const response = await axios.post(`${API_URL}/create`, trainingSession);
  return response.data;
};

export const updateTrainingSession = async (trainingSession) => {
  const response = await axios.put(`${API_URL}/update`, trainingSession);
  return response.data;
};

export const deleteTrainingSession = async (id) => {
  const response = await axios.delete(`${API_URL}/delete/${id}`);
  return response.data;
};
