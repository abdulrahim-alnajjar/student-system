import { createStore } from "vuex";
export default createStore({
  state: {
    // Backend API Link
    backendLink: "http://localhost/student-system/src/api/api_config.php",
    // Root Link
    rootPage: "http://localhost:8080/",
    // Dashboard Link
    dashboardPage: "http://localhost:8080/dashboard",
    // App Name
    appName: "octupus",
  },
  getters: {},
  mutations: {},
  actions: {},
  modules: {},
});
