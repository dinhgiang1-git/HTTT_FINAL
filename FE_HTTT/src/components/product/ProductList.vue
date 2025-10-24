<script setup>
import ProductCard from "@/components/product/ProductCard.vue";
import {computed, watchEffect} from "vue";

const props = defineProps({
  Products: {
    type: Array
  }
});


</script>

<template>
  <div class="product-list">
    <ProductCard v-for="product in props.Products" :key="product.id" :product="product"></ProductCard>
  </div>
</template>

<style scoped>
  .product-list {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 16px;
  }
</style>