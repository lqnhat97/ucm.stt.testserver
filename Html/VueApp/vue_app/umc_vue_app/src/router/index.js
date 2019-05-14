import Vue from 'vue'
import Router from 'vue-router'
import TiepNhan from '@/components/TiepNhan'
import TaoPhieuKham from '@/components/TaoPhieuKham'
import QuanLySoPhongKham from '@/components/QuanLySoPhongKham'
import KhamBenh from '@/components/KhamBenh'
import DanhSachPhongKham from '@/components/DanhSachPhongKham'
import ChiTietPhongKham from '@/components/ChiTietPhongKham'
import ChiTietCanLamSang from '@/components/ChiTietCanLamSang'
import QuanLySoCanLamSang from '@/components/QuanLySoCanLamSang'
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
    },
    {
      path: '/danhSachPhongKham',
      name: 'Danh Sach Phong Kham',
      component: DanhSachPhongKham
    },
    {
      path: '/chiTietPhongKham',
      name: 'Chi Tiet Phong Kham',
      component: ChiTietPhongKham
    },
    {
      path: '/chiTietCanLamSang',
      name: 'Chi Tiet Can Lam Sang',
      component: ChiTietCanLamSang
    },
    {
      path: '/quanLySoCanLamSang',
      name: 'Quan Ly So Can Lam Sang',
      component: QuanLySoCanLamSang
    }
  ]
})
