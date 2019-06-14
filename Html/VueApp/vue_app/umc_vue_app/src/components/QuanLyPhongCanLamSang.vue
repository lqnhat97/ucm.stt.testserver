<template>
  <div id="bodyContent">
    <div class="container">
      <div id="cliente" style="background-color: #F8F8F8;position:center">
        <form style=" border-bottom: 2px solid #bbbbbb">
          <div class="row" style="display:flex; align-items: baseline;">
            <div class="col-sm-2" style="text-align:right;"> <label class="control-label" for="chuyenkhoa"
                id="search-name">Chuyên khoa</label>
            </div>
            <div class="col-sm-4">
              <select class="form-control" v-bind:style="{ margin_top:'10%' }" id="chuyenkhoa"
                v-model="selectedChuyenKhoa" @change="handleChangeChuyenKhoa">
                <option :selected="true" disabled>Chọn chuyên khoa</option>
                <option v-for="option in chuyenKhoa" :value="option.IDChuyenKhoa" :key="option.IDChuyenKhoa">
                  {{option.TenChuyenKhoa}}</option>
              </select>
            </div>
          </div>
        </form>
        <form style="padding-bottom:8pt;padding-left:5pt">
          <div class="row">
            <div class="col-sm-5">
              <h3>Quản lý dịch vụ cận lâm sàng</h3>
            </div>
          </div>
        </form>
        <div class="row" style="display:flex; align-items: baseline;">
          <div class="col-sm-2" style="text-align:right;"> <label class="control-label" for="chuyenkhoa"
              id="search-name">Quy định giờ</label>
          </div>

          <div class="col-sm-4">
            <select class="form-control" v-bind:style="{ margin_top:'10%' }" id="chuyenkhoa" v-model="selecteDvQuiDinh">
              <option :selected="true" value="" disabled>Chọn dịch vụ</option>
              <option v-for="option in fetchedDsDichVu" :value="option.IDDichVu" :key="option.IDDichVu">
                {{option.TenDichVu}}</option>
            </select>
          </div>
          <div><input class="form-control" type="time" v-model="thoiGianDichVu"></div>
          <div class="col-sm-4">
            <input class="form-control btn btn-success" @click="quyDinhThoiGianDichVu" type="submit" value="Quy định">
          </div>
        </div>
        <div class="row" style="padding-left:5pt;display:flex;justify-content:space-between">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th>Phòng</th>
                <th>Ca</th>
                <th>Thời gian khám</th>
              </tr>
            </thead>
            <tbody>
              <template v-for="(option,index) in dichVu">
                <tr>
                  <td class="number" :rowspan="3">
                    {{option.idPhong}}</td>
                  <td class="text">Ca 1</td>
                  <td class="number"><input v-model="option.gioBdCa1" class="form-control" type="time"> - <input
                      v-model="option.gioKtCa1" type="time" class="form-control">
                  </td>
                </tr>
                <tr>
                  <td class="text">Ca 2</td>
                  <td class="number"><input v-model="option.gioBdCa2" type="time" class="form-control"> - <input
                      v-model="option.gioKtCa2" type="time" class="form-control">
                  </td>
                </tr>

                <tr>
                  <td colspan="2">
                    <div style="display:flex;justify-content:space-between">
                      <div>
                        <select :size="fetchedDsDichVu.length" multiple class="form-control" :id='"selectCls"+index'>
                          <option v-for="(optionDichVu,key) in f_dvClsConLai[index]" :value="optionDichVu.IDDichVu"
                            :key="key">
                            {{optionDichVu.TenDichVu}}</option>
                        </select>
                      </div>
                      <div style="display: flex; flex-direction: column; justify-content: center;">
                        <button type="button" @click="selectCls(index)" class="btn btn-primary">Chọn</button>
                        <button type="button" @click="unSelectCls(index)" class="btn btn-info">Xóa</button>
                      </div>
                      <div>
                        <select :size="fetchedDsDichVu.length" multiple class="form-control" :id='"unSelectCls"+index'>
                          <option v-for="(optionDichVuDaLam,key) in  f_dvClsDaLam[index]" :key="key"
                            :value="optionDichVuDaLam.IDDichVu ">
                            {{optionDichVuDaLam.TenDichVu}}</option>
                        </select>
                      </div>
                    </div>
                  </td>
                </tr>
              </template>
            </tbody>
          </table>

        </div>
        <form action="">
          <div class="row" style="display:flex ; justify-content: space-around">

            <div class="col-sm-4">
              <input class="form-group" id="buttom" @click="quyDinhCls" type="submit" value="Quy định">
            </div>
          </div>
          <modal :message="this.message" />
        </form>
      </div>
    </div>
  </div>
</template>

