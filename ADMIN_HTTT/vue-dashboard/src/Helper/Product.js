import axios from "axios";

export const getProducts = async() => {
    try {
        const res = await axios.get(`http://localhost:3000/api/products/get-all`, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const getProductById = async(id) => {
    try {
        const res = await axios.get(`http://localhost:3000/api/products/get-by-id/${id}`, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const updateVariant = async(id, data) => {
    try {
      const res = await axios.patch(`http://localhost:3000/api/variant/update/${id}`, data, {
          headers: {
              "Content-Type": "application/json"
          }
      });
      return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const deleteVariant = async(id) => {
    try {
        const res = await axios.delete(`http://localhost:3000/api/variant/delete/${id}`, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}
export const deleteProduct = async(id) => {
    try {
        const res = await axios.delete(`http://localhost:3000/api/products/delete/${id}`, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const createVariant = async(data) => {
    try {
        const res = await axios.post(`http://localhost:3000/api/variants/create`, data, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}

export const createProduct = async(data) => {
    try {
        const res = await axios.post(`http://localhost:3000/api/products/create`, data, {
            headers: {
                "Content-Type": "application/json"
            }
        });
        return res.data.data;
    } catch (e) {
        console.log(e);
    }
}