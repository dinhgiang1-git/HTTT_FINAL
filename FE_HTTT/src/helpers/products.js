import axios from "axios";

export const fetchCollectionsSpotlights = async (slug) => {
    try {
        const response = await axios.get(`http://localhost:3000/api/products/collections-spotlight/${slug}`);
        return response.data.data;
    } catch (e) {
        console.error("Lỗi khi fetch collections spotlights products", e);
    }
}

export const fetchDetailProducts = async (productId) => {
    try {
        const response = await axios.get(`http://localhost:3000/api/products/get-by-id/${productId}`);
        return response.data.data;
    } catch (e) {
        console.log('Lỗi khi fetch products detail', e);
    }
}

export const fetchCollectionsProducts = async (slug) => {
    try {
        const res = await axios.get(`http://localhost:3000/api/products/collections/${slug}`);
        return res.data.data;
    } catch (e) {
        console.log('Lỗi khi fetch Collections Products', e);
    }
}

export const fetchProductsPurchaseByUserId = async (userId) => {
    try {
        const res = await axios.get(`http://localhost:3000/api/products/getProductsPurchaseByUserId/${userId}`);
        return res.data.data;
    } catch (e) {
        console.log(e.response.data);
    }
}

export const fetchProductsSearch = async (keyword) => {
    try {
        const res = await axios.get(`http://localhost:3000/api/products/search?query=${encodeURI(keyword)}`);
        return res.data.data;
    } catch (e) {
        console.log(e.response.data);
    }
}