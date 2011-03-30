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

  $("#query").autocomplete({
    minLength: 2,
    source: "/universities"
  });
});
