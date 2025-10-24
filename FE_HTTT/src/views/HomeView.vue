<script setup>
import SlideBarMenu from "@/components/common/SlideBarMenu.vue";
import ProductList from "@/components/product/ProductList.vue";
import {onMounted, ref} from "vue";
import {fetchCollectionsSpotlights} from "@/helpers/products.js";
import FooterSubcriber from "@/components/common/FooterSubcriber.vue";

const spotlightProducts = ref({});
const laptopGamingProducts = ref({});
const laptopVanPhongProducts = ref({});
const laptopWorkstationProducts = ref({});


onMounted(async () => {
  spotlightProducts.value = await fetchCollectionsSpotlights('spotlights');
  laptopGamingProducts.value = await fetchCollectionsSpotlights('gaming');
  laptopVanPhongProducts.value = await fetchCollectionsSpotlights('vanphong');
  laptopWorkstationProducts.value = await fetchCollectionsSpotlights('workstation');
});

</script>

<template>
  <SlideBarMenu></SlideBarMenu>
  <div id="productSpotlight">
    <div class="container">
      <div class="title-moreProduct">
        <h2 class="title">⚡️ SẢN PHẨM NỔI BẬT NHẤT 🔥</h2>
        <router-link :to="{ name: 'Collections', params: { slug: 'spotlights'} }"> + Xem thêm</router-link>
      </div>
      <div class="list">
        <ProductList :Products="spotlightProducts"></ProductList>
      </div>
    </div>
  </div>
  <div id="best-selling-product">
    <div class="container">
      <h2 class="title">TOP SẢN PHẨM BÁN CHẠY</h2>
      <div class="list">
        <ProductList></ProductList>
      </div>
    </div>
  </div>
  <div id="laptop-gaming">
    <div class="container">
      <div class="lg-title-moreProduct">
        <h2 class="title">LAPTOP GAMING</h2>
        <router-link :to="{ name: 'Collections', params: { slug: 'laptop-gaming'} }"> + Xem thêm</router-link>
      </div>
      <div class="list">
        <ProductList :Products="laptopGamingProducts"></ProductList>
      </div>
    </div>
  </div>
  <div id="laptop-vanphong">
    <div class="container">
      <div class="lg-title-moreProduct">
        <h2 class="title">LAPTOP VĂN PHÒNG</h2>
        <router-link :to="{name: 'Collections', params: { slug: 'laptop-vanphong'} }">+ Xem thêm</router-link>
      </div>
      <div class="list">
        <ProductList :Products="laptopVanPhongProducts"></ProductList>
      </div>
    </div>
  </div>
  <div id="laptop-precision">
    <div class="container">
      <div class="lg-title-moreProduct">
        <h2 class="title">LAPTOP ĐỒ HỌA, KỸ THUẬT</h2>
        <router-link :to="{name: 'Collections', params: {slug: 'laptop-workstation'}}">+ Xem thêm</router-link>
      </div>
      <div class="list">
        <ProductList :Products="laptopWorkstationProducts"></ProductList>
      </div>
    </div>
  </div>
  <FooterSubcriber></FooterSubcriber>
</template>

<style scoped>

#laptop-gaming, #laptop-vanphong, #laptop-precision {
  padding: 15px;

  .container {
    max-width: 1370px;
    width: 100%;
    margin: 0 auto;
    padding: 20px 15px;

    .lg-title-moreProduct {
      display: flex;
      flex-direction: row;
      justify-content: space-between;

      .title {
        cursor: pointer;
      }
    }

    .list {
      padding: 16px 0;
    }
  }
}

#best-selling-product {
  padding: 15px;

  .container {
    max-width: 1370px;
    width: 100%;
    margin: 0 auto;

    .title {

    }

    .list {
      padding: 32px 0;
    }
  }
}

#productSpotlight {
  padding: 60px 15px 15px 15px;

  .container {
    max-width: 1370px;
    width: 100%;
    margin: 0 auto;
    padding: 20px 15px;
    background-color: #204956;
    border-radius: 10px;

    .title-moreProduct {
      display: flex;
      align-items: center;
      justify-content: space-between;

      a {
        color: #FFF;
        font-weight: 600;
      }
    }

    .title {
      color: #fff;
      text-transform: uppercase;
      cursor: pointer;
    }

    .list {
      padding: 32px 0;
    }
  }
}
</style>