<script>
  import DatePicker from 'vue2-datepicker'
  import axios from 'axios'
  import modal from './modal.vue'
  export default {
    name: 'QuanLyCanLamSang',
    components: {
      DatePicker,
      modal
    },
    data() {
      return {
        message: "",
        thoiGianDichVu: "00:02",
        datetimepicker1: "",
        chuyenKhoa: "",
        selecteDvQuiDinh: '',
        selectedChuyenKhoa: "",
        dichVu: [],
        fetchedDsDichVu: "",
        dsDv: [],
        fetchedDsDichVuDaLam: "",
        f_dvClsDaLam: [],
        f_dvClsConLai: [],
        lang: {
          days: ['Chủ nhật', 'Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy'],
          months: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9',
            'Tháng 10', 'Tháng 11', 'Tháng 12'
          ],
          pickers: ['next 7 days', 'next 30 days', 'previous 7 days', 'previous 30 days'],
          placeholder: {
            date: 'Chọn ngày',
            dateRange: 'Chọn khoảng ngày'
          },
        }
      }
    },
    props: {
      isOpen: {
        type: Boolean,
        default: false
      }
    },
    created() {
      this.selectedChuyenKhoa = ""
      axios.get(process.env.SERVER_URI + `clinic/dsChuyenKhoaCls`).then(response => {
        this.chuyenKhoa = response.data;
      });

    },
    mounted() {
      this.isOpen == true ? document.getElementById("bodyContent").style.marginLeft = "300px" : document.getElementById(
        "bodyContent").style.marginLeft = "0";
    },
    methods: {
      handleChangeChuyenKhoa() {
        this.fetchedDsDichVu = "";
        this.dichVu = [];
        this.f_dvClsConLai = [];
        axios.get(process.env.SERVER_URI + `clinic/dsPhongClsTheoChuyenKhoa/` + this.selectedChuyenKhoa).then(
          response => {
            if (this.fetchedDsDichVu == "") {
              axios.get(process.env.SERVER_URI + `clinic/dsCls/` + this.selectedChuyenKhoa).then(response => {
                this.fetchedDsDichVu = response.data;
              })
            };
            this.f_dvClsDaLam = new Array(response.data.length);
            response.data.forEach((element, index) => {
              this.dichVu.push({
                idPhong: element.IDPhong,
                gioBdCa1: "07:30",
                gioKtCa1: "11:30",
                gioBdCa2: "13:30",
                gioKtCa2: "17:30",
              });
              axios.get(process.env.SERVER_URI + `clinic/dvClsDaThucHien/` + element.IDPhong).then(
                response => {
                  this.f_dvClsDaLam[index] = (response.data);
                  //this.delDuplicateID(this.fetchedDsDichVu, this.f_dvClsDaLam[index]);
                  this.f_dvClsConLai.push(this.delDuplicateID(this.fetchedDsDichVu, this.f_dvClsDaLam[index]));
                  this.$mount('#bodyContent');

                });
            });

          });
      },
      delDuplicateID(list1, list2) {
        let len = list2.length;
        var tmp = [...list1];
        list2.forEach(value => {
          tmp = tmp.filter(v => {
            return v.IDDichVu != value.IDDichVu;
          })
        });
        return tmp;
      },
      selectCls(index) {
        let data = $("#selectCls" + index).val();
        this.addComplete(data, index, this.f_dvClsDaLam, this.f_dvClsConLai, 1);
        this.$mount('#bodyContent');
      },
      unSelectCls(index) {
        let data = $("#unSelectCls" + index).val();
        this.addComplete(data, index, this.f_dvClsConLai, this.f_dvClsDaLam, 2);
        this.$mount('#bodyContent');
      },
      addedItem(data) {
        let res = [];
        data.forEach((value, index) => {
          let tmp = this.fetchedDsDichVu.filter(v => {
            return v.IDDichVu == value;
          })[0];
          res.push({
            IDDichVu: tmp.IDDichVu,
            TenDichVu: tmp.TenDichVu
          })
        });
        return res;
      },
      deletedItem(data) {
        let res = [];
        for (const value of data) {
          let tmp = this.fetchedDsDichVu.filter(v => {
            return v.IDDichVu == value;
          })[0];
          console.log(tmp);
          res.push({
            IDDichVu: tmp.IDDichVu,
            TenDichVu: tmp.TenDichVu
          })
        }
        return res;
      },
      addComplete(data, index, data1, data2, type) {
        let res = type == 1 ? this.addedItem(data) : this.deletedItem(data);
        data1[index] = data1[index].concat(res);
        data2[index] = this.delDuplicateID(this.fetchedDsDichVu, data1[index]);
      },
      quyDinhCls(e) {
        e.preventDefault;
        for (let i = 0; i < this.dichVu.length; i++) {
          this.dichVu[i].dsDvCls = this.f_dvClsDaLam[i].map(value => {
            return value.IDDichVu
          });
        }
        axios.post(process.env.SERVER_URI + 'clinic/chiDinhDvClsChoPhong', this.dichVu).then(response => {
          this.message = "Chỉ định thành công";
          $('#findCmndModal').modal('show');
        }).catch(e => {
          this.message = "Chỉ định không thành công";
          $('#findCmndModal').modal('show');
        })
      },
      quyDinhThoiGianDichVu() {
        axios.post(process.env.SERVER_URI + 'clinic/chiDinhThoiGianChoDv',{
          idDichVu:this.selecteDvQuiDinh,
          thoiGian:this.thoiGianDichVu
        }).then(response => {
          this.message = "Chỉ định thành công";
          $('#findCmndModal').modal('show');
        }).catch(e => {
          this.message = "Chỉ định không thành công";
          $('#findCmndModal').modal('show');
        })
      }
    },
  }

</script>
