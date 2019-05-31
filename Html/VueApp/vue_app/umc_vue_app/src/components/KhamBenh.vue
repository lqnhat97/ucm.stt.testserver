<template>
  <div id="bodyContent">
    <div class="container">
          <div class="row" id="cliente" >
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
                    <input type="text" value="" class="form-control" v-model="MaPhieuKham" v-text="MaPhieuKham"
                      @change="checkMaPhieuKham">
                    <small v-if="correct" id="passwordHelpBlock" class="form-text text-muted">
                      <div class="small">
                        <span>Có bệnh nhân</span>
                      </div>
                    </small>
                    <small v-if="!correct" id="passwordHelpBlock" class="form-text text-muted">
                      <div class="small">
                        <span>Không có phiếu khám này</span>
                      </div>
                    </small>
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
                  <component v-for="(option,index) in soLuongChiDinh" :key="option.stt" :is="dynamicComponent"
                    :index="index" />
                </div>
                <a id="add" class="col-sm-6" @click="insertNewSubClinical">Thêm chỉ định</a>


                <br><br><br><br>
                <hr />
                <div class="row">
                  <div class="col-sm-4"></div>
                  <div class="col-sm-4">
                    <input class="form-group" id="buttom" type="submit" value="Chỉ định" @click="chiDinhCanLamSang">
                  </div>
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
  export default {
    name: 'KhamBenh',
    components: {
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

    methods: {
      insertNewSubClinical(e) {
        this.soLuongChiDinh.push({
          stt: this.soLuongChiDinh.length + 1
        });
        console.log(this.bodyRequestChiDinh);
      },

      checkMaPhieuKham(e) {
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
      chiDinhCanLamSang(e) {
        e.preventDefault();
        this.bodyRequestChiDinh.idPhieuKham = this.MaPhieuKham;
        axios.post(process.env.SERVER_URI + `clinic/phatSinhCLS`,
          this.bodyRequestChiDinh
        ).then(e => {
          console.log(e);
          if (e.data.hasOwnProperty('CLS') || e.data.hasOwnProperty('XetNghiem')) {
            this.message =
              'Phát sinh số cận lâm sàng thành công cho phiếu khám <strong><span style="color: #41B883;">' + this
              .MaPhieuKham + '</span></strong>';
            $('#findCmndModal').modal('show');
          } else {
            this.message = 'Phát sinh số lỗi';
          }
        })
      }

    },
    mounted() {
      this.isOpen == true ? document.getElementById("bodyContent").style.marginLeft = "300px" : document
        .getElementById("bodyContent").style.marginLeft = "0";
    },
    computed: {
      dynamicComponent: function (parent = this) {
        return {
          template: ` <div class="row form-group">
                <label for="" class="col-sm-5 col-form-label" v-text="label"></label>
                <div class="col-sm-7">
                  <select style ="width:100%" class="form-group form-control" v-model="selectedCanLamSang"
                  @change="selectCLS">
                  <option selected disabled value="0">Chọn dịch vụ</option>
                  <option v-for="option in data" :value="option.LoaiDichVu" :key="option.LoaiDichVu">{{option.TenLoaiDichVu}}</option>
                </select>

                <select style ="width:100%" class="form-group form-control" v-model="selectedDichVu"
                  @change="selectDichVu">
                  <option selected disabled value="0">Chỉ định cận lâm sàng</option>
                  <option v-for="option in dichVu" :value="option.IDDichVu" :key="option.IDDichVu">{{option.TenDichVu}}</option>
                </select>
                </div>              
                <a id="add" class="col-sm-3" style="text-align:left" @click="removeNewSubClinical">Xóa chỉ định</a>
              </div>`,
          data() {
            return {
              selectedCanLamSang: "",
              selectedDichVu: "",
              dichVu: "",
              data: "",
              stt: this.index + 1,
              label: "Chỉ định cận lâm sàng "
            }
          },
          props: {
            index: {
              type: Number,
              default: 0
            }
          },
          created() {
            this.selectedChuyenKhoa = ""
            axios.get(process.env.SERVER_URI + `clinic/dsCls`).then(response => {
              this.data = response.data;
              //this.label += this.stt;
            })
          },
          methods: {
            selectDichVu() {
              parent.bodyRequestChiDinh.idDichVuCls.splice(this.stt - 1, 1, this.selectedDichVu);
            },
            selectCLS() {
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
            removeNewSubClinical() {
              parent.soLuongChiDinh.splice(this.index, 1);
              parent.bodyRequestChiDinh.idDichVuCls.splice(this.index, 1);
            },
          }
        }
      }
    },
  }

</script>
