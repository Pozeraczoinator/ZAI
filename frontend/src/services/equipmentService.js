import axios from 'axios';
import config from '../config';

const API_URL = `${config.proxy}/api/equipment`;

export const getEqBySportId = async (id) => {
    const response = await axios.get(`${API_URL}/sport/${id}`);
    return response.data;
};

export const deleteEquipment = async (id) => {
    const response = await axios.delete(`${API_URL}/delete/${id}`);
    return response.data;
};

export const createEquipment = async (Eq) => {
    const response = await axios.post(`${API_URL}/create`, Eq);
    return response.data;
};

export const getEqById = async (id) => {
    const response = await axios.get(`${API_URL}/${id}`);
    return response.data;
};

export const updateEq = async (Eq) => {
    const response = await axios.put(`${API_URL}/update`, Eq);
    return response.data;
};