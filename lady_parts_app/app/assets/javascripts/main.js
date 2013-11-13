$(function() {
  Ladyparts.getFilms();
  $('#hideshow').on('click', function(e){
    $('#vis').toggle('show');
  });
});

var Ladyparts = {

  getFilms: function() {
      $.ajax({
        url: '/films/network',
        type: 'GET',
        dataType: 'json',
        success: function(films) {
          console.log(films);
          Ladyparts.plotFilms(films);
      }
  });
  },

  plotFilms: function(films) {
   var h = 600, w = 30000, dataLength = films.length,
    barWidth = w/dataLength,
    svg = d3.select('#vis')
      .append('svg')
      .attr('height', h)
      .attr('width', w)
      .style('border','2px solid black');

    var height = d3.scale
                  .linear()
                  .domain([0, 100])
                  .range([0, h]);

    var color = d3.scale
                  .ordinal()
                  .domain(["0", "1", "2", "3"])
                  .range(["#E80C2C", "#FF7F00", "#F5F732", "#42A87A"]);

      // selectAll iterates over each element
      svg.selectAll('rect')
        .data(films)
        .enter()
        .append('rect')
        //create anon fn that's x value of each element. this has access to data and index of data array
        .attr('x', function(data, index){
          return w/dataLength * index;
        })
        .attr('height', function(data, index){
          return height(data.critics_score);
        })
        .attr('width', barWidth)
        .attr('y', function(data, index){
          return h - height(data.critics_score);
        })
        .attr("fill", function(d, index){
          return color(d.bechdel_rating);
        })
        .on('mouseenter', function(d,i){
          $('#film-info').html("<h2>Film: " + d.title + "</h2>" + "<p>Critics Score on Rotten Tomatoes: " + Number(d.critics_score)) + "</p>" + "<p>Bechdel Rating: " + d.bechdel_rating + "</p>";

          d3.select(this)
            .transition()
            .duration(50)
            .attr('height', function(d,i){
              return height(d.critics_score)+ 40;
            })
            .attr('y', function(d,i){
              return h - height(d.critics_score) - 40;
            })
        })
        .on('mouseleave', function(d,i){
          d3.select(this)
              .transition()
              .duration(1000)
              .attr('height', function(d,i){
              return height(d.critics_score);
            })
              .attr('y', function(d,i){
              return h - height(d.critics_score);
            })
        })

  }
}