$(function() {
  var lesson = $("#lesson");

  $("#section, ul#tabs li.current, body").noisy({
    noise: 0.9,
    titleSize: 200,
    backgroundColor: '#fafafa',
    maxNoiseOpacity: 0.055,
    monochromatic: false
  });

  $("#query").autocomplete({
    minLength: 2,
    source: "/universities",
    select: function(event, ui) {
      window.location = location.origin+"/universities/"+ui.item.id;
    }
  });

  lesson.autocomplete({
    minLength: 2,
    source: lesson.data("complete")+"/lessons",
    select: function(event, ui) {
      window.location = lesson.data("complete")+"/lessons/"+ui.item.id;
    }
  });

  $("a[data-compare]").hover(function() {
    var compareData = $(this).data("compare"),
        compareFields = ["score_5", "score_4", "score_3", "test", "attestation", "course_work"];

    _.each(compareFields, function(item) {
      var diff = compareData[item];

      if (diff != undefined) {
        $("input[name*="+item+"]").val(diff).addClass("diff");
      }
    });
  }, function() {
    $(".diff").removeClass("diff");
    $("input[data-previous]").each(function(item) {
      var input = $(this);

      input.val(input.data("previous"));
    });
  });

  $(".notice, .alert").click(function() {
    $(this).fadeOut();
  });

  setTimeout(function() {
    $(".notice, .alert").fadeOut();
  }, 2500);
});
