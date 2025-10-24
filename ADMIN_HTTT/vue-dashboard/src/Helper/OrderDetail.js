import axios from "axios";

export const getOrderDetailsByOrderId = async(id) => {
    try {
        const res = await axios.get(`http://localhost:3000/api/orders_details/get-od-by-orderIdd/${id}`, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const updateOrderDetail = async(id, data) => {
    try {
        const res = await axios.patch(`http://localhost:3000/api/orders_details/updateAD/${id}`, data, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const deleteOrderDetail = async(id) => {
    try {
        const res = await axios.delete(`http://localhost:3000/api/orders_details/delete/${id}`, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}