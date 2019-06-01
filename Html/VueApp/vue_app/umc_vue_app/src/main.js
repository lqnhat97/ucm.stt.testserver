// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import cors from 'cors'
import dotenv from 'dotenv'
Vue.config.productionTip = false
dotenv.config()

Vue.use(cors)
var socket = null;

Vue.mixin({
  data: function() {
    return {
      socket:socket
    }
  }
})
/* eslint-disable no-new */

new Vue({
  el: '#app',
  router,
  components: {
    App
  },
  created(){
    socket=io(process.env.SERVER_URI);
  },
  template: '<App/>'
})
