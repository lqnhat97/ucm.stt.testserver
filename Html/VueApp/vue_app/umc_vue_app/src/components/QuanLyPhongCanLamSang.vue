<template>
  <div id="bodyContent">
    <div class="container">
      <div id="cliente" style="background-color: #F8F8F8;position:center">
        <form style=" border-bottom: 2px solid #bbbbbb">
          <div class="row" style="display:flex; align-items: baseline;">
            <div class="col-sm-2" style="text-align:right;"> <label class="control-label" for="chuyenkhoa"
                id="search-name">Chuyên khoa</label>
            </div>
            <div class="col-sm-4">
              <select class="form-control" v-bind:style="{ margin_top:'10%' }" id="chuyenkhoa"
                v-model="selectedChuyenKhoa" @change="handleChangeChuyenKhoa">
                <option :selected="true" disabled>Chọn chuyên khoa</option>
                <option v-for="option in chuyenKhoa" :value="option.IDChuyenKhoa" :key="option.IDChuyenKhoa">
                  {{option.TenChuyenKhoa}}</option>
              </select>
            </div>
            <div class="col-sm-2" style="text-align:right;"> <label class="control-label" for="ngayThang"
                id="search-name">Ngày</label>
            </div>
            <div class="col-sm-3">
              <date-picker valueType="format" :lang='lang' v-model="datetimepicker1" :shortcuts="false"
                format="DD-MM-YYYY">
              </date-picker>
            </div>
          </div>
        </form>
        <form style="padding-bottom:8pt;padding-left:5pt">
          <div class="row">
            <div class="col-sm-5">
              <h3>Quản lý dịch vụ cận lâm sàng</h3>
            </div>
          </div>
        </form>
        <div class="row" style="padding-left:5pt;display:flex;justify-content:space-between">
          <table class="table table-bordered">
            <thead>
              <tr>

                <th>Phòng</th>
                <th>Ca</th>
                <th>Thời gian khám</th>
              </tr>
            </thead>
            <tbody>
              <template v-for="(option,index) in dichVu">
                <tr>
                  <td class="number" :rowspan="option.danhSachDichVu.ca1.ds.length + option.danhSachDichVu.ca2.ds.length + 4">
                    {{option.phong}}</td>
                  <td class="text" :rowspan="option.danhSachDichVu.ca1.ds.length + 2">Ca 1</td>
                  <td class="number"><input v-model="option.danhSachDichVu.ca1.ThoiGianBatDau"> - <input
                      v-model="option.danhSachDichVu.ca1.ThoiGianKetThuc">
                  </td>
                </tr>
                <tr v-for="(singleDichVu,dvDex) in option.danhSachDichVu.ca1.ds">
                  <td ALIGN=CENTER>
                    <select :style="{ width:'30%' }" class="form-control"
                      @change="changeDichVu('ca1',index,$event,dvDex)">
                      <option :selected="true" disabled>Chọn dịch vụ</option>
                      <option v-for="singleDichVu in fetchedDsDichVu" :value="singleDichVu.IDDichVu"
                        :key="'ca1'+index+singleDichVu.IDDichVu">{{singleDichVu.TenDichVu}}</option>
                    </select>

                  </td>
                </tr>

                <tr>
                  <td ALIGN=CENTER><input type="button" class="ThemCLS" value="Thêm dịch vụ"
                      @click="addService('ca1',index)">
                  </td>
                </tr>
                <tr>
                  <td class="text" :rowspan="option.danhSachDichVu.ca2.ds.length + 2">Ca 2</td>
                  <td class="number"><input v-model="option.danhSachDichVu.ca2.ThoiGianBatDau"> - <input
                      v-model="option.danhSachDichVu.ca2.ThoiGianKetThuc">
                  </td>
                </tr>
                <tr v-for="(singleDichVu,dvDex) in option.danhSachDichVu.ca2.ds">
                  <td ALIGN=CENTER>
                    <select :style="{ width:'30%' }" class="form-control"
                      @change="changeDichVu('ca2',index,$event,dvDex)">
                      <option :selected="true" disabled>Chọn dịch vụ</option>
                      <option v-for="singleDichVu in fetchedDsDichVu" :value="singleDichVu.IDDichVu"
                        :key="'ca2'+index+singleDichVu.IDDichVu">{{singleDichVu.TenDichVu}}</option>
                    </select>

                  </td>
                </tr>
                <tr>
                  <td ALIGN=CENTER><input type="button" class="ThemCLS" value="Thêm dịch vụ"
                      @click="addService('ca2',index)">
                  </td>
                </tr>
              </template>
            </tbody>
          </table>

        </div>
        <form action="">
          <div class="row" style="display:flex ; justify-content: space-around">

            <div class="col-sm-4">
              <input class="form-group" id="buttom" type="submit" value="Quy định">
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
  import DatePicker from 'vue2-datepicker'
  import axios from 'axios'
  import modal from './modal.vue'
  export default {
    name: 'QuanLyCanLamSang',
    components: {
      DatePicker
    },
    data() {
      return {
        datetimepicker1: "",
        chuyenKhoa: "",
        selectedChuyenKhoa: "",
        dichVu: [],
        fetchedDsDichVu: "",
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
    props: {
      isOpen: {
        type: Boolean,
        default: false
      }
    },
    created() {
      this.selectedChuyenKhoa = ""
      axios.get(process.env.SERVER_URI + `clinic/dsChuyenKhoaCls`).then(response => {
        this.chuyenKhoa = response.data;
      });
    },
    mounted() {
      this.isOpen == true ? document.getElementById("bodyContent").style.marginLeft = "300px" : document.getElementById(
        "bodyContent").style.marginLeft = "0";
    },
    methods: {
      changeDichVu(ca, phong, event, dvDex) {
        if (ca == 'ca1') {
          this.dichVu[phong].danhSachDichVu.ca1.ds[dvDex].IDDichVu = event.target.value
        } else {
          this.dichVu[phong].danhSachDichVu.ca2.ds[dvDex].IDDichVu = event.target.value
        }
        console.log(this.dichVu);
      },
      handleChangeChuyenKhoa() {
        this.dichVu = [];
        axios.get(process.env.SERVER_URI + `clinic/dsPhongClsTheoChuyenKhoa/` + this.selectedChuyenKhoa).then(
          response => {
            response.data.forEach(element => {
              this.dichVu.push({
                IDPhong: element.IDPhong,
                phong: element.SoPhong,
                danhSachDichVu: {
                  ca1: {
                    ThoiGianBatDau: "7:30",
                    ThoiGianKetThuc: "11:30",
                    ds: [{
                      IDDichVu: "",
                    }]
                  },
                  ca2: {
                    ThoiGianBatDau: "7:30",
                    ThoiGianKetThuc: "11:30",
                    ds: [{
                      IDDichVu: "",
                    }]
                  }
                }
              })
            })
          });
        axios.get(process.env.SERVER_URI + `clinic/dsCls/` + this.selectedChuyenKhoa).then(response => {
          this.fetchedDsDichVu = response.data;
        })
      },
      addService(ca, phong) {
        if (ca == 'ca1') {
          this.dichVu[phong].danhSachDichVu.ca1.ds.push({
            IDDichVu: "",
          })
        } else {
          this.dichVu[phong].danhSachDichVu.ca2.ds.push({
            IDDichVu: "",
          })
        }
      }
    },
  }
</script>