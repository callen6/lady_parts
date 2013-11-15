$(function () {
	Cast.getActors();
})

var Cast = { // closure, namespace
	getActors: function(director_films) {
		$.ajax( {
			url: '/films/cast',
			data: {director_films: director_films}, 
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
				svg = d3.select('#cast_svg')
					.append('svg')
					.attr('height', h)
					.attr('width', w)
					.attr("id", "barchart")
					.style('border', '2px solid black'),
		
				height = d3.scale
								.linear()
								.domain([0, 3])
								.range([0, h]),
				color = d3.scale
                .ordinal()
                .domain(["1", "2", "3"])
                .range(["#FF7F00", "#F5F732", "#42A87A"]);
		svg.selectAll('rect')
			.data(films)
			.enter()
			.append('rect')
			.attr('x', function(data, index) {
				return w/dataLength * index;
			})
			.attr('height', function(data, index) {
				return height(data.bechdel_rating);
			})
			.attr('width', barWidth)
			.attr('y', function(data, index){
				return h - height(data.bechdel_rating);
			})
			.attr("fill", function(d, index){
				return color(d.bechdel_rating);
			})


	$('rect').tipsy({ 
		gravity: 'w', 
		html: true, 
		title: function() {
			var d = this.__data__;
			return "<h2>" + d.title + "</h2> " + "<h3>" + d.cast[0][0] + ", " + d.cast[1][0] + ", " + d.cast[2][0] + ", " + d.cast[3][0] + ", " + d.cast[4][0] + "</h3>"; 
		}
	});

	}

	sortDirector: function() {
		var dropdown = d3.select("#director_sources"),
			director_films = { directors: dropdown.node().options[dropdown.node().selectedIndex].attributes.directors.value};
		d3.json(director_films, function(json){
			Cast.getActors(director_films);
		});
	}



}