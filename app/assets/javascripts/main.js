$(function() {
// hide both charts onload
  $('#cast_svg').hide();
  $('#barchart1').hide();

  var dropdown = d3.select("#json_sources");
  dropdown.on("change", Ladyparts.change)
  Ladyparts.change(); //trigger json on load

  $('#hideshow').on('click', function(e){
    $('#cast_svg').hide();
    $('#barchart1').toggle('show');
  });
  
  $('#cast_button').on('click', function(e){
    $('#barchart1').hide();
    $('#cast_svg').toggle('show');

  });
});
