<template>
  <div id="bodyContent">
    <div class="container">
            <div id="cliente">
              <form style="padding-bottom:8pt;padding-left:5pt">
                <div class="row">
                  <div class="col-sm-5">
                    <h3>Danh sách Chuyên khoa</h3>
                  </div>
                </div>

              </form>
              <div class="row " style="padding-left:5pt;display:flex;justify-content:space-between;">
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
                        <select class="form-control" v-model="optionChuyenKhoa.selected"
                          @change="handleChange(optionChuyenKhoa.selected)">
                          <option selected disabled>Chọn chuyên khoa</option>
                          <option v-for="option in data" :value="option.IDChuyenKhoa" :key="option.IDChuyenKhoa">
                            {{option.TenChuyenKhoa}}</option>
                        </select>
                      </td>
                      <td>
                        <select size="2" class="form-control" v-model="optionChuyenKhoa.caKham"
                          @change="handleChangeCaKham(index)">
                          <option value="1" :disabled="new Date().getHours()>12?true:false">Ca 1</option>
                          <option value="2"> Ca 2 </option>
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
              <div class="col-sm-offset-2">
                <button type="button" class="btn btn-info" v-on:click="addChuyenKhoa"> Thêm </button>
              </div>
              <div style="text-align:center;display: flex;justify-content: center;">
                <div>
                  <input class="form-group" @click="taoPk" id="buttom" type="submit" value="Tạo phiếu khám">
                </div>
              </div>
            </div>
          </div>
      <Modal :message="this.message" />
  </div>
</template>



<script>
  import axios from 'axios'
  import cell from './cell.vue';
  import Modal from './modal.vue'
  import {
    setTimeout
  } from 'timers';
  export default {
    name: "TaoPhieuKham",
    components: {
      cell,
      Modal
    },
    props: {
      isOpen: {
        type: Boolean,
        default: false
      }
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
          caKham: new Date().getHours() > 12 ? "2" : "1"
        }],
      }
    },
    created(e) {
      this.selectedChuyenKhoa = ""
      axios.get(process.env.SERVER_URI + `clinic/dsChuyenKhoa`).then(response => {
        this.data = response.data;
      })
    },
    mounted(){
      this.isOpen==true?document.getElementById("bodyContent").style.marginLeft = "300px":document.getElementById("bodyContent").style.marginLeft = "0";
    },
    methods: {
      handleChangeCaKham(index) {
        this.soLuongChuyenKhoa[index].loadedDoctor = this.soLuongChuyenKhoa[index].fetchedDoctor.filter(value => {
          return value.CaKham == this.soLuongChuyenKhoa[index].caKham
        })
      },
      removeChuyenKhoa(e) {
        this.soLuongChuyenKhoa.splice(e, 1);
      },
      addChuyenKhoa(e) {
        this.soLuongChuyenKhoa.push({
          stt: this.soLuongChuyenKhoa.length,
          selected: "",
          loadedDoctor: "",
          idBacSi: "",
          caKham: new Date().getHours() > 12 ? "2" : "1"
        })

      },
      handleChange(e) {
        axios.get(process.env.SERVER_URI + `clinic/dsBacSi/` + e).then(response => {
          this.soLuongChuyenKhoa.forEach(element => {
            if (element.selected === e) {
              element.loadedDoctor = response.data;
              element.fetchedDoctor = response.data;
              element.loadedDoctor = element.fetchedDoctor.filter(value => {
                return value.CaKham == element.caKham
              });
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
            axios.post(process.env.SERVER_URI + `clinic/taoPhieuKham`, {
              idBenhNhan: localStorage.idBenhNhan,
              idChuyenKhoa: element.selected
            }).then(dataResponse => {
              console.log(dataResponse.data);
              if (element.idBacSi == '') {
                axios.post(process.env.SERVER_URI + `clinic/phatSinhStt`, {
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
                axios.post(process.env.SERVER_URI + `clinic/phatSinhSttTheoBS`, {
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
