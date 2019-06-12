<template>
  <div id="bodyContent">
    <div class="container">
      <div id="cliente" style="background-color: #F8F8F8;position:center">
        <form style="padding-bottom:8pt;padding-left:5pt">
          <form style=" border-bottom: 2px solid #bbbbbb">
            <div class="row" style="display:flex; align-items: baseline;">
              <div class="col-sm-2" style="text-align:right;"> <label class="control-label" for="dashboard"
                  id="search-name">Chọn loại phòng</label>
              </div>
              <div class="col-sm-4">
                <select class="form-control" v-bind:style="{ margin_top:'10%' }" id="dashboard"
                  v-model="selectedDashboard" @change="handleChangeDashboard($event)">
                  <option value="" disabled>Chọn loại phòng</option>
                  <option value="canLamSang">Cận lâm sàng</option>
                  <option value="lamSang">Lâm sàng</option>
                  <option value="xetNghiem">Xét nghiệm</option>
                </select>
              </div>
            </div>
          </form>

          <div class="row">
            <div class="col-sm-4">
              <h3>Dashboard</h3>
            </div>
          </div>
          <div id="roomType">

            <template v-if="selectedDashboard=='lamSang'">
              <div v-for="(option, index) in dsLs" style="" :key="index">
                <div style="padding-bottom:8pt;padding-left:5pt">
                  <div class="row" style="margin-top:1pt; display:flex;justify-content:space-between">
                    <h3>{{option.khuVuc}}</h3>
                  </div>
                </div>
                <div class="row "
                  style="padding-left:5pt;display:flex;justify-content:center; padding-top:10pt;flex-wrap: wrap;background-color: white;">
                  <div class="col-sm-6" v-for="(thongTin, index) in option.thongTin" :key="index"
                    style="margin-bottom:10pt">
                    <div style="border-bottom: 1pt solid #bbbbbb; display:flex;justify-content:start;">
                      <div>
                        <h3 style="display:inline-block; color:rgb(9, 173, 214)">{{thongTin.phongKham}}</h3>
                      </div>
                      <div>
                        <h3 style="display:inline-block; color:#67cf9c">---</h3>
                      </div>
                      <div>
                        <h3 style="display:inline-block; color:#67cf9c">Lầu {{thongTin.lau}}
                        </h3>
                      </div>
                      <div>
                        <h3 style="display:inline-block; color:#67cf9c">---</h3>
                      </div>
                      <div>
                        <h3 style="display:inline-block; color:rgb(9, 173, 214)">{{thongTin.chuyenKhoa}}</h3>
                      </div>
                    </div>
                    <div style="display:flex;justify-content:space-between">
                      <table class="table table-bordered">
                        <thead>
                          <tr>
                            <th>Bàn</th>
                            <th>Bác sĩ</th>
                            <th>Số hiện tại </th>
                            <th>Số mới nhất</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr v-for="(thongTinPhong, index) in thongTin.thongTin" :key="index">
                            <td class="number">{{thongTinPhong.SoBan}}</td>
                            <td class="number">{{thongTinPhong.BacSi}}</td>
                            <td class="number">{{thongTinPhong.STTHienTai}}</td>
                            <td class="number">{{thongTinPhong.TongSTTPhatSinh}}</td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </template>
            <template v-else-if="selectedDashboard=='canLamSang'">
              <div v-for="(option, index) in dsCls" style="" :key="index">
                <div style="padding-bottom:8pt;padding-left:5pt">
                  <div class="row" style="margin-top:1pt; display:flex;justify-content:space-between">
                    <h3>{{option.khuVuc}}</h3>
                  </div>
                </div>
                <div class="row "
                  style="padding-left:5pt;display:flex;justify-content:center; padding-top:10pt;flex-wrap: wrap;background-color: white;">
                  <div class="col-sm-4" v-for="(thongTin, index) in option.thongTin" :key="index"
                    style="margin-bottom:10pt">
                    <div style="border-bottom: 1pt solid #bbbbbb; display:flex;justify-content:start;">
                      <div>
                        <h3 style="display:inline-block; color:rgb(9, 173, 214)">{{thongTin.phongKham}}</h3>
                      </div>
                      <div>
                        <h3 style="display:inline-block; color:#ffffff">-</h3>
                      </div>
                      <div>
                        <h3 style="display:inline-block; color:#67cf9c">Lầu {{thongTin.lau}} </h3>
                      </div>
                    </div>
                    <div style="display:flex;justify-content:space-between">
                      <table class="table table-bordered">
                        <thead>
                          <tr>
                            <th>Dịch vụ </th>
                            <th>{{thongTin.chuyenKhoa}}</th>
                          </tr>
                          <tr>
                            <th>Số hiện tại </th>
                            <th>Số mới nhất</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr v-for="(thongTinPhong, index) in thongTin.thongTin" :key="index">
                            <td class="number">{{thongTinPhong.STTHienTai}}</td>
                            <td class="number">{{thongTinPhong.TongSTTPhatSinh}}</td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </template>
            <template v-else>
              <div v-for="(option, index) in dsXetNghiem" style="" :key="index">
                <div style="padding-bottom:8pt;padding-left:5pt">
                  <div class="row" style="margin-top:1pt; display:flex;justify-content:space-between">
                    <h3>{{option.khuVuc}}</h3>
                  </div>
                </div>
                <div class="row "
                  style="padding-left:5pt;display:flex;justify-content:center; padding-top:10pt;flex-wrap: wrap;background-color: white;">
                  <div class="col-sm-4" v-for="(thongTin, index) in option.thongTin" :key="index"
                    style="margin-bottom:10pt">
                    <div style="border-bottom: 1pt solid #bbbbbb; display:flex;justify-content:start;">
                      <div>
                        <h3 style="display:inline-block; color:rgb(9, 173, 214)">{{thongTin.phongKham}}</h3>
                      </div>
                      <div>
                        <h3 style="display:inline-block; color:#ffffff">-</h3>
                      </div>
                      <div>
                        <h3 style="display:inline-block; color:#67cf9c">Lầu {{thongTin.lau}} </h3>
                      </div>
                    </div>
                    <div style="display:flex;justify-content:space-between">
                      <table class="table table-bordered">
                        <thead>                        
                          <tr>
                            <th>Số hiện tại </th>
                            <th>Số mới nhất</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr v-for="(thongTinPhong, index) in thongTin.thongTin" :key="index">
                            <td class="number">{{thongTinPhong.KhoangSTT}}</td>
                            <td class="number">{{thongTinPhong.STTCuoi}}</td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </template>
          </div>

        </form>
      </div>
    </div>
  </div>
