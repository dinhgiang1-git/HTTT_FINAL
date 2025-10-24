<script setup>

</script>

<template>
  <div class="footer">
    <div class="container">
      <div class="item">
        <h3>Về TTG</h3>
        <ul>
          <li><p>Trang thương mại chính thức của Dũng CT - Trực Tiếp Game. Luôn tìm kiếm những sản phẩm vì game thủ.</p>
          </li>
          <li><img src="https://theme.hstatic.net/1000288298/1001020793/14/footer_logobct_img.png?v=1560"
                   alt="Bộ công thương"></li>
        </ul>
      </div>
      <div class="item">
        <h3>Thông tin liên hệ</h3>
        <ul>
          <li><i class="bi bi-geo-alt"></i><span>CS1: 83 - 85 Thái Hà - Đống Đa - HN CS2: 83A Cửu Long -Phường 15 - Q10 - TP.HCM</span>
          </li>
          <li><i class="bi bi-phone"></i><span>087.997.9997 - 098.655.2233</span>
          </li>
          <li><i class="bi bi-envelope-at"></i><span> ttgshoponline@gmail.com</span>
          </li>
        </ul>
      </div>
      <div class="item">
        <h3>Tài khoản ngân hàng</h3>
        <ul>
          <li><a href="">Tài khoản ngân hàng</a>
          </li>
          <li><a href="">Tìm kiếm</a>
          </li>
          <li><a href="">Phương thức thanh toán</a>
          </li>
        </ul>
      </div>
      <div class="item">
        <h3>Chính sách</h3>
        <ul>
          <li><a href="#">Chính sách bảo mật</a>
          </li>
          <li><a href="#">Quy định bảo hành</a>
          </li>
          <li><a href="#">Chính sách đổi trả</a>
          </li>
          <li><a href="#">Điều khoản sử dụng</a>
          </li>
          <li><a href="#">Chính sách vận chuyển và kiểm hàng</a>
          </li>
          <li><a href="#">Phân định trách nhiệm của tổ chức cung cấp dịch vụ logistic</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<style scoped>
.footer {
  background-color: #fff;

  .container {
    max-width: 1400px;
    margin: 0 auto;
    width: 100%;
    display: grid;
    grid-template-columns: 1.5fr 1fr 1fr 1fr;
    padding: 30px;

    .item {
      text-align: justify;
      padding: 0 15px;
      font-size: 14px;
      font-weight: 450;

      li, h3 {
        margin-bottom: 15px;
      }

      i {
        color: black;
        margin-right: 4px;
      }
    }
  }
}
</style>