<template>
  <form @submit.prevent="editStudent()" class="floating-box shadow z-3">
    <h1 class="text-center text-light">
      تعديل بيانات '{{ sdtData.fullname.split(" ")[0] }}'
    </h1>
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
    <input
      class="h-100 p-2 m-1 rounded-2"
      type="date"
      v-model="sdtData.date"
      name="date"
    />

    <!-- Error Message all fields required -->
    <div class="m-2 text-warning" v-if="errMsg">
      <p>يجب إدخال جميع البيانات</p>
    </div>
    <!-- Error Name is short Message -->
    <div class="m-2 text-warning" v-if="nameErr">
      <p>إسم الطالب قصير</p>
    </div>
    <!-- Error repeated value Message -->
    <div class="m-2 text-warning" v-if="repeatedValue">
      <p>"{{ repeatedValue }}" موجود بالفعل</p>
    </div>

    <!-- Buttons -->
    <div>
      <input
        class="btn bg-success text-light rounded-2 m-2 w-25 me-0"
        type="submit"
        value="تعديل"
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
  name: "EditStudent",
};
</script>
<script setup>
import axios from "axios";
import store from "@/store";
import { reactive, defineEmits, defineProps, ref } from "vue";

const emit = defineEmits(["refresh"]);
let errMsg = ref(false);
let repeatedValue = ref("");
let nameErr = ref(false);

// Student Data
let sdtData = reactive({
  fullname: "",
  phone: "",
  email: "",
  state: "",
  date: "",
});

// Props Data
let prop = defineProps(["data"]);
Object.assign(sdtData, reactive(prop.data));

// Add Student
async function editStudent() {
  if (sdtData.fullname.trim().split(" ").length >= 3) {
    nameErr.value = false;
    if (sdtData.phone && sdtData.state && sdtData.date) {
      errMsg.value = false;

      // Prepare Data to Post
      let data = new FormData();
      for (let item in sdtData) data.append(item, sdtData[item]);

      await axios
        .post(store.state.backendLink + "?action=edit_student", data)
        .then((res) => {
          if (res.data.edit_student === true) {
            emit("refresh");
          } else {
            // find repeated value
            for (let i in sdtData)
              if (res.data.edit_student.includes(sdtData[i]))
                repeatedValue.value = sdtData[i];
          }
        })
        .catch((err) => console.log("Error", err));
    } else {
      errMsg.value = true;
    }
  } else {
    nameErr.value = true;
  }
}
</script>

<style scoped lang="scss"></style>
