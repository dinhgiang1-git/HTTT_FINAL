<template>
  <div class="main-page" style="max-width: 1400px; width: 100%">
    <div class="page-header">
      <h2 class="title">Quản lí sản phẩm</h2>
      <p class="subtitle">Stay updated with your most recent actions.</p>
    </div>

    <div id="page-action">
      <button class="btn-them" style="background-color: #218837; color: white" @click="openAddDialog">
        Thêm mới
      </button>
      <IconField>
        <InputIcon>
          <i class="pi pi-search"/>
        </InputIcon>
        <InputText style="margin-bottom: 12px; margin-top: 12px" v-model="filters['global'].value" placeholder="Tìm kiếm sản phẩm..."/>
      </IconField>
    </div>

    <div id="container" style="width: 100%">
      <div class="card" style="width: 100%">
        <DataTable
            v-model:filters="filters"
            :value="products"
            paginator
            :rows="10"
            :rowsPerPageOptions="[10, 20, 30, 50]"
            dataKey="id"
            filterDisplay="row"
            :globalFilterFields="['name', 'category', 'price']"
            tableStyle="min-width: 60rem"
        >
          <template #header>
            <div class="flex flex-wrap items-center justify-between gap-2">
              <strong class="text-xl font-bold">Danh sách sản phẩm</strong>
            </div>
          </template>

          <Column field="name" header="Name" style="width: 20%"/>
          <Column header="Image" style="width: 15%">
            <template #body="slotProps">
              <img
                  :src="slotProps.data.image"
                  alt="product"
                  class="rounded"
                  style="width: 84px; height: 56px; object-fit: cover"
              />
            </template>
          </Column>
          <Column field="categories_name" header="Category" style="width: 20%"/>
          <Column field="quantity" header="Quantity" style="width: 10%"/>
          <Column header="Action" style="width: 15%">
            <template #body="slotProps">
              <button
                  class="btn-xemchitiet"
                  style="margin-right: 12px; background-color: #007BFF; color: white"
                  @click="openDetailDialog(slotProps.data)"
              >
                Xem chi tiết
              </button>
              <button
                  class="btn-xoa"
                  style="background-color: #dc3545; color: white"
                  @click="confirmDeleteProduct(slotProps.data.id)"
              >
                Xóa
              </button>
            </template>
          </Column>
          <template #footer>
            Tổng cộng có {{ products ? products.length : 0 }} sản phẩm.
          </template>
        </DataTable>
      </div>
    </div>
  </div>

  <!-- Dialog thêm sản phẩm -->
  <Dialog v-model:visible="visibleAddDialog" header="Thêm sản phẩm mới" modal style="width: 600px">
    <div class="flex flex-col gap-3">
      <InputText style="margin-right: 12px; margin-bottom: 12px" v-model="newProduct.name" placeholder="Tên sản phẩm"/>
      <InputText v-model="newProduct.image" placeholder="Link ảnh"/>

      <!-- TextArea mô tả -->
      <Textarea v-model="newProduct.description" rows="3" placeholder="Mô tả sản phẩm..."/>

      <!-- Dropdown chọn Category -->
      <Dropdown
          v-model="newProduct.category_id"
          :options="categoryOptions"
          optionLabel="name"
          optionValue="id"
          placeholder="Chọn danh mục"
          class="w-full"
          style="margin-left: 12px"
      />

      <!-- Dropdown chọn Brand -->
      <Dropdown
          v-model="newProduct.brand_id"
          :options="brandOptions"
          optionLabel="name"
          optionValue="id"
          placeholder="Chọn thương hiệu"
          class="w-full"
          style="margin-bottom: 12px"
      />

      <div class="text-right">
        <Button label="Thêm" icon="pi pi-check" @click="handleAddProduct"/>
      </div>
    </div>
  </Dialog>

  <!-- Dialog chi tiết -->
  <Dialog v-model:visible="visibleDetailDialog" header="Chi tiết sản phẩm" modal style="width: 900px">
    <div v-if="selectedProduct">
      <div class="flex gap-3 mb-3">
        <img :src="selectedProduct.image" alt="product" width="120" height="80" style="object-fit: cover"/>
        <div>
          <h3>{{ selectedProduct.name }}</h3>
          <p>{{ selectedProduct.description }}</p>
        </div>
      </div>

      <h4>Danh sách biến thể</h4>
      <DataTable :value="productVariants">
        <Column field="variant_id" header="ID" style="width:5%"/>
        <Column field="ram" header="RAM"/>
        <Column field="storage" header="Storage"/>
        <Column field="cpu" header="CPU"/>
        <Column field="vga" header="VGA"/>
        <Column field="monitor" header="Màn hình"/>
        <Column field="color" header="Màu sắc"/>
        <Column field="price" header="Giá"/>
        <Column field="oldprice" header="Giá cũ"/>
        <Column field="quantity" header="SL"/>
        <Column header="Hành động">
          <template #body="{ data }">
            <button
                class="btn-xemchitiet"
                style="margin-right: 12px; background-color: #007BFF; color: white"
                @click="editVariant(data)">
              Sửa
            </button>
            <Button text severity="danger" @click="handleDeleteVariant(data.variant_id)"/>
            <button
                class="btn-xoa"
                style="margin-right: 12px; background-color: #007BFF; color: white"
                @click="deleteVariant(data.variant_id)">
              Xóa
            </button>
          </template>
        </Column>
      </DataTable>

      <div class="text-right mt-3">
        <Button label="Thêm biến thể" icon="pi pi-plus" @click="addNewVariant"/>
      </div>
    </div>
  </Dialog>

  <!-- Dialog thêm biến thể -->
  <Dialog
      v-model:visible="visibleVariantDialog"
      :header="isEditingVariant ? 'Sửa biến thể' : 'Thêm biến thể mới'"
      modal
      style="width: 600px">
    <div class="flex flex-col gap-3">
      <InputText v-model="newVariant.ram" placeholder="RAM" />
      <InputText v-model="newVariant.storage" placeholder="Storage" />
      <InputText v-model="newVariant.cpu" placeholder="CPU" />
      <InputText v-model="newVariant.vga" placeholder="VGA" />
      <InputText v-model="newVariant.monitor" placeholder="Màn hình" />
      <InputText v-model="newVariant.color" placeholder="Màu sắc" />
      <InputNumber v-model="newVariant.price" placeholder="Giá mới" />
      <InputNumber v-model="newVariant.oldprice" placeholder="Giá cũ" />
      <InputNumber v-model="newVariant.quantity" placeholder="Số lượng" />

      <div class="text-right">
        <Button
            :label="isEditingVariant ? 'Cập nhật' : 'Thêm'"
            icon="pi pi-check"
            @click="isEditingVariant ? handleUpdateVariant() : handleAddVariant()"
        />
      </div>
    </div>
  </Dialog>

  <ConfirmDialog/>
