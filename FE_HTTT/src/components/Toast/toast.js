import { createApp } from "vue";
import ToastContainer from "./ToastContainer.vue";

let toastInstance = null;

export function useToast() {
    if (!toastInstance) {
        const div = document.createElement("div");
        document.body.appendChild(div);
        toastInstance = createApp(ToastContainer).mount(div);
    }

    return {
        success(message, title = "Thành công") {
            toastInstance.showToast({ title, message, type: "success" });
        },
        error(message, title = "Thất bại") {
            toastInstance.showToast({ title, message, type: "error" });
        },
        info(message, title = "Thông báo") {
            toastInstance.showToast({ title, message, type: "info" });
        },
        warning(message, title = "Cảnh báo") {
            toastInstance.showToast({ title, message, type: "warning" });
        },
    };
}
