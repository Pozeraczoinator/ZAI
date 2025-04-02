// services/sportFacilityService.js
import axios from 'axios';
import config from '../config';

const API_URL = `${config.proxy}/api/SportFacilityNews`;

export const deleteNews = async (id) => {
    const response = await axios.delete(`${API_URL}/delete/${id}`);
    return response.data;
};

export const createNews= async (News) => {
    const response = await axios.post(`${API_URL}/create`, News);
    return response.data;
};

export const updateNews = async (News) => {
    const response = await axios.put(`${API_URL}/update`, News);
    return response.data;
};