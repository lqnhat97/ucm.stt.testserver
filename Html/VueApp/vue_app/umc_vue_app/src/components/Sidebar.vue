<template>

  <div class=" col-sm-3" id="sidebar">
    <div class="nav-left">
      <div class="ava"><img src="../assets/h3.jpg" alt="" class="relative; background-left">
      </div>
      <div class="container-fluid list-option">
        <div class="panel-group">
          <div class="panel panel-default" id="changepanel">
            <div class="panel-body" id="changecolor" :class="{ active: isActive('TiepNhan') }"
              @click="setActive('TiepNhan')">
              <h4 class=" panel-title">
                <router-link @click.prevent="setActive('TiepNhan')" to="/">Tiếp nhận</router-link>
              </h4>
            </div>
          </div>
          <div class="panel panel-default" id="changepanel">
            <div class="panel-body" id="changecolor" :class="{ active: isActive('KhamBenh') }"
              @click="setActive('KhamBenh')">
              <h4 class="panel-title">
                <router-link @click.prevent="setActive('KhamBenh')" to="/khamBenh">Khám bệnh</router-link>
              </h4>
            </div>
          </div>

          <div class="panel panel-default" id="changepanel">
            <div class="panel-body" id="changecolor" :class="{ active: isActive('PhongKham') }"
              @click="setActive('PhongKham')">
              <h4 class="panel-title"> <a data-toggle="collapse" href="#collapse2">Phòng khám</a>
              </h4>
            </div>
            <div id="collapse2" class="panel-collapse collapse">
              <ul class="list-group">
                <li class="list-group-item" id="changecolortext" >
                  <router-link @click.prevent="setActive('PhongKham')" id="changepanel" to="/danhSachPhongKham">Danh
                    sách phòng khám</router-link>
                </li>
                <li class="list-group-item" id="changecolortext">
                  <router-link @click.prevent="setActive('PhongKham')" id="changepanel" to="/chiTietPhongKham">Chi
                    tiết phòng khám</router-link>
                </li>
                <li class="list-group-item" id="changecolortext">
                  <router-link @click.prevent="setActive('PhongKham')" id="changepanel" to="/quanLySoPhongKham">Quản
                    lý số</router-link>
                </li>
              </ul>
            </div>
          </div>
        </div>

        <div class="panel panel-default" id="changepanel">
          <div class="panel-body" id="changecolor" :class="{ active: isActive('CanLamSang') }"
            @click="setActive('CanLamSang')">
            <h4 class="panel-title">
              <a data-toggle="collapse" href="#collapse3">Phòng cận lâm sàng</a>
            </h4>

          </div>
          <div id="collapse3" class="panel-collapse collapse">
            <ul class="list-group">
              <li class="list-group-item" id="changecolortext">
                <router-link @click.prevent="setActive('CanLamSang')" id="changepanel" to="/chiTietCanLamSang">Chi tiếp phòng cận lâm sàng</router-link>
              </li>
              <li class="list-group-item" id="changecolortext">
                <router-link @click.prevent="setActive('CanLamSang')" id="changepanel" to="/quanLySoCanLamSang">Quản lý số</router-link>
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
    data() {
      return {
        activeItem: 'TiepNhan'
      }
    },
    methods: {
      isActive: function (menuItem) {
        return this.activeItem === menuItem
      },
      setActive: function (menuItem) {
        console.log(menuItem);
        this.activeItem = menuItem // no need for Vue.set()
      }

    }
  }

</script>

<style scoped>
  .active {
    background-color: #43cb89;
    border-radius: 5px;
  }

</style>
