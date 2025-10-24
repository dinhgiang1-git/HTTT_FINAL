import axios from "axios";

export const getBrands = async() => {
    try {
        const res = await axios.get(`http://localhost:3000/api/brands/get-all`, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const createBrand = async(data) => {
    try {
        const res = await axios.post(`http://localhost:3000/api/brands/create`, data, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const updateBrand = async(id, data) => {
    try {
        const res = await axios.patch(`http://localhost:3000/api/brands/update/${id}`, data, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e)
    }
}

export const deleteBrand = async(id) => {
    try {
        const res = await axios.delete(`http://localhost:3000/api/brands/delete/${id}`, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}