<template>
  <div v-if="isVisible" class="notification" :class="typeClass">
    <div class="notification-content">
      <p>{{ message }}</p>
    </div>
    <button @click="closeNotification" class="close-btn">&times;</button>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

const isVisible = ref(false);
const message = ref('');
const type = ref('success');

const typeClass = computed(() => {
  return `notification-${type.value}`;
});

function showNotification(msg, notifType = 'success') {
  message.value = msg;
  type.value = notifType;
  isVisible.value = true;
  setTimeout(() => {
    closeNotification();
  }, 5000); // Tự động đóng sau 5 giây
}

function closeNotification() {
  isVisible.value = false;
}

// Expose the function to the parent component
defineExpose({ showNotification });
</script>

<style scoped>
.notification {
  position: fixed;
  top: 20px;
  right: 20px;
  background-color: #4caf50; /* Màu nền mặc định */
  color: white;
  padding: 15px 20px;
  border-radius: 5px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  display: flex;
  align-items: center;
  gap: 10px;
  z-index: 1000;
  transition: transform 0.3s ease-in-out, opacity 0.3s ease-in-out;
  transform: translateX(100%);
  opacity: 0;
}

.notification-content {
  flex-grow: 1;
}

.close-btn {
  background: none;
  border: none;
  color: white;
  font-size: 20px;
  cursor: pointer;
}

/* Các loại thông báo */
.notification-success {
  background-color: #4caf50;
}

.notification-error {
  background-color: #f44336;
}

.notification-warning {
  background-color: #ff9800;
}
</style>