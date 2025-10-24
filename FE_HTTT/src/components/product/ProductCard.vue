<script setup>
const props = defineProps({
  product: {
    type: Object,
  }
});

const formatPrice = (value) => {
  if (!value) {
    return '';
  }
  return new Intl.NumberFormat('vi-VN').format(value) + 'đ';
}

function getDiscountPercent(oldPrice, prePrice) {
  if (oldPrice <= 0) return 0;
  const percent = ((oldPrice - prePrice) / oldPrice) * 100;
  return Math.round(percent);
}

const product = {
  id: props.product.id,
  image: props.product.image,
  name: props.product.name + ', ' + props.product.cpu + ', RAM ' + props.product.ram + ', SSD ' + props.product.storage + ', ' + props.product.monitor,
  price: formatPrice(props.product.price),
  oldprice: formatPrice(props.product.oldprice),
  total_variants: props.product.total_variants,
  discount_percent: getDiscountPercent(props.product.oldprice, props.product.price)
};

</script>

<template>
  <div class="product-card">
    <div class="container">
      <a :href="`/product/detail/${product.id}`"><img :src="product.image" alt=""></a>
      <div class="content">
        <h3 class="name">
          <a :href="`/product/detail/${product.id}`">
            {{ product.name }}
          </a>
        </h3>
        <p class="option">{{ '+' + product.total_variants + " Options" }}</p>
        <div class="price-promo">
          <div class="price-box">
            <p class="price-pre">{{ product.price }}</p>
            <p class="price-del">{{ product.oldprice }}</p>
          </div>
          <div class="promo">
            <span>{{ '-' + product.discount_percent + '%' }}</span>
          </div>
        </div>
        <button class="add-to-cart" type="button">
          <i class="bi bi-bag-check-fill"></i>
          <a :href="`/product/detail/${product.id}`">Thêm vào giỏ hàng.</a>
        </button>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">

.product-card {
  background-color: #fff;
  max-width: 267.2px;
  transition: all 500ms ease-in-out;
  overflow: hidden;
  border-radius: 4px;
  margin-bottom: 16px;

  &:hover {
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.12);
  }

  img {
    object-fit: cover;
    display: block;
    width: 100%;
    border-radius: 4px 4px 0 0;
    transition: all 400ms ease-in-out;
    height: 178.13px;

    &:hover {
      transform: scale(1.1);
    }
  }

  .content {
    padding: 10px 15px;
    margin-top: 12px;

    .name {
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
      font-size: 15px;
      font-weight: 500;
      margin-bottom: 5px;
      height: 38.18px;

      a {
        display: block;
      }
    }

    .option {
      font-size: 12px;
      padding: 4px 0;
      color: #787C7C;
      text-transform: uppercase;
    }

    .price-promo {
      padding-top: 4px;
      padding-bottom: 12px;
      display: flex;
      flex-direction: row;
      justify-content: space-between;

      .price-box {
        .price-pre {
          color: #d0021c;
          font-weight: 700;
          margin-bottom: 4px;
        }

        .price-del {
          text-decoration: line-through;
          font-weight: 400;
          font-size: 14px;
          color: #787C7C;
        }
      }

      .promo {
        span {
          background-color: #FF0001;
          padding: 2px 5px;
          color: #fff;
          font-size: 12px;
        }
      }

    }

    .add-to-cart {
      display: flex;
      flex-direction: row;
      align-items: center;
      gap: 12px;
      border-radius: 17px;
      position: relative;
      overflow: hidden;
      padding-right: 8px;
      cursor: pointer;

      &::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        height: 100%;
        width: 0;
        background-color: #263b96;
        z-index: 1;
        transition: all 500ms ease;
        border-radius: 17px;
      }

      i {
        font-size: 20px;
        background-color: #263b96;
        color: #fff;
        border-radius: 50%;
        width: 32px;
        height: 32px;
        position: relative;
        z-index: 1;
        line-height: 32px;
      }

      a {
        font-family: Quicksand, sans-serif;
        position: relative;
        z-index: 2;
        font-size: 12px;
        text-transform: uppercase;
        font-weight: 700;
        color: #252A2B;
        line-height: 30px;
      }

      &:hover {
        a {
          color: #fff;
        }

        &::before {
          width: 100%;
        }
      }
    }
  }
}
</style>