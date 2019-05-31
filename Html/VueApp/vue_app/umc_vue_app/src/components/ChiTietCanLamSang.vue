<template>
  <div id="bodyContent">
    <div class="container">
        <div id="cliente" style="background-color: #F8F8F8;position:center">
          <form style=" border-bottom: 2px solid #bbbbbb">
            <div class="row">
              <div class="col-sm-6 form-group" style="display:flex; align-items:center">
                <div class="col-sm-4"> <label class="control-label" for="chuyenkhoa" id="search-name">Chuyên
                    khoa</label>
                </div>
                <div class="col-sm-8">
                  <select v-bind:style="{ margin_top:'10%' }" id="chuyenkhoa" class="form-control"
                    placeholder="Chuyên khoa" v-model="selectedChuyenKhoa" @change="handleChangeChuyenKhoa">
                    <option :selected="true" disabled>Chọn chuyên khoa cận lâm sàng</option>
                    <option v-for="option in chuyenKhoa" :value="option.IDChuyenKhoa" :key="option.IDChuyenKhoa">
                      {{option.TenChuyenKhoa}}</option>
                  </select>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-4"> <label for="sophong" id="search-name">Phòng</label>
                  </div>
                  <select v-bind:style="{ margin_top:'10%' }" id="dichVu" class="form-control" placeholder="Chuyên khoa"
                    v-model="selectedPhong" @change="handleChangeDichVu">
                    <option :selected="true" disabled>Chọn phòng</option>
                    <option v-for="(option,index) in dsPhong" :value="option.IDPhong" :key="index">
                      {{option.SoPhong}}</option>
                  </select>
                </div>
              </div>

            </div>
          </form>
          <form style="padding-bottom:8pt;padding-left:5pt">
            <div class="row">
              <div class="col-sm-5">
                <h3>Chi tiết dịch vụ cận lâm sàng</h3>
              </div>
            </div>
          </form>
          <div class="row " style="padding-left:5pt;display:flex;justify-content:space-between">
            <table class="table">
              <thead>
                <tr>
                  <th>Phòng</th>
                  <th>Số hiện tại</th>
                  <th>Số cuối</th>
                  <th>Bệnh nhân hiện tại</th>
                  <th>Thao tác</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="number">401</td>
                  <td class="number">2000</td>
                  <td class="number">5</td>
                  <td>Nguyễn Hoàng Sơn</td>
                  <td class="number"><button class="btn-success">+</button></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
  </div>
</template>

<script>
  import axios from 'axios'
  export default {
    name: 'ChiTietPhongKham',
    data() {
      return {
        chuyenKhoa: "",
        selectedChuyenKhoa: "",
        selectedPhong: "",
        dsPhong: "",
        selectedCls: "",
        cls: ""
      }
    },
    props: {
      isOpen: {
        type: Boolean,
        default: false
      }
    },
    created() {
      axios.get(process.env.SERVER_URI + `clinic/dsChuyenKhoaCls`).then(res => {
        this.chuyenKhoa = res.data;
      })
    },
    mounted(){
      this.isOpen==true?document.getElementById("bodyContent").style.marginLeft = "300px":document.getElementById("bodyContent").style.marginLeft = "0";
    },
    methods: {
      handleChangeChuyenKhoa() {
        axios.get(process.env.SERVER_URI + `clinic/dsPhongClsTheoChuyenKhoa/` + this.selectedChuyenKhoa).then(res => {console.log(res.data);
          this.dsPhong = res.data;
        })
      },
      handleChangeDichVu() {
        axios.get(process.env.SERVER_URI + `clinic/dsClsTheoDv/` + this.selectedDichVu).then(res => {
          console.log(res.data)
          this.cls = res.data;
        })
      }
    }
  }

</script>
