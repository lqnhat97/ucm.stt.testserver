<template>
  <div id="bodyContent">
    <div class="container">
      <div id="cliente" style="background-color: #F8F8F8;position:center">
        <div class="row" style="padding-right:10pt;display:flex;justify-content:space-between">
          <div class="col-sm-2" style="text-align:right;margin: 0 auto"> <label class="control-label" for="chuyenkhoa"
              style="color:#969696;text-align:center;margin: 0 auto">Chuyên khoa</label></div>
          <div class="col-sm-4">
            <select id="chuyenkhoa" class="form-control" placeholder="Chuyên khoa" v-model="selectedChuyenKhoa"
              @change="handleChangeChuyenKhoa">
              <option :selected="true" disabled value="">Chọn chuyên khoa</option>
              <option v-for="option in chuyenKhoa" :value="option.IDChuyenKhoa" :key="option.IDChuyenKhoa">
                {{option.TenChuyenKhoa}}</option>
            </select>
          </div>
          <div class="col-sm-2" style="text-align:right;margin: 0 auto"> <label for="sophong" style="color:#969696">Số
              phòng</label></div>
          <div class="col-sm-4">
            <select id="phongKham" class="form-control" placeholder="Chuyên khoa" v-model="selectedPhongKham"
              @change="handleChangeSoPhong">
              <option :selected="true" value="" disabled>Chọn số phòng</option>
              <option v-for="(option,index) in soLuongPhong" :value="option.thongTin[0].IDPhong" :key="index">
                {{option.phongKham}}</option>
            </select>
          </div>
        </div>
        <form style="padding-bottom:8pt;padding-left:5pt">
          <div class="row">
            <div class="col-sm-4">
              <h3>Màn hình hiển thị trước phòng khám lâm sàng</h3>
            </div>
          </div>
        </form>
        <div class="row" id="dashBoardLs" style=" flex-wrap: wrap;display:flex;justify-content:space-evenly; ">
          <template v-if="this.selectedPhongKham!=''">
            <div class="col-sm-12" style="background-color: white; box-shadow:1px 1px 1px; margin: 10px;">
              <div class="row" style="border-bottom: 2pt solid #bbbbbb">
                <h3 style="display:inline-block;margin:10pt; color:rgb(9, 173, 214)">Phòng khám:</h3>
                <h3 style="display:inline-block; margin:10pt;color:#67cf9c" v-text="soPhong.phongKham"></h3>
              </div>
              <table class="table">
                <thead>
                  <tr>
                    <th>Bàn</th>
                    <th>Số hiện tại</th>
                    <th>Số cuối</th>
                    <th>Bác sĩ</th>
                    <th>Bệnh nhân</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(option,index) in soPhong.thongTin" :key="index" style="margin:0 auto;">
                    <td class="number">{{option.SoBan}}</td>
                    <td class="number">{{option.STTHienTai}}</td>
                    <td class="number">{{option.STTCuoi}}</td>
                    <td>{{option.BacSi}}</td>
                    <td>{{option.BenhNhan==null?"Chưa có bệnh nhân":option.BenhNhan}}</td>
                  </tr>
                </tbody>
              </table>
            </div>
            <!-- <component v-for="(phong,index) in soPhong" :key="phong.phongKham" :is="dynamicComponent" :option="phong"
              :index="index" /> -->
          </template>
          <p v-else>Vui lòng chọn phòng khám</p>

        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  import modal from './modal.vue'
  import {
    setInterval
  } from 'timers';
  export default {
    name: 'DashboardLS',
    data() {
      return {
        chuyenKhoa: "",
        selectedChuyenKhoa: "",
        selectedPhongKham: "",
        soLuongPhong: "",
        soPhong: '',
        phongKham: [],
        interval: ''
      }
    },
    props: {
      isOpen: {
        type: Boolean,
        default: false
      }
    },
    created() {
      this.selectedChuyenKhoa = "";
      axios.get(process.env.SERVER_URI + `clinic/dsChuyenKhoa`).then(response => {
        this.chuyenKhoa = response.data;
      })
    },
    mounted() {
      this.isOpen == true ? document.getElementById("bodyContent").style.marginLeft = "300px" : document.getElementById(
        "bodyContent").style.marginLeft = "0";
    },
    methods: {
      handleChangeChuyenKhoa() {
        axios.get(process.env.SERVER_URI + `clinic/tinhTrangTheoChuyenKhoa/` + this.selectedChuyenKhoa).then(
          response => {
            this.soLuongPhong = response.data;
            this.selectedPhongKham = '';
              clearInterval(this.interval)
          })
      },
      handleChangeSoPhong(e) {
        if (this.selectedPhongKham != '') {
          this.interval = setInterval(() => {
            axios.get(process.env.SERVER_URI + `clinic/thongTinLsTheoPhong/` + this.selectedPhongKham).then(
              response => {
                this.soPhong = response.data;
              })
          }, 1000);
        }else{
          clearInterval(this.interval);
        }
        this.$mount('#dashBoardLs');
      }
    }
  }

</script>
