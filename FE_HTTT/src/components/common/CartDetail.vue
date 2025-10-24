<script setup>
import {onMounted, ref} from "vue";
import {fetchUser} from "@/helpers/user.js";
import {getItemCart, deleteOrderDetail, updateOrderDetail} from "@/helpers/order.js";
import router from "@/router/index.js"
import {useProductStore} from "@/stored/productStore.js";
const store = useProductStore();

const handleQuantityProduct = async (operator, item) => {
  if (operator === '+')  {
    item.quantity++;
    await updateOrderDetail(item.order_detail_id, {quantity: 1});
  } else {
    item.quantity--;
    await updateOrderDetail(item.order_detail_id, {quantity: -1});
  }
  if (item.quantity <= 0) {
    await deleteOrderDetail(item.order_detail_id);
    item.quantity = 0;
    cartItems.value = cartItems.value.filter(i => i.quantity > 0);
    store.quantityProductInCart = store.quantityProductInCart -1;
  }
}

const cartItems = ref([]);
const user = ref({});

onMounted(async () => {
  user.value = await fetchUser();
  cartItems.value = await getItemCart(user.value.id);
});

const formatName = (item) => {
  return `${item.product_name} ${item.cpu}, RAM ${item.ram}, ${item.storage}, ${item.monitor}, ${item.vga ? item.vga : ''}`;
}
const formatPrice = (price) => {
  if (!price) {
    return '';
  }
  return new Intl.NumberFormat('vi-VN').format(price) + 'đ';
}

const totalPriceCart = (cartItems) => {
  if (!cartItems) return 0;
  return cartItems.reduce((total, item) => {
    return total + item.price * item.quantity;
  }, 0);
}

const totalPriceItem = (item) => {
  return item.price * item.quantity;
}

const goToPayment = () => {
  router.push('/payment');
}
</script>

<template>
  <div id="cartDetail">
    <div class="container">
      <div class="wrap">
        <div id="cartContent">
          <h2 class="cart-title">Giỏ hàng của bạn</h2>
          <p class="product-quantity">Bạn đang có {{ cartItems?.length || 0 }} sản phẩm trong giỏ hàng</p>
          <div class="list-item-product" v-if="cartItems && cartItems.length > 0">
            <div class="item-product" v-for="item in cartItems">
              <img :src="item.product_image" alt="" class="item-img">
              <div class="item-content">
                <div class="product-title-price">
                  <a :href="`/product/detail/${item.product_id}`"><p class="title">{{ formatName(item) }}</p></a>
                  <div class="price">
                    <p class="price-pre">{{ formatPrice(item.price) }}</p>
                    <p class="price-old">{{ formatPrice(item.oldprice) }}</p>
                  </div>
                </div>
              </div>
              <div class="product-total">
                <p>{{ formatPrice(totalPriceItem(item)) }}</p>
                <div class="quantity-btn">
                  <button @click="handleQuantityProduct('-', item)"><i class="bi bi-dash"></i></button>
                  <input type="text" :value="item.quantity"/>
                  <button @click="handleQuantityProduct('+', item)"><i class="bi bi-plus"></i></button>
                </div>
              </div>
            </div>
          </div>
          <div id="note-order" v-if="cartItems && cartItems.length > 0">
            <p class="title-note">Ghi chú đơn hàng</p>
            <textarea class="note"></textarea>
          </div>
        </div>
        <div id="cartSideBar">
          <h3 class="title-side-bar">Thông tin đơn hàng</h3>
          <div class="delivery-time">
            <div class="title-delivery">
              <p>Thời gian giao hàng</p>
              <p>Giao hàng khi có hàng</p>
            </div>
            <div class="content">
              <p>Giao hàng khi có hàng</p>
              <p>Chọn thời gian</p>
            </div>
          </div>
          <div class="total-cart-price">
            <p>Tổng tiền: </p>
            <p class="price">{{ formatPrice(totalPriceCart(cartItems)) }}</p>
          </div>
          <div class="info">
            <ul>
              <li>Phí vận chuyển sẽ được tính ở trang Thanh Toán</li>
              <li>Bạn cũng có thể nhập mã giảm giá ở trang Thanh Toán</li>
            </ul>
          </div>
          <button class="pay-btn" @click="goToPayment" v-if="cartItems && cartItems.length > 0">Thanh toán</button>
          <div class="policy">
            <p>Chính sách mua hàng: </p>
            <p>Hiện chúng tôi chỉ áp dụng thanh toán với đơn hàng có giá trị tối thiểu <b>40.000đ</b> trở lên.</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