</template>

<script setup>
import {ref, onMounted} from "vue";
import DataTable from "primevue/datatable";
import Column from "primevue/column";
import InputText from "primevue/inputtext";
import InputNumber from "primevue/inputnumber";
import IconField from "primevue/iconfield";
import InputIcon from "primevue/inputicon";
import {FilterMatchMode} from "@primevue/core/api";
import MultiSelect from "primevue/multiselect";
import Dropdown from "primevue/dropdown";
import Button from "primevue/button";
import Dialog from "primevue/dialog";
import Textarea from "primevue/textarea"; // 👈 import thêm
import {useToast} from 'primevue/usetoast'
import {useConfirm} from 'primevue/useconfirm'
import ConfirmDialog from 'primevue/confirmdialog';

import {
  createProduct,
  getProducts,
  getProductById,
  deleteVariant,
  createVariant,
  deleteProduct,
  updateVariant
} from "../../Helper/Product.js";
import {getCategory} from "../../Helper/Category.js";
import {getBrands} from "../../Helper/Brands.js";

const visibleVariantDialog = ref(false);
const newVariant = ref({
  product_id: null,
  ram: "",
  storage: "",
  cpu: "",
  vga: "",
  monitor: "",
  color: "",
  price: null,
  oldprice: null,
  quantity: 0,
});

const handleDeleteVariant = async (variantId) => {
  confirm.require({
    message: "Bạn có chắc chắn muốn xóa biến thể này?",
    header: "Xác nhận xóa",
    acceptLabel: "Xóa",
    rejectLabel: "Hủy",
    acceptClass: "p-button-danger",
    accept: async () => {
      try {
        await deleteVariant(variantId); // ⚠️ gọi API xóa biến thể
        toast.add({
          severity: "success",
          summary: "Đã xóa",
          detail: "Biến thể đã được xóa thành công",
          life: 2000,
        });
        // load lại danh sách biến thể của sản phẩm đang xem
        productVariants.value = await getProductById(selectedProduct.value.id);
      } catch (error) {
        toast.add({
          severity: "error",
          summary: "Lỗi",
          detail: "Không thể xóa biến thể",
          life: 2000,
        });
      }
    },
  });
};

const isEditingVariant = ref(false);

const editVariant = (variant) => {
  isEditingVariant.value = true; // 👉 chế độ sửa
  newVariant.value = {...variant}; // nạp dữ liệu biến thể vào form
  visibleVariantDialog.value = true; // mở dialog
};

