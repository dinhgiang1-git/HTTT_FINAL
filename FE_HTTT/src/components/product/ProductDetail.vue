<script setup>
import {onMounted, ref} from "vue";
import {fetchDetailProducts} from "@/helpers/products.js";
import {useRoute} from "vue-router";
import {createOrder, getOrder, insertOrderDetail} from "@/helpers/order.js";
import {fetchUser} from "@/helpers/user.js";
import {useProductStore} from "@/stored/productStore.js";

const store = useProductStore();

const count = ref(1);
const selectedVariant = ref(0);
const handleSelectVariant = (index, variant) => {
  selectedVariant.value = index;
  productActive.value = variant;
}

const handleCount = (key) => {
  if (key === 'plus') {
    count.value++;
  } else if (key === 'minus') {
    if (count.value <= 0) {
      count.value = 0;
      return;
    }
    count.value--;
  }
}

const handleCreateOrder = async () => {
  if (!order.value) {
    let res = await createOrder(user.value.id);
    order.value = await getOrder(user.value.id);
    return false;
  }
}

const handleInsertOrderDetail = async () => {
  await handleCreateOrder();
  productWithOrder.value = {
    ...productActive.value,
    orderId: order.value.id,
    quantity: count.value,
  };
  // console.log(productWithOrder.value)
  let res = await insertOrderDetail(productWithOrder.value);
  if (res.message !== 'Variant already in the cart') {
    store.quantityProductInCart = store.quantityProductInCart + 1;
  }
  console.log('Chèn thêm một sản phẩm vào Chi Tiết Giỏ Hàng', res);
  alert(`Đã thêm ${count.value} sản phẩm vào giỏ hàng`);
}

const route = useRoute();
const productId = route.params.id;
const productsVariants = ref({});
const productActive = ref({});
const order = ref({});
const user = ref({});
const productWithOrder = ref({});


onMounted(async () => {
  productsVariants.value = await fetchDetailProducts(productId);
  productActive.value = productsVariants.value[0];

  user.value = await fetchUser();
  order.value = await getOrder(user.value.id);

  productWithOrder.value = {
    ...productActive.value,
    orderId: order.value.id,
    quantity: count.value,
  }
});


const formatPrice = (price) => {
  if (!price) {
    return '';
  }
  return new Intl.NumberFormat('vi-VN').format(price) + 'đ';
}

const formatName = (product) => {
  return `${product.name} ${product.cpu}, RAM ${product.ram}, ${product.storage}, ${product.monitor}, ${product.vga ? product.vga : ''}`;
}

function getDiscountPercent(oldPrice, prePrice) {
  if (oldPrice <= 0) return 0;
  const percent = ((oldPrice - prePrice) / oldPrice) * 100;
  return Math.round(percent);
}


</script>

