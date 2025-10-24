<script setup>
import {onMounted, ref, watch} from "vue";
import {useRoute} from "vue-router";
import {fetchProductsSearch} from "@/helpers/products.js";

import ProductCard from "@/components/product/ProductCard.vue";

const route = useRoute();

const productsSearch = ref({});
const keyword = ref(route.query.keyword || '');

watch(
    () => route.query.keyword,
    async (newKeyword) => {
      keyword.value = newKeyword || '';
      if (newKeyword) {
        await fetchSearchResults();
      } else {
        productsSearch.value = [];
      }
    }
);

const fetchSearchResults = async () => {
  try {
    productsSearch.value = await fetchProductsSearch(keyword.value);
  } catch (error) {
    productsSearch.value = [];
  }
};

onMounted(async () => {
  if (route.query.keyword) {
    await fetchSearchResults();
  }
});

//Handle Button Sort Active:
const toggleButtonSort = ref('');
const handleClickBtn = (sort) => {
  if (toggleButtonSort.value === sort) {
    toggleButtonSort.value = null;
  } else {
    toggleButtonSort.value = sort;
  }
}

watch(toggleButtonSort, () => {
  handleSort();
})

const handleSort = () => {
  let filterd = [...productsSearch.value];
  if (toggleButtonSort.value) {
    switch (toggleButtonSort.value) {
      case 'thap-cao':
        filterd.sort((a, b) => a.price - b.price);
        break;
      case 'cao-thap':
        filterd.sort((a, b) => b.price - a.price);
        break;
      default:
        break;
    }
  }
  productsSearch.value = filterd;
}

</script>

<template>
  <div id="search">
    <div class="container">
      <h2 class="s-title">Tìm kiếm</h2>
      <p class="s-subtitle" v-if="productsSearch">Có <strong>{{ productsSearch?.length || 0 }} sản phẩm</strong>
        cho tìm kiếm
      </p>
      <p class="s-subtitle" v-else>Không tìm thấy sản phẩm nào!
      </p>
      <div class="s-space"></div>
      <p class="s-show-keyword">Kết quả tìm kiếm cho <strong>"{{ keyword }}"</strong></p>
      <div class="s-sort">
        <p>Sắp xếp theo: </p>
        <button @click="handleClickBtn('thap-cao')" :class="{'selected': toggleButtonSort === 'thap-cao' }">
          Giá thấp -> cao
        </button>
        <button @click="handleClickBtn('cao-thap')" :class="{'selected': toggleButtonSort === 'cao-thap' }">
          Giá cao -> thấp
        </button>
      </div>
      <div class="s-list">
        <ProductCard v-for="product in productsSearch" :key="product.id" :product="product"></ProductCard>
      </div>
    </div>
  </div>
</template>

<style scoped>

#search {
  .s-sort {
    display: flex;
    flex-direction: row;
    align-items: center;
    font-size: 14px;
    margin-bottom: 20px;

    p {
      color: #666666;
      margin-right: 12px;
    }

    button {
      color: #333333;
      margin-right: 8px;
      padding: 6px 12px;
      border: 1px solid #ddd;
      border-radius: 4px;
      background-color: #fff;
      transition: all 0.2s ease;

      &:hover {
        background-color: #f5f5f5;
      }
    }

    button.selected {
      background-color: #007bff;
      color: white;
      border-color: #007bff;
    }
  }

  .s-list {
    display: grid;
    gap: 16px;
    grid-template-columns: repeat(5, 1fr);
  }
}

#search {
  .s-title {
    text-align: center;
    margin: 25px 0 5px 0;
    font-size: 30px;
    color: #333333;
  }

  .s-subtitle {
    text-align: center;
    color: #252a2b;
    font-size: 14px;
  }

  .s-space {
    margin-bottom: 20px;
  }

  .s-show-keyword {
    font-size: 14px;
    color: #252a2b;
    margin-bottom: 16px;
  }
}

#search {
  min-height: 60vh;
  background-color: #F5F5F5;

  .container {
    padding: 0 15px;
    max-width: 1370px;
    width: 100%;
    margin: 0 auto;
  }
}
</style>