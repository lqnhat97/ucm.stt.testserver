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
        <div class="row">
          <div class="col-sm-5">
            <h3>Quy định thời gian thực hiện dịch vụ</h3>
          </div>
        </div>
        <template v-if="fetchedDsDichVu!=''">
          <form @submit="quyDinhThoiGian">
            <div class="row" style="display:flex; justify-content:center; align-items: baseline;"
              v-for="(dv, index) in this.fetchedDsDichVu" :key="index">
              <label class="col-sm-2 control-label" style="text-align:right">Tên dịch vụ</label>
              <div class="col-sm-8 form-group"><input readonly class="form-control" :value="dv.TenDichVu"><input hidden
                  readonly v-model="dv.IDDichVu"></div>
              <label class="col-sm-2 control-label" style="text-align:right">Thời gian</label>
              <div class="col-sm-3 form-group"><input class="form-control" type="text"
                  pattern="([01]?[0-9]|2[0-3]):[0-5][0-9]" v-model="thoiGianDichVu[index]"></div>
            </div>
            <div class="row" style="display:flex ; justify-content: space-around">
              <div class="form-group col-sm-4">
                <input class="form-group" id="buttom" type="submit" value="Quy định">
              </div>
            </div>
          </form>
        </template>
        <p v-else>Vui lòng chọn phòng khám</p>
        <modal :message="this.message" />
      </div>
    </div>
  </div>

</template>

<script>
  import axios from 'axios'
  import modal from './modal.vue'
  import moment from 'moment'
  export default {
    name: 'ChiDinhThoiGianDvCls',
    components: {
      modal
    },
    data() {
      return {
        chuyenKhoa: "",
        selectedChuyenKhoa: "",
        fetchedDsDichVu: "",
        idDv: [],
        thoiGianDichVu: [],
        message: "aaaa"
      }
    },
    props: {
      isOpen: {
        type: Boolean,
        default: false
      }
    },
    created() {
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
        axios.get(process.env.SERVER_URI + `clinic/dsCls/` + this.selectedChuyenKhoa).then(response => {
          this.fetchedDsDichVu = response.data;
          this.idDv = this.fetchedDsDichVu.map((value) => {
            return value.IDDichVu;
          });
          this.thoiGianDichVu = this.fetchedDsDichVu.map((value) => {
            var result = new Date(value.ThoiGianNhaySoTB);
            result.setHours(result.getHours() - 7);
            return moment(result).format('HH:mm');
          })
        })
      },
      quyDinhThoiGian(e) {
        e.preventDefault();
        axios.post(process.env.SERVER_URI + 'clinic/chiDinhThoiGianChoDv', {
          idDichVu: this.idDv,
          thoiGian: this.thoiGianDichVu
        }).then(response => {
          this.message = "Chỉ định thành công";
          $('#findCmndModal').modal('show');
        }).catch(e => {
          this.message = "Chỉ định không thành công";
          $('#findCmndModal').modal('show');
        })
      }
    }
  }

</script>
