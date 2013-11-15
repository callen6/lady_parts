$(function () {
	Cast.getActors();
})

var Cast = { // closure, namespace
	getActors: function(director_passing_films) {
		$.ajax( {
			url: '/films/director',
			data: {director_passing_films: director_passing_films}, 
			type: 'GET', 
			dataType: 'json',
			success: function(films) {
				d3.select("#director").remove(),
				Cast.plotFilms(films);
			}
		});
	},

	
	

	plotFilms: function(films) {
		var h = 600, 
				w = 1150, 
				dataLength = films.length, 
				barWidth = w/dataLength, 
				svg = d3.select("#dpmvis")
					.append('svg')
					.attr('height', h)
					.attr('width', w)
					.attr("id", "director")
					.style('border', '2px solid black'),
		
				height = d3.scale
								.linear()
								.domain([0, 100])
								.range([0, h]),
				color = d3.scale
                .ordinal()
                .domain(["0", "1", "2", "3"])
                .range(["#E80C2C", "#FF7F00", "#F5F732", "#42A87A"]);
		svg.selectAll('rect')
			.data(films)
			.enter()
			.append('rect')
			.attr('x', function(data, index) {
				return w/dataLength * index;
			})
			.attr('height', function(data, index) {
				return height(data.critics_score);
			})
			.attr('width', barWidth)
			.attr('y', function(data, index){
				return h - height(data.critics_score);
			})
			.attr("fill", function(d, index){
				return color(d.bechdel_rating);
			})


	$('rect').tipsy({ 
		gravity: 'w', 
		html: true, 
		title: function() {
			var d = this.__data__;
			return "<h2>" + d.title + "</h2> " + "<h3>" + d.director + "</h3>" + "<h4>" + d.cast[0][0] + ", " + d.cast[1][0] + ", " + d.cast[2][0] + ", " + d.cast[3][0] + ", " + d.cast[4][0] + "</h4>" + "<p>Bechdel rating: " + d.bechdel_rating + "</p>"; 
		}
	});

	},

	sortDirector: function() {
		var dropdown = d3.select("#director_sources"),
			director_passing_films = { dpm: dropdown.node().options[dropdown.node().selectedIndex].attributes.dpm.value};
		d3.json(director_passing_films, function(json){
			Cast.getActors(director_passing_films);
		});
	}
}