#cartSideBar {
  .policy {
    background-color: #d9edf7;
    padding: 12px 15px;
    border-radius: 4px;
    margin-top: 24px;

    p:nth-child(1) {
      font-weight: 600;
      font-size: 14px;
      color: #252a2b;
      margin-bottom: 8px;
    }

    p:nth-child(2) {
      font-size: 14px;
      color: #252a2b;
    }
  }
}

#cartSideBar {
  .pay-btn {
    font-family: 'Quicksand', sans-serif;
    background-color: #ff0000;
    text-transform: uppercase;
    color: #fff;
    font-size: 15px;
    text-align: center;
    padding: 10px 5px;
    font-weight: 600;
    width: 100%;
    margin-top: 12px;
    cursor: pointer;
  }
}

#cartSideBar {
  .info {
    margin-top: 4px;
    font-size: 14px;
    color: #252a2b;

    ul {
      display: flex;
      flex-direction: column;
      gap: 4px;
    }
  }
}

#cartSideBar {
  .total-cart-price {
    display: flex;
    flex-direction: row;
    align-items: center;
    padding: 10px 0;
    justify-content: space-between;

    p:nth-child(1) {
      font-size: 16px;
      color: #252a2b;
      font-weight: bold;
    }

    .price {
      font-size: 24px;
      color: #ff0000;
      font-weight: bold;
    }
  }
}

#cartSideBar {
  padding: 15px;
  max-width: 33.333%;
  background-color: #fff;
  margin-left: auto;

  .title-side-bar {
    font-size: 20px;
    font-weight: bold;
    margin-top: 10px;
    line-height: 24px;
    margin-bottom: 15px;
    color: #333333;
  }
}

#cartSideBar {
  .delivery-time {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    background: #fcfcfc;
    border: 1px solid #F5f5f5;
    padding: 10px 8px;
  }

  .title-delivery {
    display: flex;
    flex-direction: column;
    gap: 4px;

    p:nth-child(1) {
      font-size: 13px;
      font-weight: 400;
      text-transform: uppercase;
      color: #252a2b;
    }

    p:nth-child(2) {
      font-size: 13px;
      font-weight: bold;
      color: #252a2b;
    }
  }

  .content {
    display: flex;
    flex-direction: column;
    gap: 4px;

    p {
      font-size: 13px;
      font-weight: 500;
      color: #252a2b;
    }
  }
}

#note-order {
  margin-top: 12px;

  textarea {
    border-radius: 4px;
    margin-top: 12px;
    margin-bottom: 24px;
    padding: 10px 15px;
    width: 100%;
    min-height: 80px;
    resize: none;
    border: 1px solid #dfe0e1;
    box-shadow: none;
    font-family: 'Quicksand', sans-serif;
    font-weight: 500;
    font-size: 15px;
  }

  .title-note {
    color: #4caf50;
    font-weight: 600;
  }
}

#cartDetail {
  background-color: #F5F5F5;

  .container {
    max-width: 1370px;
    width: 100%;
    margin: 0 auto;

    .wrap {
      display: flex;
      min-height: 60vh;
      padding-bottom: 30px;
      //margin-left: -15px;
      //margin-right: -15px;
    }
  }
}

#cartContent {
  background-color: #fff;
  padding: 15px;
  width: 100%;
  margin-right: 12px;

  .cart-title {
    margin-bottom: 12px;
  }
}

#cartContent {
  .list-item-product {
    display: flex;
    flex-direction: column;
    gap: 24px;
    border: 2px solid #eae4e8;
    margin-top: 24px;
    padding: 8px 10px;
    border-radius: 4px;

    .item-product {
      display: flex;
      flex-direction: row;
      gap: 24px;
      border-bottom: 1px solid #f1f1f1;
      padding: 8px;
      border-radius: 4px;
      align-items: center;

      .item-img {
        object-fit: cover;
        height: 67px;
        width: 100px;
        display: block;
      }

      .item-content {
        display: flex;
        flex-direction: row;
      }

      .product-title-price {
        width: 100%;

        .title {
          color: #252a2b;
          font-size: 15px;
        }

        .price {
          margin-top: 6px;
          display: flex;
          font-size: 14px;
          gap: 8px;

          .price-pre {
            color: #FF0001;
            font-weight: 700;
          }

          .price-old {
            text-decoration: line-through;
            font-weight: 500;
            color: #878c8f;
          }
        }
      }

      .product-total {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-left: auto;
        font-weight: 600;

        .quantity-btn {
          margin: 6px;
          display: flex;
          align-items: center;

          button {
            cursor: pointer;
            height: 28px;
            padding: 4px;
            border: 1px solid #f3f4f4;
            background-color: #f9f9f9;
          }

          input {
            text-align: center;
            width: 40px;
            height: 28px;
            font-size: 14px;
            font-weight: 600;
            border: 1px solid #f3f4f4;
          }
        }
      }
    }
  }
}
</style>