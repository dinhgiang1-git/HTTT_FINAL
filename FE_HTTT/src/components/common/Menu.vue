<script setup>

</script>

<template>
  <div id="menu-content">
    <ul class="list">
      <li><a href="/products/collections/laptop-gaming">Laptop Gaming</a></li>
      <li><a href="/products/collections/laptop-vanphong">Laptop Văn Phòng</a></li>
      <li><a href="/products/collections/laptop-workstation">Laptop Workstation</a></li>
      <li><a href="">Macbook</a></li>
      <li><a href="">Linh kiện máy tính</a></li>
    </ul>
  </div>
</template>

<style scoped>
#menu-content {
  display: block;
  position: absolute;
  top: 100%;
  left: 0;
  width: 206px;
  background-color: #fff;
  border-bottom-left-radius: 4px;
  border-bottom-right-radius: 4px;
  margin-bottom: 15px;
  font-size: 14px;
  .list {
    box-shadow: 0 1px 2px 0 rgba(60, 64, 67, 0.1), 0 2px 6px 2px rgba(60, 64, 67, 0.15);
    li {
      cursor: pointer;
      padding: 10px 15px;
      border-left: 3px solid transparent;
      &:hover {
        background-color: #ececec;
        border-left-color: #f9bb01;
      }
    }
  }
}
</style>