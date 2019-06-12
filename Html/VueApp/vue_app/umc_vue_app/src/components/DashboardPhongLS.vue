<template>
  <div id="bodyContent">
    <div class="container">
      <div id="cliente" style="background-color: #F8F8F8;position:center">
        <form style="padding-bottom:8pt;padding-left:5pt">
          <div class="row">
            <div class="col-sm-4">
              <h3>Dashboard</h3>
            </div>
          </div>
          <div id="roomType">
            <div>
              <div style="padding-bottom:8pt;padding-left:5pt">
                <div class="row" style="margin-top:1pt; display:flex;justify-content:space-between">
                  <h3>KhuA</h3>
                </div>
              </div>
              <div class="row "
                style="padding-left:5pt;display:flex;justify-content:center; padding-top:10pt;flex-wrap: wrap;background-color: white;">
                <div class="col-sm-12" style="margin-bottom:10pt">
                  <div style="border-bottom: 1pt solid #bbbbbb; display:flex;justify-content:start;">
                    <div>
                      <h3 style="display:inline-block; color:rgb(9, 173, 214)">{{dsLs.phongKham}}</h3>
                    </div>
                    <div>
                      <h3 style="display:inline-block; color:#67cf9c">---</h3>
                    </div>
                    <div>
                      <h3 style="display:inline-block; color:#67cf9c">Lầu {{dsLs.thongTin[0].Lau}}
                      </h3>
                    </div>
                    <div>
                      <h3 style="display:inline-block; color:#67cf9c">---</h3>
                    </div>
                    <div>
                      <h3 style="display:inline-block; color:rgb(9, 173, 214)">{{dsLs.thongTin[0].TenChuyenKhoa}}</h3>
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
                        <tr v-for="(thongTinPhong, index) in dsLs.thongTin" :key="index">
                          <td class="number">{{thongTinPhong.SoBan}}</td>
                          <td class="number">{{thongTinPhong.BacSi}}</td>
                          <td class="number">{{thongTinPhong.STTHienTai}}</td>
                          <td class="number">{{thongTinPhong.STTCuoi}}</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>

        </form>
      </div>
    </div>
  </div>
</template>


<script>
  import axios from 'axios'
  export default {
    name: 'DashboardLS',
    data() {
      return {
        dsLs: "",
        idPhong:""
      }
    },
    props: {
      isOpen: {
        type: Boolean,
        default: false
      }
    },
    created() {
      this.idPhong = this.$route.params.idPhong;
      setInterval(() => {
        axios.get(process.env.SERVER_URI + `clinic/thongTinLsTheoPhong/` + this.idPhong).then(response => {
          this.dsLs = response.data;
        });
      }, 1000);
    },
  }

</script>
