<template>

  <div id="sidebar">
    <h2 style="text-align:center;color:white">UMC.STT</h2>
    <div class="nav-left">
      <div class="container-fluid list-option">
        <div class="panel-group">
          <div class="panel panel-default" id="changepanel">
            <div class="panel-body" @click="handleClicked"
              :id="this.currentTab == 5? this.changecolor_now:this.changecolor">
              <h4 class=" panel-title">
                <router-link to="/dashboard">Dashboard</router-link>
              </h4>
            </div>
          </div>
          <div class="panel panel-default" id="changepanel">
            <div class="panel-body" @click="handleClicked"
              :id="this.currentTab == 1? this.changecolor_now:this.changecolor">
              <h4 class=" panel-title">
                <router-link to="/">Tiếp nhận</router-link>
              </h4>
            </div>
          </div>
          <div class="panel panel-default" id="changepanel">
            <div class="panel-body" @click="handleClicked"
              :id="this.currentTab == 2? this.changecolor_now:this.changecolor">
              <h4 class="panel-title">
                <router-link to="/khamBenh">Khám bệnh</router-link>
              </h4>
            </div>
          </div>

          <div class="panel panel-default" id="changepanel">
            <div class="panel-body" :id="this.currentTab == 3? this.changecolor_now:this.changecolor">
              <h4 class="panel-title"> <a data-toggle="collapse" href="#collapse2">Phòng khám</a>
              </h4>
            </div>
            <div id="collapse2" class="panel-collapse collapse">
              <ul class="list-group">
                <li class="list-group-item" id="changecolortext" @click="handleClicked">
                  <router-link id="changepanel" to="/quanLyBacSi">Phân công lịch khám</router-link>
                </li>
                <li class="list-group-item" id="changecolortext" @click="handleClicked">
                  <router-link id="changepanel" to="/danhSachPhongKham">Chi tiết phòng khám
                  </router-link>
                </li>
                <li class="list-group-item" id="changecolortext" @click="handleClicked">
                <router-link id="changepanel" to="/themThanhVien" >Thêm nhân viên</router-link>
              </li>
              <li class="list-group-item" id="changecolortext" @click="handleClicked">
                <router-link id="changepanel" to="/dashboardLs" >Màn hình hiển thị STT trước phòng</router-link>
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
          <div class="panel-body" :id="this.currentTab == 4? this.changecolor_now:this.changecolor">
            <h4 class="panel-title">
              <a data-toggle="collapse" href="#collapse3">Phòng cận lâm sàng</a>
            </h4>

          </div>
          <div id="collapse3" class="panel-collapse collapse">
            <ul class="list-group">
              <li class="list-group-item" id="changecolortext"  @click="handleClicked">
                <router-link id="changepanel" to="/quanLyPhongCanLamSang">Quản lý phòng cận lâm sàng
                </router-link>
              </li>
              <li class="list-group-item" id="changecolortext" @click="handleClicked">
                <router-link id="changepanel" to="/thoiGianChoDvCls" >Chỉ định thời gian thực hiện dịch vụ</router-link>
              </li>
              <li class="list-group-item" id="changecolortext" @click="handleClicked">
                <router-link id="changepanel" to="/chiTietCanLamSang" >Chi tiếp phòng cận lâm sàng</router-link>
              </li>
              <li class="list-group-item" id="changecolortext" @click="handleClicked">
                <router-link id="changepanel" to="/dashboardCls" >Màn hình hiển thị STT trước phòng</router-link>
              </li>
              <!-- <li class="list-group-item" id="changecolortext">
                <router-link id="changepanel" to="/quanLySoCanLamSang">Quản lý
                  số</router-link>
              </li> -->
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
    data() {
      return {
        currentTab: 1,
        activeItem: 'TiepNhan',
        changecolor_now: 'changecolor-now',
        changecolor: 'changecolor'
      }
    },
    methods: {
      handleClicked(e) {
        this.execLink(e.srcElement.hash)
      },
      execLink(link) {
        switch (link) {
          case "#/": {
            this.currentTab = 1;
            break;
          }
          case "#/khamBenh": {
            this.currentTab = 2;
            break;
          }
          case "#/quanLyBacSi": {
            this.currentTab = 3;
            break;
          }
          case "#/danhSachPhongKham": {
            this.currentTab = 3;
            break;
          }
          case "#/quanLyPhongCanLamSang": {
            this.currentTab = 4;
            break;
          }
          case "#/chiTietCanLamSang": {
            this.currentTab = 4;
            break;
          }
          case "#/dashboard": {
            this.currentTab = 5;
            break;
          };
          case "#/themThanhVien": {
            this.currentTab = 3;
            break;
          };
          case "#/dashboardLs": {
            this.currentTab = 3;
            break;
          };
          case "#/thoiGianChoDvCls": {
            this.currentTab = 4;
            break;
          };
          case "#/dashboardLs": {
            this.currentTab = 4;
            break;
          }
        }
      }
    },
    created() {
      let pathname = window.location.href;
      this.execLink('#'+pathname.split('#')[1]);
    }
  }

</script>

<style scoped>
  #sidebar {
    height: 100%;
    width: 0;
    position: fixed;
    z-index: 1;
    top: 0;
    left: 0;
    overflow-x: hidden;
    transition: 0.5s;
    padding-top: 50px;
    background-color: #7595b4;
  }

  #sidebar a {
    padding: 8px 8px 8px 32px;
    text-decoration: none;
    display: block;
    transition: 0.3s;
  }

  #sidebar a:hover {
    color: #f1f1f1;
  }

  #sidebar .closebtn {
    position: absolute;
    top: 0;
    right: 25px;
    font-size: 36px;
    margin-left: 50px;
  }

</style>
