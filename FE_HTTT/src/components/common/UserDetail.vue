<script setup>
import {computed, onMounted, ref, watchEffect} from "vue";
import {fetchUser, updateUser} from "@/helpers/user.js";
import {fetchProductsPurchaseByUserId} from "@/helpers/products.js";
import dayjs from "dayjs";

const loading = ref(true);
const error = ref(null);
const selectedItem = ref('info');
const isVisible_addressUpdate = ref(false);
const toggleAddressUpdate = () => {
  isVisible_addressUpdate.value = !isVisible_addressUpdate.value;
}

const groupedOrders = computed(() => {
  if (!order_purchased.value || !Array.isArray(order_purchased.value)) return [];

  const groups = {};

  for (const item of order_purchased.value) {
    const id = item.order_id;
    if (!groups[id]) {
      groups[id] = {
        order_id: id,
        status: item.status,
        updated_at: item.updated_at,
        products: []
      };
    }
    groups[id].products.push(item);
  }
  return Object.values(groups);
});

const form = ref({
  ho: '',
  ten: '',
  congty: '',
  diachi: '',
  phone: ''
});
const updateAddress = async () => {
  try {
    const dataToUpdate = {};
    for (const key in form.value) {
      if (form.value[key] !== null && form.value[key] !== '') {
        dataToUpdate[key] = form.value[key];
      }
    }
    const update = await updateUser(userDetail.value.id, dataToUpdate);
    alert(update.message);
    window.location.reload();
  } catch (err) {
    console.log(err)
  }
}

const logout = () => {
  localStorage.removeItem('token');
  window.location.assign('/');
}

const userDetail = ref({});
const order_purchased = ref({});
onMounted(async () => {
  try {
    const user = await fetchUser();
    userDetail.value = user || {};
    console.log(userDetail.value);
    order_purchased.value = await fetchProductsPurchaseByUserId(userDetail.value.id);
  } catch (err) {
    error.value = 'Không thể tải thông tin người dùng';
    console.error('Lỗi khi tải dữ liệu:', err);
  } finally {
    loading.value = false;
  }
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

const totalPriceCart = (products) => {
  if (!products) {
    return 0;
  }
  return products.reduce((total, product) => {
    return total + product.price * product.quantity
  }, 0);
}

const statusText = (status) => {
  switch (status) {
    case 0:
      return 'Chờ shop xác nhận.';
    case 1:
      return 'Đã xác nhận đơn hàng.';
  }
}

const formatDate = (date) => {
  return dayjs(date).format('HH:mm DD/MM/YYYY');
}
</script>

<template>
  <div class="user-detail">
    <div class="container">
      <h3>Tài khoản của bạn</h3>
      <div class="wrap">
        <div class="sidebar">
          <h4>Tài khoản</h4>
          <ul>
            <li :class="{'selected': selectedItem === 'info'}" @click="selectedItem = 'info'">Thông tin tài khoản</li>
            <li :class="{'selected': selectedItem === 'address'}" @click="selectedItem = 'address'">Địa chỉ</li>
            <li :class="{'selected': selectedItem === 'cart'}" @click="selectedItem = 'cart'">Đơn hàng đã mua</li>
            <li v-if="userDetail.role === 1">
              <a href="http://localhost:5173/" target="_blank">ADMIN</a>
            </li>
            <li @click="logout">Đăng xuất</li>
          </ul>
        </div>
        <div class="content">
          <div v-if="loading">Đang tải...</div>
          <div v-else-if="error">{{ error }}</div>
          <div v-else>
            <h4 v-if="selectedItem === 'info'">Thông tin tài khoản</h4>
            <div class="info-content" v-if="selectedItem === 'info'">
              <p class="name">{{ userDetail.ten || 'Null' }}</p>
              <p class="email">{{ userDetail.email || 'Null' }}</p>
              <p class="address">{{ userDetail.diachi || 'Null' }}</p>
            </div>
            <div class="info-address" v-if="selectedItem === 'address'">
              <div class="address">
                <p>Địa chỉ mặc định</p>
                <div class="group">
                  <label for="">Ho: </label>
                  <p class="first-name">{{ userDetail.ho || 'Null' }}</p>
                </div>
                <div class="group">
                  <label for="">Ten: </label>
                  <p class="last-name">{{ userDetail.ten || 'Null' }}</p>
                </div>
                <div class="group">
                  <label for="">Công ty: </label>
                  <p>{{ userDetail.congty || 'Null' }}</p>
                </div>
                <div class="group">
                  <label for="">Địa chỉ: </label>
                  <p>{{ userDetail.diachi || 'Null' }}</p>
                </div>
                <div class="group">
                  <label for="">SĐT: </label>
                  <p>{{ userDetail.phone || 'Null' }} </p>
                </div>
              </div>
              <div class="address-input">
                <p @click="toggleAddressUpdate" class="btn-updateAddress">Cập nhật địa chỉ</p>
                <div class="input-box" v-if="isVisible_addressUpdate === true">
                  <div class="group-input">
                    <input v-model="form.ho" type="text" placeholder="Họ" id="first-name"/>
                  </div>
                  <div class="group-input">
                    <input v-model="form.ten" type="text" placeholder="Tên" id="last-name"/>
                  </div>
                  <div class="group-input">
                    <input v-model="form.congty" type="text" placeholder="Tên công ty" id="company"/>
                  </div>
                  <div class="group-input">
                    <input v-model="form.diachi" type="text" placeholder="Địa chỉ" id="address"/>
                  </div>
                  <div class="group-input">
                    <input v-model="form.phone" type="text" placeholder="Số điện thoại" id="phone"/>
                  </div>
                  <button type="button" @click="updateAddress">Lưu</button>
                </div>
              </div>
            </div>
            <div id="purchased-order" v-if="selectedItem === 'cart'" v-for="order in groupedOrders" :key="order.order_id">
              <div class="po-list">
                <div class="po-item">
                  <div class="info-purchased">
                    <p class="time">{{ formatDate(order.updated_at) }}</p>
                    <p class="status">{{ statusText(order.status) }}</p>
                  </div>
                  <div class="product" v-for="product in order.products" :key="order.order_id">
                    <div class="p-img"><img :src="product.product_image" alt=""></div>
                    <div class="p-name">{{ formatName(product) }}</div>
                    <div class="p-price">
                      <p class="pp-price">{{ formatPrice(product.total_price) }}</p>
                      <p class="pp-quantity">{{ product.quantity }}</p>
                    </div>
                  </div>
                </div>
              </div>
              <p class="total-price">Thành tiền: {{ formatPrice(totalPriceCart(order.products)) }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">

#purchased-order {
  .total-price {
    color: #252a2b;
    font-size: 18px;
    font-weight: 600;
  }
}

#purchased-order {
  .po-list {
    .po-item {
      display: flex;
      flex-direction: column;
      border-bottom: #4caf50 1px solid;
      padding: 10px;

      .info-purchased {
        display: flex;
        margin-bottom: 12px;

        .status {
          margin-left: auto;
          color: #f9bb01;
          font-weight: 600;
        }

        .time {
          font-weight: 600;
          color: #252a2b;
        }
      }

      .product {
        display: flex;
        flex-direction: row;
        align-items: center;
        gap: 24px;
        margin-bottom: 24px;

        .p-img {
          img {
            width: 70px;
            height: 46px;
            display: block;
            object-fit: cover;
          }
        }

        .p-name {
          color: #252a2b;
          font-size: 16px;
        }

        .p-price {
          margin-left: auto;
          text-align: center;

          .pp-price {
            font-weight: 600;
            color: #252a2b;
            margin-bottom: 2px;
            font-size: 14px;
          }

          .pp-quantity {
            color: #252a2b;
            font-size: 14px;
            font-weight: 600;
          }
        }
      }
    }
  }
}

#purchased-order {
  display: flex;
  flex-direction: column;
  gap: 12px;
  margin-bottom: 80px;
}

