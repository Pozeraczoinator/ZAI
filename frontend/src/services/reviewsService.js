import axios from 'axios';
import config from '../config';

const API_URL = `${config.proxy}/api/rating`;

export const getRatingById = async (id, objectType) => {
    const response = await axios.get(`${API_URL}/all`, {
        params: {
            id,
            objectType
        }
    });
    return response.data;
};
