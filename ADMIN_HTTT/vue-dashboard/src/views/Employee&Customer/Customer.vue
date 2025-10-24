<template>
  <div class="main-page">
    <div class="page-header">
      <h2 class="title">Quản lí khách hàng</h2>
      <p class="subtitle">Stay updated with your most recent actions.</p>
    </div>

    <div id="page-action">
      <button class="btn-them" @click="openDialog('add')">Thêm mới</button>
      <InputText
          v-model="search"
          placeholder="Nhập từ khóa tìm kiếm ..."
          style="width: 250px"
      />
    </div>

    <div id="container">
      <div class="card">
        <DataTable
            :value="filteredCustomers"
            paginator
            :rows="10"
            :rowsPerPageOptions="[10, 20, 30, 50]"
            class="custom-table"
            tableStyle="min-width: 50rem"
        >
          <Column field="id" header="ID" style="width: 10%"></Column>
          <Column field="email" header="Email" style="width: 35%"></Column>
          <Column header="Tên khách hàng" style="width: 25%">
            <template #body="{ data }">
              {{ data.ten ? data.ten : "Không có..." }}
            </template>
          </Column>
          <Column header="Trạng thái" style="width: 15%">
            <template #body="{ data }">
              <Tag
                  :value="data.is_delete === 0 ? 'Active' : 'Blocked'"
                  :severity="data.is_delete === 0 ? 'success' : 'danger'"
              />
            </template>
          </Column>
          <Column header="Thao tác" style="width: 20%">
            <template #body="{ data }">
              <button class="btn-xemchitiet" @click="openDialog('view', data)">
                Xem chi tiết
              </button>
            </template>
          </Column>
        </DataTable>
      </div>
    </div>

    <!-- Dialog xem/thêm/sửa -->
    <Dialog
        v-model:visible="visibleDialog"
        :header="dialogTitle"
        modal
        style="width: 500px"
    >
      <div class="p-fluid">
        <div v-if="dialogMode === 'view'">
          <p><b>ID:</b> {{ customerForm.id }}</p>
          <p><b>Email:</b> {{ customerForm.email }}</p>
          <p><b>Họ:</b> {{ customerForm.ho || "—" }}</p>
          <p><b>Tên:</b> {{ customerForm.ten || "—" }}</p>
          <p><b>Địa chỉ:</b> {{ customerForm.diachi || "—" }}</p>
          <p><b>SĐT:</b> {{ customerForm.phone || "—" }}</p>

          <!-- Cho phép chỉnh trạng thái -->
          <div class="field">
            <label>Trạng thái</label>
            <Dropdown
                v-model="customerForm.is_delete"
                :options="[
                { label: 'Active', value: 0 },
                { label: 'Blocked', value: 1 },
              ]"
                optionLabel="label"
                optionValue="value"
                style="width: 100%"
            />
          </div>
        </div>

        <div v-else>
          <div class="field">
            <label>Email</label>
            <InputText
                style="margin-bottom: 12px"
                v-model="customerForm.email"
                placeholder="Nhập email..."
            />
          </div>
          <div class="field">
            <label style="margin-right: 8px">Họ</label>
            <InputText style="margin-bottom: 12px" v-model="customerForm.ho" placeholder="Nhập họ..." />
          </div>
          <div class="field">
            <label style="margin-right: 8px">Tên</label>
            <InputText style="margin-bottom: 12px" v-model="customerForm.ten" placeholder="Nhập tên..." />
          </div>
          <div class="field">
            <label style="margin-right: 8px">Địa chỉ</label>
            <InputText
                style="margin-bottom: 12px"
                v-model="customerForm.diachi"
                placeholder="Nhập địa chỉ..."
            />
          </div>
          <div class="field">
            <label style="margin-right: 8px; display: inline-block">Số điện thoại</label>
            <InputText
                style="margin-bottom: 12px"
                v-model="customerForm.phone"
                placeholder="Nhập số điện thoại..."
            />
          </div>
        </div>
      </div>

      <template #footer>
        <button @click="visibleDialog = false">Đóng</button>

        <button
            v-if="dialogMode === 'add'"
            class="btn-luu"
            @click="saveCustomer"
        >
          Lưu
        </button>

        <button
            v-if="dialogMode === 'edit' || dialogMode === 'view'"
            class="btn-luu"
            @click="handleUpdateCustomer"
        >
          Cập nhật
        </button>

        <div v-if="dialogMode === 'view'" style="display: flex; gap: 10px">
          <button class="btn-sua" @click="openDialog('edit', customerForm)">
            Sửa
          </button>
          <button class="btn-xoa" @click="confirmDelete(customerForm.id)">
            Xóa
          </button>
        </div>
      </template>
    </Dialog>

    <ConfirmDialog />
    <Toast />
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import DataTable from "primevue/datatable";
import Column from "primevue/column";
import Dialog from "primevue/dialog";
import Toast from "primevue/toast";
import InputText from "primevue/inputtext";
import ConfirmDialog from "primevue/confirmdialog";
import Dropdown from "primevue/dropdown";
import Tag from "primevue/tag";
import { useConfirm } from "primevue/useconfirm";
import { useToast } from "primevue/usetoast";
import {
  getCustomers,
  createCustomer,
  updateCustomer,
  deleteCustomer,
} from "../../Helper/Customer.js";

