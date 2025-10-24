<script setup>
import {onMounted, ref} from "vue";
import {fetchUser} from "@/helpers/user.js";
import {getItemCart, updateOrder} from "@/helpers/order.js";


const user = ref({});
const cartItems = ref([{}]);
const orderId = ref();
const dataToUpdate = {
  status: 0,
  note: 'Chờ xác nhận.'
};

onMounted(async () => {
  user.value = await fetchUser();
  cartItems.value = await getItemCart(user.value.id);
  orderId.value = cartItems.value[0].order_id;
  console.log(cartItems.value);
});

const completeOrder = async () => {
  let res =  await updateOrder(orderId.value, dataToUpdate);
  console.log(res);
  alert('Đặt hàng thành công!');
  window.location.assign('/');

}

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
  return cartItems.reduce((total, item) => {
    return total + item.price;
  }, 0);
}

const totalPriceItem = (item) => {
  return item.price * item.quantity;
}

</script>

<template>
  <div id="payment">
    <div class="container">
      <div id="payment-content">
        <h3 class="p-title">Thông tin giao hàng</h3>
        <div class="p-user">
          <img
              src="https://images.unsplash.com/photo-1633544325196-bcf8bf81ead0?q=80&w=1160&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
              alt="" class="p-avatar">
          <div>
            <p class="p-email">{{ user.email }}</p>
            <p class="p-logout">Đăng xuất</p>
          </div>
        </div>
        <div class="p-address">
          <div class="p-store-address">
            <label for="">Lựa chọn địa chỉ...</label>
            <select class="p-select-address">
              <option value="">{{ user.diachi }}</option>
            </select>
          </div>
          <div class="p-show-address">
            <p>Tên: <strong>{{ user.ho + ' ' + user.ten }}</strong></p>
            <p>Số điện thoại: <strong>{{ user.phone }}</strong></p>
            <p>Địa chỉ: <strong>{{ user.diachi }}</strong></p>
            <p>Công ty: <strong>{{ user.congty }}</strong></p>
          </div>
        </div>
        <div class="method-payment">
          <h3 class="m-title">Phương thức thanh toán</h3>
          <p>Thanh toán khi nhận hàng (COD)</p>
        </div>
      </div>
      <div id="payment-sidebar">
        <div class="p-product-list">
          <div class="item" v-for="item in cartItems">
            <img
                :src="item.product_image"
                alt="">
            <p class="item-name">{{ formatName(item) }}</p>
            <p class="item-quantity">{{ item.quantity }}</p>
            <p class="item-price">{{ formatPrice(totalPriceItem(item)) }}</p>
          </div>
        </div>
        <div class="p-voucher">
          <input type="text" placeholder="Mã giảm giá">
          <button>Sử dụng</button>
        </div>
        <div class="p-detail-price">
          <p>Tạm tính: <span>{{ formatPrice(totalPriceCart(cartItems)) }}</span></p>
          <p>Phí vận chuyển: <span>-</span></p>
        </div>
        <div class="p-total-price">
          <p>Tổng cộng <span>{{ formatPrice(totalPriceCart(cartItems)) }}</span></p>
        </div>
        <div class="p-complete-order">
          <button @click="completeOrder">Hoàn tất đơn hàng</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>

#payment-sidebar {
  .p-complete-order {
    padding: 8px 12px;

    button {
      width: 100%;
      background-color: #338DBC;
      padding: 10px 12px;
      color: #fff;
      text-transform: uppercase;
      font-family: 'Quicksand', sans-serif;
      font-weight: 500;
      cursor: pointer;

      &:hover {
        filter: brightness(1.2);
      }
    }
  }
}

#payment-sidebar {
  .p-total-price {
    padding: 12px 6px;

    p {
      display: flex;
      flex-direction: row;
      align-items: center;
      font-weight: 600;

      span {
        margin-left: auto;
        font-size: 24px;
        color: #4b4b4b;
        font-weight: 600;
      }
    }
  }
}

#payment-sidebar {
  .p-detail-price {
    display: flex;
    flex-direction: column;
    gap: 12px;
    border-bottom: 1px solid #f1f1f1;
    padding: 0 6px 12px 6px;

    p {
      display: flex;
      flex-direction: row;
      color: #717171;
      font-size: 14px;

      span {
        margin-left: auto;
        font-size: 14px;
        color: #4b4b4b;
      }
    }
  }
}

#payment-sidebar {
  .p-voucher {
    display: flex;
    align-items: center;
    margin-top: 12px;
    margin-bottom: 12px;
    border-bottom: 1px solid #f1f1f1;
    padding-bottom: 12px;
    padding-left: 8px;

    input {
      height: 30px;
      padding: 4px 8px;
      border: #878c8f solid 1px;
      font-size: 13px;
      width: 60%;
    }

    button {
      cursor: pointer;
      color: #fff;
      background: #c8c8c8;
      margin-left: 24px;
      height: 30px;
      padding: 4px 12px;
    }
  }

}

#payment-sidebar {
  background-color: #fff;
  margin-left: 12px;
  width: 33.33333%;

  .p-product-list {
    display: flex;
    flex-direction: column;
    gap: 12px;

    .item {
      display: flex;
      flex-direction: row;
      align-items: center;
      padding: 4px 6px;
      border-bottom: 1px solid #f1f1f1;

      img {
        width: 47px;
        height: 47px;
        border-radius: 4px;
      }

      .item-name {
        width: 66%;
        margin-left: 12px;
        font-size: 14px;
        color: #4b4b4b;;
      }

      .item-quantity {
        padding: 2px 8px;
        margin-right: 4px;
        font-size: 14px;
        color: #fff;
        background-color: #878c8f;
      }

      .item-price {
        margin-left: auto;
        font-size: 14px;
        color: #4b4b4b;;
      }
    }
  }
}

#payment {
  background-color: #F5F5F5;
  min-height: 60vh;

  .container {
    max-width: 1370px;
    margin: 0 auto;
    display: flex;
  }
}

#payment-content {
  width: 66.6666666%;
  padding: 15px;
  background: #fff;

  .p-title {
    font-size: 24px;
  }

  .p-user {
    display: flex;
    flex-direction: row;
    align-items: center;
    gap: 12px;
    font-size: 15px;
    margin: 24px 0px;

    .p-avatar {
      width: 50px;
      object-fit: cover;
      display: block;
      border-radius: 4px;
    }

    .p-email {
      color: #5c5c5c;
      margin-bottom: 2px;
    }

    .p-logout {
      cursor: pointer;
    }
  }
}

#payment-content {
  .p-address {
    display: flex;
    flex-direction: column;
    gap: 12px;
    margin-bottom: 12px;
    border: 2px solid #eae4e8;
    border-radius: 4px;
    padding: 8px 12px;

    .p-store-address {
      display: flex;
      flex-direction: column;
      text-align: left;
      width: 60%;
      gap: 2px;
      padding: 2px 4px;
      border-bottom: 1px solid #f1f1f1;
      border-radius: 4px;

      label {
        font-size: 13px;
        color: #5c5c5c;
      }

      .p-select-address {
        border: none;
        font-size: 15px;
      }
    }

    .p-show-address {
      display: flex;
      flex-direction: column;
      gap: 12px;
    }
  }
}

#payment-content {
  .method-payment {
    margin-top: 4px;
    display: flex;
    flex-direction: column;
    gap: 8px;

    .title {

    }
  }
}
</style>