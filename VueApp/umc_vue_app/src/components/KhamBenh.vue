<template>
  <div id="bodyContent">
    <div class="container">
      <div class="form-group">
        <div class="row">
          <div class="col-sm-6" id="cliente-left">
            <form action="" style=" border-bottom: 2px solid #bbbbbb">
              <p>Thông tin bệnh nhân</p>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Họ và tên</label>
                <div class="col-sm-9">
                  <input type="text" value="" class="form-control" v-model="HoVaTen" v-text="HoVaTen" disabled>
                </div>

              </div>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Giới
                  tính</label>
                <div class="col-sm-3">
                  <input type="text" value="" class="form-control" style="margin-right: 10px;" v-model="GioiTinh"
                    v-text="GioiTinh" disabled>
                </div>
              </div>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Ngày sinh</label>
                <div class="col-sm-5">
                  <input type="text" value="" class="form-control" v-model="NgaySinh" v-text="NgaySinh" disabled>
                </div>

              </div>

              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Quê quán</label>
                <div class="col-sm-9">
                  <input type="text" value="" class="form-control" v-model="QueQuan" v-text="QueQuan" disabled>
                </div>

              </div>

              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">CMND/CCCD</label>
                <div class="col-sm-9">
                  <input type="text" value="" class="form-control" v-model="cmnd" v-text="cmnd" disabled>
                </div>
              </div>

              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Địa chỉ</label>
                <div class="col-sm-9">
                  <input type="text" value="" class="form-control" v-model="DiaChi" v-text="DiaChi" disabled>
                </div>
              </div>

              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Nghề nghiệp</label>
                <div class="col-sm-9">
                  <input type="text" value="" class="form-control" v-model="NgheNghiep" v-text="NgheNghiep" disabled>
                </div>

              </div>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Số điện
                  thoại</label>
                <div class="col-sm-9">
                  <input type="text" value="" class="form-control" v-model="SoDienThoai" v-text="SoDienThoai" disabled>
                </div>
              </div>


            </form>
          </div>
          <div class="col-sm-6" id="cliente-right">
            <form style=" border-bottom: 2px solid #bbbbbb; padding:10pt">
              <p>Phiếu khám và chỉ định</p>
            </form>
            <div>
              <form action="" style="margin-top: 10px">
                <div class="row form-group">
                  <label for="" class="col-sm-3 col-form-label" style="text-align:right">Mã phiếu khám</label>
                  <div class="col-sm-4">
                    <autocomplete ref="autocomplete" placeholder="Phiếu khám" :source="phieuKham"
                      input-class="form-control" resultsDisplay="IDPhieuKham" resultsValue="IDPhieuKham"
                      @selected="autocompleteSelected" @clear="clearSearch">
                    </autocomplete>
                  </div>
                  <label for="" class="col-sm-3 col-form-label" style="text-align:right">Ngày
                    khám</label>
                  <div class="col-sm-3">
                    <input type="text" value="" class="form-control" disabled v-model="date" v-text="date">
                  </div>
                </div>

                <div class="row form-group">
                  <label for="" class="col-sm-3 col-form-label" style="text-align:right">Triệu chứng</label>
                  <div class="col-sm-9">
                    <input type="text" value="" class="form-control">
                  </div>
                </div>
                <hr color="black" />

                <div id="chiDinhCanLamSang">
                  <template v-if="this.MaPhieuKham != ''">
                    <div class="row form-group">
                      <label for="" class="col-sm-4 col-form-label">Danh sách dịch vụ</label>
                      <div class="col-sm-8">
                        <select style="width:100%" class="form-group form-control" v-model="selectedCanLamSang"
                          @change="handleChangeDsDvCls">
                          <option selected disabled value="0">Chọn dịch vụ</option>
                          <option v-for="option in dsDvCls" :value="option.LoaiDichVu" :key="option.LoaiDichVu">
                            {{option.TenLoaiDichVu}}</option>
                        </select>
                        <select multiple size="7" style="width:100%" class="form-group form-control"
                          v-model="selectedDichVu">
                          <option selected disabled value="0">Danh sách dịch vụ</option>
                          <option v-for="option in dichVu" :value="option.IDDichVu" :key="option.IDDichVu">
                            {{option.TenDichVu}}</option>
                        </select>
                        <input type="button" value="Thêm chỉ định" class="btn btn-success" @click="themDichVu">
                      </div>
                    </div>
                    <div class="row">
                      <label for="" class="col-sm-4 col-form-label">Danh sách dịch vụ đã chọn</label>
                      <div class="col-sm-8">
                        <select multiple size="7" class="form-group form-control" v-model="dsDvThucHien">
                          <option v-if="dvThucHien.length === 0" value="" disabled>Chưa chỉ định dịch vụ</option>
                          <option v-else v-for="(dv, index) in dvThucHien" :key="index" :value="dv.IDDichVu">
                            {{dv.TenDichVu}}</option>
                        </select>
                        <input type="button" id="remove" value="Xóa chỉ định" class="btn btn-danger" @click="xoaDichVu"
                          style="text-align:left">
                      </div>
                    </div>
                  </template>
                  <h3 v-else>Chưa có bệnh nhân</h3>
                </div>
                <hr />
                <div style="display:flex;justify-content:center">
                  <input class="form-group" id="buttom" type="submit" value="Chỉ định" @click="chiDinhCanLamSang"
                    style="width:30%">
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
      <!-- Modal -->
      <modal :message="this.message" />
    </div>
  </div>


</template>

