<script setup>
import ProductCard from "@/components/product/ProductCard.vue";
import {onMounted, ref, watch} from "vue";
import {useRoute} from "vue-router";
import {fetchCollectionsProducts} from "@/helpers/products.js";
import FooterSubcriber from "@/components/common/FooterSubcriber.vue";

const route = useRoute();


//Handle data
const products = ref([]);
const productsFiltered = ref([]);
const slug = ref();
const selectedSort = ref();

//HandleUI
const selectedPriceRange = ref();

async function loadProducts() {
  slug.value = route.params.slug;
  products.value = await fetchCollectionsProducts(slug.value);
  productsFiltered.value = products.value;
}

const renderTitleCollections = (slug) => {
  switch (slug) {
    case 'spotlights':
      return 'Sản phẩm nổi bật';
    case 'laptop-gaming':
      return 'Laptop Gaming';
    case 'laptop-vanphong':
      return 'Laptop Văn Phòng';
    case 'laptop-workstation':
      return 'Laptop Đồ Họa, Kỹ Thuật';
  }
}

//Handle Filter
const filterProducts = () => {
  let filtered = [...products.value];
  if (selectedPriceRange.value) {
    filtered = products.value.filter((product) => {
      const price = product.price;
      switch (selectedPriceRange.value) {
        case '<5m':
          return price < 5000000;
        case '5m-10m':
          return price >= 5000000 && price <= 10000000;
        case '10m-15m':
          return price >= 10000000 && price <= 15000000;
        case '>20m':
          return price >= 20000000;
        default:
          break;
      }
    });
  }

  if (selectedSort.value) {
    switch (selectedSort.value) {
      case 'newest':
        filtered.sort((a, b) => new Date(b.created_at) - new Date(a.created_at)); // Mới nhất
        break;
      case 'ascPrice':
        filtered.sort((a, b) => a.price - b.price); //Giá tăng dần
        break;
      case 'descPrice':
        filtered.sort((a, b) => b.price - a.price); //Giá giảm dần
        break;
      case 'ascName':
        filtered.sort((a, b) => a.name.localeCompare(b.name)); //Tên A-Z
        break;
      case 'descName':
        filtered.sort((a, b) => b.name.localeCompare(a.name)); //Tên Z-A
        break;
      case 'oldest':
        filtered.sort((a, b) => new Date(a.create_at) - new Date(b.created_at)); //Cũ nhất
        break;
      case 'bestSeller':
        filtered.sort((a, b) => b.buyturn - a.buyturn); //Sản phẩm bán chạy nhất
        break;
      default:
        break;
    }
  }
  productsFiltered.value = filtered;
}

watch([selectedPriceRange, selectedSort], () => {
  filterProducts();
})

onMounted(() => {
  loadProducts();
});


const handlePriceRangeClick = (range) => {
  if (selectedPriceRange.value === range) {
    selectedPriceRange.value = null;
  } else {
    selectedPriceRange.value = range;
  }
}

const handleSortClick = (sort) => {
  if (selectedSort.value === sort) {
    selectedSort.value = null;
  } else {
    selectedSort.value = sort;
  }
}

</script>

