<template>
  <div class="ChiTietPhongKham">
    <Header />
    <Sidebar :currentTab="3" />

    <div class="col-sm-9 ">
      <div class="col-sm-11  form-group" id="cliente" style="background-color: #F8F8F8;position:center">
        <form style=" border-bottom: 2px solid #bbbbbb">
          <div class="row" style="padding:5pt">
            <div class="col-sm-4"> <label class="control-label" for="chuyenkhoa"
                style="color:#969696;padding:8pt;margin-left: 3pt">Chuyên khoa</label></div>
            <select v-bind:style="{ margin_top:'10%' }" id="chuyenkhoa" class="form-control" placeholder="Chuyên khoa"
              v-model="selectedChuyenKhoa" @change="handleChangeChuyenKhoa">
              <option :selected="true" disabled>Chọn chuyên khoa</option>
              <option v-for="option in chuyenKhoa" :value="option.IDChuyenKhoa" :key="option.IDChuyenKhoa">
                {{option.TenChuyenKhoa}}</option>
            </select>
            <div class="col-sm-4"> <label for="sophong" style="color:#969696;padding:8pt;margin-left: 15pt">Số
                phòng</label></div>

            <select v-bind:style="{ margin_top:'10%' }" id="chuyenkhoa" class="form-control" placeholder="Chuyên khoa"
              v-model="selectedPhongKham" @change="handleChangeSoPhong">
              <option :selected="true" disabled>Chọn số phòng</option>
              <option selected value="tatCa">Tất cả</option>
              <option v-for="option in soLuongPhong" :value="option.phongKham" :key="option.SoBan">
                {{option.phongKham}}</option>
            </select>
          </div>
        </form>
        <form style="padding-bottom:8pt;padding-left:5pt">
          <div class="row" style="margin-top:1pt;margin-left:10pt">
            <h3>Thống kê chi tiết phòng khám</h3>
          </div>
        </form>

        <div class="row " style="display:flex;flex-wrap: wrap;justify-content:space-evenly">
          <component v-for="(phong,index) in soPhong" :key="phong.phongKham" :is="dynamicComponent" :option="phong" :index="index" />
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  import axios from 'axios'
  import Header from './Header.vue'
  import Sidebar from './Sidebar.vue'
  export default {
    name: 'ChiTietPhongKham',
    components: {
      Header,
      Sidebar
    },
    data() {
      return {
        chuyenKhoa: "",
        selectedChuyenKhoa: "",
        selectedPhongKham: "",
        soPhong: "",
        soLuongPhong: "",
        phongKham: [],
      }
    },
    methods: {
      handleChangeChuyenKhoa(e) {
        axios.get(process.env.SERVER_URI + `clinic/tinhTrangConChoTheoChuyenKhoa/` + this.selectedChuyenKhoa).then(
          response => {
            console.log(response.data);
            this.soPhong = response.data;
            this.soLuongPhong = response.data;

          })
      },
      handleChangeSoPhong() {
        this.soPhong = this.soLuongPhong.filter(value => {
          return value.phongKham === this.selectedPhongKham
        })
        if (this.selectedPhongKham === "tatCa") {
          this.soPhong = this.soLuongPhong;
        }

      }
    },
    created() {
      this.selectedChuyenKhoa = ""
      axios.get(process.env.SERVER_URI + `clinic/dsChuyenKhoa`).then(response => {
        this.chuyenKhoa = response.data;
      })
    },
    computed: {
      dynamicComponent: function (parent = this) {
        return {
          template: `<div class="col-sm-5" style="background-color: white;margin: 10px;   box-shadow:1px 1px 1px;">
                      <div class="row" style="border-bottom: 2pt solid #bbbbbb">
                        <h3 style="display:inline-block;margin:10pt; color:rgb(9, 173, 214)">Phòng khám</h3>
                        <h3 style="display:inline-block; margin:10pt;color:#67cf9c">{{this.option.phongKham}}</h3>
                      </div>
                      <table class="table">
                        <thead>
                          <tr>
                            <th>Bàn</th>
                            <th>Số còn chờ</th>
                            <th>Tốc độ nhảy số</th>
                            <th>Thời gian khám số cuối</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr v-for="(option,index) in soLuongBan" :value="option.SoBan" :key="index">
                            <td class="number">{{option.SoBan}}</td>
                            <td class="number">{{option.SoConCho}}</td>
                            <td>{{(option.TocDoNhaySo.split("T")[1]).split("Z")[0]}}</td>
                            <td>{{option.ThoiGianKhamSoCuoi==null?'Chưa khám':option.ThoiGianKhamSoCuoi}}</td>
                          </tr>                          
                        </tbody>
                      </table>
                    </div>`,
          props: {
            option: {
              type: Object,
              default: {},
            },
            index: {
              type: Number,
              default: 0
            }
          },
          data() {
            return {
              soPhong: "",
              soLuongBan: "",
              message: ""
            }
          },
          created() {
            this.soLuongBan = this.option.thongTin;
            this.soPhong += this.option.phongKham;
          },
        }

      }
    }
  }

</script>
