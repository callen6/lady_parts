$(function() {
  // 1) On the page load, getFilms with default value of pre-1960 (or dropdown value)
  
  var dropdown = d3.select("#json_sources");
  dropdown.on("change", Ladyparts.change)
  Ladyparts.change(); //trigger json on load

  $('#hideshow').on('click', function(e){
    $('#barchart1').toggle('show');
  });
});
