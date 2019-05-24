<template>
  <div class="KhamBenh">
    <Header />
    <Sidebar :currentTab="2" />
    <div class="col-md-9 form-group">
      <div class="row">
        <div class="col-sm-5" id="cliente">
          <form action="" style=" border-bottom: 2px solid #bbbbbb">
            <p>Thông tin bệnh nhân</p>
            <div class="row form-group">
              <label for="" class="col-sm-3 col-form-label">Họ và tên</label>
              <div class="col-sm-9">
                <input type="text" value="" class="form-control" v-model="HoVaTen" v-text="HoVaTen" disabled>
              </div>

            </div>
            <div class="row form-group">
              <label for="" class="col-sm-3 col-form-label" style="text-align:left">Giới
                tính</label>
              <div class="col-sm-3">
                <input type="text" value="" class="form-control" style="margin-right: 10px;" v-model="GioiTinh"
                  v-text="GioiTinh" disabled>
              </div>
            </div>
            <div class="row form-group">
              <label for="" class="col-sm-3 col-form-label">Ngày sinh</label>
              <div class="col-sm-5">
                <input type="text" value="" class="form-control" v-model="NgaySinh" v-text="NgaySinh" disabled>
              </div>

            </div>

            <div class="row form-group">
              <label for="" class="col-sm-3 col-form-label">Quê quán</label>
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
              <label for="" class="col-sm-3 col-form-label">Địa chỉ</label>
              <div class="col-sm-9">
                <input type="text" value="" class="form-control" v-model="DiaChi" v-text="DiaChi" disabled>
              </div>
            </div>

            <div class="row form-group">
              <label for="" class="col-sm-3 col-form-label">Nghề nghiệp</label>
              <div class="col-sm-9">
                <input type="text" value="" class="form-control" v-model="NgheNghiep" v-text="NgheNghiep" disabled>
              </div>

            </div>
            <div class="row form-group">
              <label for="" class="col-sm-3 col-form-label" style="text-align:left">Số điện
                thoại</label>
              <div class="col-sm-9">
                <input type="text" value="" class="form-control" v-model="SoDienThoai" v-text="SoDienThoai" disabled>
              </div>
            </div>


          </form>
        </div>
        <div class="col-sm-6" id="cliente">
          <form style=" border-bottom: 2px solid #bbbbbb; padding:10pt">
            <p>Phiếu khám và chỉ định</p>
          </form>
          <div>
            <form action="" style="margin-top: 10px">
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label">Mã phiếu khám</label>
                <div class="col-sm-3">
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
                <label for="" class="col-sm-3 col-form-label">Triệu chứng</label>
                <div class="col-sm-9">
                  <input type="text" value="" class="form-control">
                </div>
              </div>
              <hr color="black" />

              <div id="chiDinhCanLamSang">
                <component v-for="(option,index) in soLuongChiDinh" :key="option.stt" :is="dynamicComponent" :index="index"/>
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
              <!-- <div class="small">
                                    <span>Tổng cộng</span>
                                    <span>450.000 VNĐ</span>
                                </div>
                                <hr />
                                <div class="row">
                                    <label for="" class="col-sm-9 col-form-label">Số tài khoản</label>
                                    <label for="" class="col-sm-3 col-form-label">Tình trạng</label>
                                </div>
                                <div class="row" style="margin-bottom:10px;">
                                    <div class="col-sm-9"><input type="text" value="" class="form-control"></div>
                                    <div class="col-sm-3"><small id="passwordHelpInline" class="text-muted"><span
                                                style="color: rgb(9, 173, 214); text-align: right">Số dư
                                                đủ</span></small></div>
                                </div> -->
            </form>

          </div>
        </div>

      </div>
    </div>


    <!-- Modal -->
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
    </div>

  </div>


</template>

<script>
  import axios from 'axios'
  import Header from './Header.vue'
  import Sidebar from './Sidebar.vue'
  export default {
    name: 'KhamBenh',
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
          IDPhieuKham: "",
          CLS: []
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
        })
      },

      checkMaPhieuKham(e) {
        axios.get(`http://192.168.1.11:8088/clinic/checkPK/` + this.MaPhieuKham).then(response => {
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
        this.bodyRequestChiDinh.IDPhieuKham = this.MaPhieuKham;
        axios.post(`http://192.168.1.11:8088/clinic/phatSinhCLS`,
          this.bodyRequestChiDinh
        ).then(e => {
          if (e.status === 200) {
            this.message = "Đã sinh số thành công";
            $('#findCmndModal').modal('show');
          }
        })
      }

    },
    computed: {
      dynamicComponent: function (parent = this) {
        return {
          template: ` <div class="row form-group">
                <label for="" class="col-sm-5 col-form-label" v-text="label"> </label>
                <div class="col-sm-7">
                  <select style ="width:100%" class="browser-default custom-select-lg form-group" v-model="selectedCanLamSang"
                  @change="selectCLS">
                  <option selected disabled>Chọn chuyên khoa</option>
                  <option v-for="option in data" :value="option.IDDichVu" :key="option.IDDichVu">{{option.TenDichVu}}</option>
                </select>
                </div>
                <a id="add" class="col-sm-6" style="text-align:right" @click="removeNewSubClinical">Xóa chỉ định</a>
              </div>`,
          data() {
            return {
              selectedCanLamSang: "",
              data: "",
              stt: this.index+1,
              label: "Chỉ định cận lâm sàng "
            }
          },
          props:{
            index:{
              type:Number,
              default: 0
            }
          },
          created() {
            this.selectedChuyenKhoa = ""
            axios.get(`http://192.168.1.11:8088/clinic/loadCLS`).then(response => {
              this.data = response.data;
              //this.label += this.stt;
            })
          },
          methods: {
            selectCLS() {
              parent.bodyRequestChiDinh.CLS.splice(this.stt - 1, 1, {
                idCLS: this.selectedCanLamSang
              });
            },
            removeNewSubClinical() {
              parent.soLuongChiDinh.splice(this.index,1);
              parent.bodyRequestChiDinh.CLS.splice(this.index , 1);
            },
          }
        }
      }
    },
  }
</script>