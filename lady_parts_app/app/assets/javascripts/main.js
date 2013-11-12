$(function() {
  Ladyparts.getFilms();
});

var Ladyparts = {

  getFilms: function() {
      $.ajax({
        url: '/',
        type: 'GET',
        cache: false,
        dataType: 'json',
        success: function(films) {
          console.log(films);
      }
  });
  }
}