<template>
  <div class="productDetail">
    <div class="container">
      <div class="container-product">
        <div class="gallery">
          <picture>
            <img :src="productActive.image" alt="">
          </picture>
        </div>
        <div class="content">
          <div class="heading">
            <h1>{{ formatName(productActive) }}</h1>
            <span
                class="soldold">Tình trạng: <strong>{{
                productActive.quantity > 0 ? 'Còn hàng' : 'Hết hàng'
              }}</strong></span>
            <span class="vendor">Thương hiệu: <strong>{{ productActive.thuonghieu }}</strong></span>
          </div>
          <div class="wrap-product">
            <div class="product-content">
              <div class="product-price">
                <span>Giá: </span>
                <span class="pre-price">{{ formatPrice(productActive.price) }}</span>
                <span class="old-price">{{ formatPrice(productActive.oldprice) }}</span>
                <span class="percent-price">{{
                    '-' + getDiscountPercent(productActive.oldprice, productActive.price) + '%'
                  }}</span>
              </div>
              <div id="products-variant">
                <div class="variant-box" v-for="(variant, index) in productsVariants" :key="index"
                     :class="{'selected': selectedVariant === index}"
                     @click="handleSelectVariant(index, variant)">
                  <p class="variant-name"> {{ formatName(variant) }} </p>
                  <p class="variant-price">{{ formatPrice(variant.price) }}</p>
                </div>
              </div>
              <div class="product-action">
                <div class="product-quantity">
                  <span>Số lượng: </span>
                  <button class="btn-qtt-minus" @click="handleCount('minus')"><i class="bi bi-dash"></i></button>
                  <input type="text" name="quantity" v-model="count" min="1">
                  <button class="btn-qtt-plus" @click="handleCount('plus')"><i class="bi bi-plus"></i></button>
                </div>
                <div class="product-addtocart">
                  <button class="addcart-btn" @click="handleInsertOrderDetail"><span>Thêm vào giỏ hàng</span></button>
                  <button class="buynow-btn" @click="handleInsertOrderDetail"><span>Mua ngay</span></button>
                </div>
              </div>
            </div>
            <div class="product-delivery">
              <div class="info-delivery">
                <p>Chính sách bán hàng</p>
                <span><i class="bi bi-bag-check"></i>Cam kết hàng 100% chính hãng</span>
                <span><i class="bi bi-phone-vibrate"></i>Hỗ trợ 24/7</span>
              </div>
              <div class="info-delivery">
                <p>Thông tin thêm</p>
                <span><i class="bi bi-shield-check"></i>Hoàn tiền 111% nếu hàng giả</span>
                <span><i class="bi bi-hand-thumbs-up"></i>Mở hộp kiểm tra nhận hàng</span>
                <span><i class="bi bi-arrows-angle-expand"></i>Đổi trả trong vòng 7 ngày</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="description-container">
      <h3>Mô tả sản phẩm</h3>
      <div class="product-description">
        {{ productActive.description }}
      </div>
      <div id="specification">
        <h2>Thông số kĩ thuật</h2>
        <table>
          <thead>
          <th>STT</th>
          <th style="width: 70%">Mô tả thiết bị</th>
          <th>Số lượng</th>
          <th>Bảo hành</th>
          </thead>
          <tbody>
          <td>1</td>
          <td style="text-align: left">{{ 'CPU: ' + productActive.cpu }}</td>
          <td>1</td>
          <td>36TH</td>
          </tbody>
          <tbody>
          <td>2</td>
          <td style="text-align: left">{{ 'RAM: ' + productActive.ram }}</td>
          <td>1</td>
          <td>36TH</td>
          </tbody>
          <tbody>
          <td>3</td>
          <td style="text-align: left">{{ 'SSD: ' + productActive.storage }}</td>
          <td>1</td>
          <td>36TH</td>
          </tbody>
          <tbody>
          <td>4</td>
          <td style="text-align: left">{{ 'Màn hình: ' + productActive.monitor }}</td>
          <td>1</td>
          <td>36TH</td>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<style scoped>
