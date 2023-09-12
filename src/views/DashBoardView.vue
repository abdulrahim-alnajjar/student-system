<template>
  <!-- Components -->
  <HeaderComp />
  <AddStudent
    v-if="showAddForm"
    @close="showAddForm = !showAddForm"
    @refresh="refresh()"
    v-click-away="
      () => {
        if (showAddForm) {
          showAddForm = false;
        }
      }
    "
  />
  <DeleteAllBox
    v-if="dltAllSdtBox"
    @close="dltAllSdtBox = !dltAllSdtBox"
    @refresh="refresh()"
    v-click-away="
      () => {
        if (dltAllSdtBox) {
          dltAllSdtBox = false;
        }
      }
    "
  />
  <InfoStudent
    v-if="showInfoBox"
    :data="currSdt"
    @close="showInfoBox = !showInfoBox"
    v-click-away="
      () => {
        if (showInfoBox) {
          showInfoBox = false;
        }
      }
    "
  />
  <EditStudent
    v-if="showEditeBox"
    :data="currSdt"
    @close="showEditeBox = !showEditeBox"
    @refresh="refresh()"
    v-click-away="
      () => {
        if (showEditeBox) {
          showEditeBox = false;
        }
      }
    "
  />
  <DeleteBox
    v-if="showDeleteBox"
    :data="currSdt"
    @close="showDeleteBox = !showDeleteBox"
    @refresh="refresh()"
    v-click-away="
      () => {
        if (showDeleteBox) {
          showDeleteBox = false;
        }
      }
    "
  />

  <div class="container">
    <div class="tools-bar">
      <!-- Buttons -->
      <div class="buttons d-flex justify-content-between">
        <!-- Add Student -->
        <button
          @click="showAddForm = !showAddForm"
          class="btn bg-success text-light my-2 rounded-pill"
        >
          إضافة طالب
        </button>
        <!-- Delete All -->
        <button
          @click="dltAllSdtBox = !dltAllSdtBox"
          class="btn bg-danger text-light my-2 rounded-pill"
          v-if="students.length"
        >
          حذف الكل
        </button>
      </div>

      <!-- Searching -->
      <div class="searching">
        <form
          @submit.prevent
          class="search-form rounded-2 overflow-hidden my-2 border border-1"
        >
          <input
            v-model="searchValue"
            type="search"
            class="srch-input p-2"
            placeholder="بحث"
          />
          <select v-model="searchType" class="select-list h-100 border-0">
            <option value="" disabled>نوع البحث</option>
            <option value="fullname">الإسم</option>
            <option value="id">الرقم</option>
            <option value="phone">تليفون</option>
            <option value="email">البريد</option>
            <option value="date">التاريخ</option>
          </select>
        </form>
      </div>
    </div>

    <hr />

    <!-- Table -->
    <table class="student-table w-100 shadow rounded-2">
      <caption class="text-end m-2">
        قائمة الطلاب ({{
          filteredLis.length
        }})
      </caption>

      <thead class="text-light">
        <tr>
          <th>الإسم</th>
          <th>تليفون</th>
          <th>الحالة</th>
          <th></th>
        </tr>
      </thead>

      <tbody>
        <!-- students -->
        <tr v-for="student in filteredLis" :key="student.id">
          <td v-text="student.fullname"></td>
          <td class="ltr-dir" v-text="student.phone"></td>
          <td v-text="student.state"></td>
          <!-- Buttons -->
          <td>
            <!-- Info Student -->
            <svg
              class="svg-success"
              @click="
                showInfoBox = !showInfoBox;
                select(student);
              "
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 512 512"
            >
              <path
                d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM216 336h24V272H216c-13.3 0-24-10.7-24-24s10.7-24 24-24h48c13.3 0 24 10.7 24 24v88h8c13.3 0 24 10.7 24 24s-10.7 24-24 24H216c-13.3 0-24-10.7-24-24s10.7-24 24-24zm40-208a32 32 0 1 1 0 64 32 32 0 1 1 0-64z"
              />
            </svg>
            <!-- Edit Student -->
            <svg
              class="svg-warning"
              @click="
                showEditeBox = !showEditeBox;
                select(student);
              "
              xmlns="http://www.w3.org/2000/svg"
              width="1em"
              height="1em"
              viewBox="0 0 640 512"
            >
              <path
                d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H322.8c-3.1-8.8-3.7-18.4-1.4-27.8l15-60.1c2.8-11.3 8.6-21.5 16.8-29.7l40.3-40.3c-32.1-31-75.7-50.1-123.9-50.1H178.3zm435.5-68.3c-15.6-15.6-40.9-15.6-56.6 0l-29.4 29.4 71 71 29.4-29.4c15.6-15.6 15.6-40.9 0-56.6l-14.4-14.4zM375.9 417c-4.1 4.1-7 9.2-8.4 14.9l-15 60.1c-1.4 5.5 .2 11.2 4.2 15.2s9.7 5.6 15.2 4.2l60.1-15c5.6-1.4 10.8-4.3 14.9-8.4L576.1 358.7l-71-71L375.9 417z"
              />
            </svg>
            <!-- Delete Student -->
            <svg
              class="svg-danger"
              @click="
                showDeleteBox = !showDeleteBox;
                select(student);
              "
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 512 512"
            >
              <path
                d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM175 175c9.4-9.4 24.6-9.4 33.9 0l47 47 47-47c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9l-47 47 47 47c9.4 9.4 9.4 24.6 0 33.9s-24.6 9.4-33.9 0l-47-47-47 47c-9.4 9.4-24.6 9.4-33.9 0s-9.4-24.6 0-33.9l47-47-47-47c-9.4-9.4-9.4-24.6 0-33.9z"
              />
            </svg>
          </td>
        </tr>
      </tbody>
    </table>

    <hr />
  </div>

  <FooterComp />
