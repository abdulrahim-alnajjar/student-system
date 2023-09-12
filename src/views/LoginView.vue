<template>
  <div class="container text-center">
    <form
      @submit.prevent="logging"
      class="login-form list-group my-4 mx-auto w-75"
    >
      <!-- Title -->
      <div
        class="title-group mb-3 d-flex justify-content-center align-items-center"
      >
        <h1 class="form-title text-capitalize m-0 p-0 fw-bold">
          {{ store.state.appName }}
        </h1>
        <svg class="m-0 p-0" viewBox="0 0 512 512">
          <path
            d="M455.6,349.2c-45.891-39.09-36.67-77.877-16.095-128.11C475.16,134.04,415.967,34.14,329.93,8.3,237.04-19.6,134.252,24.341,99.677,117.147a180.862,180.862,0,0,0-10.988,73.544c1.733,29.543,14.717,52.97,24.09,80.3,17.2,50.161-28.1,92.743-66.662,117.582-46.806,30.2-36.319,39.857-8.428,41.858,23.378,1.68,44.478-4.548,65.265-15.045,9.2-4.647,40.687-18.931,45.13-28.588C135.9,413.388,111.122,459.5,126.621,488.9c19.1,36.229,67.112-31.77,76.709-45.812,8.591-12.572,42.963-81.279,63.627-46.926,18.865,31.361,8.6,76.391,35.738,104.622,32.854,34.2,51.155-18.312,51.412-44.221.163-16.411-6.1-95.852,29.9-59.944C405.428,418,436.912,467.8,472.568,463.642c38.736-4.516-22.123-67.967-28.262-78.695,5.393,4.279,53.665,34.128,53.818,9.52C498.234,375.678,468.039,359.8,455.6,349.2Z"
          />
        </svg>
      </div>
      <p class="form-description mb-2 fs-6">نظام إدارة الطلاب</p>
      <!-- Check the app -->
      <p class="form-description mb-2 fs-6 text-info">
        لإختبار النظام استخدم البيانات التالية
      </p>
      <p class="form-description mb-2 fs-6 text-info">إسم المستخدم: alnajjar</p>
      <p class="form-description mb-2 fs-6 text-info">كلمة السر: 12</p>

      <div class="input-group my-2 mx-auto rounded-pill overflow-hidden">
        <input
          type="text"
          name="username"
          v-model="formData.username"
          placeholder="اسم المستخدم"
        />
      </div>

      <div class="input-group my-2 mx-auto rounded-pill overflow-hidden">
        <input
          type="password"
          v-model="formData.password"
          placeholder="كلمة السر"
        />
      </div>

      <!-- Error msg -->
      <div v-if="errMsg" class="alert-danger text-danger text-end fw-semibold">
        <span>خطأ في البيانات المدخلة</span>
      </div>

      <!-- Submit -->
      <input
        class="submit btn fw-bold text-light mt-3 w-100 rounded-pill"
        type="submit"
        value="دخول"
      />
    </form>
  </div>
  <FooterComp class="position-fixed bottom-0 left-0" />
</template>

<script>
import FooterComp from "@/components/global/Footer.vue";
export default {
  name: "LoginView",
  components: {
    FooterComp,
  },
};
</script>
<script setup>
import store from "@/store";
import axios from "axios";
import { onBeforeMount, reactive, ref } from "vue";

let errMsg = ref(false);

let formData = reactive({
  username: "",
  password: "",
});

// Login To App
function logging() {
  let data = new FormData();
  for (let item in formData) data.append(item, formData[item]);

  axios
    .post(store.state.backendLink + "?action=login", data)
    .then((res) => {
      if (res.data.login == true) {
        // Remove Error Msg in exists
        errMsg.value = false;

        // Go to dashboard page
        window.location = store.state.dashboardPage;
      } else {
        // Show error and empty fields
        errMsg.value = true;
        formData.username = "";
        formData.password = "";
      }
    })
    .catch((err) => {
      // Reload page
      console.error(err);
    });
}

// logout when return to login page
onBeforeMount(async () => {
  await axios
    .get(store.state.backendLink + "?action=logout")
    .then((res) => console.log(res.data));
});
</script>

<style scoped lang="scss">
@import "@/style/main";
.login-form {
  .title-group {
    svg {
      width: 50px;
      height: 50px;
      fill: var(--bs-primary);
    }
    .form-title {
      width: fit-content;
      color: var(--bs-primary);
    }
  }
  .form-description {
    color: gray;
  }

  // Input Group
  .input-group {
    border: 1px solid var(--bs-hover);
    input {
      flex: 1;
      padding: 0.5rem 0.75rem;
      &:focus {
        background: var(--bs-hover);
      }
    }
  }

  // Submit Button
  .submit {
    background: var(--bs-primary);
    &:hover {
      background: var(--bs-green);
    }
  }
}
</style>
