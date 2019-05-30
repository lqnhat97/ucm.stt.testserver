<template>
  <div class="QuanLyBacSi">
    <Header />
    <Sidebar :currentTab="3" />
    <div class="col-sm-9 ">
      <div class="col-sm-11  form-group" id="cliente" style="background-color: #F8F8F8;position:center">
        <form style=" border-bottom: 2px solid #bbbbbb">
          <div class="row" style="display:flex; align-items: baseline;">
            <div class="col-sm-2" style="text-align:right;"> <label class="control-label" for="chuyenkhoa"
                id="search-name">Chuyên khoa</label>
            </div>
            <div class="col-sm-4">
              <select class="form-control" v-bind:style="{ margin_top:'10%' }" id="chuyenkhoa" placeholder="Chuyên khoa"
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
                format="MM/DD/YYYY">
              </date-picker>
            </div>
          </div>


        </form>
        <form style="padding-bottom:8pt;padding-left:5pt">
          <div class="row">
            <div class="col-sm-5">
              <h3>Quản lý bác sĩ</h3>
            </div>
          </div>
        </form>
        <div class="row" style="padding:5pt;display:flex;justify-content:space-between">
          <table class="table table-bordered">
            <thead>
              <tr>

                <th>Phòng</th>
                <th>Ca</th>
                <th>Bàn</th>
                <th>Bác sĩ</th>
              </tr>
            </thead>
            <tbody>
              <template v-for="(option,index) in soLuongPhong">
                <tr :key="index+'ca1'+option.thongTin[0].SoBan">
                  <td class="number" :rowspan="option.thongTin.length*2">{{option.phongKham}} <button
                      style="margin:10%;" class="btn-danger" :click="huyLichTheoPhong(index)">X</button></td>
                  <td class="text" id="Ca" :rowspan="option.thongTin.length">Ca 1 <button style="margin:10%;"
                      class="btn-danger" :click="huyLichTheoCa('ca1',index)">X</button></td>
                  <td class="number">{{option.thongTin[0].SoBan}} <button style="margin:10%;" class="btn-danger"
                      :click="huyLichTheoBan('ca2',option.thongTin[0].IDBan,index)">X</button></td>
                  <td class="text" id="BacSi"><select>
                      <option v-for="singleBacSi in soLuongBacSi" :value="singleBacSi.IDBacSi"
                        :key="singleBacSi.IDBacSi+'ca1'+option.thongTin[0].SoBan">
                        {{singleBacSi.HovaTen}}</option>
                    </select></td>

                </tr>
                <tr v-for="singleBan in soLuongBan[index]" :key="index+'ca1'+singleBan.SoBan">
                  <td class="number">{{singleBan.SoBan}} <button style="margin:10%;" class="btn-danger"
                      :click="huyLichTheoBan('ca1',singleBan.IDBan,index)">X</button>
                  </td>
                  <td class="text" id="BacSi"><select>
                      <option v-for="singleBacSi in soLuongBacSi" :value="singleBacSi.IDBacSi"
                        :key="singleBacSi.IDBacSi+'ca1'+singleBan.SoBan">
                        {{singleBacSi.HovaTen}}</option>
                    </select></td>
                </tr>
                <tr :key="index+'ca2'+option.thongTin[0].SoBan">
                  <td class="text" id="Ca" :rowspan="option.thongTin.length">Ca 2 <button style="margin:10%;"
                      class="btn-danger" :click="huyLichTheoCa('ca2',index)">X</button></td>
                  <td class="number">{{option.thongTin[0].SoBan}} <button style="margin:10%;" class="btn-danger"
                      :click="huyLichTheoBan('ca2',option.thongTin[0].IDBan,index)">X</button></td>

                  <td class="text"><select>
                      <option v-for="singleBacSi in soLuongBacSi" :value="singleBacSi.IDBacSi"
                        :key="singleBacSi.IDBacSi+'ca2'+option.thongTin[0].SoBan">
                        {{singleBacSi.HovaTen}}</option>

                    </select></td>
                </tr>

                <tr v-for="singleBan in soLuongBan[index]" :key="index+'ca2'+singleBan.SoBan">
                  <td class="number">{{singleBan.SoBan}} <button style="margin:10%;" class="btn-danger"
                      :click="huyLichTheoBan('ca2',singleBan.IDBan,index)">X</button>
                  </td>
                  <td class="text" id="BacSi"><select>
                      <option v-for="singleBacSi in soLuongBacSi" :value="singleBacSi.IDBacSi"
                        :key="singleBacSi.IDBacSi+'ca2'+singleBan.SoBan">
                        {{singleBacSi.HovaTen}}</option>

                    </select></td>
                </tr>

              </template>
            </tbody>
          </table>

        </div>
        <form action="">
          <div class="form-group">
            <label for="excelInput">Chọn file excel</label>
            <input type="file" class="form-control-file" id="exampleFormControlFile1">
          </div>
          <div class="row" style="display:flex ; justify-content: space-around">

            <div class="col-sm-4">
              <input class="form-group" id="buttom" type="submit" :click="quyDinh" value="Quy định">
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
  import Header from './Header.vue'
  import Sidebar from './Sidebar.vue'
  import modal from './modal.vue'
  export default {
    name: 'QuanLyBacSi',
    components: {
      Header,
      Sidebar,
      DatePicker
    },
    data() {
      return {
        selectedChuyenKhoa: "",
        chuyenKhoa: "",
        datetimepicker1: "",
        soLuongPhong: "",
        soLuongBan: [],
        soLuongBacSi: [],
        bodyRequest: [],
        lang: {
          days: ['Chủ nhật', 'Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy'],
          months: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9',
            'Tháng 10', 'Tháng 11', 'Tháng 12'
          ],
          pickers: ['next 7 days', 'next 30 days', 'previous 7 days', 'previous 30 days'],
          placeholder: {
            date: 'Chọn ngày',
            dateRange: 'Chọn khoảng ngày'
          }
        },
      }
    },
    created(e) {
      this.selectedChuyenKhoa = ""
      axios.get(process.env.SERVER_URI + `clinic/dsChuyenKhoa`).then(response => {
        this.chuyenKhoa = response.data;
      });

    },
    methods: {
      handleChangeChuyenKhoa() {
        this.soLuongBan = [];
        axios.get(process.env.SERVER_URI + `clinic/dspkbkTheoChuyenKhoa/` + this.selectedChuyenKhoa).then(response => {
          this.soLuongPhong = response.data;
          this.soLuongPhong.forEach(element => {
            element.thongTin.forEach(item => {
              this.bodyRequest.push({
                Ngay: this.datetimepicker1,
                Phong: item.IDPhong,
                Ca: 1,
                Ban: item.IDBan,
                BacSi: "",
              })
            })
          })
          this.soLuongPhong.forEach(element => {
            element.thongTin.forEach(item => {
              this.bodyRequest.push({
                Ngay: this.datetimepicker1,
                Phong: item.IDPhong,
                Ca: 2,
                Ban: item.IDBan,
                BacSi: "",
              })
            })
          })
          this.soLuongPhong.forEach(element => {
            this.soLuongBan.push(element.thongTin.filter((value, index) => {
              return index > 0;
            }));

          });
        })
        axios.get(process.env.SERVER_URI + `clinic/dsBsTheoChuyenKhoa/` + this.selectedChuyenKhoa).then(response => {
          this.soLuongBacSi = response.data;
        })
        console.log(this.bodyRequest);
      },
      quyDinh() {

      },
      huyLichTheoBan(ca, ban, phong) {

      },
      huyLichTheoCa(ca, phong) {

      },
      huyLichTheoPhong(phong) {

      }
    }
  }

</script>
