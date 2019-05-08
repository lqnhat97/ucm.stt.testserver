<template>
  <div class="TiepNhan">
    <Header />
    <div class="row" style="background-color:#ece9e9">
      <Sidebar />
      <div class="col-sm-9 ">
        <div class="row">
          <div class="col-sm-11" id="cliente">
            <form style=" border-bottom: 2px solid #bbbbbb">
              <div class="row form-group" style="padding:5pt">
                <div class="col-sm-3"> <label class="control-label" for="chuyenkhoa"
                    style="color:#969696;padding:8pt;margin-left: 3pt; ">Số CMND/CCCD</label> </div>
                <div class="search-box col-sm-3" style="height:30pt; margin-bottom: 10px">
                  <input type="text" id="cmnd" value="" class="form-control" v-model="cmnd">
                  <button class="btn btn-link search-btn" @click="checkCMND"> <i class="glyphicon glyphicon-search"></i>
                  </button>
                </div>
              </div>
            </form>
            <form action="">
              <p>Thông tin bệnh nhân</p>

              <div class="row form-group">
                <label for="" class="col-sm-2 col-form-label">Họ và tên</label>
                <div class="col-sm-4">
                  <input type="text" value="" class="form-control" v-model="HoVaTen" v-text="HoVaTen">
                </div>
                <div class="col-sm-1"></div>
                <label for="" class="col-sm-2 col-form-label" style="text-align:left">Giới
                  tính</label>
                <div class="col-sm-3">
                  <input type="text" value="" class="form-control" style="margin-right: 10px;" v-model="GioiTinh"
                    v-text="GioiTinh">
                </div>
              </div>

              <div class="row form-group">
                <label for="" class="col-sm-2 col-form-label">Ngày sinh</label>
                <div class="col-sm-4">
                  <input type="text" value="" class="form-control" v-model="NgaySinh" v-text="NgaySinh">
                </div>
                <div class="col-sm-1"></div>
                <label for="" class="col-sm-2 col-form-label" style="text-align:left">Tuổi</label>
                <div class="col-sm-3">
                  <input type="datetimepicker" value="" class="form-control" v-model="Tuoi" v-text="Tuoi">
                </div>
              </div>

              <div class="row form-group">
                <label for="" class="col-sm-2 col-form-label">Quê quán</label>
                <div class="col-sm-4">
                  <input type="text" value="" class="form-control" v-model="QueQuan" v-text="QueQuan">
                </div>
                <div class="col-sm-1"></div>
                <label for="" class="col-sm-2 col-form-label" style="text-align:left">CMND/CCCD</label>
                <div class="col-sm-3">
                  <input type="text" value="" class="form-control" v-model="cmnd" v-text="cmnd">
                </div>
              </div>


              <div class="row form-group">
                <label for="" class="col-sm-2 col-form-label">Nghề nghiệp</label>
                <div class="col-sm-4">
                  <input type="text" value="" class="form-control" v-model="NgheNghiep" v-text="NgheNghiep">
                </div>
                <div class="col-sm-1"></div>
                <label for="" class="col-sm-2 col-form-label" style="text-align:left">Số điện
                  thoại</label>
                <div class="col-sm-3">
                  <input type="text" value="" class="form-control" v-model="SoDienThoai" v-text="SoDienThoai">
                </div>
              </div>
              <div class="row form-group">
                <label for="" class="col-sm-2 col-form-label">Địa chỉ</label>
                <div class="col-sm-10">
                  <input type="text" value="" placeholder="Số nhà, đường, xã/phường, quận/huyện, tỉnh"
                    class="form-control" v-model="DiaChi" v-text="DiaChi">
                </div>
              </div>

              <div class="row form-group">
                <label for="" class="col-sm-2 col-form-label">Người thân</label>
                <div class="col-sm-10">
                  <input type="text" value="" class="form-control" v-model="NguoiThan" v-text="NguoiThan">
                </div>
              </div>
              <div class="row">
                
                <div class="col-sm-6">
                  <input class="form-group" id="buttom" type="submit" value="Tạo hồ sơ" @click="taoHoSo">
                </div>
                <div class="col-sm-6">
                  <router-link to="/taoPhieuKham"><input class="form-group" id="buttom" type="submit" value="Tạo phiếu khám"></router-link>
                </div>
              </div>

            </form>
          </div>
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
    name: 'TiepNhan',
    components: {
      Header,
      Sidebar
    },
    data() {
      return {
        cmnd: "",
        HoVaTen: "",
        GioiTinh: "",
        NgaySinh: "",
        Tuoi: "",
        QueQuan: "",
        NgheNghiep: "",
        DiaChi: "",
        NguoiThan: "",
        SoDienThoai: "",

      }
    },
    methods: {
      checkCMND(e) {
        e.preventDefault();
        axios.get(`http://192.168.1.90:8088/patient/checkBenhNhan/` + this.cmnd)
          .then(response => {
            console.log(response);
            let res = response.data;
            this.cmnd = res.CMND_CCCD;
            this.HoVaTen = res.Ho + " " + res.TenLot + " " + res.Ten;
            this.NgaySinh = res.NgaySinh.split("T")[0];
            this.GioiTinh = res.GioiTinh;
            this.QueQuan = res.QueQuan;
            this.NgheNghiep = res.NgheNghiep;
            this.DiaChi = res.Diachi;
            this.SoDienThoai = res.SDT
          })
          .catch(e => {
            console.log(e);
          })
      },
      taoHoSo(e) {
        e.preventDefault();
        var splitedHoVaTen = this.HoVaTen.split(" ");
        var posbody = {
          "firstName": splitedHoVaTen[0],
          "middleName": "",
          "lastName": splitedHoVaTen[splitedHoVaTen.lenght - 1],
          "cmnd_cccd": this.cmnd,
          "sex": this.GioiTinh,
          "dob": this.NgaySinh,
          "town": this.QueQuan,
          "job": this.NgheNghiep,
          "phone": this.SoDienThoai,
          "address": this.DiaChi,
        };
        console.log(posbody);
        axios.post(`http://192.168.1.90:8088/patient/taoThongTin`, {
            body:  posbody
          }).then(response => {})
          .catch(e => {
            this.error.push(e)
          })

      }
    }
  }
</script>

<style>
  @import '../../UMCC.css';
</style>