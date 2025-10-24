import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import './assets/style.css';
import PrimeVue from 'primevue/config';
import Aura from '@primeuix/themes/aura';
import ToastService from 'primevue/toastservice'
import ConfirmationService from 'primevue/confirmationservice';


const app = createApp(App);
app.use(PrimeVue, {
    theme: {
        preset: Aura,     // 👈 cấu hình theme ở đây
        options: {
            darkModeSelector: false, // ép luôn light mode
        },
    },
});
app.use(ToastService)
app.use(router);
app.use(ConfirmationService);
app.mount('#app');
