<script setup>
import Header from "@/components/common/Header.vue";
import Footer from "@/components/common/Footer.vue";
import {onMounted, ref} from "vue";
import {fetchUser} from "@/helpers/user.js";

const userData = ref({});
onMounted(async () => {
  userData.value = await fetchUser();
});

</script>

<template>

  <Header :userData="userData"></Header>
  <router-view></router-view>
  <Footer></Footer>

</template>

<style scoped>

</style>