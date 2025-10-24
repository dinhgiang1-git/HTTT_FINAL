<template>
  <div class="main-page">
    <div class="page-header">
      <h2 class="title">Quản lí danh mục</h2>
      <p class="subtitle">Stay updated with your most recent actions.</p>
    </div>

    <div id="page-action">
      <Button
          label="Thêm mới"
          class="btn-them"
          @click="openDialog()"
      />
      <InputText
          v-model="filters.global.value"
          placeholder="Tìm kiếm ..."
          style="width: 250px"
      />
    </div>

    <div id="container">
      <div class="card">
        <DataTable
            :value="categories"
            paginator
            :rows="10"
            :rowsPerPageOptions="[10, 20, 30, 50]"
            class="custom-table"
            v-model:filters="filters"
            tableStyle="min-width: 50rem"
        >
          <Column field="id" header="ID" style="width: 10%"></Column>
          <Column field="name" header="Tên danh mục" style="width: 60%"></Column>
          <Column header="Thao tác" style="width: 30%">
            <template #body="{ data }">
              <Button
                  label="Sửa"
                  class="btn-sua"
                  @click="openDialog(data)"
              />
              <Button
                  label="Xóa"
                  class="btn-xoa"
                  @click="confirmDelete(data.id)"
              />
            </template>
          </Column>
        </DataTable>
      </div>
    </div>

    <!-- Dialog thêm/sửa -->
    <Dialog
        v-model:visible="visibleDialog"
        :header="isEdit ? 'Sửa danh mục' : 'Thêm danh mục'"
        modal
        style="width: 400px"
    >
      <div class="p-fluid">
        <div class="field">
          <label for="name" style="margin-right: 16px">Tên danh mục</label>
          <InputText id="name" v-model="categoryForm.name" placeholder="Nhập tên danh mục" />
        </div>
      </div>
      <template #footer>
        <Button label="Hủy" @click="visibleDialog = false" />
        <Button label="Lưu" @click="saveCategory" />
      </template>
    </Dialog>

    <!-- Confirm delete -->
    <ConfirmDialog />
    <Toast />
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import Button from "primevue/button";
import InputText from "primevue/inputtext";
import Dialog from "primevue/dialog";
import Toast from "primevue/toast";
import ConfirmDialog from "primevue/confirmdialog";
import { useConfirm } from "primevue/useconfirm";
import { useToast } from "primevue/usetoast";
import { FilterMatchMode } from "@primevue/core/api";

// 🧠 Import API
import { getCategory, createCategory, updateCategory, deleteCategory } from "../../Helper/Category.js";

const categories = ref([]);
const categoryForm = ref({ id: null, name: "" });
const visibleDialog = ref(false);
const isEdit = ref(false);

const toast = useToast();
const confirm = useConfirm();

const filters = ref({
  global: { value: null, matchMode: FilterMatchMode.CONTAINS },
});

// 📦 Lấy danh sách ban đầu
const loadCategories = async () => {
  categories.value = await getCategory();
};

onMounted(() => {
  loadCategories();
});

// 🧩 Mở dialog thêm hoặc sửa
const openDialog = (data = null) => {
  if (data) {
    categoryForm.value = { ...data };
    isEdit.value = true;
  } else {
    categoryForm.value = { id: null, name: "" };
    isEdit.value = false;
  }
  visibleDialog.value = true;
};

// 💾 Lưu (Thêm hoặc Sửa)
const saveCategory = async () => {
  try {
    if (!categoryForm.value.name.trim()) {
      toast.add({ severity: "warn", summary: "Cảnh báo", detail: "Tên danh mục không được để trống", life: 2000 });
      return;
    }

    if (isEdit.value) {
      await updateCategory(categoryForm.value.id, categoryForm.value);
      toast.add({ severity: "success", summary: "Thành công", detail: "Cập nhật danh mục thành công", life: 2000 });
    } else {
      await createCategory(categoryForm.value);
      toast.add({ severity: "success", summary: "Thành công", detail: "Thêm danh mục thành công", life: 2000 });
    }

    visibleDialog.value = false;
    await loadCategories();
  } catch (err) {
    toast.add({ severity: "error", summary: "Lỗi", detail: "Có lỗi xảy ra", life: 2000 });
  }
};

// ❌ Xóa có xác nhận
const confirmDelete = (id) => {
  confirm.require({
    message: "Bạn có chắc chắn muốn xóa danh mục này?",
    header: "Xác nhận xóa",
    icon: "pi pi-exclamation-triangle",
    acceptLabel: "Xóa",
    rejectLabel: "Hủy",
    acceptClass: "p-button-danger",
    accept: async () => {
      await deleteCategory(id);
      toast.add({ severity: "success", summary: "Đã xóa", detail: "Xóa danh mục thành công", life: 2000 });
      await loadCategories();
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

.btn-them {
  background-color: #218837;
  color: white;
}

.btn-sua {
  background-color: #E0A801;
  color: white;
  margin-right: 8px;
}

.btn-xoa {
  background-color: #DC3545;
  color: white;
}

.card {
  padding: 1rem;
  margin-top: 20px;
}
</style>