<script>
  import axios from 'axios'
  import modal from './modal'
  import Autocomplete from 'vuejs-auto-complete'
  export default {
    name: 'KhamBenh',
    components: {
      Autocomplete,
      modal
    },
    props: {
      isOpen: {
        type: Boolean,
        default: false
      }
    },
    data() {
      return {
        phieuKham: "",
        cmnd: "",
        HoVaTen: "",
        GioiTinh: "",
        NgaySinh: "",
        QueQuan: "",
        NgheNghiep: "",
        DiaChi: "",
        SoDienThoai: "",
        message: "",
        handleBtn: "",
        idBenhNhan: "",
        MaPhieuKham: "",
        selectedChuyenKhoa: "",
        selectedPhongKham: "",
        selectedCanLamSang: "",
        selectedDichVu: [],
        dvThucHien: [],
        dsDvThucHien: [],
        dsDvCls: "",
        dichVu: "",
        selectedBan: "",
        chuyenKhoa: "",
        soLuongPhong: [],
        soLuongBan: [],
        correct: false,
        bodyRequestChiDinh: {
          idPhieuKham: "",
          idDichVuCls: []
        },
        soLuongChiDinh: [{
          stt: 1,
        }],
        message: "",
        date: new Date().getDate() + "/" + String(new Date().getMonth() + 1) + "/" + new Date().getFullYear()
      }
    },
    created() {
      axios.get(process.env.SERVER_URI + `clinic/dsChuyenKhoa`).then(response => {
        this.chuyenKhoa = response.data;
      })
      axios.get(process.env.SERVER_URI + `clinic/loadAllPhieuKham`).then(response => {
        this.phieuKham = response.data;
      })
      axios.get(process.env.SERVER_URI + `clinic/dsCls`).then(response => {
        this.dsDvCls = response.data;
      });
    },
    methods: {
      autocompleteSelected(group) {
        this.group = group
        this.MaPhieuKham = this.group.selectedObject.IDPhieuKham;
        console.log(this.MaPhieuKham);
        this.checkMaPhieuKham();
      },
      clearSearch() {
        this.cmnd = "";
        this.HoVaTen = "";
        this.NgaySinh = "";
        this.GioiTinh = "";
        this.QueQuan = "";
        this.NgheNghiep = "";
        this.DiaChi = "";
        this.SoDienThoai = "";
        this.idBenhNhan = "";
        this.MaPhieuKham = "";
        this.correct = false;
        this.$mount('#bodyContent');
      },
      handleChangeDsDvCls() {
        if (this.selectedCanLamSang != 0) {
          axios.get(process.env.SERVER_URI + `clinic/dsClsTheoDv/` + this.selectedCanLamSang).then(
            response => {
              if (response != null) {
                this.dichVu = response.data;
              }
            }
          )
        }
      },
      checkMaPhieuKham() {
        axios.get(process.env.SERVER_URI + `clinic/checkPK/` + this.MaPhieuKham).then(response => {
          let res = response.data;
          if (!res.hasOwnProperty("message")) {
            this.correct = true
            this.cmnd = res.CMND_CCCD;
            this.HoVaTen = res.Ho + " " + res.TenLot + " " + res.Ten;
            this.NgaySinh = res.NgaySinh.split("T")[0];
            this.GioiTinh = res.GioiTinh;
            this.QueQuan = res.QueQuan;
            this.NgheNghiep = res.NgheNghiep;
            this.DiaChi = res.Diachi;
            this.SoDienThoai = res.SDT;
            this.idBenhNhan = res.Id;
          }
        }).catch(e => {
          this.cmnd = "";
          this.HoVaTen = "";
          this.NgaySinh = "";
          this.GioiTinh = "";
          this.QueQuan = "";
          this.NgheNghiep = "";
          this.DiaChi = "";
          this.SoDienThoai = "";
          this.idBenhNhan = "";
          this.correct = false;
        })
      },
      themDichVu() {
        for (const [index, value] of this.selectedDichVu.entries()) {
          let tmp = this.dichVu.filter(v => {
            return v.IDDichVu == value;
          })[0];
          let contain = this.dvThucHien.some(value => value.IDDichVu === tmp.IDDichVu);
          if (!contain)
            this.dvThucHien.push({
              IDDichVu: tmp.IDDichVu,
              TenDichVu: tmp.TenDichVu
            })
        }
      },
      xoaDichVu() {
        for (const dv of this.dsDvThucHien) {
          this.dvThucHien = this.dvThucHien.filter(value => value.IDDichVu != dv)
        }
      },
      chiDinhCanLamSang(e) {
        e.preventDefault();
        if (this.dvThucHien.length === 0) {
          this.message = "Vui lòng chọn và chỉ định dịch vụ";
          $('#findCmndModal').modal('show');
        } else {
          axios.post(process.env.SERVER_URI + `clinic/phatSinhCLS`, {
            idPhieuKham: this.MaPhieuKham,
            idDichVuCls: this.dvThucHien.map(value => value.IDDichVu),
          }).then(e => {
            console.log(e);
            if (e.data.hasOwnProperty('CLS') || e.data.hasOwnProperty('XetNghiem')) {
              this.message =
                'Phát sinh số cận lâm sàng thành công cho phiếu khám <strong><span style="color: #41B883;">' + this
                .MaPhieuKham + '</span></strong>';
              $('#findCmndModal').modal('show');
            } else {
              this.message = 'Phát sinh số lỗi';
            }
          }).catch(err => {
            this.message = "Có lỗi xảy ra";
            $('#findCmndModal').modal('show');
          })
        }
      }
    },
    mounted() {
      this.isOpen == true ? document.getElementById("bodyContent").style.marginLeft = "300px" : document
        .getElementById("bodyContent").style.marginLeft = "0";
      axios.get(process.env.SERVER_URI + `clinic/loadAllPhieuKham`).then(response => {
        this.phieuKham = response.data;
        //this.label += this.stt;
      })
    },
  }

</script>
