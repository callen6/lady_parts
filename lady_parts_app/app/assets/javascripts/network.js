$(function () {
	Network.getActors();
})

var Network = {
	getActors: function() {
		$.ajax( {
			url: '/films/network'
		})
	}
}