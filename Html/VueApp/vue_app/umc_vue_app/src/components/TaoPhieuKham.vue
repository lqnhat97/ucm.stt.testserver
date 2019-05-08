<template>
  <div class="TaoPhieuKham">
    <Header />
    <div class="row" style="background-color:#ece9e9">
      <Sidebar />
      <div class="col-sm-9 ">
        <div class="row">
          <div class="col-sm-11" id="cliente">
            <form style=" border-bottom: 2px solid #bbbbbb">

              <div class="row" style="padding:5pt">
                <div class="col-sm-3"> <label class="control-label" for="chuyenkhoa"
                    style="color:#969696;padding:8pt;margin-left: 3pt; ">Chuyên khoa</label>
                </div>
                <select class="browser-default custom-select-lg form-group" v-model="selectedOption"
                  @change="handleChange">
                  <option selected disabled>Chọn chuyên khoa</option>
                  `<option v-for="option in data" v-bind:key="option.IDChuyenKhoa">{{option.TenChuyenKhoa}}</option>

                </select>
              </div>


            </form>
            <form style="padding-bottom:8pt;padding-left:5pt">
              <div class="row">
                <div class="col-sm-5">
                  <h3>Danh sách bác sĩ</h3>
                </div>
              </div>
            </form>
            <div class="row " style="padding-left:5pt;display:flex;justify-content:space-between">
              <table class="table">
                <thead>
                  <tr>
                    <th>Bàn</th>
                    <th>Phòng</th>
                    <th>Bác sĩ</th>
                    <th>Chọn bác sĩ</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(row, rindex) in loadedDoctor" v-bind:key="row.data">
                    <td >{{ rindex }}</td>
                      <cell v-for="(value, vindex) in row" :value="value" :vindex="vindex" :rindex="rindex"
                        :key="value"></cell>
                  </tr>
                </tbody>
              </table>

            </div>
            <form action="">

              <div class="row">
                <div class="col-sm-4"></div>
                <div class="col-sm-4">
                  <input class="form-group" id="buttom" type="submit" value="Tạo phiếu khám">
                </div>
              </div>
            </form>
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
  import cell from './cell';
  export default {
    name: "TaoPhieuKham",
    components: {
      Header,
      Sidebar,
      cell
    },
    data() {
      return {
        selectedOption: "",
        data: "",
        loadedDoctor: "",
      }
    },
    created(e) {
      axios.get(`http://192.168.1.90:8088/clinic/dsChuyenKhoa`).then(response => {
        this.data = response.data;
      })
    },
    methods: {
      handleChange(e) {
        axios.get(`http://192.168.1.90:8088/clinic/dsChuyenKhoa`).then(response => {
          this.data = response.data;
          console.log(response.data);
        })
      }
    }
  }
</script>

<style>
  @import '../../UMCC.css';
</style>