import Vue from 'vue'
import Router from 'vue-router'
import TiepNhan from '@/components/TiepNhan'
import TaoPhieuKham from '@/components/TaoPhieuKham'
import KhamBenh from '@/components/KhamBenh'
import DanhSachPhongKham from '@/components/DanhSachPhongKham'
import ChiTietPhongKham from '@/components/ChiTietPhongKham'
import ChiTietCanLamSang from '@/components/ChiTietCanLamSang'
import QuanLyPhongCanLamSang from '@/components/QuanLyPhongCanLamSang'
import QuanLyBacSi from '@/components/QuanLyBacSi'
import Dashboard from '@/components/Dashboard'
import DashboardLs from '@/components/DashboardPhongLs'
import DashboardCls from '@/components/DashboardPhongCLs'
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
      path: '/khamBenh',
      name: 'Kham Benh',
      component: KhamBenh
    },
    // {
    //   path: '/danhSachPhongKham/:chuyenKhoa/:phongKham',
    //   name: 'Danh Sach Phong Kham',
    //   component: DanhSachPhongKham
    // },
    {
      path: '/danhSachPhongKham/',
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
      path: '/quanLyBacSi',
      name: 'Quan Ly Bac Si',
      component: QuanLyBacSi
    },
    {
      path: '/quanLyPhongCanLamSang',
      name: 'Quan Ly Phong Can Lam Sang',
      component: QuanLyPhongCanLamSang
    },
    {
      path: '/dashboard',
      name: 'Dashboard',
      component: Dashboard
    },
    {
      path: '/dashboardLs/',
      name: 'DashboardLs',
      component: DashboardLs
    },
    {
      path: '/dashboardCls/',
      name: 'DashboardCls',
      component: DashboardCls
    }
  ]
})
