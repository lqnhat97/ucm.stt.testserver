<template>
  <div class="TiepNhan">
    <Header />
    <Sidebar :currentTab="1"/>
    <div class="col-sm-9 ">
      <div class="row">
        <div class="col-sm-11" id="cliente">
          <form style=" border-bottom: 2px solid #bbbbbb">
            <div class="row form-group" style="padding:5pt">
              <div class="col-sm-3"> <label class="control-label" for="chuyenkhoa"
                  style="color:#969696;padding:8pt;margin-left: 3pt; ">Số CMND/CCCD</label>
              </div>
              <div class="search-box col-sm-3" style="height:30pt; margin-bottom: 10px">
                <input type="text" id="cmnd" value="" class="form-control" v-model="cmnd">
                <button class="btn btn-link search-btn" @click="checkCMND" data-toggle="modal"
                  data-target="#findCmndModal"> <i class="glyphicon glyphicon-search"></i>
                </button>
              </div>
            </div>
          </form>

          <!-- Modal 
          <div class="modal fade" id="findCmndModal" tabindex="-1" role="dialog" aria-labelledby="findCmndModalTitle"
            aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h4 class="modal-title" id="findCmndModalTitle">Thông báo</h4>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body" v-text="message">

                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                </div>
              </div>
            </div>
          </div>-->

          <Modal :message="this.message"/>
          <form action="">
            <p>Thông tin bệnh nhân</p>
            <div class="row form-group">
              <label for="" class="col-sm-2 col-form-label" style="text-align:right">Họ và tên</label>
              <div class="col-sm-4">
                <input type="text" value="" class="form-control" :disabled="isFound?true:false" v-model="HoVaTen"
                  v-text="HoVaTen">
              </div>
              <label for="" class="col-sm-2 col-form-label" style="text-align:right">Giới tính</label>
              <div class="col-sm-4">
                <select type="text"  class="form-control" :disabled="isFound?true:false"
                  style="margin-right: 10px;" v-model="GioiTinh" >
                  <option>Nam</option>
                  <option>Nữ</option>
                </select>
              </div>
            </div>

            <div class="row form-group">
              <label for="" class="col-sm-2 col-form-label" style="text-align:right">Ngày sinh</label>
              <div class="col-sm-4">
                <input type="text" value="" placeholder="mm/dd/yyyy" class="form-control" :disabled="isFound?true:false" v-model="NgaySinh"
                  v-text="NgaySinh">
              </div>
              <label for="" class="col-sm-2 col-form-label" style="text-align:right">CMND/CCCD</label>
              <div class="col-sm-4">
                <input type="text" value="" :disabled="isFound?true:false" class="form-control" v-model="cmnd"
                  v-text="cmnd">
              </div>
            </div>

            <div class="row form-group">
              <label for="" class="col-sm-2 col-form-label" style="text-align:right">Quê quán</label>
              <div class="col-sm-4">
                <input type="text" value="" :disabled="isFound?true:false" class="form-control" v-model="QueQuan"
                  v-text="QueQuan">
              </div>
              <label for="" class="col-sm-2 col-form-label" style="text-align:right">Số điện
                thoại</label>
              <div class="col-sm-4">
                <input type="text" value="" :disabled="isFound?true:false" class="form-control" v-model="SoDienThoai"
                  v-text="SoDienThoai">
              </div>
            </div>


            <div class="row form-group">
              <label for="" class="col-sm-2 col-form-label" style="text-align:right">Nghề nghiệp</label>
              <div class="col-sm-4">
                <input type="text" value="" :disabled="isFound?true:false" class="form-control" v-model="NgheNghiep"
                  v-text="NgheNghiep">
              </div>
              <label for="" class="col-sm-2 col-form-label" style="text-align:right">Địa chỉ</label>
              <div class="col-sm-4">
                <input type="text" value="" :disabled="isFound?true:false"
                  placeholder="Số nhà, đường, xã/phường, quận/huyện, tỉnh" class="form-control" v-model="DiaChi"
                  v-text="DiaChi">
              </div>
            </div>

          </form>
          <div style="text-align:center;display: flex;justify-content: center;">
            <div>
              <router-link to="#" v-if="idBenhNhan == ''"><input class="form-group" id="buttom" type="submit"
                  value="Tạo hồ sơ" @click="taoHoSo"></router-link>
              <router-link to="/taoPhieuKham" v-else><input class="form-group" id="buttom" type="submit"
                  value="Tạo phiếu khám" v-text="handleBtn"></router-link>
            </div>
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
  import Modal from './modal.vue'
  export default {
    name: 'TiepNhan',
    components: {
      Header,
      Sidebar,
      Modal
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
        message: "",
        handleBtn: "",
        idBenhNhan: "",
        isFound: false
      }
    },
    methods: {
      checkCMND(e) {
        e.preventDefault();
        axios.get(`http://nhatlq97.sytes.net:8088/patient/checkBenhNhan/` + this.cmnd)
          .then(response => {
            let res = response.data;
            if (!res.hasOwnProperty("message")) {
              this.cmnd = res.CMND_CCCD;
              this.HoVaTen = res.Ho + " " + res.TenLot + " " + res.Ten;
              this.NgaySinh = res.NgaySinh.split("T")[0];
              this.GioiTinh = res.GioiTinh;
              this.QueQuan = res.QueQuan;
              this.NgheNghiep = res.NgheNghiep;
              this.DiaChi = res.Diachi;
              this.SoDienThoai = res.SDT;
              localStorage.idBenhNhan = res.ID;
              console.log(localStorage.idBenhNhan);

              this.idBenhNhan = res.Id;
              this.message = "Có kết qủa tìm kiếm"
              this.isFound = true;
            } else {
              this.message = res.message;
              this.isFound = false;
            }
          })
          .catch(e => {
            console.log(e);
          })
      },
      taoHoSo(e) {
        e.preventDefault();
        let splitedHoVaTen = this.HoVaTen.split(" ");
        if (splitedHoVaTen.length > 2) {
          var tmpMiddleName = [...splitedHoVaTen];
          tmpMiddleName.pop();
          tmpMiddleName.shift();
          var middleName = tmpMiddleName.reduce(getMiddleName);
        }

        let posbody = {
          "firstName": splitedHoVaTen[0],
          "middleName": splitedHoVaTen.length > 2 ? middleName : "",
          "lastName": splitedHoVaTen[splitedHoVaTen.length - 1],
          "cmnd_cccd": this.cmnd,
          "sex": this.GioiTinh,
          "dob": this.NgaySinh,
          "town": this.QueQuan,
          "job": this.NgheNghiep,
          "phone": this.SoDienThoai,
          "address": this.DiaChi,
        };
        axios.post(`http://nhatlq97.sytes.net:8088/patient/taoThongTin`, {
            body: posbody
          }).then(async response => {
            console.log(response);
            this.message = "Tạo thông tin thành công " + response.data.ID;
            this.handleBtn = "Tạo phiếu khám";
            localStorage.idBenhNhan = response.data.ID;
            console.log(localStorage.idBenhNhan);
            this.idBenhNhan = response.data.ID
            $('#findCmndModal').modal('show');
          })
          .catch(e => {
            this.message = "Đã tạo thông tin cho bệnh nhân " + this.cmnd;
            $('#findCmndModal').modal('show');
          })

      }
    }
  }

  function getMiddleName(result, str) {
    return result + " " + str;
  }

</script>

<style>
  @import '../../UMCC.css';

</style>
