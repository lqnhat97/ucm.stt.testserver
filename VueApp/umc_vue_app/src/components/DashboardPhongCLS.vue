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

        <div class="row" id="dashBoardCls">
          <div class="col-sm-5">
            <h3>Màn hình hiển thị phòng cận lâm sàng</h3>
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
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="number">{{cls.SoPhong}}</td>
                  <td class="number">{{cls.STTHienTai}}</td>
                  <td class="number">{{cls.STTCuoi}}</td>
                  <td>{{cls.BenhNhan==null?"Không có bệnh nhân":cls.BenhNhan}}</td>                  
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
    name: 'DashboardCls',
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
            return value.CaKham == 1;
          });
          this.isXetNghiem = false;
          this.selectedPhong = "";
          this.cls = "";
        })
      },
      handleChangePhong() {
        clearInterval(this.interval);
        if (this.selectedChuyenKhoa != '') {
          this.interval = setInterval(() => {
            axios.get(process.env.SERVER_URI + `clinic/thongTinClsTheoPhong/` + this.selectedPhong).then(res => {
              if (this.selectedPhong != "") {
                this.cls = res.data;
                if (!this.cls.hasOwnProperty('STTHienTai')) {
                  this.cls.STTHienTai = (this.cls.STTHientai - this.cls.STTHientai % this.cls.SoNhay + 1) +
                    " -> " + (
                      this.cls
                      .STTHientai - this.cls.STTHientai % this.cls.SoNhay + this.cls.SoNhay);
                  this.isXetNghiem = true;
                  this.khoangSoXetNghiem = Math.floor(this.cls.STTHientai / this.cls.SoNhay);
                }
              }
            })
          }, 2000);
          this.$mount('#dashBoardCls');
        }
      },
    }
  }

</script>
