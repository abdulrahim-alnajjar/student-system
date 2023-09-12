import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store"; // Vuex
import bootstrap from "../node_modules/bootstrap/scss/bootstrap.scss";
import normalize from "normalize.css";
import style from "@/style/main.scss";
import VueClickAway from "vue3-click-away";

createApp(App)
  .use(store)
  .use(router)
  .use(bootstrap)
  .use(normalize)
  .use(style)
  .use(VueClickAway)
  .mount("#app");
