import axios from 'axios';
import config from '../config';

const API_URL = `${config.proxy}/api/details`;

export const getSportFacilityDetails = async (id) => {
    const response = await axios.get(`${API_URL}/${id}`);
    return response.data;
};
