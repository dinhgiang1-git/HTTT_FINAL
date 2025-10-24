<template>
  <div class="main-page" style="max-width: 1400px; width: 100%">
    <div class="page-header">
      <h2 class="title">Quản lí đơn hàng</h2>
      <p class="subtitle">Stay updated with your most recent actions.</p>
    </div>

    <div id="page-action">
      <button class="btn-them" style="background-color: #218837; color: white">Thêm mới</button>
      <IconField>
        <InputIcon><i class="pi pi-search" /></InputIcon>
        <InputText v-model="filters.global.value" placeholder="Tìm kiếm đơn hàng..." />
      </IconField>
    </div>

    <!-- Bảng danh sách đơn hàng -->
    <div id="container" style="width: 100%">
      <div class="card" style="width: 100%">
        <DataTable
            v-model:filters="filters"
            :value="orders"
            paginator
            :rows="10"
            :rowsPerPageOptions="[10, 20, 30, 50]"
            dataKey="id"
            filterDisplay="row"
            :globalFilterFields="['ho', 'ten', 'note', 'status']"
            tableStyle="min-width: 70rem"
        >
          <template #header>
            <div class="flex flex-wrap items-center justify-between gap-2">
              <strong class="text-xl font-bold">Danh sách đơn hàng</strong>
            </div>
          </template>

          <Column field="ho" header="Khách hàng" style="width: 25%">
            <template #body="{ data }">{{ data.ho }} {{ data.ten }}</template>
          </Column>

          <Column field="updated_at" header="Ngày cập nhật" style="width: 20%">
            <template #body="{ data }">{{ formatDateTime(data.updated_at) }}</template>
          </Column>

          <Column field="total" header="Tổng giá trị đơn hàng" style="width: 20%">
            <template #body="{ data }">{{ formatCurrency(data.total) }}</template>
          </Column>

          <Column field="status" header="Trạng thái" style="width: 15%">
            <template #body="{ data }">
              <Tag :value="getStatusLabel(data.status)" :severity="getStatusSeverity(data.status)" />
            </template>
          </Column>

          <Column header="Hành động" style="width: 10%">
            <template #body="{ data }">
              <button class="btn-xemchitiet" style="background-color: #007BFF; color: white" @click="openDialog(data)">
                Xem chi tiết
              </button>
            </template>
          </Column>

          <template #footer>Tổng cộng có {{ orders ? orders.length : 0 }} đơn hàng.</template>
        </DataTable>
      </div>
    </div>

    <!-- 🧩 Dialog chi tiết đơn hàng -->
    <Dialog v-model:visible="visibleDialog" header="Chi tiết đơn hàng" modal style="width: 900px">
      <div v-if="selectedOrder">
        <div class="flex justify-between mb-3">
          <div>
            <p><b>ID:</b> {{ selectedOrder.id }}</p>
            <p><b>Khách hàng:</b> {{ selectedOrder.ho }} {{ selectedOrder.ten }}</p>
          </div>

          <!-- Dropdown trạng thái -->
          <Dropdown
              v-model="selectedOrder.status"
              :options="statusOptions"
              optionLabel="label"
              optionValue="value"
              @change="updateOrderStatus"
              style="width: 200px"
          />
        </div>

        <!-- Danh sách chi tiết sản phẩm -->
        <DataTable :value="orderDetails" tableStyle="min-width: 100%">
          <Column header="Ảnh" style="width: 10%">
            <template #body="{ data }">
              <img :src="data.product_image" alt="Ảnh sản phẩm" width="50" height="50" style="object-fit: cover" />
            </template>
          </Column>

          <Column field="product_name" header="Sản phẩm" />
          <Column field="configuration" header="Cấu hình" />

          <Column field="quantity" header="Số lượng" style="width: 20%">
            <template #body="{ data }">
              <InputNumber
                  v-model="data.quantity"
                  :min="1"
                  showButtons
                  @blur="handleUpdateOrderDetail(data)"
              />
            </template>
          </Column>

          <Column field="price" header="Đơn giá" style="width: 15%">
            <template #body="{ data }">{{ formatCurrency(data.price) }}</template>
          </Column>

          <Column header="Thành tiền" style="width: 15%">
            <template #body="{ data }">{{ formatCurrency(data.quantity * data.price) }}</template>
          </Column>

          <Column header="Hành động" style="width: 10%">
            <template #body="{ data }">
              <button class="btn-xemchitiet" style="background-color: #007BFF; color: white" @click="confirmDeleteDetail(data.id)">
                Xóa
              </button>
            </template>
          </Column>
        </DataTable>

        <div class="text-right mt-3">
          <b>Tổng cộng: {{ formatCurrency(totalPrice) }}</b>
        </div>
      </div>

      <ConfirmDialog />
      <Toast />
    </Dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import DataTable from "primevue/datatable";
