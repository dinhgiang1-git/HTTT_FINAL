import axios from 'axios';

export const createOrder = async (userId) => {
    try {
        const token = localStorage.getItem('token');
        if (!token) {
            console.log('Token is missing');
            return;
        }
        const res = await axios.post('http://localhost:3000/api/orders/create', {userId}, {
            headers: {
                Authorization: `Bearer ${token}`,
                'Content-Type': 'application/json',
            }
        });
        return res.data;
    } catch (e) {
        console.log(e.response.data);
    }
}

export const getOrder = async (userId) => {
    try {
        const token = localStorage.getItem('token');
        if (!token) {
            console.log('Token is missing');
            return;
        }
        const res = await axios.get(`http://localhost:3000/api/orders/get-order-by-user-id/${userId}`, {
            headers: {
                Authorization: `Bearer ${token}`,
                'Content-Type': 'application/json',
            }
        });
        return res.data.data[0];
    } catch (e) {
        console.log('Lỗi khi lấy ra giỏ hàng', e);
    }
}

export const updateOrder = async (orderId, data) => {
    try {
        const token = localStorage.getItem('token');
        if (!token) {
            console.log('Token is missing');
            return;
        }
        const res = await axios.patch(`http://localhost:3000/api/orders/update/${orderId}`, data, {
            headers: {
                Authorization: `Bearer ${token}`,
                'Content-Type': 'application/json',
            }
        });
        return res.data.data;
    } catch (e) {
        console.log('Lỗi khi update Order', e);
    }
}

export const getItemCart = async (userId) => {
    try {
        const token = localStorage.getItem('token');
        if (!token) {
            console.log('Token is missing');
            return;
        }
        const res = await axios.get(`http://localhost:3000/api/orders_details/get-od-by-orderId/${userId}`, {
            headers: {
                Authorization: `Bearer ${token}`,
                'Content-Type': 'application/json',
            }
        });
        return res.data.data;
    } catch (e) {
        // console.log(e.response.data);
    }
}

export const insertOrderDetail = async (product) => {
    try {
        const token = localStorage.getItem('token');
        if (!token) {
            console.log('Token is missing');
            return;
        }
        const res = await axios.post(`http://localhost:3000/api/orders_details/create`, product, {
            headers: {
                Authorization: `Bearer ${token}`,
                'Content-Type': 'application/json'
            }
        });
        return res.data;
    } catch (e) {
        console.log('Lỗi khi update giỏ hàng', e);
    }
}

export const updateOrderDetail = async (id, quantity) => {
    try {
        const token = localStorage.getItem('token');
        if (!token) {
            console.log('Token is missing');
            return;
        }
        const res = await axios.patch(`http://localhost:3000/api/orders_details/update/${id}`, quantity, {
            headers: {
                Authorization: `Bearer ${token}`,
                'Content-Type': 'application/json',
            }
        });
        return res.data;
    } catch (e) {
        console.log('Lỗi khi update số lượng một sản phẩm trong giỏ hàng', e);
    }
}

export const deleteOrderDetail = async (id) => {
    try {
        const token = localStorage.getItem('token');
        if (!token) {
            console.log('Token is missing');
            return;
        }
        const res = await axios.delete(`http://localhost:3000/api/orders_details/delete/${id}`, {
            headers: {
                Authorization: `Bearer ${token}`,
                'Content-Type': 'application/json'
            }
        });
        return res.data.data;
    }catch (e) {
        console.log('Lỗi khi delete sản phẩm khỏi giỏ hàng', e);
    }
}