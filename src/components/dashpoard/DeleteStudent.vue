<template>
  <div class="floating-box shadow z-3">
    <h1 class="text-center text-light">
      حذف بيانات '{{ student.fullname.split(" ")[0] }}'
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

    <!-- Can't delete msg -->
    <div class="m-2 text-warning" v-if="cannotDltMsg">
      <p>لم يتم مسح الطالب</p>
    </div>

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
import { defineProps, defineEmits, reactive, ref } from "vue";

const emit = defineEmits(["refresh"]);

let prop = defineProps(["data"]);
let student = reactive(prop.data);

let cannotDltMsg = ref(false);

// Add Student
async function deleteStudent() {
  let data = new FormData();
  for (let item in student) data.append(item, student[item]);

  await axios
    .post(store.state.backendLink + "?action=delete_sdt", data)
    .then((res) => {
      if (res.data.delete_sdt === true) {
        cannotDltMsg.value = false;
        emit("refresh");
      } else {
        cannotDltMsg.value = true;
      }
    });
}
</script>

<style scoped lang="scss"></style>
