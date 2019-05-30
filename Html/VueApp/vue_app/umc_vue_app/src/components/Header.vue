<template>
  <div id="bodyHeader">
    <div class="col-sm-offset banner-name">
      <h1 style="color:#67cf9c">HỆ THỐNG BỆNH VIỆN<br></h1>
      <div id="main">
        <button v-if="this.isOpen==false" class="openbtn" @click="openNav">☰ Menu </button>
        <button v-else class="openbtn" @click="closeNav">☰ Menu</button>
        <router-link to="/">
          <div>
            <h1 id="head">UMC</h1>
          </div>
        </router-link>
      </div>

    </div>
  </div>

</template>

<script>
  /* eslint-disable */
  export default {
    name: "Header",
    data() {
      return {
        doctor_name: "Hoàng Công Lương",
        isOpen: false
      }
    },
    methods: {
      openNav() {
        document.getElementById("sidebar").style.width = "300px";
        document.getElementById("bodyHeader").style.marginLeft = "300px";
        document.getElementById("bodyContent").style.marginLeft = "300px";

        this.isOpen = true;
        this.$emit('update', this.isOpen);
      },
      closeNav() {
        document.getElementById("sidebar").style.width = "0";
        document.getElementById("bodyHeader").style.marginLeft = "0";
        document.getElementById("bodyContent").style.marginLeft = "0";

        this.isOpen = false;
        this.$emit('update', this.isOpen);
      },
    },
    mounted() {
      this.$emit('update', this.isOpen);
    }

  }

</script>
<style scoped>
  @media screen and (max-height: 450px) {
    #sidebar {
      padding-top: 15px;
    }

    #sidebar a {
      font-size: 18px;
    }
  }

  #main {
    display: inherit;
    transition: margin-left .5s;
    padding: 15px;
    position: absolute;
  }

  .openbtn {
    font-family: Segoe UI;
    font-size: 20px;
    cursor: pointer;
    color: #67cf9c;
    padding: 10px 15px;
    border: none;
  }

  .openbtn:hover {
    color: #67cf9c;
  }

  .banner-name {
    display: flex;
    flex-direction: column;
    text-align: center;
    font-family: 'Segoe UI';
  }

</style>
