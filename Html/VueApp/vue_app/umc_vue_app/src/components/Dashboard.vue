<template>
  <div id="bodyContent">
    <div class="container">
      <div id="cliente" style="background-color: #F8F8F8;position:center">
        <form style="padding-bottom:8pt;padding-left:5pt">
          <div class="row">
            <div class="col-sm-4">
              <h3>Dashboard</h3>
            </div>
          </div>
          <div style="flex-wrap: wrap;display:flex;justify-content:space-evenly;">
            <template v-for="(phognKham,index) in danhSachPhongKham">
              <div class="col-sm-5" style="background-color: white; box-shadow:1px 1px 1px; margin: 10px;" :key="index">
                <div class="row" style="border-bottom: 2pt solid #bbbbbb">
                  <h3 style="display:inline-block;margin:10pt; color:rgb(9, 173, 214)" v-text="phongKham"></h3>
                  <h3 style="display:inline-block; margin:10pt;color:#67cf9c" v-text="soPhong"></h3>
                </div>
                <!-- <modal :message="this.message" /> -->

                <table class="table">
                  <thead>
                    <tr>
                      <th>Bàn</th>
                      <th>Số hiện tại</th>
                      <th>Bác sĩ</th>
                      <th>Bệnh nhân</th>
                      <th>Tăng số</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="(option,index) in soLuongBan" :value="option.SoBan" :key="index">
                      <td class="number">{{option.SoBan}}</td>
                      <td class="number">{{option.SoHienTai}}</td>
                      <td>{{option.BacSi}}</td>
                      <td>{{option.BenhNhan}}</td>
                      <td><button class="btn-primary" @click="nextNumber(option)">+</button></td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </template>
          </div>
        </form>

      </div>
    </div>
  </div>
</template>


<script>
  import axios from 'axios'
  export default {
    name: 'Dashboard',
    data() {
      return {
        danhSachPhongKham: "",
      }
    },
    props: {
      isOpen: {
        type: Boolean,
        default: false
      }
    },
    created() {
      axios.get(process.env.SERVER_URI + `clinic/dsChuyenKhoa`).then(response => {
        console.log(response.data);
        this.danhSachPhongKham = response.data;
      })
    },
    mounted() {
      this.isOpen == true ? document.getElementById("bodyContent").style.marginLeft = "300px" : document.getElementById(
        "bodyContent").style.marginLeft = "0";
    },
  }

</script>
