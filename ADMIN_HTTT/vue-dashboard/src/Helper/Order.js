import axios from "axios";

export const getOrders = async() => {
    try {
        const res = await axios.get(`http://localhost:3000/api/orders/get-all`, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const updateOrder = async(id, data) => {
    try {
        const res = await axios.patch(`http://localhost:3000/api/orders/update/${id}`, data, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}