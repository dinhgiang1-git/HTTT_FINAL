import axios from "axios";

export const getCategory = async() => {
    try {
        const res = await axios.get(`http://localhost:3000/api/categories/get-all`, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const createCategory = async(data) => {
    try {
        const res = await axios.post(`http://localhost:3000/api/categories/create`, data, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const deleteCategory = async(id) => {
    try {
        const res = await axios.delete(`http://localhost:3000/api/categories/delete/${id}`, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const updateCategory = async(id, data) => {
    try {
        const res = await axios.patch(`http://localhost:3000/api/categories/update/${id}`, data, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}