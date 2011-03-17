$(function() {

  $("#section, ul#tabs li.current").noisy({
    noise: 0.9,
    titleSize: 200,
    backgroundColor: '#fafafa',
    maxNoiseOpacity: 0.055,
    monochromatic: false
  });

  $("#add_price").click(function(){
    $("#price_dialog").dialog({
      // height: 400,
      width: 480,
      resizable: false,
      zIndex: 10000,
      modal: true
    });
  });

  /* Sign up and sign in */

  $("a#signup, a#signin").click(function() {
    var _a = this;

    jQuery.facebox(function() {
      jQuery.get($(_a).attr("href")+".js");
    })

    return false;
  });

  $("a.submit").live("click", function(){
    $(this).parent().parent().submit();

    return false;
  });

});
