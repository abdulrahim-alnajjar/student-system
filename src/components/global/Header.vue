<template>
  <header class="app-header mb-3">
    <div class="container d-flex align-items-center">
      <svg class="logo ms-2 svg-light" viewBox="0 0 512 512">
        <path
          d="M455.6,349.2c-45.891-39.09-36.67-77.877-16.095-128.11C475.16,134.04,415.967,34.14,329.93,8.3,237.04-19.6,134.252,24.341,99.677,117.147a180.862,180.862,0,0,0-10.988,73.544c1.733,29.543,14.717,52.97,24.09,80.3,17.2,50.161-28.1,92.743-66.662,117.582-46.806,30.2-36.319,39.857-8.428,41.858,23.378,1.68,44.478-4.548,65.265-15.045,9.2-4.647,40.687-18.931,45.13-28.588C135.9,413.388,111.122,459.5,126.621,488.9c19.1,36.229,67.112-31.77,76.709-45.812,8.591-12.572,42.963-81.279,63.627-46.926,18.865,31.361,8.6,76.391,35.738,104.622,32.854,34.2,51.155-18.312,51.412-44.221.163-16.411-6.1-95.852,29.9-59.944C405.428,418,436.912,467.8,472.568,463.642c38.736-4.516-22.123-67.967-28.262-78.695,5.393,4.279,53.665,34.128,53.818,9.52C498.234,375.678,468.039,359.8,455.6,349.2Z"
        />
      </svg>
      <nav class="pages-links mx-2 d-flex">
        <router-link class="link p-2 fw-semibold text-light" to="/dashboard"
          >لوحة التحكم</router-link
        >
        <router-link class="link p-2 fw-semibold text-light" to="/about"
          >عن التطبيق
        </router-link>
      </nav>

      <!-- profile -->
      <router-link to="/profile" class="ms-4">
        <svg
          class="profile svg-light"
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 512 512"
        >
          <path
            d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z"
          />
        </svg>
      </router-link>
      <!-- logout -->
      <svg @click="logout" class="logout svg-danger" viewBox="0 0 512 512">
        <path
          d="M502.6 278.6c12.5-12.5 12.5-32.8 0-45.3l-128-128c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L402.7 224 192 224c-17.7 0-32 14.3-32 32s14.3 32 32 32l210.7 0-73.4 73.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l128-128zM160 96c17.7 0 32-14.3 32-32s-14.3-32-32-32L96 32C43 32 0 75 0 128L0 384c0 53 43 96 96 96l64 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-64 0c-17.7 0-32-14.3-32-32l0-256c0-17.7 14.3-32 32-32l64 0z"
        />
      </svg>
    </div>
  </header>
</template>

<script>
export default {
  name: "HeaderComp",
};
</script>
<script setup>
import store from "@/store";
import axios from "axios";

// Lougout
async function logout() {
  await axios.get(store.state.backendLink + "?action=logout");
  window.location.assign(store.state.rootPage);
}
</script>

<style lang="scss" scoped>
@import "@/style/main";
.app-header {
  background: var(--bs-primary);
  .logo {
    width: 30px;
  }

  .pages-links {
    flex: 1;
    .link:hover {
      color: var(--bs-primary) !important;
      background: var(--bs-hover);
    }
    .router-link-exact-active {
      color: var(--bs-primary) !important;
      background: #fff !important;
    }
  }

  .profile {
    width: 20px;
    cursor: pointer;
  }

  .logout {
    width: 20px;
    transform: rotate(180deg);
    cursor: pointer;
  }
}
</style>
