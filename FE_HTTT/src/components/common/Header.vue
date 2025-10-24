<script setup>
import router from "@/router/index.js";
import {computed, onMounted, ref, watchEffect} from "vue";
import {getItemCart} from "@/helpers/order.js";
import {fetchUser} from "@/helpers/user.js";
import Menu from "@/components/common/Menu.vue";
import {useProductStore} from "@/stored/productStore.js";


//Quantity Products In Cart
const store = useProductStore();

const props = defineProps({
  userData: Object
});

const actionLoginOut = computed(() =>
    user.value.id ? "Tài khoản của" : "Đăng nhập/Đăng ký"
);

const accountName = computed(() =>
    user.value.id ? props.userData.ten : "Tài khoản của tôi"
);

const user = ref({});
const cartItems = ref([{}]);

onMounted(async () => {
  user.value = await fetchUser();
  cartItems.value = await getItemCart(user.value.id);
  store.quantityProductInCart = cartItems.value.length;
});

const goToLogin = function () {
  router.push("/auth/login");
}
const goToHome = function () {
  router.push("/");
}
const goToDeTailUser = () => {
  router.push(`/auth/account/${user.value.id}`);
}

const goToCartDetail = () => {
  router.push(`/cart/detail/${user.value.id}`);
}

const toggleMenuClick = ref(false);
const handleMenuCLick = () => {
  toggleMenuClick.value = !toggleMenuClick.value;
}

//Handle Search
const keyword = ref('');
const handleSearch = (event) => {
  event.preventDefault();
  if (keyword.value.trim()) {
    router.push({path: 'search', query: {keyword: keyword.value.trim()}});
  }
}
</script>

<template>
  <header class="header">
    <div class="wrapper-top">
      <div class="content-top">
        <p>Hotline: <b>0906 222 121 - 0988 838 620 </b></p>
        <p> * Tư vấn build PC. </p>
        <p> &nbsp; Địa chỉ: CS1: <b>154 - Lê Thanh Nghị - Hai Bà Trưng CS2: 149 Triều Khúc - Thanh Trì - Hà Nội</b></p>
      </div>
    </div>
    <div class="wrapper-middle">
      <div class="content-middle">
        <div class="logo" @click="goToHome">
          <img src="../../assets/images/logo.png" alt="" class="logo-img">
        </div>
        <form action="" class="search" @submit.prevent="handleSearch">
          <input type="text" v-model="keyword" placeholder="Tìm kiếm sản phẩm..." required>
          <button type="submit"><i class="bi bi-search"></i></button>
        </form>
        <div class="user-cart">
          <!--     Nếu có dữ liệu thì detail     -->
          <div class="user" v-if="user.id" @click="goToDeTailUser">
            <div class="user-img">
              <i class="bi bi-person"></i>
            </div>
            <div class="user-action">
              <p>{{ actionLoginOut }}</p>
              <p style="font-weight: 500">{{ accountName }}</p>
            </div>
          </div>
          <!--Nếu không có dữ liệu thì login-->
          <div class="user" v-else @click="goToLogin">
            <div class="user-img">
              <i class="bi bi-person"></i>
            </div>
            <div class="user-action">
              <p>{{ actionLoginOut }}</p>
              <p style="font-weight: 500">{{ accountName }}</p>
            </div>
          </div>
          <div class="cart" v-if="props.userData" @click="goToCartDetail">
            <div class="cart-img">
              <p class="quantity-cart">{{ store.quantityProductInCart }}</p>
              <i class="bi bi-cart"></i>
            </div>
            <p>Giỏ hàng.</p>
          </div>
        </div>
      </div>
    </div>
    <div class="wrapper-bottom">
      <div class="content-bottom">
        <div class="toggleMenuClick" @click="handleMenuCLick">
          <i class="bi bi-list"></i>
          <p>Danh mục sản phẩm</p>
          <Menu v-if="toggleMenuClick === true"></Menu>
        </div>
        <div class="awards-list">
          <div class="award">
            <i class="bi bi-award"></i>
            <span>Chất lượng sản phẩm</span>
          </div>
          <div class="award">
            <i class="bi bi-truck"></i>
            <span>Vận chuyển siêu tốc</span>
          </div>
          <div class="award">
            <i class="bi bi-telephone"></i>
            <span>Gọi tư vấn</span>
          </div>
        </div>
      </div>
    </div>
  </header>
</template>

<style scoped lang="scss">
.header {

  .wrapper-top {
    background-color: black;

    .content-top {
      max-width: 1200px;
      width: 100%;
      margin: 0 auto;
      display: flex;
      align-items: center;
      padding: 4px 0;

      p {
        font-size: 13px;
        font-weight: 400;
        color: white;
        margin-bottom: 0;
      }
    }
  }

  .wrapper-middle {
    background-color: #E2E2E2;

    .content-middle {
      max-width: 1200px;
      width: 100%;
      margin: 0 auto;
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-direction: row;
      padding: 15px 0;

      .logo {
        display: flex;
        flex-direction: row;
        align-items: center;
        cursor: pointer;

        .logo-img {
          height: 60px;
          display: block;
          font-weight: 600;
        }

        h1 {
          text-transform: uppercase;
          margin-bottom: 0;
        }
      }

      .search {
        max-width: 680px;
        background-color: white;
        border-radius: 4px;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: space-between;

        input {
          font-size: 14px;
          width: 100%;
          padding: 10px 15px;
        }

        button {
          background-color: #F9BA03;
          border-radius: 4px;
          color: white;
          padding: 8px 16px;
          margin-right: 4px;
          cursor: pointer;
        }
      }

      .user-cart {
        display: flex;
        align-items: center;

        .user {
          display: flex;
          align-items: center;
          font-size: 13px;
          font-weight: 400;
          margin-right: 16px;
          cursor: pointer;

          .user-img {
            font-size: 30px;
            color: black;
            margin-right: 8px;
          }
        }

        .cart {
          font-size: 13px;
          font-weight: 400;
          display: flex;
          align-items: center;
          cursor: pointer;

          .cart-img {
            font-size: 28px;
            margin-right: 4px;
            position: relative;

            .quantity-cart {
              font-size: 12px;
              position: absolute;
              top: 0;
              right: 0;
              background-color: #FF0001;
              border-radius: 50%;
              color: white;
              padding: 0 5px;
            }
          }
        }
      }
    }
  }

  .wrapper-bottom {
    background-color: #fff;

    .content-bottom {
      max-width: 1370px;
      width: 100%;
      margin: 0 auto;
      display: flex;
      flex-direction: row;
      border-bottom: solid 1px #eee;

      .toggleMenuClick {
        position: relative;
        padding: 10px 15px;
        display: flex;
        align-items: center;
        font-weight: 600;
        gap: 4px;
        border-left: #ececec solid 1px;
        border-right: #ececec solid 1px;
        cursor: pointer;
        box-shadow: rgba(60, 64, 67, 0.1) 0px -1px 2px 0px, rgba(60, 64, 67, 0.15) 0px -4px 6px 2px;;
      }

      .awards-list {
        padding: 10px 15px;
        display: flex;
        align-items: center;
        font-size: 13px;
        gap: 24px;

        .award {
          display: flex;
          align-items: center;
          gap: 4px;
          -webkit-box-align: center;
        }
      }
    }
  }

}
</style>