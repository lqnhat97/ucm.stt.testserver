<template>
  <div class="head">
    <router-link to="/"><div>
      <h1 id="head">UMC</h1>
    </div></router-link>
    <div class="head">
      <!--<div style="padding-right:5pt"><img src="../assets/h2.png" alt="Avartar" height="42pt" width="42pt"></div>
      <div>
        <h4>{{ doctor_name }}</h4>
      </div>
      <div class="dropdown" style="margin-top:7pt">

        <a href="#" class="dropdown-toggle " data-toggle="dropdown"><span class="caret"></span></a>

        <ul class="dropdown-menu dropdown-menu-right" role="menu">
          <li class="menu-item"><a href="#">Đăng xuất</a></li>
        </ul>
      </div>-->
    </div>
  </div>
</template>

<script>
  /* eslint-disable */
  export default {
    name: "Header",
    data() {
      return {
        doctor_name: "Hoàng Công Lương"
      }
    }
  }
</script>