<template>
  <div id="ProductCollection">
    <div class="container">
      <div id="filter">
        <div class="price-range">
          <p class="pr-title">Chọn khoảng giá:</p>
          <button class="pr-btn" :class="{'selected' : selectedPriceRange === '<5m'}"
                  @click="handlePriceRangeClick('<5m')">Dưới 5.000.000đ
          </button>
          <button class="pr-btn" :class="{'selected' : selectedPriceRange === '5m-10m'}"
                  @click="handlePriceRangeClick('5m-10m')">5.000.000đ - 10.000.000đ
          </button>
          <button class="pr-btn" :class="{'selected' : selectedPriceRange === '10m-15m'}"
                  @click="handlePriceRangeClick('10m-15m')">10.000.000đ - 15.000.000đ
          </button>
          <button class="pr-btn" :class="{'selected' : selectedPriceRange === '>20m'}"
                  @click="handlePriceRangeClick('>20m')">Trên 20.000.000đ
          </button>
        </div>
        <div class="choose-brand">
          <p class="cb-title">Chọn thương hiệu: </p>
          <select>
            <option>Thương hiệu</option>
            <option>DELL</option>
          </select>
        </div>
        <div class="p-sort">
          <p class="ps-title">Sắp xếp: </p>
          <button class="ps-btn" :class="{'selected' : selectedSort === 'newest'}" @click="handleSortClick('newest')">
            Mới nhất
          </button>
          <button class="ps-btn" :class="{'selected' : selectedSort === 'ascPrice'}"
                  @click="handleSortClick('ascPrice')">Giá tăng dần
          </button>
          <button class="ps-btn" :class="{'selected' : selectedSort === 'descPrice'}"
                  @click="handleSortClick('descPrice')">Giá giảm dần
          </button>
          <button class="ps-btn" :class="{'selected' : selectedSort === 'ascName'}" @click="handleSortClick('ascName')">
            Tên A-Z
          </button>
          <button class="ps-btn" :class="{'selected' : selectedSort === 'descName'}"
                  @click="handleSortClick('descname')">Tên Z-A
          </button>
          <button class="ps-btn" :class="{'selected' : selectedSort === 'oldest'}" @click="handleSortClick('oldest')">Cũ
            nhất
          </button>
          <button class="ps-btn" :class="{'selected' : selectedSort === 'bestSeller'}"
                  @click="handleSortClick('bestSeller')">Bán chạy nhất
          </button>
        </div>
      </div>
      <div id="products">
        <div class="collection-title">
          <h2>{{ renderTitleCollections(slug) }}</h2>
          <p><strong>{{ productsFiltered?.length || 0 }}</strong> sản phẩm</p>
        </div>
        <div class="p-list">
          <ProductCard v-for="product in productsFiltered" :key="product.id" :product="product"></ProductCard>
        </div>
        <div class="paging">

        </div>
      </div>
    </div>
  </div>
  <FooterSubcriber></FooterSubcriber>
</template>

<style scoped>

#products {
  .collection-title {
    margin-bottom: 16px;
    display: flex;
    align-items: center;

    h2 {
      margin-right: 24px;
    }
  }
}

#products {


  .p-list {
    display: grid;
    gap: 16px;
    grid-template-columns: repeat(5, 1fr);
  }
}

#products {
  padding: 15px;
  background-color: #F2F3F5;
  margin-top: 10px;
}

#filter {
  background-color: #fff;
  padding: 15px;

  .price-range {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    align-items: center;
    text-align: left;
    gap: 10px;

    .pr-title {
      margin-right: 24px;
      font-size: 15px;
      color: #252a2b;
      width: 130px;
    }

    .pr-btn {
      padding: 8px 12px;
      background-color: #F2F3F5;
      border-radius: 4px;
      cursor: pointer;
      color: #252a2b;

      &:hover {
        background-color: #4caf50;
        color: #fff;
      }
    }

    .pr-btn.selected {
      background-color: #4caf50;
      color: white;
    }
  }

  .choose-brand {
    display: flex;
    flex-direction: row;
    align-items: center;
    margin-top: 12px;
    margin-bottom: 24px;
    gap: 10px;

    .cb-title {
      margin-right: 24px;
      font-size: 15px;
      color: #252a2b;
      width: 130px;
    }

    select {
      width: 33.33%;
      padding: 6px 12px;
      border: none;
      background-color: #F2F3F5;
      border-radius: 4px;
      color: #252a2b;
    }
  }

  .p-sort {
    display: flex;
    flex-direction: row;
    align-items: center;
    gap: 10px;
    margin-bottom: 12px;

    .ps-btn {
      padding: 8px 12px;
      color: #252a2b;
      border: 1px dashed #C3C3C3;
      border-radius: 4px;
      cursor: pointer;

      &:hover {
        background-color: #4caf50;
        color: #fff;
      }
    }

    .ps-btn.selected {
      background-color: #4caf50;
      color: #fff;
      border: 1px solid #4caf50;
    }

    .ps-title {
      color: #252a2b;;
      font-size: 15px;
      margin-right: 24px;
      width: 130px;
    }
  }
}

#ProductCollection {
  min-height: 60vh;

  .container {
    max-width: 1370px;
    width: 100%;
    margin: 0 auto;
  }
}
</style>