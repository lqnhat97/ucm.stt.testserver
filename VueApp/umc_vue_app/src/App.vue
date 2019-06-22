<template>
  <div id="app">
      <Header @update="handleIsOpen"/>
      <Sidebar/>
    <router-view :isOpen="headerIsOpen"/>
  </div>
</template>

<script>
import Header from './components/Header';
import Sidebar from './components/Sidebar.vue'

export default {
  name: 'App',
  data(){
    return {
      headerIsOpen:false,
    }
  },
  components:{
    Header,
    Sidebar
  },
  methods:{
    handleIsOpen(isOpen){
      this.headerIsOpen = isOpen;
    },
  }
}
</script>

<style>
  @import '../UMCC.css';
</style>


