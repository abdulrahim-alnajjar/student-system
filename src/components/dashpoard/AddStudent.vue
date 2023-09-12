<template>
  <form @submit.prevent="addStudent()" class="floating-box shadow z-3">
    <h1 class="text-center text-light">إضافة طالب</h1>
    <input
      class="h-100 p-2 m-1 rounded-2"
      name="fullname"
      type="text"
      placeholder="إسم الطالب"
      v-model="sdtData.fullname"
    />
    <input
      class="ltr-dir h-100 p-2 m-1 rounded-2"
      name="phone"
      type="text"
      placeholder="تليفون"
      v-model="sdtData.phone"
    />
    <input
      class="ltr-dir h-100 p-2 m-1 rounded-2"
      type="text"
      placeholder="البريد الابكتروني"
      v-model="sdtData.email"
      name="email"
    />
    <select
      class="h-100 p-2 m-1 rounded-2"
      name="state"
      id="state"
      v-model="sdtData.state"
    >
      <option value disabled>حالة الطالب</option>
      <option value="قيد المراجعة">قيد المراجعة</option>
      <option value="تم القبول">تم القبول</option>
      <option value="غير معروف">غير معروف</option>
    </select>
    <!-- <input
      class="h-100 p-2 m-1 rounded-2"
      type="date"
      v-model="sdtData.date"
      name="date"
    /> -->

    <!-- Error Message -->
    <div class="m-2 text-warning" v-if="errMsg">
      <p>يجب إدخال جميع البيانات</p>
    </div>
    <!-- Error Repeated Message -->
    <div class="m-2 text-warning" v-if="reErrMsg">
      <p>{{ repeatedValue }} موجود بالفعل</p>
    </div>
    <!-- Error Name Message -->
    <div class="m-2 text-warning" v-if="nameErr">
      <p>إسم الطالب قصير</p>
    </div>

    <div>
      <input
        class="btn bg-success text-light rounded-2 m-2 w-25 me-0"
        type="submit"
        value="تم"
      />
      <button
        class="btn bg-danger text-light rounded-2 m-2 w-25 me-0"
        @click="$emit('close')"
      >
        إلغاء
      </button>
    </div>
  </form>
</template>

<script>
export default {
  name: "AddStudent",
};
</script>
<script setup>
import axios from "axios";
import store from "@/store";
import { reactive, defineEmits, ref } from "vue";

const emit = defineEmits(["refresh"]);
let errMsg = ref(false);
let reErrMsg = ref(false);
let repeatedValue = ref("");
let nameErr = ref(false);

// Student Data
let sdtData = reactive({
  fullname: "",
  phone: "",
  email: "",
  state: "",
  // date: "",
});

// Add Student
async function addStudent() {
  if (sdtData.fullname.trim().split(" ").length >= 3) {
    nameErr.value = false;
    if (sdtData.phone && sdtData.state /**&& sdtData.date*/) {
      errMsg.value = false;

      // Prepare Data to Post
      let data = new FormData();
      for (let item in sdtData) data.append(item, sdtData[item]);

      await axios
        .post(store.state.backendLink + "?action=add_student", data)
        .then((res) => {
          if (res.data.add_student === true) {
            emit("refresh");
          } else {
            // Show error msg
            reErrMsg.value = true;
            // find repeated value
            for (let i in sdtData) {
              if (res.data.includes(sdtData[i])) {
                repeatedValue.value = sdtData[i];
              }
            }
          }
        })
        .catch((err) => console.log("Error", err));
    } else {
      errMsg.value = true;
      reErrMsg.value = false;
    }
  } else {
    nameErr.value = true;
  }
}
</script>

<style scoped lang="scss"></style>
