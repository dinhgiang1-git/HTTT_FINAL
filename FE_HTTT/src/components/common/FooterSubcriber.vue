<script setup lang="ts">

</script>

<template>
  <div id="footersubcriber">
    <div class="container">
      <div class="fs-title">
        <h3>Đăng ký nhận bản tin</h3>
        <p>Đế nhận các thông tin mới từ LT Laptop cũng như các chương trình khuyến mãi</p>
      </div>
      <div class="fs-input-group">
        <input type="email" placeholder="Vui lòng nhập email của bạn...">
        <button>Đăng ký</button>
      </div>
    </div>
  </div>
</template>

<style scoped>
#footersubcriber {
  background-color: #009dde;

  .container {
    max-width: 1370px;
    width: 100%;
    margin: 0 auto;
    display: flex;
    padding: 20px 0;

    .fs-title {
      width: 50%;
      padding-right: 15px;
      text-align: right;
      color: white;
      h3 {
        font-size: 22px;
        margin-bottom: 10px;
      }
      p {
        font-size: 14px;
      }
    }
    .fs-input-group {
      align-self: center;
      width: 33.3333%;
      padding-left: 15px;
      background-color: #fff;
      display: flex;
      flex-direction: row;
      align-items: center;
      border-radius: 4px;

      input {
        font-size: 13px;
        padding: 12px 12px;
        width: 66%;
        font-family: 'Quicksand', sans-serif;
      }

      button {
        font-family: 'Quicksand', sans-serif;
        margin-left: auto;
        background-color: #F9BA03;
        color: #fff;
        cursor: pointer;
        text-transform: uppercase;
        font-size: 13px;
        font-weight: 600;
        display: block;
        padding: 5px 25px;
        margin-right: 4px;
        border-radius: 4px;
      }
    }
  }
}
</style>