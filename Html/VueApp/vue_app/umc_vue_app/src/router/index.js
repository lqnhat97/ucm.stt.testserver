import Vue from 'vue'
import Router from 'vue-router'
import TiepNhan from '@/components/TiepNhan'
import TaoPhieuKham from '@/components/TaoPhieuKham'
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'TiepNhan',
      component: TiepNhan
    },
    {
      path: '/taoPhieuKham',
      name: 'Tao Phieu Kham',
      component: TaoPhieuKham
    }
  ]
})
