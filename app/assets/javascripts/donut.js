
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
