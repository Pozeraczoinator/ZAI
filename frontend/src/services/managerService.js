import axios from 'axios';
import config from '../config';

const API_URL = `${config.proxy}/api/manager`;


export const getManagersByFacility = async (facilityId) => {
    const response = await axios.get(`${API_URL}/${facilityId}`);
    return response.data;
};

export const getUsers = async (facilityId) => {
    const response = await axios.get(`${API_URL}/byId/${facilityId}`);
    return response.data;
};

export const addManager = async (managerDTO) => {
    const response = await axios.post(`${API_URL}/add`, managerDTO);
    return response.data;
};


export const deleteManager = async (managerDTO) => {
    const response = await axios.post(`${API_URL}/delete`, managerDTO);
    return response.data;
};
