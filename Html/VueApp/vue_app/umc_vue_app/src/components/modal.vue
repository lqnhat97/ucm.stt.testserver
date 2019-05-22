<template>
  <!-- Modal -->
  <div class="modal fade" id="findCmndModal" tabindex="-1" role="dialog" aria-labelledby="findCmndModalTitle"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="findCmndModalTitle">Thông báo</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body" v-text="message">

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: "modal",
    props: {
      message: {
        type: String,
        default: ""
      }
    },
  };

</script>
