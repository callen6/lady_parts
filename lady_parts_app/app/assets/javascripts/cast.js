$(function () {
	Cast.getActors();
})

var Cast = {
	getActors: function() {
		$.ajax( {
			url: '/films/cast', 
			type: 'GET', 
			dataType: 'json',
			success: function(films) {
				console.log(films);
			}
		});
	}

	plotFilms: function(films) {
		var h = 600, 
				w = 1200, 
				dataLength = films.length, 
				barWidth = w/dataLength, 
				svg = d3.select('#vis2')
					.append('svg')
	}



}