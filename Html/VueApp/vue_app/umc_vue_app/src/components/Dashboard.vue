<template>
  <div id="bodyContent">
    <div class="container">
      <div id="cliente" style="background-color: #F8F8F8;position:center">
        <form style="padding-bottom:8pt;padding-left:5pt">
          <form style=" border-bottom: 2px solid #bbbbbb">
            <div class="row" style="display:flex; align-items: baseline;">
              <div class="col-sm-2" style="text-align:right;"> <label class="control-label" for="dashboard"
                  id="search-name">Chọn Dashboard</label>
              </div>
              <div class="col-sm-4">
                <select class="form-control" v-bind:style="{ margin_top:'10%' }" id="dashboard"
                  v-model="selectedDashboard" @change="handleChangeDashboard($event)">
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
          <template v-for(option in dsDashBoard)>
            <form style="padding-bottom:8pt;padding-left:5pt">
              <div class="row" style="margin-top:1pt; display:flex;justify-content:space-between">
                <h3>Khu vực A</h3>
              </div>
            </form>
            <div class="row " style="padding-left:5pt;display:flex;justify-content:center; padding-top:10pt;flex-wrap: wrap">
              <div class="col-sm-5" style="background-color: white;">
                <div class="row" style="border-bottom: 1pt solid #bbbbbb; display:flex;justify-content:space-around">
                  <div>
                    <h3 style="display:inline-block; color:rgb(9, 173, 214)">Lầu 1</h3>
                  </div>
                  <div>
                    <h3 style="display:inline-block; color:rgb(9, 173, 214)">Phòng </h3>
                    <h3 style="display:inline-block; color:#67cf9c; text-align-last: right ">X-quang
                    </h3>
                  </div>
                </div>
                <div style="display:flex;justify-content:space-between">
                  <table class="table table-bordered">
                    <thead>
                      <tr>
                        <th>Số hiện tại </th>
                        <th>Số đã cấp</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>

                        <td class="number">2</td>
                        <td class="number">20</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>

              <div class="col-sm-5" style="background-color: white;">
                <div class="row" style="border-bottom: 1pt solid #bbbbbb; display:flex;justify-content:space-around">
                  <div>
                    <h3 style="display:inline-block; color:rgb(9, 173, 214)">Lầu 1</h3>
                  </div>
                  <div>
                    <h3 style="display:inline-block; color:rgb(9, 173, 214)">Phòng </h3>
                    <h3 style="display:inline-block; color:#67cf9c; text-align-last: right ">X-quang
                    </h3>
                  </div>
                </div>
                <div style="display:flex;justify-content:space-between">
                  <table class="table table-bordered">
                    <thead>
                      <tr>
                        <th>Số hiện tại </th>
                        <th>Số đã cấp</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>

                        <td class="number">2</td>
                        <td class="number">20</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>

                <div class="col-sm-5" style="background-color: white;">
                <div class="row" style="border-bottom: 1pt solid #bbbbbb; display:flex;justify-content:space-around">
                  <div>
                    <h3 style="display:inline-block; color:rgb(9, 173, 214)">Lầu 1</h3>
                  </div>
                  <div>
                    <h3 style="display:inline-block; color:rgb(9, 173, 214)">Phòng </h3>
                    <h3 style="display:inline-block; color:#67cf9c; text-align-last: right ">X-quang
                    </h3>
                  </div>
                </div>
                <div style="display:flex;justify-content:space-between">
                  <table class="table table-bordered">
                    <thead>
                      <tr>
                        <th>Số hiện tại </th>
                        <th>Số đã cấp</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>

                        <td class="number">2</td>
                        <td class="number">20</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
                <div class="col-sm-5" style="background-color: white;">
                <div class="row" style="border-bottom: 1pt solid #bbbbbb; display:flex;justify-content:space-around">
                  <div>
                    <h3 style="display:inline-block; color:rgb(9, 173, 214)">Lầu 1</h3>
                  </div>
                  <div>
                    <h3 style="display:inline-block; color:rgb(9, 173, 214)">Phòng </h3>
                    <h3 style="display:inline-block; color:#67cf9c; text-align-last: right ">X-quang
                    </h3>
                  </div>
                </div>
                <div style="display:flex;justify-content:space-between">
                  <table class="table table-bordered">
                    <thead>
                      <tr>
                        <th>Số hiện tại </th>
                        <th>Số đã cấp</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>

                        <td class="number">2</td>
                        <td class="number">20</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>

                <div class="col-sm-5" style="background-color: white;">
                <div class="row" style="border-bottom: 1pt solid #bbbbbb; display:flex;justify-content:space-around">
                  <div>
                    <h3 style="display:inline-block; color:rgb(9, 173, 214)">Lầu 1</h3>
                  </div>
                  <div>
                    <h3 style="display:inline-block; color:rgb(9, 173, 214)">Phòng </h3>
                    <h3 style="display:inline-block; color:#67cf9c; text-align-last: right ">X-quang
                    </h3>
                  </div>
                </div>
                <div style="display:flex;justify-content:space-between">
                  <table class="table table-bordered">
                    <thead>
                      <tr>
                        <th>Số hiện tại </th>
                        <th>Số đã cấp</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>

                        <td class="number">2</td>
                        <td class="number">20</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>

            </div>
          </template>
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
        selectedDashboard: "lamSang"
      }
    },
    props: {
      isOpen: {
        type: Boolean,
        default: false
      }
    },
    created() {
      axios.get(process.env.SERVER_URI + `clinic/dsChuyenKhoa`).then(response => {
        console.log(response.data);
        this.danhSachPhongKham = response.data;
      })
    },
    mounted() {
      this.isOpen == true ? document.getElementById("bodyContent").style.marginLeft = "300px" : document.getElementById(
        "bodyContent").style.marginLeft = "0";
    },
  }
</script>