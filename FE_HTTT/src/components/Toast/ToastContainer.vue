<script setup >
import { ref } from "vue";

const toasts = ref([]);
const icons = {
  success: "fas fa-check-circle",
  error: "fas fa-exclamation-circle",
  info: "fas fa-info-circle",
  warning: "fas fa-exclamation-triangle",
};

function showToast({ title, message, type = "info", duration = 3000 }) {
  const id = Date.now();
  const delay = (duration / 1000).toFixed(2);
  const toast = { id, title, message, type, delay };

  toasts.value.push(toast);
  setTimeout(() => removeToastById(id), duration + 1000);
}

function removeToast(index) {
  toasts.value.splice(index, 1);
}

function removeToastById(id) {
  toasts.value = toasts.value.filter((t) => t.id !== id);
}

defineExpose({ showToast });
</script>

<template>
  <div id="toast">
    <transition-group name="toast" tag="div">
      <div
          v-for="(t, index) in toasts"
          :key="t.id"
          class="toast"
          :class="`toast--${t.type}`"
          @click="removeToast(index)"
          :style="{ animation: `slideInLeft ease .3s, fadeOut linear 1s ${t.delay}s forwards` }">
        <div class="toast__icon">
          <i :class="icons[t.type]"></i>
        </div>
        <div class="toast__body">
          <h3 class="toast__title">{{ t.title }}</h3>
          <p class="toast__msg">{{ t.message }}</p>
        </div>
        <div class="toast__close">
          <i class="fas fa-times"></i>
        </div>
      </div>
    </transition-group>
  </div>
</template>

<style scoped>
@import "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css";
#toast {
  position: fixed;
  top: 100px;
  right: 32px;
  z-index: 999999;
}

.toast {
  display: flex;
  align-items: center;
  background-color: #fff;
  border-radius: 4px;
  padding: 20px 0;
  min-width: 400px;
  max-width: 450px;
  border-left: 4px solid;
  box-shadow: 0 5px 8px rgba(0, 0, 0, 0.08);
  transition: all linear 0.3s;
}

/* Animation */
@keyframes slideInLeft {
  from {
    opacity: 0;
    transform: translateX(calc(100% + 32px));
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes fadeOut {
  to {
    opacity: 0;
  }
}

/* Toast Types */
.toast--success {
  border-color: #47d864;
}
.toast--success .toast__icon {
  color: #47d864;
}

.toast--error {
  border-color: #ff623d;
}
.toast--error .toast__icon {
  color: #ff623d;
}

.toast--info {
  border-color: #2f86eb;
}
.toast--info .toast__icon {
  color: #2f86eb;
}

.toast--warning {
  border-color: #ffc021;
}
.toast--warning .toast__icon {
  color: #ffc021;
}

/* Toast structure */
.toast + .toast {
  margin-top: 24px;
}
.toast__icon {
  font-size: 24px;
  padding: 0 16px;
}
.toast__close {
  font-size: 20px;
  color: rgba(0, 0, 0, 0.3);
  cursor: pointer;
  padding: 0 16px;
}
.toast__body {
  flex-grow: 1;
}
.toast__title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
}
.toast__msg {
  font-size: 14px;
  color: #888;
  margin-top: 6px;
  line-height: 1.5;
}
</style>