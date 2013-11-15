var Ladyparts = {

  getFilms: function(year_range) {
      $.ajax({
        url: '/films/barchart',
        data: {year_range: year_range},
        type: 'GET',
        dataType: 'json',
        success: function(films) {
          d3.select("#barchart").remove(),
          d3.select("#donut").remove(),
          Ladyparts.plotFilms(films);
          // Ladyparts.donutChart(films);
      }
  });
  },

// donut chart - in progress
//   donutChart: function(films) {
//     var width = 960,
//     height = 500,
//     radius = Math.min(width, height) / 2,

//     color = d3.scale.ordinal()
//               .range(["#E80C2C", "#FF7F00", "#F5F732", "#42A87A"]),

//     arc = d3.svg.arc()
//             .outerRadius(radius - 10)
//             .innerRadius(radius - 70),

//     pie = d3.layout.pie()
//             .sort(null)
//             .value(function(d) { return d.critics_score; }),

//     svg = d3.select("donut").append("svg")
//             .attr("width", width)
//             .attr("height", height)
//             .append("g")
//             .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

// what to do with this
//     d3.json('/films/barchart', function(json) {
//       data = json,
//       console.log(data);
//       debugger;
//       data.forEach(function(d) {
//         d.title = +d.title;
//         d.critics_score = +d.critics_score;
//       }),

//     g = svg.selectAll(".arc")
//       .data(pie(data))
//     .enter().append("g")
//       .attr("class", "arc");

//   g.append("path")
//       .attr("d", arc)
//       .style("fill", function(d) { return color(d.data.bechdel_rating); });

//   g.append("text")
//       .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
//       .attr("dy", ".35em")
//       .style("text-anchor", "middle")
//       .text(function(d) { return d.data.age; });

// });

//   },

  // below is for the barchart

  plotFilms: function(films) {
    var h = 600,
        w = 1150, 
        dataLength = films.length,
        barWidth = w/dataLength,
        svg = d3.select('#vis1')
          .append('svg')
          .attr('height', h)
          .attr('width', w)
          .attr("id", "barchart")
          .style('border','2px solid black'),
        // tooltip = d3.select("#vis1")
        //   .append("div")
        //   .style("position", "absolute")
        //   .style("z-index", "10")
        //   .style("visibility", "hidden")
        //   .text("Film"),
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
        // .call(d3.helper.tooltip()
        //   .attr({class: function(d, i) { return d + ' ' +  i + ' A'; }})
        //   .style({color: 'blue'})
        //   .text(function(d, i){ return d.title; })
        //   )
        .on('mouseenter', function(d,i){
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
        .on('mouseover', function(d,i){
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

//     $(document).on('change', '#json_sources', function(e) {
//     $('#year-info').text(this.options[e.target.selectedIndex].text);
//     $('#barchart-info').text("Percent of Films that pass: ");
// });
    

    $('explain').on('click', function(e){

    });

    $('rect').tipsy({ 
        gravity: 'w', 
        html: true, 
        title: function() {
          var d = this.__data__;
          return '<h2>' + d.title + "</h2> " + "<h3>" + d.critics_score + "</h3>"; 
        }
      });

// for changing graph based on dropdown
  

  }, 
  change: function() {
    var dropdown = d3.select("#json_sources"),
        year_range = {
          start_year: dropdown.node().options[dropdown.node().selectedIndex].attributes.start_year.value, 
          end_year: dropdown.node().options[dropdown.node().selectedIndex].attributes.end_year.value};
    d3.json(year_range, function(json) {
      Ladyparts.getFilms(year_range);
      // Pass the year/page
    });
  }
}