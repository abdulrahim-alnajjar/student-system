<template>
  <HeaderComp />
  <div class="container">
    <div class="">
      <div class="label-field fw-bold mb-1">الإسم</div>
      <div
        class="data-field fw-semibold mb-3 border px-1 w-75"
        v-text="userData.fullname"
      ></div>

      <div class="label-field fw-bold mb-1">إسم المستخدم</div>
      <div
        class="data-field fw-semibold mb-3 border px-1 w-75"
        v-text="userData.username"
      ></div>

      <div class="label-field fw-bold mb-1">البريد الألكتروني</div>
      <div
        class="data-field fw-semibold mb-3 border px-1 w-75"
        v-text="userData.email"
      ></div>

      <div class="label-field fw-bold mb-1">حالة الحساب</div>
      <div
        class="data-field fw-semibold mb-3 border px-1 w-75"
        v-text="userData.truststate"
      ></div>
    </div>
  </div>
  <FooterComp />
</template>

<script>
import HeaderComp from "@/components/global/Header.vue";
import FooterComp from "@/components/global/Footer.vue";
export default {
  name: "ProfileView",
  components: {
    HeaderComp,
    FooterComp,
  },
};
</script>
<script setup>
import axios from "axios";
import store from "@/store";
import { onBeforeMount, ref } from "vue";

let userData = ref({});

// Get data BeforeMounted
onBeforeMount(async () => {
  // Check login state
  await axios.get(store.state.backendLink + "?action=read_user").then((res) => {
    if (res.data.read_user) {
      // Object.assign(userData, res.data.read_user);
      userData.value = res.data.read_user;
    } else {
      window.location.assign(store.state.rootPage);
    }
  });
});
</script>

<style scoped lang="scss">
.label-field {
  color: var(--bs-primary);
}
.data-field {
  color: var(--bs-gray-700);
}
</style>
