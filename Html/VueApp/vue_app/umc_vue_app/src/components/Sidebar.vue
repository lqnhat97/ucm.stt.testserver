<template>

  <div class=" col-sm-3" id="sidebar">
    <div class="nav-left">
      <div class="ava"><img src="../assets/h3.jpg" alt="" class="relative; background-left">
      </div>
      <div class="container-fluid list-option">
        <div class="panel-group">
          <div class="panel panel-default" id="changepanel">
            <div class="panel-body" id="changecolor-now">
              <h4 class="panel-title">
                <router-link to="/">Tiếp nhận</router-link>
              </h4>
            </div>
          </div>
          <div class="panel panel-default" id="changepanel">
            <div class="panel-body" id="changecolor">
              <h4 class="panel-title">
                <a href="WKhamBenh.html">Khám bệnh</a>
              </h4>
            </div>
          </div>

          <div class="panel panel-default" id="changepanel">
            <div class="panel-body" id="changecolor">
              <h4 class="panel-title">
                <a data-toggle="collapse" href="#collapse2">Phòng khám</a>
              </h4>
            </div>
            <div id="collapse2" class="panel-collapse collapse">
              <ul class="list-group">
                <li class="list-group-item" id="changecolortext"><router-link to="/taoPhieuKham"><a id="changepanel" href="WDanhSachPhongKham.html">Danh
                    sách phòng khám</a></router-link></li>
                <li class="list-group-item" id="changecolortext"><a id="changepanel" href="WThongKePhongKham.html">Thống
                    kê</a></li>
              </ul>
            </div>
          </div>
        </div>

        <div class="panel panel-default" id="changepanel">
          <div class="panel-body" id="changecolor">
            <h4 class="panel-title">
              <a href="WChiTietPhongCanLamSang.html">Phòng cận lâm sàng</a>
            </h4>
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
  }
</script>


