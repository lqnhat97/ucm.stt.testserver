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
                  <option v-for="option in data" :value="option.IDChuyenKhoa">{{option.TenChuyenKhoa}}</option>

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
                  <tr v-for="(row, rindex) in loadedDoctor">
                    <td>{{ row.BanKham }}</td>
                    <td>{{ row.PhongKham }}</td>                    
                    <td>{{row.HovaTen}}</td>
                    <td>
                      <div class="custom-control custom-radio">
                        <input type="radio" class="custom-control-input" id="customRadio" name="example1"
                          value="customEx" @click="checkedDoctor(row)">                    
                      </div>
                    </td>
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
        item: ""
      }
    },
    created(e) {
      this.selectedOption = ""
      axios.get(`http://localhost:8088/clinic/dsChuyenKhoa`).then(response => {
        this.data = response.data;
      })
    },
    methods: {
      handleChange(e) {
        axios.get(`http://localhost:8088/clinic/dsBacSi/` + this.selectedOption).then(response => {
          this.loadedDoctor = response.data;
          console.log(this.loadedDoctor);
        })
      },
      checkedDoctor(row) {
        this.idBacSi = row.ID;
        console.log(this.idBacSi);
      },
      taoPk() {
        axios.post(`http://localhost:8088/clinic/taoPhieuKham`, {
          idBenhNhan: localStorage.idBenhNhan,
          idChuyenKhoa: this.selectedChuyenKhoa
        }).then(dataResponse => {
          console.log(dataResponse.data);
          if (this.idBacSi == '') {
            axios.post(`http://localhost:8088/clinic/phatSinhStt`, {
              IDPhieuKham: dataResponse.data.IDPhieuKham,
              IDChuyenKhoa: this.selectedChuyenKhoa
            }).then(result => {
              console.log(result.data);
            }).catch(err => {
              console.log(err);
            });
          }
          else{
            axios.post(`http://localhost:8088/clinic/phatSinhSttTheoBS`, {
              IDPhieuKham: dataResponse.data.IDPhieuKham,
              IDChuyenKhoa: this.selectedChuyenKhoa,
              IDBacSi: this.idBacSi
            }).then(result => {
              console.log(result.data);
            }).catch(err => {
              console.log(err);
            });
          }
        }).catch(err => {
          console.log(err);
        })
      }
    }
  }

</script>

<style>
  @import '../../UMCC.css';

</style>
