<template>
  <div class="DanhSachPhongKham">
    <Header />
    <Sidebar :currentTab="3"/>
    <div class="col-sm-9 ">

      <div class="col-sm-11  form-group" id="cliente" style="background-color: #F8F8F8;position:center">
        <form style=" border-bottom: 2px solid #bbbbbb">
          <div class="row" style="padding:5pt">
            <div class="col-sm-2"> <label class="control-label" for="chuyenkhoa"
                style="color:#969696;padding:8pt;margin-left: 3pt">Chuyên khoa</label></div>

            <select v-bind:style="{ margin_top:'10%' }" id="chuyenkhoa" class="form-control" placeholder="Chuyên khoa"
              v-model="selectedChuyenKhoa" @change="handleChangeChuyenKhoa">
              <option :selected="true" disabled>Chọn chuyên khoa</option>
              <option v-for="option in chuyenKhoa" :value="option.IDChuyenKhoa" :key="option.IDChuyenKhoa">
                {{option.TenChuyenKhoa}}</option>

            </select>

            <div class="col-sm-2"> <label for="sophong" style="color:#969696;padding:8pt;margin-left: 15pt">Số
                phòng</label></div>
            <select v-bind:style="{ margin_top:'10%' }" id="chuyenkhoa" class="form-control" placeholder="Chuyên khoa"
              v-model="selectedPhongKham" @change="handleChangeSoPhong">
              <option :selected="true" disabled>Chọn số phòng</option>
              <option selected value="tatCa">Tất cả</option>
              <option v-for="option in soLuongPhong" :value="option.phongKham" :key="option.Phong">
                {{option.phongKham}}</option>
            </select>
          </div>
        </form>
        <form style="padding-bottom:8pt;padding-left:5pt">
          <div class="row">
            <div class="col-sm-4">
              <h3>Danh sách phòng khám</h3>
            </div>
          </div>
        </form>
        <div class="row" id="chiDinhCanLamSang" style=" flex-wrap: wrap;display:flex;justify-content:space-evenly; ">
          <component v-for="phong in soPhong" :key="phong.phongKham" :is="dynamicComponent" :option="phong" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  import Header from './Header.vue'
  import Sidebar from './Sidebar.vue'
  import modal from './modal.vue'
  export default {
    name: 'DanhSachPhongKham',
    components: {
      Header,
      Sidebar,
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
    created() {
      this.selectedChuyenKhoa = ""
      axios.get(`http://localhost:8088/clinic/dsChuyenKhoa`).then(response => {
        this.chuyenKhoa = response.data;
      })
    },
    methods: {
      handleChangeChuyenKhoa(e) {
        axios.get(`http://localhost:8088/clinic/tinhTrangTheoChuyenKhoa/` + this.selectedChuyenKhoa).then(
          response => {
            this.soPhong = response.data;
            this.soLuongPhong = response.data;
          })
      },
      handleChangeSoPhong(e) {
        this.soPhong = this.soLuongPhong.filter(value => {
          return value.phongKham === this.selectedPhongKham
        })
        if (this.selectedPhongKham === "tatCa") {
          this.soPhong = this.soLuongPhong;
        }
      }
    },
    computed: {
      dynamicComponent: function (parent = this) {
        return {
          template: ` <div class="col-sm-5" style="background-color: white; box-shadow:1px 1px 1px; margin: 10px;">
            <div class="row" style="border-bottom: 2pt solid #bbbbbb">
              <h3 style="display:inline-block;margin:10pt; color:rgb(9, 173, 214)" v-text="phongKham"></h3>
              <h3 style="display:inline-block; margin:10pt;color:#67cf9c" v-text="soPhong"></h3>
            </div>
            <modal :message="this.message" />

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
          </div>`,
          props: {
            option: {
              type: Object,
              default: {},
            }
          },
          components: {
            modal
          },
          data() {
            return {
              phongKham: "Phòng khám: ",
              soPhong: "",
              soLuongBan: "",
              message: ""
            }
          },
          created() {
            console.log(this.option);
            this.soLuongBan = this.option.thongTin;
            this.soPhong += this.option.phongKham;
          },
          methods: {
            nextNumber(data) {
              axios.post(`http://localhost:8088/clinic/soKeTiepLamSang`, {
                idBanKham: data.IDBan,
                idPhong: data.IDPhongKham
              }).then(response => {
                console.log(response)
                if (response.status == 200) {
                  this.message = 'Đã qua số cho bàn <strong><span style="color: #41B883;">' + response.data.BanKham + '</span></strong>  phòng <strong><span style="color: #41B883;">' + response.data.PhongKham + '</span></strong>' ;
                  $('#findCmndModal').modal('show');

                };
              })
            }
          }
        }
      }
    }
  }

</script>
