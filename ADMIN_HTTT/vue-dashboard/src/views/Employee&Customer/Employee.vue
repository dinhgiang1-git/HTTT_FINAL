<template>
  <div class="main-page">
    <div class="page-header">
      <h2 class="title">Quản lí nhân viên</h2>
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
            :value="filteredEmployees"
            paginator
            :rows="5"
            :rowsPerPageOptions="[5, 10, 20, 50]"
            class="custom-table"
            tableStyle="min-width: 50rem"
        >
          <Column field="id" header="ID" style="width: 10%"></Column>
          <Column field="email" header="Email" style="width: 35%"></Column>
          <Column header="Tên nhân viên" style="width: 25%">
            <template #body="{ data }">
              {{ data.ten ? data.ten : 'Không có...' }}
            </template>
          </Column>
          <Column header="Thao tác" style="width: 30%">
            <template #body="{ data }">
              <button class="btn-xemchitiet" @click="openDialog('view', data)">Xem chi tiết</button>
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
          <p><b>ID:</b> {{ employeeForm.id }}</p>
          <p><b>Email:</b> {{ employeeForm.email }}</p>
          <p><b>Họ:</b> {{ employeeForm.ho || '—' }}</p>
          <p><b>Tên:</b> {{ employeeForm.ten || '—' }}</p>
          <p><b>Địa chỉ:</b> {{ employeeForm.diachi || '—' }}</p>
          <p><b>Công ty:</b> {{ employeeForm.congty || '—' }}</p>
          <p><b>SĐT:</b> {{ employeeForm.phone || '—' }}</p>
          <p><b>Vai trò:</b> {{ employeeForm.role === 1 ? 'Admin' : 'Nhân viên' }}</p>
        </div>

        <div v-else>
          <div class="field">
            <label style="margin-right: 8px">Email</label>
            <InputText style="margin-bottom: 12px" v-model="employeeForm.email" placeholder="Nhập email..."/>
          </div>
          <div class="field">
            <label style="margin-right: 8px">Họ</label>
            <InputText style="margin-bottom: 12px" v-model="employeeForm.ho" placeholder="Nhập họ..."/>
          </div>
          <div class="field">
            <label style="margin-right: 8px">Tên</label>
            <InputText style="margin-bottom: 12px" v-model="employeeForm.ten" placeholder="Nhập tên..."/>
          </div>
          <div class="field">
            <label style="margin-right: 8px">Địa chỉ</label>
            <InputText style="margin-bottom: 12px" v-model="employeeForm.diachi" placeholder="Nhập địa chỉ..."/>
          </div>
          <div class="field">
            <label style="margin-right: 8px">Công ty</label>
            <InputText style="margin-bottom: 12px" v-model="employeeForm.congty" placeholder="Nhập công ty..."/>
          </div>
          <div class="field">
            <label style="margin-right: 8px">Số điện thoại</label>
            <InputText style="margin-bottom: 12px" v-model="employeeForm.phone" placeholder="Nhập số điện thoại..."/>
          </div>
        </div>
      </div>

      <template #footer>
        <button @click="visibleDialog = false">Đóng</button>

        <button v-if="dialogMode === 'add'" class="btn-luu" @click="saveEmployee">Lưu</button>
        <button v-if="dialogMode === 'edit'" class="btn-luu" @click="handleUpdateEmployee">Cập nhật</button>
        <div v-if="dialogMode === 'view'" style="display: flex; gap: 10px;">
          <button class="btn-sua" @click="openDialog('edit', employeeForm)">Sửa</button>
          <button class="btn-xoa" @click="confirmDelete(employeeForm.id)">Xóa</button>
        </div>
      </template>
    </Dialog>

    <ConfirmDialog/>
    <Toast/>
  </div>
</template>

<script setup>
import {ref, computed, onMounted} from "vue";
import DataTable from "primevue/datatable";
import Column from "primevue/column";
import Dialog from "primevue/dialog";
import Toast from "primevue/toast";
import InputText from "primevue/inputtext";
import ConfirmDialog from "primevue/confirmdialog";
import {useConfirm} from "primevue/useconfirm";
import {useToast} from "primevue/usetoast";
import {getEmployee, createEmployee, updateEmployee, deleteEmployee} from "../../Helper/Employee.js";

const employees = ref([]);
const employeeForm = ref({});
const visibleDialog = ref(false);
const dialogMode = ref("view"); // "add" | "edit" | "view"
const dialogTitle = ref("");
const search = ref("");

const toast = useToast();
const confirm = useConfirm();

onMounted(async () => {
  await loadEmployees();
});

const loadEmployees = async () => {
  employees.value = await getEmployee();
};

const filteredEmployees = computed(() =>
    employees.value.filter(
        (emp) =>
            emp.email?.toLowerCase().includes(search.value.toLowerCase()) ||
            emp.ten?.toLowerCase().includes(search.value.toLowerCase())
    )
);

const openDialog = (mode, data = null) => {
  dialogMode.value = mode;
  visibleDialog.value = true;

  if (mode === "add") {
    dialogTitle.value = "Thêm nhân viên mới";
    employeeForm.value = {email: "", ho: "", ten: "", diachi: "", congty: "", phone: "", role: "1", password: "1"};
  } else if (mode === "edit") {
    dialogTitle.value = "Sửa thông tin nhân viên";
    employeeForm.value = {...data};
  } else {
    dialogTitle.value = "Chi tiết nhân viên";
    employeeForm.value = {...data};
  }
};

const saveEmployee = async () => {
  if (!employeeForm.value.email.trim()) {
    toast.add({severity: "warn", summary: "Cảnh báo", detail: "Email không được để trống", life: 2000});
    return;
  }
  console.log(employeeForm.value);
  await createEmployee(employeeForm.value);
  toast.add({severity: "success", summary: "Thành công", detail: "Thêm nhân viên thành công", life: 2000});
  visibleDialog.value = false;
  await loadEmployees();
};

const handleUpdateEmployee = async () => {
  const { created_at, ...rest } = employeeForm.value; // 🧹 Bỏ created_at

  const filteredData = Object.fromEntries(
      Object.entries(rest).filter(([_, v]) => v !== "" && v !== null && v !== undefined)
  );

  await updateEmployee(employeeForm.value.id, filteredData);

  toast.add({
    severity: "success",
    summary: "Thành công",
    detail: "Cập nhật nhân viên thành công",
    life: 2000,
  });

  visibleDialog.value = false;
  await loadEmployees();
};


const confirmDelete = (id) => {
  confirm.require({
    message: "Bạn có chắc chắn muốn xóa nhân viên này?",
    header: "Xác nhận xóa",
    acceptLabel: "Xóa",
    rejectLabel: "Hủy",
    acceptClass: "p-button-danger",
    accept: async () => {
      await deleteEmployee(id);
      toast.add({severity: "success", summary: "Đã xóa", detail: "Xóa nhân viên thành công", life: 2000});
      visibleDialog.value = false;
      await loadEmployees();
    },
  });
};
</script>

<style scoped>
#page-action {
  display: flex;
  flex-direction: row;
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
  background-color: #E0A801;
  color: white;
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
}

.btn-xoa {
  background-color: #DC3545;
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
  background-color: #007BFF;
  color: white;
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
}
</style>
