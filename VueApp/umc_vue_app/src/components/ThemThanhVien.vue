<template>
  <div id="bodyContent">
    <div class="container">
      <div class="form-group">
        <div class="row">
          <div class="col-sm-6" id="cliente-left">
            <form action="" style=" border-bottom: 2px solid #bbbbbb">
              <p>Thêm bác sĩ</p>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Họ và tên</label>
                <div class="col-sm-9">
                  <input type="text" value="" class="form-control" v-model="HoVaTen" v-text="HoVaTen">
                </div>

              </div>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Giới
                  tính</label>
                <div class="col-sm-4">
                  <select type="text" class="form-control" v-model="GioiTinh">
                    <option value="Nam">Nam</option>
                    <option value="Nữ">Nữ</option>
                  </select>
                </div>
              </div>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Ngày sinh</label>
                <div class="col-sm-4">
                  <date-picker style="width:100%" valueType="format" :lang='lang' :placeholder="NgaySinh"
                    v-model="NgaySinh" :shortcuts="false" format="MM/DD/YYYY">
                  </date-picker>
                </div>
              </div>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Quê quán</label>
                <div class="col-sm-9">
                  <input type="text" value="" class="form-control" v-model="QueQuan" v-text="QueQuan">
                </div>

              </div>

              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Chuyên khoa</label>
                <div class="col-sm-5">
                  <input type="text" value="" class="form-control">
                </div>
              </div>
              <div style="display:flex;justify-content:center">
                <input class="form-group" id="buttom" type="submit" value="Thêm bác sĩ" style="width:30%">
              </div>
            </form>
          </div>
          <div class="col-sm-6" id="cliente-left">
            <form action="" style=" border-bottom: 2px solid #bbbbbb">
              <p>Thêm nhân viên</p>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Họ và tên</label>
                <div class="col-sm-9">
                  <input type="text" value="" class="form-control" v-model="HoVaTen" v-text="HoVaTenNv">
                </div>0

              </div>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">CMND/CCCD</label>
                <div class="col-sm-3">
                  <input type="text" value="" class="form-control" style="margin-right: 10px;" v-model="cmnd"
                    v-text="GioiTinh">
                </div>
              </div>
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Phân hệ</label>
                <div class="col-sm-9">
                  <input type="text" value="" class="form-control" >
                </div>
              </div>
              <div style="display:flex;justify-content:center">
                <input class="form-group" id="buttom" type="submit" value="Thêm nhân viên" style="width:30%">
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
        HoVaTenNv:"",
        GioiTinh: "",
        NgaySinh: "",
        QueQuan: "",        
        chuyenKhoa:"",
        message: "",
      }
    },
  }

</script>
