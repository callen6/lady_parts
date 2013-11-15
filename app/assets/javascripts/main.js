$(function() {
// hide both charts onload
  $('#cast_svg').hide();
  $('#barchart1').hide();
  $('#about').hide();

  var dropdown = d3.select("#json_sources");
  dropdown.on("change", Ladyparts.change)
  Ladyparts.change(); //trigger json on load

  $('#bechdel_about').on('click', function(e){
    $('#cast_svg').hide();
    $('#barchart1').hide();
    $('#about').toggle('show');
  });

  $('#hideshow').on('click', function(e){
    $('#cast_svg').hide();
    $('#about').hide();
    $('#barchart1').toggle('show');
  });

  $('#cast_button').on('click', function(e){
    $('#barchart1').hide();
    $('#about').hide();
    $('#cast_svg').toggle('show');
    });

    $('#json_sources').on('change', function(e) {
      $('#year-info').text(this.options[e.target.selectedIndex].text);
      $('#barchart-info').text("Percent of Films that pass: ");
    });
});
