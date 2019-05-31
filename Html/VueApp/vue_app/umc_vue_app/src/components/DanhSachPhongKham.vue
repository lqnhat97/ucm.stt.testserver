<template>
  <div id="bodyContent">
    <div class="container">
      <div id="cliente" style="background-color: #F8F8F8;position:center">
        <div class="row">
            <div class="col-sm-4" style="text-align:right;margin: 0 auto"> <label class="control-label" for="chuyenkhoa"
                style="color:#969696;text-align:center;margin: 0 auto">Chuyên khoa</label></div>

            <select id="chuyenkhoa" class="form-control" placeholder="Chuyên khoa"
              v-model="selectedChuyenKhoa" @change="handleChangeChuyenKhoa">
              <option :selected="true" disabled>Chọn chuyên khoa</option>
              <option v-for="option in chuyenKhoa" :value="option.IDChuyenKhoa" :key="option.IDChuyenKhoa">
                {{option.TenChuyenKhoa}}</option>
            </select>

            <div class="col-sm-4" style="text-align:right;margin: 0 auto"> <label for="sophong" style="color:#969696">Số
                phòng</label></div>
            <select id="phongKham" class="form-control" placeholder="Chuyên khoa"
              v-model="selectedPhongKham" @change="handleChangeSoPhong">
              <option :selected="true" disabled>Chọn số phòng</option>
              <option v-for="option in soLuongPhong" :value="option.phongKham" :key="option.Phong">
                {{option.phongKham}}</option>
            </select>
          </div>
        <form style="padding-bottom:8pt;padding-left:5pt">
          <div class="row">
            <div class="col-sm-4">
              <h3>Danh sách phòng khám</h3>
            </div>
          </div>
        </form>
        <div class="row" id="chiDinhCanLamSang" style=" flex-wrap: wrap;display:flex;justify-content:space-evenly; ">
          <template v-if="this.selectedPhongKham!=''">
            <component v-for="(phong,index) in soPhong" :key="phong.phongKham" :is="dynamicComponent" :option="phong"
              :index="index" />
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
  export default {
    name: 'DanhSachPhongKham',
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
            this.soPhong = response.data;
            this.soLuongPhong = response.data;
            this.selectedPhongKham = ""
          })
      },
      handleChangeSoPhong(e) {
        this.soPhong = this.soLuongPhong.filter(value => {
          return value.phongKham === this.selectedPhongKham
        })
      }
    },
    computed: {
      dynamicComponent: function (parent = this) {
        return {
          template: ` <div class="col-sm-12" style="background-color: white; box-shadow:1px 1px 1px; margin: 10px;">
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
                  <th>Số cuối</th>
                  <th>Bác sĩ</th>
                  <th>Bệnh nhân</th>
                  <th>Thao tác</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(option,index) in soLuongBan" :value="option.SoBan" :key="index" style="margin:0 auto;">
                  <td class="number">{{option.SoBan}}</td>
                  <td class="number">{{option.STTHienTai}}</td>
                  <td class="number">{{option.STTCuoi}}</td>
                  <td>{{option.BacSi}}</td>
                  <td>{{option.BenhNhan==null?"Chưa có bệnh nhân":option.BenhNhan}}</td>
                  <td v-if="option.STTHienTai==option.STTCuoi">Không thể thao tác</td>
                  <td v-else><button class="btn btn-primary" @click="nextNumber(option)">+</button> <button class="btn btn-danger" @click="nextNumber(option)">x</button></td>
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

            this.soLuongBan = this.option.thongTin;
            this.soPhong += this.option.phongKham;
          },
          methods: {
            nextNumber(data) {
              axios.post(process.env.SERVER_URI + `clinic/soKeTiepLamSang`, {
                idBanKham: data.IDBan,
                idPhong: data.IDPhongKham
              }).then(response => {
                if (response.status == 200) {
                  this.message = 'Đã qua số cho bàn <strong><span style="color: #41B883;">' + response.data
                    .SoBan + '</span></strong>  phòng <strong><span style="color: #41B883;">' + response.data
                    .SoPhong + '</span></strong>' +
                    '</span></strong>  ca <strong><span style="color: #41B883;">' + response.data.CaKham;
                  $('#findCmndModal').modal('show');
                  this.soLuongBan = parent.soPhong[this.index].thongTin;

                };
              })
            }
          }
        }
      }
    }
  }

</script>
