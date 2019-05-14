<template>
  <div class="ChiTietCanLamSang">
      <Header/>
      <Sidebar/>
    <div class="col-sm-9 ">
      <div class="col-sm-11  form-group" id="cliente" style="background-color: #F8F8F8;position:center">
        <form style=" border-bottom: 2px solid #bbbbbb">
          <div class="row">
            <div class="col-sm-6 form-group" style="display:flex; align-items:center">
              <div class="col-sm-4"> <label class="control-label" for="chuyenkhoa" id="search-name">Chuyên khoa</label>
              </div>
              <div class="search-box col-sm-8" style="height:30pt">
                <input type="text" id="chuyenkhoa" class="form-control" placeholder="Nội soi">
                <button class="btn btn-link search-btn"> <i class="glyphicon glyphicon-search"></i>
                </button>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="row">
                <div class="col-sm-4"> <label for="sophong" id="search-name">Loại dịch vụ</label>
                </div>
                <div class="search-box col-sm-7" style="height:30pt"> <input type="text" id="sophong"
                    class="form-control" placeholder="Nội soi">
                  <button class="btn btn-link search-btn"> <i class="glyphicon glyphicon-search"></i>
                  </button>
                </div>
              </div>
              <div class="row">
                <div class="col-sm-4"> <label for="sophong" id="search-name">Tên dịch vụ</label>
                </div>
                <div class="search-box col-sm-7" style="height:30pt"> <input type="text" id="sophong"
                    class="form-control" placeholder="Nội soi thực quản-dạ dày, lấy dị vật">
                  <button class="btn btn-link search-btn"> <i class="glyphicon glyphicon-search"></i>
                  </button>
                </div>
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
                <th>Bệnh nhân</th>
                <th>Số còn chờ</th>
                <th>Tốc độ nhảy số</th>
                <th>Thời gian khám số cuối</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td class="number">401</td>
                <td class="number">2000</td>
                <td>Nguyễn Hoàng Sơn</td>
                <td class="number">5</td>
                <td class="number">5 phút</td>
                <td class="number">9h15</td>
              </tr>
              <tr>
                <td class="number">402</td>
                <td class="number">2002</td>
                <td>Nguyễn Hoàng Sơn</td>
                <td class="number">5</td>
                <td class="number">5 phút</td>
                <td class="number">9h15</td>
              </tr>
              <tr>
                <td class="number">403</td>
                <td class="number">2011</td>
                <td>Nguyễn Hoàng Sơn</td>
                <td class="number">5</td>
                <td class="number">5 phút</td>
                <td class="number">9h15</td>
              </tr>
              <tr>
                <td class="number">404</td>
                <td class="number">2020</td>
                <td>Nguyễn Hoàng Sơn</td>
                <td class="number">5</td>
                <td class="number">5 phút</td>
                <td class="number">9h15</td>
              </tr>
              <tr>
                <td class="number">405</td>
                <td class="number">2045</td>
                <td>Nguyễn Hoàng Sơn</td>
                <td class="number">5</td>
                <td class="number">5 phút</td>
                <td class="number">9h15</td>
              </tr>
              <tr>
                <td class="number">406</td>
                <td class="number">2015</td>
                <td>Nguyễn Hoàng Sơn</td>
                <td class="number">5</td>
                <td class="number">5 phút</td>
                <td class="number">9h15</td>
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
  import Header from './Header.vue'
  import Sidebar from './Sidebar.vue'
  export default {
    name: 'ChiTietPhongKham',
    components: {
      Header,
      Sidebar
    },
  }
</script>