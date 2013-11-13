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
}