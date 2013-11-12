$(function() {
  Ladyparts.getFilms();
});

var Ladyparts = {

  getFilms: function() {
      $.ajax({
        url: '/',
        type: 'GET',
        dataType: 'json',
        success: function(films) {
          console.log(films);
          Ladyparts.plotFilms(films);
      }
  });
  },

  plotFilms: function(films) {
    var h = 600, w = 1000,
    svg = d3.select('#container')
            .append('svg')
            .attr('height', h)
            .attr('width', w)
            .style('border','2px solid black');
  }

}