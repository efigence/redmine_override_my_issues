(function($){
  var my_page = {
    init: function(){
      this.bindSelectPer();
    },

    bindSelectPer: function(){
      $('#select-per').change(function(){
        var per = parseInt($('#select-per').val()),
            url = window.location.href;
        $.ajax({
          url: url,
          type: "GET",
          data: { 'per' : per },
          success: function(data){
            document.open();
            document.write(data);
            document.close();
          }
        })
      });
    }
  }

  $(function(){
    my_page.init();
  });
})(jQuery)