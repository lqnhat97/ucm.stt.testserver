<template>

  <div class=" col-sm-3" id="sidebar">
    <div class="nav-left">
      <div class="ava"><img src="../assets/h3.jpg" alt="" class="relative; background-left">
      </div>
      <div class="container-fluid list-option">
        <div class="panel-group">
          <div class="panel panel-default" id="changepanel">
            <div class="panel-body" :id="this.currentTab == 1? this.changecolor_now:this.changecolor"
              >
              <h4 class=" panel-title">
                <router-link  to="/">Tiếp nhận</router-link>
              </h4>
            </div>
          </div>
          <div class="panel panel-default" id="changepanel">
            <div class="panel-body" :id="this.currentTab == 2? this.changecolor_now:this.changecolor"
              >
              <h4 class="panel-title">
                <router-link  to="/khamBenh">Khám bệnh</router-link>
              </h4>
            </div>
          </div>

          <div class="panel panel-default" id="changepanel">
            <div class="panel-body"  :id="this.currentTab == 3? this.changecolor_now:this.changecolor">
              <h4 class="panel-title"> <a data-toggle="collapse" href="#collapse2">Phòng khám</a>
              </h4>
            </div>
            <div id="collapse2" class="panel-collapse collapse">
              <ul class="list-group">
                <li class="list-group-item" id="changecolortext">
                  <router-link  id="changepanel" to="/danhSachPhongKham">Danh
                    sách phòng khám</router-link>
                </li>
                <li class="list-group-item" id="changecolortext">
                  <router-link  id="changepanel" to="/chiTietPhongKham">Chi
                    tiết phòng khám</router-link>
                </li>
                <!-- <li class="list-group-item" id="changecolortext">
                  <router-link  id="changepanel" to="/quanLySoPhongKham">Quản
                    lý số</router-link>
                </li> -->
              </ul>
            </div>
          </div>
        </div>

        <div class="panel panel-default" id="changepanel">
          <div class="panel-body"  :id="this.currentTab == 4? this.changecolor_now:this.changecolor">
            <h4 class="panel-title">
              <a data-toggle="collapse" href="#collapse3">Phòng cận lâm sàng</a>
            </h4>

          </div>
          <div id="collapse3" class="panel-collapse collapse">
            <ul class="list-group">
              <li class="list-group-item" id="changecolortext">
                <router-link  id="changepanel" to="/chiTietCanLamSang">Chi tiếp
                  phòng cận lâm sàng</router-link>
              </li>
              <li class="list-group-item" id="changecolortext">
                <router-link  id="changepanel" to="/quanLySoCanLamSang">Quản lý
                  số</router-link>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>

</template>

<script>
  /* eslint-disable */
  export default {
    name: "Sidebar",
    props:{
      currentTab:{
        type: Number,
        default: 0
      }
    },
    data() {
      return {
        activeItem: 'TiepNhan',
        changecolor_now:'changecolor-now',
        changecolor: 'changecolor'
      }
    },  
  }
</script>

<style scoped>
</style>