.productDetail {
  background-color: #F2F3F5;
  padding-bottom: 24px;

  .container {
    background-color: #fff;
    max-width: 1400px;
    width: 100%;
    margin: 0 auto;
    padding: 0 15px 15px 15px;

    .container-product {
      display: flex;
    }

    .gallery {
      width: 36%;
      padding: 15px;

      picture {
        padding-top: 15px;
      }

      img {
        height: 309px;
        width: 100%;
        object-fit: cover;
        display: block;
      }
    }

    .content {
      width: 64%;
      border-left: solid 1px #eee;
      padding-top: 15px;

      .heading {
        margin-bottom: 15px;
        padding-left: 15px;

        h1 {
          font-size: 24px;
          color: #333333;
        }

        span {
          font-size: 14px;
          margin-right: 8px;

          strong {
            color: #f9bb01;
          }
        }
      }

      .wrap-product {
        display: grid;
        grid-template-columns: 2fr 1fr;

        .product-content {
          padding-left: 15px;

          .product-price {
            display: flex;
            flex-direction: row;
            align-items: center;
            background-color: #fafafa;
            padding: 15px 15px 15px 15px;

            span:nth-child(1) {
              font-weight: 600;
              width: 16%;
            }

            .pre-price {
              font-size: 28px;
              color: #FF0000;
              font-weight: 650;
            }

            .old-price {
              text-decoration: line-through;
              font-size: 18px;
              color: #878c8f;
              font-weight: 400;
              margin-left: 8px;
            }

            .percent-price {
              padding: 4px 12px;
              border: 1px solid #FF0000;
              color: #FF0000;
              border-radius: 4px;
              font-size: 13px;
              margin-left: 12px;
              font-weight: 600;
            }
          }
        }

        .product-action {
          .product-quantity {
            display: flex;
            flex-direction: row;
            align-items: center;
            padding: 15px;

            span {
              font-size: 15px;
              font-weight: 600;
              width: 16%;
            }

            button {
              border: solid 1px #f3f4f4;
              height: 40px;
              width: 40px;
              cursor: pointer;
            }

            input {
              height: 40px;
              width: 60px;
              text-align: center;
              font-weight: 600;
              border: solid 1px #f3f4f4;
              cursor: text;
            }
          }

          .product-addtocart {
            display: flex;
            flex-direction: row;
            gap: 15px;

            .addcart-btn,
            .buynow-btn {
              text-transform: uppercase;
              width: 100%;
              font-size: 15px;
              font-weight: 700;
              overflow: hidden;
              font-family: 'Quicksand', sans-serif;
              padding: 12px 20px;

              span {
                position: relative;
                z-index: 2;
              }
            }

            .addcart-btn {
              border: solid 1px #e70505;
              border-radius: 4px;
              color: #e70505;
              z-index: 2;
              position: relative;
              transition: all 500ms ease;

              &::before {
                content: "";
                position: absolute;
                transform: skewX(15deg);
                top: 0;
                left: -10%;
                display: block;
                width: 0;
                height: 110%;
                background-color: #e70505;
                z-index: 1;
                transition: all 500ms ease;
              }

              &:hover {
                color: #fff;

                &::before {
                  width: 120%;
                }
              }
            }

            .buynow-btn {
              background-color: #e70505;
              color: #fff;
              border-radius: 4px;
              position: relative;
              z-index: 2;

              &::before {
                content: "";
                position: absolute;
                z-index: 1;
                display: block;
                top: 0;
                right: 0;
                height: 100%;
                width: 100%;
                transition: width 400ms ease;
                width: 100%;
                background-color: rgba(0, 0, 0, 0.1);
              }

              &:hover {
                &::before {
                  width: 0;
                }
              }
            }
          }
        }

        .product-delivery {
          padding: 15px;
          margin: 0 15px;
          border: solid 1px #eee;
          border-radius: 4px;
          font-size: 14px;

          .info-delivery {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-bottom: 15px;

            p {
              font-weight: 600;
            }

            span {
              font-weight: 400;
              display: flex;
              align-items: center;
              gap: 12px
            }

            span i {
              color: green;
            }
          }
        }
      }
    }

  }
}

.productDetail {
  .description-container {
    max-width: 1400px;
    margin: 0 auto;
    width: 100%;
    background-color: #fff;
    padding: 15px;
    margin-bottom: 12px;

    h3 {
      margin-bottom: 12px;
    }

    h2 {
      margin-top: 12px;
    }
  }
}


#specification {
  table {
    width: 100%;
    border-collapse: collapse;
    text-align: center;
    margin-top: 12px;
    font-size: 14px;
  }

  th, td {
    padding: 8px;
    border: #000 solid 1px;
  }
}

#products-variant {
  .variant-box.selected {
    color: #4caf50;
    border: #4caf50 1px solid;
  }
}

#products-variant {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  margin-top: 20px;
  margin-left: -8px;

  .variant-box {
    width: 45%;
    text-align: center;
    padding: 8px;
    border: #878c8f 1px solid;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    margin-bottom: 12px;
    margin-left: 8px;
    cursor: pointer;

    &:hover {
      color: #4caf50;
      border: #4caf50 1px solid;
    }

    .variant-price {
      margin-top: 4px;
      color: #FF0000;
      font-weight: 650;
    }
  }
}
</style>