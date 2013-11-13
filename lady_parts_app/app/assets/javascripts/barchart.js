var Ladyparts = {

  getFilms: function(year_range) {
      $.ajax({
        url: '/films/barchart',
        data: {year_range: year_range},
        type: 'GET',
        dataType: 'json',
        success: function(films) {
          console.log(films);
          d3.select("#barchart").remove(),
          Ladyparts.plotFilms(films);
      }
  });
  },

  plotFilms: function(films) {
    var h = 600,
        w = 1200, 
        dataLength = films.length,
        barWidth = w/dataLength,
        svg = d3.select('#vis1')
          .append('svg')
          .attr('height', h)
          .attr('width', w)
          .attr("id", "barchart")
          .style('border','2px solid black'),
        height = d3.scale
                .linear()
                .domain([0, 100])
                .range([0, h]),
        color = d3.scale
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

// for changing graph based on dropdown
  

  }, 
  change: function() {
    var dropdown = d3.select("#json_sources"),
        year_range = {
          start_year: dropdown.node().options[dropdown.node().selectedIndex].attributes.start_year.value, 
          end_year: dropdown.node().options[dropdown.node().selectedIndex].attributes.end_year.value};
    d3.json(year_range, function(json) {
      console.log(year_range)
      Ladyparts.getFilms(year_range); // Pass the year/page
    });
  }
}