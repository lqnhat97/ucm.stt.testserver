<template>
  <div class="QuanLySoCanLamSang">
    <Header />
    <Sidebar />
    <div class="col-sm-9 ">
      <div class="col-sm-11" id="cliente">
        <form style="padding-bottom:8pt;padding-left:5pt">
          <div class="row">
            <div class="col-sm-5">
              <h3>Quản lý số phòng cận lâm sàng</h3>
            </div>
          </div>
        </form>
        <form>
          <div class="row form-group" style="padding:5pt">
            <div class="col-sm-3"> <label class="control-label" for="chuyenkhoa"
                style="color:#969696;padding:8pt;margin-left: 3pt; ">Chuyên khoa</label> </div>
            <div class="search-box col-sm-3" style="height:30pt; margin-bottom: 10px">
              <input type="text" id="chuyenkhoa" value="" class="form-control" placeholder="">
              <button class="btn btn-link search-btn"> <i class="glyphicon glyphicon-search"></i>
              </button>

            </div>
            <div class="col-sm-2"> <label class="control-label" for="loaidichvu"
                style="color:#969696;padding:8pt;margin-left: 3pt; ">Loại dịch vụ</label> </div>
            <div class="search-box col-sm-4" style="height:30pt; margin-bottom: 10px">
              <input type="text" id="loaidichvu" value="" class="form-control" placeholder="">
              <button class="btn btn-link search-btn"> <i class="glyphicon glyphicon-search"></i>
              </button>
            </div>
          </div>
          <div class="row form-group" style="padding:5pt">
            <div class="col-sm-3"> <label class="control-label" for="tendichvu"
                style="color:#969696;padding:8pt;margin-left: 3pt; ">Tên dịch vụ</label> </div>
            <div class="search-box col-sm-3" style="height:30pt; margin-bottom: 10px">
              <input type="text" id="tendichvu" value="" class="form-control" placeholder="">
              <button class="btn btn-link search-btn"> <i class="glyphicon glyphicon-search"></i>
              </button>

            </div>
            <div class="col-sm-2"> <label class="control-label" for="sophong"
                style="color:#969696;padding:8pt;margin-left: 3pt; ">Số phòng</label> </div>
            <div class="search-box col-sm-4" style="height:30pt; margin-bottom: 10px">
              <input type="text" id="sophong" value="" class="form-control" placeholder="">
              <button class="btn btn-link search-btn"> <i class="glyphicon glyphicon-search"></i>
              </button>
            </div>
          </div>
        </form>
        <form action="">
          <div class="row">
            <div class="col-sm-4"></div>
            <div class="col-sm-4">
              <input class="form-group" id="buttom" type="submit" value="Qua số">
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
  import axios from 'axios'
  import Header from './Header.vue'
  import Sidebar from './Sidebar.vue'
  export default {
    name: 'QuanLySoCanLamSang',
    components: {
      Header,
      Sidebar
    },
  }
</script>