.user-detail {
  .container {
    max-width: 1400px;
    width: 100%;
    margin: 0 auto;
    padding: 30px;
    min-height: 60vh;

    h3 {
      text-align: center;
      margin-bottom: 30px;
      width: 110%;
    }

    .wrap {
      display: grid;
      grid-template-columns: 0.5fr 2fr
    }


    .sidebar {
      ul {
        margin-top: 24px;
        display: flex;
        flex-direction: column;
        gap: 24px;

        li {
          cursor: pointer;
        }

        li.selected {
          color: #d0021c;
        }
      }
    }

    .content {
      width: 90%;
      padding: 15px;
      background-color: white;

      h4 {
        margin-bottom: 12px;
      }

      .info-content {
        display: flex;
        flex-direction: column;
        gap: 8px;
      }

      .info-address {
        display: grid;
        grid-template-columns: 1fr 1fr;

        .address {
          display: flex;
          flex-direction: column;
          gap: 8px;

          .group {
            margin-top: 8px;
            display: flex;
            gap: 4px;

            label {
              font-weight: bold;
            }
          }
        }

        .address-input {
          .btn-updateAddress {
            background-color: #323232;
            color: #fff;
            text-transform: uppercase;
            text-align: center;
            padding: 8px;
            font-weight: bold;
            font-size: 14px;
            cursor: pointer;
          }

          .input-box {
            margin-top: 8px;
            display: flex;
            flex-direction: column;
            gap: 24px;

            .group-input {
              display: flex;
              flex-direction: column;
              gap: 4px;

              input {
                border: 1px solid #ebebeb;
                padding: 8px;
                font-size: 14px;
              }
            }

            button {
              text-align: center;
              padding: 8px 0;
              background-color: #323232;
              color: #fff;
              text-transform: uppercase;
              display: block;
              width: 120px;
              cursor: pointer;
              font-weight: 400;
            }
          }
        }
      }
    }
  }
}
</style>