import {defineStore} from "pinia";
import {ref} from "vue";

export const useProductStore = defineStore('products', () => {
    const quantityProductInCart = ref(0);


    return {quantityProductInCart}
})