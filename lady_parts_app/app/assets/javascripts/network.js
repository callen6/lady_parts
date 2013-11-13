$(function () {
	Cast.getActors();
})

var Cast = {
	getActors: function() {
		$.ajax( {
			url: '/films/cast', 
			type: 'GET', 
			dataType: 'json',
			success: function(actors) {
				console.log(actors);

			}
		})
	}
}