import Column from "primevue/column";
import InputText from "primevue/inputtext";
import IconField from "primevue/iconfield";
import InputIcon from "primevue/inputicon";
import { FilterMatchMode } from "@primevue/core/api";
import Calendar from "primevue/calendar";
import Dropdown from "primevue/dropdown";
import Tag from "primevue/tag";
import Dialog from "primevue/dialog";
import InputNumber from "primevue/inputnumber";
import Button from "primevue/button";
import ConfirmDialog from "primevue/confirmdialog";
import Toast from "primevue/toast";
import { useToast } from "primevue/usetoast";
import { useConfirm } from "primevue/useconfirm";

// 🧠 Import helper
import { getOrders, updateOrder } from "../../Helper/Order.js";
import {
  getOrderDetailsByOrderId,
  updateOrderDetail,
  deleteOrderDetail,
} from "../../Helper/OrderDetail.js";

const orders = ref([]);
const filters = ref({
  global: { value: null, matchMode: FilterMatchMode.CONTAINS },
  ho: { value: null, matchMode: FilterMatchMode.CONTAINS },
  updated_at: { value: null, matchMode: FilterMatchMode.DATE_IS },
  status: { value: null, matchMode: FilterMatchMode.EQUALS },
});

const visibleDialog = ref(false);
const selectedOrder = ref(null);
const orderDetails = ref([]);

const toast = useToast();
const confirm = useConfirm();

const statusOptions = [
  { label: "Chờ shop xác nhận", value: 0 },
  { label: "Shop đã xác nhận", value: 1 },
];

// 🧩 Load danh sách đơn hàng
onMounted(async () => {
  const data = await getOrders();
  orders.value = data.map((o) => ({
    ...o,
    updated_at: new Date(o.updated_at),
  }));
});

// 📦 Mở dialog chi tiết
const openDialog = async (order) => {
  selectedOrder.value = { ...order };
  visibleDialog.value = true;
  console.log(order.id);
  orderDetails.value = await getOrderDetailsByOrderId(order.id);
};

// 💰 Tổng giá trị đơn hàng
const totalPrice = computed(() =>
    orderDetails.value.reduce((sum, item) => sum + item.price * item.quantity, 0)
);

// ✏️ Cập nhật số lượng sản phẩm
const handleUpdateOrderDetail = async (detail) => {
  console.log(detail.quantity);
  await updateOrderDetail(detail.order_detail_id, { quantity: detail.quantity });
  // await updateOrder(selectedOrder.value.id, { total: totalPrice.value });
  toast.add({
    severity: "success",
    summary: "Thành công",
    detail: "Đã cập nhật số lượng sản phẩm",
    life: 2000,
  });
};

// 🗑️ Xóa sản phẩm khỏi đơn hàng
const confirmDeleteDetail = (id) => {
  confirm.require({
    message: "Bạn có chắc chắn muốn xóa sản phẩm này khỏi đơn hàng?",
    header: "Xác nhận",
    acceptLabel: "Xóa",
    rejectLabel: "Hủy",
    acceptClass: "p-button-danger",
    accept: async () => {
      await deleteOrderDetail(id);
      orderDetails.value = orderDetails.value.filter((item) => item.id !== id);
      await updateOrder(selectedOrder.value.id, { total: totalPrice.value });
      toast.add({
        severity: "success",
        summary: "Đã xóa",
        detail: "Sản phẩm đã bị xóa khỏi đơn hàng",
        life: 2000,
      });
    },
  });
};

// 🔄 Cập nhật trạng thái đơn hàng
const updateOrderStatus = async () => {
  let temp = "0";
  if (selectedOrder.value.status === 1) {
    temp = "1";
  } else {
    temp = "0";
  }
  console.log(selectedOrder.value.id)
  await updateOrder(selectedOrder.value.id, { status: temp });
  toast.add({
    severity: "success",
    summary: "Thành công",
    detail: "Đã cập nhật trạng thái đơn hàng",
    life: 2000,
  });
};

// 📅 Định dạng thời gian
const formatDateTime = (date) => {
  if (!date) return "";
  const d = date instanceof Date ? date : new Date(date);
  return new Intl.DateTimeFormat("vi-VN", {
    timeZone: "Asia/Ho_Chi_Minh",
    hour: "2-digit",
    minute: "2-digit",
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  })
      .format(d)
      .replace(",", "");
};

const formatCurrency = (val) =>
    val?.toLocaleString("vi-VN", { style: "currency", currency: "VND" }) ?? "0 ₫";
const getStatusLabel = (status) => (status === 0 ? "Chờ shop xác nhận" : "Shop đã xác nhận");
const getStatusSeverity = (status) => (status === 0 ? "warn" : "success");
</script>

<style scoped>
#container {
  margin-top: 30px;
  max-width: 1400px;
  width: 100%;
}
.card {
  padding: 1rem;
  background-color: white;
  border-radius: 8px;
}
#page-action {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.btn-them,
.btn-xemchitiet {
  padding: 6px 12px;
  border-radius: 4px;
  color: #fff;
}
.mt-3 {
  margin-top: 1rem;
}
.text-right {
  text-align: right;
}
</style>
