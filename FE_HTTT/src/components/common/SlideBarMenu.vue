<script setup>

</script>

<template>
  <div class="slide-bar-menu">
    <div class="container">
      <div class="menu">
        <ul class="list">
          <li><a href="/products/collections/laptop-gaming">Laptop Gaming</a></li>
          <li><a href="/products/collections/laptop-vanphong">Laptop Văn Phòng</a></li>
          <li><a href="/products/collections/laptop-workstation">Laptop Workstation</a></li>
          <li><a href="">Macbook</a></li>
          <li><a href="">Linh kiện máy tính</a></li>
        </ul>
      </div>
      <div class="slide-lg">
        <img src="https://theme.hstatic.net/1000288298/1001020793/14/slide_1_img.jpg?v=1592" alt="">
      </div>
      <div class="slide-sm">
        <a href="" class="img-box">
          <img src="https://the-bithub.com/1jsbp" alt="">
        </a>
        <a href="" class="img-box">
          <img src="https://the-bithub.com/ztl7l" alt="">
        </a>
        <a href="" class="img-box">
          <img src="https://the-bithub.com/ztl7l" alt="">
        </a>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.slide-bar-menu {
  background-color: #F2F3F5;

  .container {
    max-width: 1370px;
    margin: 0 auto;
    width: 100%;
    padding: 0;
    display: grid;
    grid-template-columns: 0.5fr 2fr 0.5fr;

    .menu {
      background-color: #fff;
      border-bottom-left-radius: 4px;
      border-bottom-right-radius: 4px;
      margin-bottom: 15px;
      width: 208.42px;
      font-size: 14px;
      .list {
        box-shadow: 0 1px 2px 0 rgba(60, 64, 67, 0.1), 0 2px 6px 2px rgba(60, 64, 67, 0.15);
        li {
          cursor: pointer;
          padding: 10px 15px;
          border-left: 3px solid transparent;
          &:hover {
            background-color: #ececec;
            border-left-color: #f9bb01;
          }
        }
      }
    }

    .slide-lg {
      padding: 15px;
      img {
        border-radius: 4px;
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
      }
    }

    .slide-sm {
      padding: 15px 0 15px 0;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      .img-box {
        //overflow: hidden;
        width: 343px;
        img {
          width: 100%;
          border-radius: 4px;
          display: block;
          object-fit: cover;
          transition: all 400ms ease;
          &:hover {
            filter: brightness(1.2);
          }
        }
      }
    }
  }
}
</style>