<template>
  <div class="floating-box shadow z-3">
    <h1 class="text-center text-light">
      بيانات '{{ student.fullname.split(" ")[0] }}'
    </h1>
    <ul class="p-0">
      <label class="d-block my-1 mx-2 fw-bold text-warning mb-0">الإسم:</label>
      <li class="m-2 text-light mt-0" v-text="student.fullname"></li>
      <label class="d-block my-1 mx-2 fw-bold text-warning mb-0"
        >الرقم التسلسلي:</label
      >
      <li class="m-2 text-light mt-0" v-text="student.id"></li>
      <label class="d-block my-1 mx-2 fw-bold text-warning mb-0">تليفون:</label>
      <li class="m-2 text-light mt-0 ltr-dir" v-text="student.phone"></li>
      <label class="d-block my-1 mx-2 fw-bold text-warning mb-0"
        >البريد الإلكتروني:</label
      >
      <li class="m-2 text-light mt-0" v-text="student.email"></li>
      <label class="d-block my-1 mx-2 fw-bold text-warning mb-0">الحالة:</label>
      <li class="m-2 text-light mt-0" v-text="student.state"></li>
      <label class="d-block my-1 mx-2 fw-bold text-warning mb-0"
        >التاريخ:</label
      >
      <li class="m-2 text-light mt-0" v-text="student.date"></li>
    </ul>
    <button
      class="btn bg-success text-light rounded-2 w-100"
      @click="$emit('close')"
    >
      تراجع
    </button>
  </div>
</template>

<script>
export default {
  name: "DeleteBox",
};
</script>
<script setup>
import { defineProps, reactive } from "vue";

let prop = defineProps(["data"]);
let student = reactive(prop.data);
</script>

<style scoped lang="scss">
@import "@/style/main.scss";
.info-box {
  h1 {
    text-align: center;
    color: #fff;
    margin: 1rem;
  }

  ul {
    list-style: none;
    label {
      display: block;
      margin: 0.25rem 0.5rem;
      font-weight: 700;
      color: rgb(255, 255, 0);
    }
    .item {
      margin: 0.25rem 0.5rem 1rem;
      color: #fff;
    }
  }

  .btn {
    padding: 0.5rem;
    margin: 0.5rem;
    border-radius: 0.25rem;
  }
}
</style>
