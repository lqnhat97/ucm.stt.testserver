<template>
  <div class="TaoPhieuKham">
    <Header />
    <div class="row" style="background-color:#ece9e9">
      <Sidebar :currentTab="1" />
      <div class="col-sm-9 ">
        <div class="row">
          <div class="col-sm-11" id="cliente">
            <!--<form style=" border-bottom: 2px solid #bbbbbb">

              <div class="row" style="padding:5pt">
                <div class="col-sm-3"> <label class="control-label" for="chuyenkhoa"
                    style="color:#969696;padding:8pt;margin-left: 3pt; ">Chuyên khoa</label>
                </div>
                <select class="browser-default custom-select-lg form-group" v-model="selectedChuyenKhoa"
                  @change="handleChange">
                  <option selected disabled>Chọn chuyên khoa</option>
                  <option v-for="option in data" :value="option.IDChuyenKhoa" :key="option.IDChuyenKhoa">
                    {{option.TenChuyenKhoa}}</option>

                </select>
              </div>


            </form>-->
            <form style="padding-bottom:8pt;padding-left:5pt">
              <div class="row">
                <div class="col-sm-5">
                  <h3>Danh sách Chuyên khoa</h3>
                </div>
              </div>

            </form>
            <div class="row " style="padding-left:5pt;display:flex;justify-content:space-between">
              <table class="table" id="chuyenKhoaTbody">
                <thead>
                  <tr>
                    <th>Chuyên Khoa</th>
                    <th>Ca</th>
                    <th>Danh sách bác sĩ</th>

                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(optionChuyenKhoa,index) in soLuongChuyenKhoa" :key="index">
                    <td>
                      <select class="browser-default custom-select-lg form-group" v-model="optionChuyenKhoa.selected"
                        @change="handleChange(optionChuyenKhoa.selected)">
                        <option selected disabled>Chọn chuyên khoa</option>
                        <option v-for="option in data" :value="option.IDChuyenKhoa" :key="option.IDChuyenKhoa">
                          {{option.TenChuyenKhoa}}</option>

                      </select>
                    </td>
                    <td>
                      <select class="browser-default custom-select-lg form-group"  v-model="optionChuyenKhoa.caKham"
                        @change="handleChangeCaKham(index)">
                        <option value="1" :disabled="new Date().getHours()>12?true:false">Ca 1</option>
                        <option value="2" > Ca 2 </option>
                      </select>
                    </td>
                    <td>
                      <table class="table" id="demo" style="width: 100%">
                        <thead>
                          <tr>
                            <th>Bàn</th>
                            <th>Phòng</th>
                            <th>Bác sĩ</th>
                            <th>Chọn bác sĩ</th>

                          </tr>
                        </thead>
                        <tbody>
                          <tr v-for="(row, rindex) in optionChuyenKhoa.loadedDoctor" :key="rindex">
                            <td>{{ row.SoBan }}</td>
                            <td>{{ row.SoPhong }}</td>
                            <td>{{row.HovaTen}}</td>
                            <td>
                              <div class="custom-control custom-radio">
                                <input type="radio" class="custom-control-input" :name=" index"
                                  @click="checkedDoctor(row,index)">
                              </div>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </td>
                    <button type="button" class="btn btn-danger" v-on:click="removeChuyenKhoa(index)"> Xóa </button>
                  </tr>
                </tbody>
              </table>
              
            </div>
            <button type="button" class="btn btn-info" v-on:click="addChuyenKhoa"> Thêm </button>
            
            <div style="text-align:center;display: flex;justify-content: center;">
              <div>
                <input class="form-group" @click="taoPk" id="buttom" type="submit" value="Tạo phiếu khám">
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal 
    <div class="modal fade" id="findCmndModal" tabindex="-1" role="dialog" aria-labelledby="findCmndModalTitle"
      aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title" id="findCmndModalTitle">Thông báo</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body" v-text="message">

          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
          </div>
        </div>
      </div>
    </div>-->
    <Modal :message="this.message" />
  </div>
