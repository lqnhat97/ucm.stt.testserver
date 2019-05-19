<template>
  <div class="ChiTietPhongKham">
    <Header />
    <Sidebar />

    <div class="col-sm-9 ">
      <div class="col-sm-11  form-group" id="cliente" style="background-color: #F8F8F8;position:center">
        <form style=" border-bottom: 2px solid #bbbbbb">
          <div class="row" style="padding:5pt">
            <div class="col-sm-2"> <label class="control-label" for="chuyenkhoa"
                style="color:#969696;padding:8pt;margin-left: 3pt">Chuyên khoa</label></div>
            <select v-bind:style="{ margin_top:'10%' }" id="chuyenkhoa" class="form-control" placeholder="Chuyên khoa"
              v-model="selectedChuyenKhoa" @change="handleChangeChuyenKhoa">
              <option :selected="true" disabled>Chọn chuyên khoa</option>
              <option v-for="option in chuyenKhoa" :value="option.IDChuyenKhoa" :key="option.IDChuyenKhoa">
                {{option.TenChuyenKhoa}}</option>
            </select>
            <div class="col-sm-2"> <label for="sophong" style="color:#969696;padding:8pt;margin-left: 15pt">Số
                phòng</label></div>
    
              <select v-bind:style="{ margin_top:'10%' }" id="chuyenkhoa" class="form-control" placeholder="Chuyên khoa"
                v-model="selectedPhongKham" @change="handleChangeSoPhong">
                <option :selected="true" disabled>Chọn số phòng</option>
                <option v-for="option in soPhong" :value="option.SoBan" :key="option.SoBan">
                  {{option.SoBan}}</option>
              </select>
          </div>
        </form>
        <form style="padding-bottom:8pt;padding-left:5pt">
          <div class="row" style="margin-top:1pt;margin-left:10pt">
            <h3>Thống kê chi tiết phòng khám</h3>
          </div>
        </form>

        <div class="row " style="flex-wrap: wrap;padding-left:5pt;display:flex;justify-content:space-evenly">
          <div class="col-sm-5" style="background-color: white;   box-shadow:1px 1px 1px;">
            <div class="row" style="border-bottom: 2pt solid #bbbbbb">
              <h3 style="display:inline-block;margin:10pt; color:rgb(9, 173, 214)">Phòng khám</h3>
              <h3 style="display:inline-block; margin:10pt;color:#67cf9c">102</h3>
            </div>
            <table class="table">
              <thead>
                <tr>
                  <th>Bàn</th>
                  <th>Số còn chờ</th>
                  <th>Tốc độ nhảy số</th>
                  <th>Thời gian khám số cuối</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="number">1</td>
                  <td class="number">10</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">2</td>
                  <td class="number">7</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">3</td>
                  <td class="number">8</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">4</td>
                  <td class="number">9</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">5</td>
                  <td class="number">10</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">6</td>
                  <td class="number">11</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">7</td>
                  <td class="number">6</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
              </tbody>
            </table>
          </div>

          <div class="col-sm-5" style="background-color: white;box-shadow:1px 1px 1px; ">
            <div class="row" style="border-bottom: 2pt solid #bbbbbb">
              <h3 style="display:inline-block;margin:10pt; color:rgb(9, 173, 214)">Phòng khám</h3>
              <h3 style="display:inline-block; margin:10pt;color:#67cf9c">103</h3>
            </div>
            <table class="table">
              <thead>
                <tr>
                  <th>Bàn</th>
                  <th>Số còn chờ</th>
                  <th>Tốc độ nhảy số</th>
                  <th>Thời gian khám số cuối</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="number">1</td>
                  <td class="number">10</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">2</td>
                  <td class="number">7</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">3</td>
                  <td class="number">8</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">4</td>
                  <td class="number">9</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">5</td>
                  <td class="number">10</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">6</td>
                  <td class="number">11</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">7</td>
                  <td class="number">6</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="row " style="padding-left:5pt;display:flex;justify-content:space-between ; padding-top:10pt">
          <div class="col-sm-5" style="background-color: white;   box-shadow:1px 1px 1px;">
            <div class="row" style="border-bottom: 2pt solid #bbbbbb">
              <h3 style="display:inline-block;margin:10pt; color:rgb(9, 173, 214)">Phòng khám</h3>
              <h3 style="display:inline-block; margin:10pt;color:#67cf9c">104</h3>
            </div>
            <table class="table">
              <thead>
                <tr>
                  <th>Bàn</th>
                  <th>Số còn chờ</th>
                  <th>Tốc độ nhảy số</th>
                  <th>Thời gian khám số cuối</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="number">1</td>
                  <td class="number">10</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">2</td>
                  <td class="number">7</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">3</td>
                  <td class="number">8</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">4</td>
                  <td class="number">9</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">5</td>
                  <td class="number">10</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">6</td>
                  <td class="number">11</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">7</td>
                  <td class="number">6</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
              </tbody>
            </table>
          </div>

          <div class="col-sm-5" style="background-color: white;box-shadow:1px 1px 1px ">
            <div class="row" style="border-bottom: 2pt solid #bbbbbb">
              <h3 style="display:inline-block;margin:10pt; color:rgb(9, 173, 214)">Phòng khám</h3>
              <h3 style="display:inline-block; margin:10pt;color:#67cf9c">105</h3>
            </div>
            <table class="table">
              <thead>
                <tr>
                  <th>Bàn</th>
                  <th>Số còn chờ</th>
                  <th>Tốc độ nhảy số</th>
                  <th>Thời gian khám số cuối</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="number">1</td>
                  <td class="number">10</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">2</td>
                  <td class="number">7</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">3</td>
                  <td class="number">8</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">4</td>
                  <td class="number">9</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">5</td>
                  <td class="number">10</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">6</td>
                  <td class="number">11</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
                <tr>
                  <td class="number">7</td>
                  <td class="number">6</td>
                  <td>5 phút</td>
                  <td>6 phút 43 giây</td>
                </tr>
              </tbody>
            </table>
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
    name: 'ChiTietPhongKham',
    components: {
      Header,
      Sidebar
    },
    data(){
      return{
        chuyenKhoa: "",
        selectedChuyenKhoa: "",
        selectedPhongKham: "",
        soPhong: "",
      }
    },
    methods:{
      handleChangeChuyenKhoa(e){
         axios.get(`http://localhost:8088/clinic/tinhTrangConChoTheoChuyenKhoa/` + this.selectedChuyenKhoa).then(
          response => {
            console.log(response.data);
            this.soPhong = response.data;
            this.soLuongPhong  = response.data  ;
           
          })
      },
      handleChangeSoPhong(){
        this.soPhong = this.soLuongPhong.filter(value=>{
            return value.phongKham === this.selectedPhongKham
          })
          if(this.selectedPhongKham === "tatCa"){
             this.soPhong = this.soLuongPhong;
          }
          
      }
    },
    created() {
      this.selectedChuyenKhoa = ""
      axios.get(`http://localhost:8088/clinic/dsChuyenKhoa`).then(response => {
        this.chuyenKhoa = response.data;
      })
    }
  }
</script>