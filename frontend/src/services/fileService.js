import axios from 'axios';
import config from '../config';

const API_BASE_URL = `${config.proxy}/`;

export const uploadPicture = async (file) => {
    try {
        const formData = new FormData();
        formData.append('file', file);

        const response = await axios.post(`${API_BASE_URL}api/resource/picture`, formData, {
            headers: {
                'Content-Type': 'multipart/form-data',
            },
        });
        console.log('Upload response:', response.data);
        return response.data;
    } catch (error) {
        console.error('Error while uploading picture: ', error);

        throw error.response?.data?.message || 'Error uploading file';
    }
};

export const getPicture = async (imageUrl) => {
    try {
        const response = await axios.get(`${API_BASE_URL}${imageUrl}`, {
            responseType: 'blob',
        });
        const imageObjectUrl = URL.createObjectURL(response.data);
        return imageObjectUrl;
    } catch (error) {
        console.error('Error fetching image:', error);
        return null;
    }
};