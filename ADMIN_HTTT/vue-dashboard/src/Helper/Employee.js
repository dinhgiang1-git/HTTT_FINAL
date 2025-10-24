import axios from "axios";

export const getEmployee = async() => {
    try {
        const res = await axios.get(`http://localhost:3000/api/employee/get-all`, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const updateEmployee = async(id, data) => {
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

export const deleteEmployee = async(id) => {
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

export const createEmployee = async(data) => {
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