</template>



<script>
  import axios from 'axios'
  import Header from './Header.vue'
  import Sidebar from './Sidebar.vue'
  import cell from './cell.vue';
  import Modal from './modal.vue'
  import {
    setTimeout
  } from 'timers';
  export default {
    name: "TaoPhieuKham",
    components: {
      Header,
      Sidebar,
      cell,
      Modal
    },
    data() {
      return {
        selectedChuyenKhoa: "",
        data: "",
        item: "",
        message: "",
        soLuongChuyenKhoa: [{
          stt: 0,
          selected: "",
          loadedDoctor: "",
          fetchedDoctor: "",
          idBacSi: "",
          caKham: new Date().getHours()>12?"2":"1"
        }],
      }
    },
    created(e) {
      
      this.selectedChuyenKhoa = ""
      axios.get(`http://nhatlq97.sytes.net:8088/clinic/dsChuyenKhoa`).then(response => {
        this.data = response.data;
      })
    },
    methods: {
      handleChangeCaKham(index) {
        this.soLuongChuyenKhoa[index].loadedDoctor = this.soLuongChuyenKhoa[index].fetchedDoctor.filter(value => {
          return value.CaKham == this.soLuongChuyenKhoa[index].caKham
        })
      },
      removeChuyenKhoa(e){
        this.soLuongChuyenKhoa.splice(e,1);
      },
      addChuyenKhoa(e) {
        this.soLuongChuyenKhoa.push({
          stt: this.soLuongChuyenKhoa.length,
          selected: "",
          loadedDoctor: "",
          idBacSi: "",
          caKham: ""
        })
        
      },
      handleChange(e) {
        axios.get(`http://nhatlq97.sytes.net:8088/clinic/dsBacSi/` + e).then(response => {
          this.soLuongChuyenKhoa.forEach(element => {
            if (element.selected === e) {
              element.loadedDoctor = response.data;
              element.fetchedDoctor = response.data;
              element.loadedDoctor = element.fetchedDoctor.filter(value => {
          return value.CaKham == element.caKham});
            }
          });

        })
      },
      checkedDoctor(row, index) {
        this.soLuongChuyenKhoa[index].idBacSi = row.ID;
      },
      taoPk(e) {
        e.preventDefault();
        this.message = "";
        this.soLuongChuyenKhoa.forEach(element => {
          setTimeout(() => {
            axios.post(`http://nhatlq97.sytes.net:8088/clinic/taoPhieuKham`, {
              idBenhNhan: localStorage.idBenhNhan,
              idChuyenKhoa: element.selected
            }).then(dataResponse => {
              console.log(dataResponse.data);
              if (element.idBacSi == '') {
                axios.post(`http://nhatlq97.sytes.net:8088/clinic/phatSinhStt`, {
                  IDPhieuKham: dataResponse.data.IDPhieuKham,
                  IDChuyenKhoa: element.selected,
                  CaKham: element.caKham
                }).then(result => {
                  this.message += "Tạo phiếu khám thành công <strong>" + dataResponse.data.IDPhieuKham +
                    "</strong><br/>";
                  $('#findCmndModal').modal('show');
                  console.log(result.data);
                }).catch(err => {
                  console.log(err);
                });
              } else {
                axios.post(`http://nhatlq97.sytes.net:8088/clinic/phatSinhSttTheoBS`, {
                  IDPhieuKham: dataResponse.data.IDPhieuKham,
                  IDChuyenKhoa: element.selected,
                  IDBacSi: element.idBacSi,
                  CaKham: element.caKham
                }).then(result => {
                  this.message += "Tạo phiếu khám thành công <strong>" + dataResponse.data.IDPhieuKham +
                    "</strong> <br/>";
                  $('#findCmndModal').modal('show');
                  console.log(result.data);
                }).catch(err => {
                  console.log(err);
                });
              }
            }).catch(err => {
              console.log(err);
            });
          }, 500)
        })
      }
    }
  }
</script>

<style>
  @import '../../UMCC.css';
</style>