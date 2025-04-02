import axios from 'axios';

axios.interceptors.request.use(
  (config) => {
    const user = JSON.parse(localStorage.getItem('user'));
    if (user && user.token) {
      config.headers.Authorization = `Bearer ${user.token}`;
        console.log("Authorization header set:", config.headers.Authorization);
    }
    return config;
  },
  (error) => Promise.reject(error)
);

export default axios;
