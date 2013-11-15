$(function() {
// hide both charts onload
  $('#cast_svg').hide();
  $('#barchart1').hide();
  $('#about-bechdel').hide();

  var dropdown = d3.select("#json_sources");
  dropdown.on("change", Ladyparts.change)
  Ladyparts.change(); //trigger json on load

  $('#bechdel_about').on('click', function(e){
    $('#cast_svg').hide();
    $('#barchart1').hide();
    $('#about').toggle('hide');
    $('#about-bechdel').toggle('show');
  });

  $('#hideshow').on('click', function(e){
    $('#cast_svg').hide();
    $('#about').toggle('hide');
    $('#about-bechdel').hide();
    $('#barchart1').toggle('show');
  });

  var director_dropdown = d3.select("#director_sources");
  director_dropdown.on("change", Cast.sortDirector)
  Cast.sortDirector();

  $('#cast_button').on('click', function(e){
    $('#barchart1').hide();
    $('#about').toggle('hide');
    $('#about-bechdel').hide();
    $('#cast_svg').toggle('show');
    });

    $('#json_sources').on('change', function(e) {
      $('#year-info').text(this.options[e.target.selectedIndex].text);
    });

    

    $('#explain').tipsy({ 
        gravity: 'ne', 
        html: true, 
        title: function() {
          return "<h5>Green: passes 3/3 questions</h5><h5>Yellow: passes 2/3</h5><h5>Orange: passes 1/3</h5><h5>Red: passes 0/3 questions</h5>"; 
        }
      });

    var easter_egg = new Konami();
    easter_egg.load('http://www.youtube.com/watch?v=F6ImxY6hnfA')

});