</template>

<script>
import HeaderComp from "@/components/global/Header.vue";
import AddStudent from "@/components/dashpoard/AddStudent.vue";
import DeleteAllBox from "@/components/dashpoard/DeleteAllStudents.vue";
import InfoStudent from "@/components/dashpoard/InfoStudent.vue";
import EditStudent from "@/components/dashpoard/EditStudent.vue";
import DeleteBox from "@/components/dashpoard/DeleteStudent.vue";
import FooterComp from "@/components/global/Footer.vue";
import axios from "axios";
export default {
  name: "DashBoard",
  components: {
    HeaderComp,
    AddStudent,
    DeleteAllBox,
    InfoStudent,
    EditStudent,
    DeleteBox,
    FooterComp,
  },
};
</script>
<script setup>
import store from "@/store";
import { computed, onBeforeMount, ref } from "vue";

let students = ref([]);
let currSdt = ref({});
let searchValue = ref("");
let searchType = ref("fullname");
let filteredLis = ref([]);

// Show add Form student
let showAddForm = ref(false);
// show Delete All student box
let dltAllSdtBox = ref(false);
// show Edit student box
let showInfoBox = ref(false);
// show Edit student box
let showEditeBox = ref(false);
// show Delete student box
let showDeleteBox = ref(false);

// Select Function
function select(s) {
  currSdt.value = s;
}

// Refresh page
function refresh() {
  window.location = store.state.dashboardPage;
}

// Searching
filteredLis = computed(() => {
  return students.value.filter((s) =>
    String(s[searchType.value]).includes(searchValue.value)
  );
});

// Get data BeforeMounted
onBeforeMount(async () => {
  // Check login state
  await axios
    .get(store.state.backendLink + "?action=login_state")
    .then((res) => {
      if (res.data.login_state) {
        // // Return data if login true
        axios
          .get(store.state.backendLink + "?action=read_students")
          .then((res) => {
            if (res.data.read_students) {
              students.value = res.data.read_students;
            } else {
              console.error("Error In Database");
            }
          });
      } else {
        window.location.assign(store.state.rootPage);
      }
    });
});
</script>

<style scoped lang="scss">
@import "@/style/main";
.tools-bar {
  // Buttons
  .buttons {
    .btn {
      width: fit-content;
      // box-shadow: 0px 0px 10px -5px #000;
    }
  }

  // Searching
  .searching {
    // Search Form
    .search-form {
      width: fit-content;
      height: 35px;
      border-color: var(--bs-hover) !important;
      .srch-input {
        background: var(--bs-hover);
      }
      .select-list {
        outline: none;
        cursor: pointer;
      }
    }
  }
}

.student-table {
  border-spacing: 0;
  thead {
    background: var(--bs-primary);
    th {
      max-width: 40px;
      padding: 0.5rem 0.25rem;
      text-align: start;
      font-size: 1rem;
      font-weight: 500;

      // Border Radius
      &:first-child {
        border-top-right-radius: 0.5rem;
      }
      &:last-child {
        border-top-left-radius: 0.5rem;
      }
    }
  }
  tbody {
    tr {
      // Border radius
      &:last-child {
        td:first-child {
          border-bottom-right-radius: 0.5rem;
        }
        td:last-child {
          border-bottom-left-radius: 0.5rem;
        }
      }
      &:hover {
        background: #d6d6d6 !important;
      }

      // cells
      td {
        max-width: 40px;
        padding: 0.5rem;
        margin: 1rem;
        word-wrap: break-word;

        svg {
          width: 22px;
          height: 22px;
          margin: 0.25rem;
          cursor: pointer;
        }
      }
    }
    tr:nth-child(even) {
      background: var(--bs-hover);
    }
  }
}
</style>