const customers = ref([]);
const customerForm = ref({});
const visibleDialog = ref(false);
const dialogMode = ref("view"); // "add" | "edit" | "view"
const dialogTitle = ref("");
const search = ref("");

const toast = useToast();
const confirm = useConfirm();

onMounted(async () => {
  await loadCustomers();
});

const loadCustomers = async () => {
  customers.value = await getCustomers();
};

const filteredCustomers = computed(() =>
    customers.value.filter(
        (cus) =>
            cus.email?.toLowerCase().includes(search.value.toLowerCase()) ||
            cus.ten?.toLowerCase().includes(search.value.toLowerCase())
    )
);

const openDialog = (mode, data = null) => {
  dialogMode.value = mode;
  visibleDialog.value = true;

  if (mode === "add") {
    dialogTitle.value = "Thêm khách hàng mới";
    customerForm.value = {
      email: "",
      ho: "",
      ten: "",
      congty: "",
      diachi: "",
      phone: "",
      role: 0,
      password: "1",
    };
  } else if (mode === "edit") {
    dialogTitle.value = "Sửa thông tin khách hàng";
    customerForm.value = { ...data };
  } else {
    dialogTitle.value = "Chi tiết khách hàng";
    customerForm.value = { ...data };
  }
};

const saveCustomer = async () => {
  if (!customerForm.value.email.trim()) {
    toast.add({
      severity: "warn",
      summary: "Cảnh báo",
      detail: "Email không được để trống",
      life: 2000,
    });
    return;
  }
  await createCustomer(customerForm.value);
  toast.add({
    severity: "success",
    summary: "Thành công",
    detail: "Thêm khách hàng thành công",
    life: 2000,
  });
  visibleDialog.value = false;
  await loadCustomers();
};

const handleUpdateCustomer = async () => {
  // Sao chép object và loại bỏ created_at, updated_at
  const { created_at, updated_at, ...rest } = customerForm.value;

  // Lọc bỏ các giá trị null/undefined/rỗng
  const filteredData = Object.fromEntries(
      Object.entries(rest).filter(
          ([_, v]) => v !== "" && v !== null && v !== undefined
      )
  );

  await updateCustomer(customerForm.value.id, filteredData);

  toast.add({
    severity: "success",
    summary: "Thành công",
    detail: "Cập nhật khách hàng thành công",
    life: 2000,
  });

  visibleDialog.value = false;
  await loadCustomers();
};


const confirmDelete = (id) => {
  confirm.require({
    message: "Bạn có chắc chắn muốn xóa khách hàng này?",
    header: "Xác nhận xóa",
    acceptLabel: "Xóa",
    rejectLabel: "Hủy",
    acceptClass: "p-button-danger",
    accept: async () => {
      await deleteCustomer(id);
      toast.add({
        severity: "success",
        summary: "Đã xóa",
        detail: "Xóa khách hàng thành công",
        life: 2000,
      });
      visibleDialog.value = false;
      await loadCustomers();
    },
  });
};
</script>

<style scoped>
#page-action {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card {
  padding: 1rem;
  margin-top: 20px;
}

.btn-them {
  background-color: #218837;
  color: white;
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
}

.btn-sua {
  background-color: #e0a801;
  color: white;
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
}

.btn-xoa {
  background-color: #dc3545;
  color: white;
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
}

.btn-luu {
  background-color: #218837;
  color: white;
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
}

.btn-xemchitiet {
  background-color: #007bff;
  color: white;
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
}
</style>
