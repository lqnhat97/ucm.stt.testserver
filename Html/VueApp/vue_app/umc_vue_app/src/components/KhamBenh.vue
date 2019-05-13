<template>
  <div class="KhamBenh">
    <Header />
    <Sidebar />
    <div class="col-md-9 form-group">
      <div class="row">
        <div class="col-sm-5" id="cliente">
          <form style=" border-bottom: 2px solid #bbbbbb">
            <div class="row" style="padding:10pt">
              <div class="col-md-4"> <label class="control-label" for=""
                  style="color:#969696;padding:8pt;margin-left: 3pt">Mã bệnh nhân</label>
              </div>
              <div class="search-box col-md-6" style="height:30pt">
                <input type="text" id="" class="form-control" placeholder="">
                <button class="btn btn-link search-btn"> <i class="glyphicon glyphicon-search"></i>
                </button>
              </div>
            </div>
          </form>
          <form action="" style=" border-bottom: 2px solid #bbbbbb">
            <p>Thông tin bệnh nhân</p>
            <div class="row form-group">
              <label for="" class="col-sm-3 col-form-label">Họ và tên</label>
              <div class="col-sm-5">
                <input type="text" value="" class="form-control">
              </div>
              <label for="" class="col-sm-2 col-form-label" style="text-align:right">Giới
                tính</label>
              <div class="col-sm-2">
                <input type="text" value="" class="form-control" style="margin-right: 10px;">
              </div>
            </div>

            <div class="row form-group">
              <label for="" class="col-sm-3 col-form-label">Ngày sinh</label>
              <div class="col-sm-5">
                <input type="text" value="" class="form-control">
              </div>
              <label for="" class="col-sm-2 col-form-label" style="text-align:right">Tuổi</label>
              <div class="col-sm-2">
                <input type="text" value="" class="form-control">
              </div>
            </div>

            <div class="row form-group">
              <label for="" class="col-sm-3 col-form-label">Quê quán</label>
              <div class="col-sm-3">
                <input type="text" value="" class="form-control">
              </div>
              <label for="" class="col-sm-3 col-form-label" style="text-align:right">CMND/CCCD</label>
              <div class="col-sm-3">
                <input type="text" value="" class="form-control">
              </div>
            </div>

            <div class="row form-group">
              <label for="" class="col-sm-3 col-form-label">Địa chỉ</label>
              <div class="col-sm-9">
                <input type="text" value="" class="form-control">
              </div>
            </div>

            <div class="row form-group">
              <label for="" class="col-sm-3 col-form-label">Nghề nghiệp</label>
              <div class="col-sm-3">
                <input type="text" value="" class="form-control">
              </div>
              <label for="" class="col-sm-3 col-form-label" style="text-align:right">Số điện
                thoại</label>
              <div class="col-sm-3">
                <input type="text" value="" class="form-control">
              </div>
            </div>

            <div class="row form-group">
              <label for="" class="col-sm-3 col-form-label">Người thân</label>
              <div class="col-sm-9">
                <input type="text" value="" class="form-control">
              </div>
            </div>
          </form>
          <p style="text-align:center">Các thông tin khác</p>
        </div>
        <div class="col-sm-6" id="cliente">
          <form style=" border-bottom: 2px solid #bbbbbb; padding:10pt">
            <p>Phiếu khám và chỉ định</p>
          </form>
          <div>
            <form action="" style="margin-top: 10px">
              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label">Mã phiếu khám</label>
                <div class="col-sm-3">
                  <input type="text" value="" class="form-control">
                </div>
                <label for="" class="col-sm-3 col-form-label" style="text-align:right">Ngày
                  khám</label>
                <div class="col-sm-3">
                  <input type="text" value="" class="form-control">
                </div>
              </div>

              <div class="row form-group">
                <label for="" class="col-sm-3 col-form-label">Triệu chứng</label>
                <div class="col-sm-9">
                  <input type="text" value="" class="form-control">
                </div>
              </div>
              <hr color="black" />
              <div class="row form-group">
                <label for="" class="col-sm-5 col-form-label">Chỉ định cận lâm sàng 1</label>
                <div class="col-sm-7">
                  <input type="text" value="" class="form-control">
                  <!-- <small id="passwordHelpBlock" class="form-text text-muted">
                                            <div class="small">
                                                <span>Phí</span>
                                                <span>150.000 VNĐ</span>
                                            </div>
                                        </small> -->
                </div>
              </div>

              <div class="row form-group">
                <label for="" class="col-sm-5 col-form-label">Chỉ định cận lâm sàng 2</label>
                <div class="col-sm-7">
                  <input type="text" value="" class="form-control">
                  <!-- <small id="passwordHelpBlock" class="form-text text-muted">
                                            <div class="small">
                                                <span>Phí</span>
                                                <span>150.000 VNĐ</span>
                                            </div>
                                        </small> -->
                </div>
              </div>

              <div class="row form-group">
                <label for="" class="col-sm-5 col-form-label">Chỉ định cận lâm sàng 3</label>
                <div class="col-sm-7">
                  <input type="text" value="" class="form-control">
                  <!-- <small id="passwordHelpBlock" class="form-text text-muted">
                                            <div class="small">
                                                <span>Phí</span>
                                                <span>150.000 VNĐ</span>
                                            </div>
                                        </small> -->
                </div>
              </div>
              <div></div>
              <a id="add" href="">Thêm chỉ định</a>
              <br><br><br><br>
              <hr />
              <div class="row">
                <div class="col-sm-4"></div>
                <div class="col-sm-4">
                  <input class="form-group" id="buttom" type="submit" value="Chỉ định">
                </div>
              </div>
              <!-- <div class="small">
                                    <span>Tổng cộng</span>
                                    <span>450.000 VNĐ</span>
                                </div>
                                <hr />
                                <div class="row">
                                    <label for="" class="col-sm-9 col-form-label">Số tài khoản</label>
                                    <label for="" class="col-sm-3 col-form-label">Tình trạng</label>
                                </div>
                                <div class="row" style="margin-bottom:10px;">
                                    <div class="col-sm-9"><input type="text" value="" class="form-control"></div>
                                    <div class="col-sm-3"><small id="passwordHelpInline" class="text-muted"><span
                                                style="color: rgb(9, 173, 214); text-align: right">Số dư
                                                đủ</span></small></div>
                                </div> -->
            </form>

          </div>
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
    name: 'KhamBenh',
    components: {
      Header,
      Sidebar
    },
  }

</script>

<!--<style>
  @import '../../UMCC.css';
</style>-->