// Mở dialog thêm biến thể
const addNewVariant = () => {
  isEditingVariant.value = false; // 👉 chế độ thêm mới
  newVariant.value = {
    product_id: selectedProduct.value.id, // lấy id của sản phẩm đang xem
    ram: "",
    storage: "",
    cpu: "",
    vga: "",
    monitor: "",
    color: "",
    price: null,
    oldprice: null,
    quantity: 0,
  };
  visibleVariantDialog.value = true;
};

// Thêm biến thể mới
const handleAddVariant = async () => {
  try {
    newVariant.value.product_id = selectedProduct.value.id;
    await createVariant(newVariant.value);

    toast.add({
      severity: "success",
      summary: "Thành công",
      detail: "Đã thêm biến thể mới!",
      life: 3000,
    });

    visibleVariantDialog.value = false;
    productVariants.value = await getProductById(selectedProduct.value.id); // load lại list
  } catch (error) {
    console.error(error);
    toast.add({
      severity: "error",
      summary: "Lỗi",
      detail: "Không thể thêm biến thể",
      life: 3000,
    });
  }
};

const confirm = useConfirm();
const confirmDeleteProduct = (id) => {
  console.log(id)
  confirm.require({
    message: 'Bạn có chắc chắn muốn xóa sản phẩm này?',
    header: 'Xác nhận xóa',
    acceptLabel: 'Xóa',
    rejectLabel: 'Hủy',
    acceptClass: 'p-button-danger',
    accept: async () => {
      try {
        await deleteProduct(id); // 👈 hoặc đổi sang deleteProduct nếu bạn có API riêng
        toast.add({
          severity: 'success',
          summary: 'Đã xóa',
          detail: 'Sản phẩm đã được xóa thành công',
          life: 2000,
        });
        products.value = await getProducts(); // cập nhật lại danh sách
      } catch (error) {
        toast.add({
          severity: 'error',
          summary: 'Lỗi',
          detail: 'Không thể xóa sản phẩm',
          life: 2000,
        });
      }
    },
  });
};

const visibleAddDialog = ref(false);
const visibleDetailDialog = ref(false);
const selectedProduct = ref(null);
const productVariants = ref([]);
const products = ref([]);
const categoryOptions = ref([]);
const brandOptions = ref([]);

const newProduct = ref({
  name: "",
  image: "",
  description: "",
  price: null,
  oldprice: null,
  quantity: 0,
  category_id: null,
  brand_id: null,
});

const toast = useToast(); // 👈 khởi tạo toast

// 🔧 Reset form sau khi thêm
const resetNewProduct = () => {
  newProduct.value = {
    name: "",
    image: "",
    description: "",
    price: null,
    oldprice: null,
    quantity: 0,
    category_id: null,
    brand_id: null,
  };
};

const filters = ref({
  global: {value: null, matchMode: FilterMatchMode.CONTAINS},
});

const openAddDialog = () => (visibleAddDialog.value = true);
const openDetailDialog = async (product) => {
  selectedProduct.value = product;
  visibleDetailDialog.value = true;
  console.log(product.id);
  productVariants.value = await getProductById(product.id);
};

const handleAddProduct = async () => {
  try {
    await createProduct(newProduct.value);
    toast.add({
      severity: 'success',
      summary: 'Thành công',
      detail: 'Thêm sản phẩm thành công!',
      life: 3000,
    });
    visibleAddDialog.value = false;
    resetNewProduct(); // 👈 xóa trắng form
    products.value = await getProducts(); // tải lại danh sách
  } catch (error) {
    toast.add({
      severity: 'error',
      summary: 'Lỗi',
      detail: 'Không thể thêm sản phẩm. Vui lòng thử lại.',
      life: 3000,
    });
  }
};

const handleUpdateVariant = async () => {
  try {
    // Chỉ lấy các trường cần update
    const updatedData = {
      ram: newVariant.value.ram,
      storage: newVariant.value.storage,
      cpu: newVariant.value.cpu,
      color: newVariant.value.color,
      monitor: newVariant.value.monitor,
      price: newVariant.value.price,
      oldprice: newVariant.value.oldprice,
      vga: newVariant.value.vga,
    };

    await updateVariant(newVariant.value.variant_id, updatedData);

    toast.add({
      severity: "success",
      summary: "Thành công",
      detail: "Đã cập nhật biến thể!",
      life: 3000,
    });

    visibleVariantDialog.value = false;
    productVariants.value = await getProductById(selectedProduct.value.id);
  } catch (error) {
    toast.add({
      severity: "error",
      summary: "Lỗi",
      detail: "Không thể cập nhật biến thể",
      life: 3000,
    });
  }
};


onMounted(async () => {
  products.value = await getProducts();
  categoryOptions.value = await getCategory(); // lấy từ API category
  brandOptions.value = await getBrands(); // lấy từ API brand
});
</script>
