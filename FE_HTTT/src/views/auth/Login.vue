<script setup>
import {ref} from "vue";
import router from "@/router/index.js";
import axios from "axios";
import {storedToken} from '@/helpers/user.js'

const email = ref('');
const password = ref('');
const errMessage = ref('');

const handleBtnLogin = async function (event) {
  event.preventDefault();

  if (!email.value || !password.value) {
    alert("Vui lòng nhập email và mật khẩu.");
    return;
  }

  try {
    const res = await axios.post('http://localhost:3000/auth/login', {
      email: email.value,
      password: password.value
    }, {
      headers: {
        'Content-Type': 'application/json'
      }
    });
    storedToken(res.data.token);
    errMessage.value = '';
    window.location.assign("/");
  } catch (e) {
    const {success, message} = e.response.data;
    if (!success) {
      errMessage.value = message;
    }
  }
}
</script>

<template>
  <div class="login">
    <div class="container">
      <div class="content">
        <h3 class="title">Đăng nhập</h3>
        <div class="space"></div>
        <p id="message-error">{{ errMessage }}</p>
        <form action="">
          <div class="group-input">
            <input type="email" required placeholder="Vui lòng nhập email của bạn" v-model="email"/>
          </div>
          <div class="group-input">
            <input type="password" required placeholder="Vui lòng nhập nhập mật khẩu" v-model="password">
          </div>
          <p class="recapcha">
            This site is protected by reCAPTCHA and the Google <a href="">Privacy Policy</a> and <a href="">Terms of
            Service</a> apply.
          </p>
          <div class="btn-group">
            <button class="login-btn" type="submit" @click="handleBtnLogin">Đăng nhập</button>
            <div class="action">
              <p>Bạn chưa có tài khoản ? <a href="/auth/register">Đăng ký</a></p>
              <p>Bạn quên mật khẩu ? <a href="">Quên mật khẩu</a></p>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<style scoped>
#message-error {
  color: #d0021c;
  text-align: left;
  margin-bottom: 8px;
  font-size: 14px;
}

.login {
  background-color: #F5F5F5;
  min-height: 60vh;

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

        .login-btn {
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