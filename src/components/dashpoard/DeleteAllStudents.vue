<template>
  <div class="floating-box shadow z-3">
    <h1 class="text-center text-light">حذف كل الطلاب</h1>
    <form class="d-flex flex-column">
      <input
        class="h-100 p-2 m-1 rounded-2"
        v-model="formData.username"
        name="username"
        type="text"
        placeholder="إسم المستخدم"
      />
      <input
        class="h-100 p-2 m-1 rounded-2"
        v-model="formData.password"
        name="password"
        type="password"
        placeholder="كلمة السر"
      />
    </form>
    <!-- Error Name Message -->
    <div class="m-2 text-warning" v-if="errMsg">
      <p>أدخل بيانات صحيحة لمسح البيانات</p>
    </div>
    <!-- Buttons -->
    <div class="d-flex">
      <button
        class="btn bg-success text-light rounded-2 m-2 me-0 w-75"
        @click="$emit('close')"
      >
        تراجع
      </button>
      <button
        class="btn bg-danger text-light rounded-2 m-2 me-0 w-25"
        @click="deleteStudent()"
      >
        حذف
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: "DeleteBox",
};
</script>
<script setup>
import store from "@/store";
import axios from "axios";
import { reactive, ref, defineEmits } from "vue";

const emit = defineEmits(["refresh"]);
let errMsg = ref(false);
let formData = reactive({
  username: "",
  password: "",
});

// Add Student
async function deleteStudent() {
  let data = new FormData();
  for (let item in formData) data.append(item, formData[item]);

  axios.post(store.state.backendLink + "?action=login", data).then((res) => {
    if (res.data.login) {
      errMsg.value = false;
      axios.get(store.state.backendLink + "?action=deleteAll");
      emit("refresh");
    } else {
      errMsg.value = true;
      formData.username = "";
      formData.password = "";
    }
  });
}
</script>

<style scoped lang="scss"></style>
