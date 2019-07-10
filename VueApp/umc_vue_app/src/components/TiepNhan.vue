<template>
  <div id="bodyContent">
    <div>
      <div class="container">
        <div id="cliente">
          <div style=" border-bottom: 2px solid #bbbbbb">
            <div class="row form-group" style="padding:5pt">
              <div class="col-sm-2"> <label class="control-label" style="color:#969696;padding:5pt;text-align:right">Số
                  CMND/CCCD</label>
              </div>
              <div class="col-sm-5">
                <autocomplete ref="autocomplete" placeholder="CMND" :source="allBenhNhan" input-class="form-control"
                  v-model="cmnd" resultsDisplay="CMND_CCCD" resultsValue="CMND_CCCD" @selected="autocompleteSelected"
                  @clear="clearSearch">
                </autocomplete>
              </div>
              <div class="col-sm-2"> <label class="control-label" style="color:#969696;padding:5pt;text-align:right">Mã
                  bệnh nhân</label>
              </div>
              <div>
                <input type="text" value="" class="form-control" disabled v-model="maBn" v-text="HoVaTen">
              </div>
            </div>
          </div>
          <Modal :message="this.message" />
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
                <select type="text" class="form-control" :disabled="isFound?true:false" style="margin-right: 10px;"
                  v-model="GioiTinh">
                  <option>Nam</option>
                  <option>Nữ</option>
                </select>
              </div>
            </div>

            <div class="row form-group">
              <label for="" class="col-sm-2 col-form-label" style="text-align:right">Ngày sinh</label>
              <div class="col-sm-4">
                <date-picker style="width:100%" valueType="format" :lang='lang' :placeholder="NgaySinh"
                  v-model="NgaySinh" :shortcuts="false" :disabled="isFound?true:false" format="MM/DD/YYYY">
                </date-picker>
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
                <input type="number" value="" :disabled="isFound?true:false" class="form-control" v-model="SoDienThoai"
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
          <div>
            <div style="text-align:center; width:30%; margin:0 auto">
              <router-link to="#" v-if="isFound == false"><input class="form-group" id="buttom" type="submit"
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
  import Modal from './modal.vue'
  import DatePicker from 'vue2-datepicker'
  import Autocomplete from 'vuejs-auto-complete'
  export default {
    name: 'TiepNhan',
    props: {
      isOpen: {
        type: Boolean,
        default: false
      }
    },
    components: {
      Modal,
      Autocomplete,
      DatePicker
    },
    data() {
      return {
        allBenhNhan: "",
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
        isFound: false,
        maBn: "",
        lang: {
          days: ['Chủ nhật', 'Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy'],
          months: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9',
            'Tháng 10', 'Tháng 11', 'Tháng 12'
          ],
          pickers: ['next 7 days', 'next 30 days', 'previous 7 days', 'previous 30 days'],
          placeholder: {
            date: 'Chọn ngày',
            dateRange: 'Chọn khoảng ngày'
          },
        }
      }
    },
    mounted() {
      this.isOpen == true ? document.getElementById("bodyContent").style.marginLeft = "300px" : document.getElementById(
        "bodyContent").style.marginLeft = "0";

    },
    created() {
      axios.get(process.env.SERVER_URI + `patient/loadAll`).then((res) => {
        this.allBenhNhan = res.data;
      })
    },
    methods: {
      autocompleteSelected(group) {
        this.group = group;
        this.cmnd = group.selectedObject.CMND_CCCD;
        this.checkCMND();
      },
      clearSearch() {
        this.clearTex();
        this.isFound = false;
      },
      clearTex() {
        this.cmnd = "";
        this.HoVaTen = "";
        this.NgaySinh = "";
        this.GioiTinh = "";
        this.QueQuan = "";
        this.NgheNghiep = "";
        this.DiaChi = "";
        this.SoDienThoai = "";
        this.maBn = "";
      },
      checkCMND() {
        axios.get(process.env.SERVER_URI + `patient/checkBenhNhan/` + this.cmnd)
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
              this.maBn = res.ID;
              this.message = "Có kết qủa tìm kiếm"
              this.isFound = true;
              this.socket.emit('genarateBarcode', `${process.env.SERVER_URI}home?idBenhNhan=${res.ID}&cmnd=${this.cmnd}`);
            } else {
              this.message = res.message;
              this.isFound = false;
              this.clearTex();
            }
          })
          .catch(e => {
            console.log(e);
          })
      },
      isEmpty(obj) {
        return Object.values(obj).some(element => element === "");
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
        console.log(posbody);
        if (!this.isEmpty(posbody)) {
          axios.post(process.env.SERVER_URI + `patient/taoThongTin`, {
              body: posbody
            }).then(async response => {

              console.log(response);
              this.message =
                `Tạo thông tin thành công, mã bệnh nhân: <strong>${response.data.ID}</strong>. Xem barcode <a href="localhost:8088/home?idBenhNhan=${response.data.ID}&hoten=${this.HoVaTen}&cmnd=${this.cmnd}">Tại đây</a>`;
              this.handleBtn = "Tạo phiếu khám";
              this.socket.emit('genarateBarcode', `${process.env.SERVER_URI}home?idBenhNhan=${response.data.ID}&cmnd=${this.cmnd}`);
              localStorage.idBenhNhan = response.data.ID;
              this.idBenhNhan = response.data.ID;
              this.maBn = response.data.ID
              this.isFound = true;
              $('#findCmndModal').modal('show');
            })
            .catch(e => {
              this.message = e;
              $('#findCmndModal').modal('show');
            })
        } else {
          this.message = "Vui lòng nhập đủ thông tin";
          $('#findCmndModal').modal('show');
        }
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
