// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import cors from 'cors'
Vue.config.productionTip = false
Vue.use(cors)
/* eslint-disable no-new */
// This is a global mixin, it is applied to every vue instance
Vue.mixin({
  data: function() {
    return {
      idBenhNhan:''
    }
  }
})

new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
