import Vue from 'vue'
import Router from 'vue-router'
import TiepNhan from '@/components/TiepNhan'
import TaoPhieuKham from '@/components/TaoPhieuKham'
import QuanLySoPhongKham from '@/components/QuanLySoPhongKham'
import KhamBenh from '@/components/KhamBenh'
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
    },
    {
      path: '/quanLySoPhongKham',
      name: 'Quan Ly So Phong Kham',
      component: QuanLySoPhongKham
    },
    {
      path: '/khamBenh',
      name: 'Kham Benh',
      component: KhamBenh
    }
  ]
})
