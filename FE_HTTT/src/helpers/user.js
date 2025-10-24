import axios from "axios";
import {jwtDecode} from "jwt-decode";

export const storedToken = (token) => {
    localStorage.setItem('token', token);
}

export const getToken = () => {
    return localStorage.getItem('token');
}

export const fetchUser = async () => {
    const token = getToken();
    if (!token) {
        console.log("Không có token");
        return false;
    }
    const decoded = jwtDecode(token);
    const userId = decoded.id;
    try {
        const res = await axios.get(`http://localhost:3000/api/users/get-by-id/${userId}`, {
            headers: {
                Authorization: `Bearer ${token}`,
                "Content-Type": "application/json"
            }
        });
        // console.log(res.data.data[0]);
        return res.data.data[0];
    } catch (e) {
        console.log("Lỗi khi fetch user", e);
    }
}

export const updateUser = async (id, user) => {
    const token = getToken();
    if (!token) {
        console.log("Không có token");
        return false;
    }
    try {
        console.log(user)
        const res = await axios.patch(`http://localhost:3000/api/users/update/${id}`, user, {
            headers: {
                Authorization: `Bearer ${token}`,
                "Content-Type": "application/json"
            }
        });
        return res.data;
    } catch (e) {
        console.log('Lỗi khi update user', e);
    }
}