</template>


<script>
  import axios from 'axios'
  export default {
    name: 'Dashboard',
    data() {
      return {
        dsDashBoard: "",
        selectedDashboard: "",
        dsLs: "",
        dsCls: "",
        dsXetNghiem: "",
      }
    },
    props: {
      isOpen: {
        type: Boolean,
        default: false
      }
    },
    
    methods: {
      handleChangeDashboard() {
        setInterval(() => {
          let i =0;
          switch (this.selectedDashboard) {
            case "lamSang":
              axios.get(process.env.SERVER_URI + `clinic/dashBoardLs`).then(response => {
                this.dsLs = response.data;
              });
              break;

            case "canLamSang":
              axios.get(process.env.SERVER_URI + `clinic/dashBoardCls`).then(response => {
                this.dsCls = response.data;
              })
              break;


            case "xetNghiem":
              axios.get(process.env.SERVER_URI + `clinic/dashBoardXn`).then(response => {
                console.log(this.selectedDashboard);
                this.dsXetNghiem = response.data;
              })
              break;
          }
          console.log(i++);
        }, 1000);
        this.$mount('#roomType');
      }
    },
    beforeMount(){
       this.$destroy('#roomType');
    },
    mounted() {
      this.isOpen == true ? document.getElementById("bodyContent").style.marginLeft = "300px" : document.getElementById(
        "bodyContent").style.marginLeft = "0";
    },
  }

</script>
