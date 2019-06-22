<template>
  <div id="bodyContent">
    <div class="container">
      <div id="cliente" style="background-color: #F8F8F8;position:center">
        <div class="row">
          <div class="col-sm-2" style="text-align:right"> <label class="control-label" for="chuyenkhoa"
              id="search-name">Chuyên
              khoa</label>
          </div>
          <div class="col-sm-4">
            <select v-bind:style="{ margin_top:'10%' }" id="chuyenkhoa" class="form-control" placeholder="Chuyên khoa"
              v-model="selectedChuyenKhoa" @change="handleChangeChuyenKhoa">
              <option :selected="true" disabled>Chọn chuyên khoa cận lâm sàng</option>
              <option v-for="option in chuyenKhoa" :value="option.IDChuyenKhoa" :key="option.IDChuyenKhoa">
                {{option.TenChuyenKhoa}}</option>
            </select>
          </div>
          <div class="col-sm-2" style="text-align:right"> <label for="sophong" id="search-name">Phòng</label>
          </div>
          <div class="col-sm-4">
            <select v-bind:style="{ margin_top:'10%' }" id="dichVu" class="form-control" placeholder="Chuyên khoa"
              v-model="selectedPhong" @change="handleChangePhong">
              <option :selected="true" disabled value="">Chọn phòng</option>
              <option v-for="(option,index) in dsPhong" :value="option.IDPhong" :key="index">
                {{option.SoPhong}}</option>
            </select>
          </div>

        </div>

        <div class="row" id="tbCls">
          <div class="col-sm-5">
            <h3>Chi tiết dịch vụ cận lâm sàng</h3>
          </div>
        </div>
        <div class="row " style="padding-left:5pt;display:flex;justify-content:space-between">
          <template v-if='selectedPhong != ""'>
            <table class="table">
              <thead>
                <tr>
                  <th>Phòng</th>
                  <th>Số hiện tại</th>
                  <th>Số cuối</th>
                  <th>Bệnh nhân hiện tại</th>
                  <th>Thao tác</th>
                  <th>Tình trạng</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="number">{{cls.SoPhong}}</td>
                  <td class="number">{{cls.STTHienTai}}</td>
                  <td class="number">{{cls.STTCuoi}}</td>
                  <td>{{cls.BenhNhan==null?"Không có bệnh nhân":cls.BenhNhan}}</td>
                  <template v-if="cls.STTHienTai!=cls.STTCuoi">
                    <td class="number"><button @click="nextNumber" class="btn btn-success">+</button></td>
                    <td class="number">
                      <div class="checkbox form-control-lg"><label><input type="checkbox" @change="handleChangeCheckbox"
                            value="">Khám </label></div>
                    </td>
                  </template>
                  <template v-else>
                    <td class="number">Không thể thao tác</td>
                    <td class="number">Không thể thao tác</td>
                  </template>>
                </tr>
              </tbody>
            </table>
          </template>
          <h3 v-else>Vui lòng chọn phòng</h3>
          <modal :message="this.message" />
        </div>
      </div>
    </div>
  </div>

</template>

<script>
  import axios from 'axios'
  import modal from './modal.vue'
  export default {
    name: 'ChiTietPhongKham',
    components: {
      modal
    },
    data() {
      return {
        chuyenKhoa: "",
        selectedChuyenKhoa: "",
        selectedPhong: "",
        dsPhong: "",
        cls: "",
        isXetNghiem: false,
        khoangSoXetNghiem: "",
        message: "aaaa"
      }
    },
    props: {
      isOpen: {
        type: Boolean,
        default: false
      }
    },
    created() {
      axios.get(process.env.SERVER_URI + `clinic/dsChuyenKhoaClsCoLich`).then(res => {
        this.chuyenKhoa = res.data;
      })
    },
    mounted() {
      this.isOpen == true ? document.getElementById("bodyContent").style.marginLeft = "300px" : document.getElementById(
        "bodyContent").style.marginLeft = "0";
    },
    methods: {
      handleChangeChuyenKhoa() {
        axios.get(process.env.SERVER_URI + `clinic/dsPhongClsTheoChuyenKhoa/` + this.selectedChuyenKhoa).then(res => {
          this.dsPhong = res.data.filter(value=>{
            return value.CaKham ===1;
          });
          this.isXetNghiem = false;
          this.selectedPhong = "";
          this.cls = "";
        })
      },
      handleChangePhong() {
        axios.get(process.env.SERVER_URI + `clinic/thongTinClsTheoPhong/` + this.selectedPhong).then(res => {
          if (this.selectedPhong != "") {
            this.cls = res.data;
            if (!this.cls.hasOwnProperty('STTHienTai')) {
              this.cls.STTHienTai = (this.cls.STTHientai - this.cls.STTHientai % this.cls.SoNhay + 1) + " -> " + (
                this.cls
                .STTHientai - this.cls.STTHientai % this.cls.SoNhay + this.cls.SoNhay);
              this.isXetNghiem = true;
              this.khoangSoXetNghiem = Math.floor(this.cls.STTHientai / this.cls.SoNhay);
            }
          }
        })
      },
      nextNumber() {
        axios.post(process.env.SERVER_URI + `clinic/soKeTiepCanLamSang`, {
          idPhong: this.cls.IDPhong,
          isXetNghiem: this.isXetNghiem
        }).then(response => {
          if (response.status == 200) {
            console.log(response.data);
            if (this.isXetNghiem) {
              if (this.khoangSoXetNghiem == Math.floor(response.data.STTCuoi / 10))
                this.message = 'Qua số xét nghiệm không thành công';
              else
                this.message = 'Qua số xét nghiệm thành công';

            } else {

              this.message = 'Qua số cận lâm sàng thành công';
            }
            $('#findCmndModal').modal('show');
            this.handleChangePhong();
            $mount('#tbCls');

            //this.soLuongBan = parent.soPhong[this.index].thongTin;
          };
        })
      },
      handleChangeCheckbox() {
        axios.post(process.env.SERVER_URI + `clinic/checkBenhNhanDangKhamCls`, {
          idPhongKham: this.cls.IDPhong,
          CaKham: this.cls.CaKham,
          stt: this.cls.STTHienTai
        })
      }
    }
  }

</script>
