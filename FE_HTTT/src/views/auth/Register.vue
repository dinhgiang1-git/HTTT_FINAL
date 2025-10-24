<script setup>

</script>

<template>
  <div class="register">
    <div class="container">
      <div class="content">
        <h3 class="title">Đăng ký</h3>
        <div class="space"></div>
        <form action="">
          <div class="group-input">
            <input type="text" required placeholder="Họ">
          </div>
          <div class="group-input">
            <input type="text" required placeholder="Tên">
          </div>
          <div class="field-gender">
            <input type="radio" id="radio0" value="0" name="customer_gender">
            <label for="radio0">Nữ</label>
            <input type="radio" id="radio1" value="1" name="customer_gender">
            <label for="radio1">Nam</label>
          </div>
          <div class="group-input">
            <input type="date" required placeholder="dd/mm/yyyy">
          </div>
          <div class="group-input">
            <input type="email" required placeholder="Email">
          </div>
          <div class="group-input">
            <input type="password" required placeholder="Mật khẩu">
          </div>
          <p class="recapcha">
            This site is protected by reCAPTCHA and the Google <a href="">Privacy Policy</a> and <a href="">Terms of
            Service</a> apply.
          </p>
          <div class="btn-group">
            <button class="login" type="submit">Đăng ký</button>
            <div class="action">
              <p>Bạn đã có tài khoản ? <a href="/auth/login">Đăng nhập</a></p>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<style scoped>
.register {
  background-color: #F5F5F5;

  .container {
    max-width: 1400px;
    width: 100%;
    margin: 0 auto;
    padding: 60px 0;

    .content {
      text-align: center;
      max-width: 620px;
      width: 100%;
      margin: 0 auto;
      background-color: #fff;
      padding: 30px;

      .title {
        font-size: 24px;
      }

      .space {
        margin-bottom: 30px;
      }

      .group-input {
        text-align: left;
        background-color: #ececec;
        margin-bottom: 24px;
        border: 1px solid #f5f5f5;

        input {
          color: #5c5c5c;
          width: 100%;
          height: 54px;
          font-style: italic;
          padding: 4px 12px;

          &:focus {
            background-color: #fff;
          }
        }
      }

      .field-gender {
        text-align: left;
        display: flex;
        gap: 8px;
        flex-direction: row;
        margin-bottom: 20px;
        opacity: 0.70;

        input {
          margin-left: 32px;
        }

        label {
          cursor: pointer;
        }

        input:nth-child(1) {
          margin-left: 0;
        }
      }

      .recapcha {
        text-align: left;
        opacity: 0.60;
        font-size: 13px;
        margin-top: -12px;
        margin-bottom: 24px;

        a {
          color: #2962FF;
        }
      }

      .btn-group {
        display: flex;
        align-items: center;

        .login {
          padding: 16px 35px;
          text-transform: uppercase;
          background-color: #f9bb01;
          color: #fff;
          border-radius: 4px;
          font-weight: 700;
          cursor: pointer;
        }

        .action {
          display: flex;
          flex-direction: column;
          text-align: left;
          margin-left: 32px;
          gap: 4px;
          opacity: 0.60;
          font-size: 14px;

          a {
            color: #009DDe;
          }
        }
      }
    }
  }
}
</style>