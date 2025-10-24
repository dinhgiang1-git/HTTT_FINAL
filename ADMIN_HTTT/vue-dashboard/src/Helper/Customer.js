import axios from "axios";

export const getCustomers = async() => {
    try {
        const res = await axios.get(`http://localhost:3000/api/users/get-all`, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const updateCustomer = async(id, data) => {
    try {
        const res = await axios.patch(`http://localhost:3000/api/users/update/${id}`, data, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const deleteCustomer = async(id) => {
    try {
        const res = await axios.delete(`http://localhost:3000/api/users/delete/${id}`, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const createCustomer = async(data) => {
    try {
        const res = await axios.post(`http://localhost:3000/api/users/create`, data, {
            headers: {
                "Content-Type": "application/json"
            }
        })
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}