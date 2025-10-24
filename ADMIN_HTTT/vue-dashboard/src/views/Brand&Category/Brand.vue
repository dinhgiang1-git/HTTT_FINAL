<template>
  <div class="main-page">
    <div class="page-header">
      <h2 class="title">Quản lí thương hiệu</h2>
      <p class="subtitle">Stay updated with your most recent actions.</p>
    </div>

    <div id="page-action">
      <button class="btn-them" style="background-color: #218837; color: white" @click="openAddDialog">
        Thêm mới
      </button>

      <InputText
          v-model="filters.global.value"
          placeholder="Tìm kiếm ..."
      />
    </div>

    <div id="container">
      <div class="card">
        <DataTable
            :value="brands"
            paginator
            :rows="10"
            :rowsPerPageOptions="[10, 20, 30, 50]"
            class="custom-table"
            tableStyle="min-width: 50rem"
            v-model:filters="filters"
        >
          <Column field="id" header="ID" style="width: 20%"></Column>
          <Column field="name" header="Tên thương hiệu" style="width: 50%"></Column>
          <Column header="Thao tác" style="width: 30%">
            <template #body="{ data }">
              <button
                  class="btn-sua"
                  style="margin-right: 12px; background-color: #E0A801; color: white"
                  @click="openEditDialog(data)"
              >
                Sửa
              </button>
              <button
                  class="btn-xoa"
                  style="background-color: #DC3545; color: white"
                  @click="confirmDelete(data.id)"
              >
                Xóa
              </button>
            </template>
          </Column>
        </DataTable>
      </div>
    </div>

    <!-- 🪟 Dialog thêm/sửa thương hiệu -->
    <Dialog
        v-model:visible="visible"
        style="margin-top: 24px"
        modal
        :header="isEdit ? 'Sửa thương hiệu' : 'Thêm thương hiệu mới'"
        :style="{ width: '25rem' }"

    >
      <div class="flex flex-col gap-4">
        <div class="flex items-center gap-4">
          <label for="brandName" class="font-semibold w-32" style="margin-right: 32px">Tên thương hiệu</label>
          <InputText id="brandName" v-model="brandName" class="flex-auto" autocomplete="off" />
        </div>
        <div class="flex justify-end gap-2 mt-4">
          <Button style="margin-right: 24px" label="Hủy" severity="secondary" @click="visible = false" />
          <Button :label="isEdit ? 'Cập nhật' : 'Lưu'" @click="saveBrand" />
        </div>
      </div>
    </Dialog>

    <!-- ✅ Toast thông báo -->
    <Toast />

    <!-- ⚠️ ConfirmDialog -->
    <ConfirmDialog />
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { getBrands, createBrand, deleteBrand, updateBrand } from "../../Helper/Brands.js";
import DataTable from "primevue/datatable";
import Column from "primevue/column";
import InputText from "primevue/inputtext";
import Dialog from "primevue/dialog";
import Button from "primevue/button";
import Toast from "primevue/toast";
import ConfirmDialog from "primevue/confirmdialog";
import { useToast } from "primevue/usetoast";
import { useConfirm } from "primevue/useconfirm";
import { FilterMatchMode } from "@primevue/core/api";

const brands = ref([]);
const visible = ref(false);
const brandName = ref("");
const editingId = ref(null);
const isEdit = ref(false);

const toast = useToast();
const confirm = useConfirm();

const filters = ref({
  global: { value: null, matchMode: FilterMatchMode.CONTAINS },
});

onMounted(async () => {
  await loadBrands();
});

const loadBrands = async () => {
  brands.value = await getBrands();
};

// 🟢 Thêm mới
const openAddDialog = () => {
  isEdit.value = false;
  brandName.value = "";
  visible.value = true;
};

// 🟡 Sửa thương hiệu
const openEditDialog = (brand) => {
  isEdit.value = true;
  brandName.value = brand.name;
  editingId.value = brand.id;
  visible.value = true;
};

// 💾 Lưu hoặc cập nhật
const saveBrand = async () => {
  if (!brandName.value.trim()) {
    toast.add({
      severity: "warn",
      summary: "Thiếu thông tin",
      detail: "Vui lòng nhập tên thương hiệu!",
      life: 2500,
    });
    return;
  }

  try {
    if (isEdit.value) {
      await updateBrand(editingId.value, { name: brandName.value });
      toast.add({
        severity: "success",
        summary: "Thành công",
        detail: "Đã cập nhật thương hiệu!",
        life: 2000,
      });
    } else {
      await createBrand({ name: brandName.value });
      toast.add({
        severity: "success",
        summary: "Thành công",
        detail: "Đã thêm thương hiệu mới!",
        life: 2000,
      });
    }

    visible.value = false;
    await loadBrands();
  } catch (error) {
    toast.add({
      severity: "error",
      summary: "Lỗi",
      detail: "Không thể lưu thương hiệu!",
      life: 2500,
    });
  }
};

// 🔴 Xác nhận xóa
const confirmDelete = (id) => {
  confirm.require({
    message: "Bạn có chắc chắn muốn xóa thương hiệu này?",
    header: "Xác nhận xóa",
    icon: "pi pi-exclamation-triangle",
    rejectLabel: "Hủy",
    acceptLabel: "Xóa",
    acceptClass: "p-button-danger",
    accept: async () => {
      try {
        await deleteBrand(id);
        toast.add({
          severity: "success",
          summary: "Đã xóa",
          detail: "Thương hiệu đã được xóa!",
          life: 2000,
        });
        await loadBrands();
      } catch (error) {
        toast.add({
          severity: "error",
          summary: "Lỗi",
          detail: "Không thể xóa thương hiệu!",
          life: 2500,
        });
      }
    },
  });
};
</script>

<style scoped>
#container {
  margin-top: 30px;
  .card {
    padding: 1rem;
  }
}

::v-deep(.p-button.p-component.btn-sua) {
  margin: unset;
}

#page-action {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}

.btn-sua,
.btn-xoa,
.btn-them {
  padding: 6px 12px;
  border: none;
  color: #0f172a;
  border-radius: 4px;
  transition: all ease 0.3s;

  &:hover {
    filter: brightness(1.1);
  }
}
</style>
