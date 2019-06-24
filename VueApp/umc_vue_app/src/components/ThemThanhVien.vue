<template>
  <div id="bodyContent">
    <div class="container">
      <div class="form-group">
        <div class="row">
          <div class="col-sm-6" id="cliente-left">
            <form  @submit="themBacSi">
              <p>Thêm bác sĩ</p>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Họ và tên</label>
                <div class="col-sm-7">
                  <input type="text" value="" class="form-control" v-model="HoVaTen" v-text="HoVaTen" required>
                </div>

              </div>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Giới
                  tính</label>
                <div class="col-sm-4">
                  <select type="text" class="form-control" v-model="GioiTinh" required>
                    <option value="Nam">Nam</option>
                    <option value="Nữ">Nữ</option>
                  </select>
                </div>
              </div>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Ngày sinh</label>
                <div class="col-sm-4">
                  <date-picker style="width:100%" valueType="format" :lang='lang' :placeholder="NgaySinh" required
                    v-model="NgaySinh" :shortcuts="false" format="MM/DD/YYYY">
                  </date-picker>
                </div>
              </div>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Quê quán</label>
                <div class="col-sm-7">
                  <input type="text" value="" class="form-control" v-model="QueQuan" v-text="QueQuan" required>
                </div>

              </div>

              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Chuyên khoa</label>
                <div class="col-sm-4">
                  <select class="form-control" v-bind:style="{ margin_top:'10%' }" id="chuyenkhoa" required
                    v-model="selectedChuyenKhoa">
                    <option :selected="true" value="" disabled>Chọn chuyên khoa</option>
                    <option v-for="option in dsChuyenKhoa" :value="option.IDChuyenKhoa" :key="option.IDChuyenKhoa">
                      {{option.TenChuyenKhoa}}</option>
                  </select>
                </div>
              </div>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Thời gian khám trung bình</label>
                <div class="col-sm-4">
                  <div class="form-group"><input class="form-control" type="text"
                  pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]" v-model="ThoiGianTBmin"></div>
                </div>
              </div>
              <div style="display:flex;justify-content:center;border-top: 2px solid #bbbbbb">
                <input class="form-group btn btn-success" type="submit" value="Thêm bác sĩ" style="margin:15px 0px 15px;width:30%">
              </div>
            </form>
          </div>
          <div class="col-sm-6" id="cliente-left">
            <form @submit="themChuyenVien">
              <p>Thêm nhân viên</p>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Họ và tên</label>
                <div class="col-sm-7">
                  <input type="text" value="" class="form-control" v-model="HoVaTenNv" v-text="HoVaTenNv" required>
                </div>
              </div>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">CMND/CCCD</label>
                <div class="col-sm-3">
                  <input type="text" value="" class="form-control" style="margin-right: 10px;" v-model="cmnd" required>
                </div>
              </div>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Phân hệ</label>
                <div class="col-sm-7">
                  <select class="form-control" v-bind:style="{ margin_top:'10%' }" required
                    v-model="selectedPhanHe">
                    <option :selected="true" value="" disabled>Chọn phân hệ</option>
                    <option v-for="option in dsPhanHe" :value="option.IDPhanHe" :key="option.IDPhanHe">
                      {{option.TenPhanHe}}</option>
                  </select>
                </div>
              </div>
              <div style="display:flex;justify-content:center;border-top: 2px solid #bbbbbb">
                <input class="form-group btn btn-success" type="submit" value="Thêm nhân viên" style="margin:15px 0px 15px;width:30%">
              </div>
            </form>
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
  import DatePicker from 'vue2-datepicker'
  export default {
    name: 'KhamBenh',
    components: {
      modal,
      DatePicker
    },
    props: {
      isOpen: {
        type: Boolean,
        default: false
      }
    },
    data() {
      return {
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
        },
        cmnd: "",
        HoVaTen: "",
        HoVaTenNv: "",
        GioiTinh: "",
        NgaySinh: "",
        QueQuan: "",
        chuyenKhoa: "",
        message: "",
        selectedChuyenKhoa:"",
        selectedPhanHe:"",
        dsChuyenKhoa:"",
        ThoiGianTBmin:"",
        dsPhanHe:""
      }
    },
    props: {
      isOpen: {
        type: Boolean,
        default: false
      }
    },
    created(){
      axios.get(process.env.SERVER_URI + `clinic/dsChuyenKhoa`).then((res)=>{
        this.dsChuyenKhoa = res.data;
      });
      axios.get(process.env.SERVER_URI + `clinic/showPhanHeCls`).then((res)=>{
        this.dsPhanHe = res.data;
      })
    },
    mounted(){
      this.isOpen==true?document.getElementById("bodyContent").style.marginLeft = "300px":document.getElementById("bodyContent").style.marginLeft = "0";
    },
    methods: {
      themBacSi(e) {
        e.preventDefault();
        axios.post(process.env.SERVER_URI + `clinic/themBacSi`, {
          HovaTen: this.HoVaTen,
          GioiTinh: this.GioiTinh,
          NamSinh: new Date(this.NgaySinh).getFullYear(),
          QueQuan: this.QueQuan,
          ChuyenKhoa: this.selectedChuyenKhoa,
          ThoiGianTBmin: this.ThoiGianTBmin,
        }).then(res=>{
          this.message ="Tạo thông tin bác sĩ thành công"
          $('#findCmndModal').modal('show');
          this.clearText();
        }).catch(err=>{
          this.message = err;
          $('#findCmndModal').modal('show');
        })
      },
      themChuyenVien(e){
        e.preventDefault();
        axios.post(process.env.SERVER_URI + `clinic/themNhanVien`, {
          HovaTen: this.HoVaTenNv,
          CMND_CCCD: this.cmnd,
          PhanHe: this.selectedPhanHe
        }).then(res=>{
          this.message ="Tạo thông tin nhân viên thành công"
          $('#findCmndModal').modal('show');
          this.clearText();
        }).catch(err=>{
          this.message = err;
          $('#findCmndModal').modal('show');
        })
      },
      clearText(){
        this.cmnd= "",
        this.HoVaTen= "",
        this.HoVaTenNv= "",
        this.GioiTinh= "",
        this.NgaySinh= "",
        this.QueQuan= "",
        this.selectedChuyenKhoa="",
        this.dsChuyenKhoa="",
        this.ThoiGianTBmin="",
        this.selectedPhanHe=""
      }
    }
  }

</script>
