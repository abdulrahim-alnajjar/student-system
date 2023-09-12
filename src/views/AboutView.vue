<template>
  <HeaderComp />
  <div class="container">
    <div v-for="item in aboutData" :key="item">
      <h2
        class="text-primary text-capitalize fw-bold"
        v-text="item.p_title + ' ' + store.state.appName + ':-'"
      ></h2>
      <p
        class="fw-bold pe-3 border border-5 border-top-0 border-bottom-0 border-start-0 border-end-4 border-secondary text-secondary"
        v-text="item.body + '.'"
      ></p>
    </div>
  </div>
  <FooterComp />
</template>

<script>
import HeaderComp from "@/components/global/Header.vue";
import FooterComp from "@/components/global/Footer.vue";
export default {
  name: "AboutView",
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

let aboutData = ref([]);

// Get data BeforeMounted
onBeforeMount(async () => {
  // Check login state
  await axios
    .get(store.state.backendLink + "?action=login_state")
    .then((res) => {
      if (res.data.login_state) {
        axios
          .get(store.state.backendLink + "?action=read_about")
          .then((res) => {
            aboutData.value = res.data.read_about;
          });
      } else {
        window.location.assign(store.state.rootPage);
      }
    });
});
</script>

<style scoped lang="scss"></style>
