$(function() {
  Ladyparts.getFilms();
});

var Ladyparts = {

  getFilms: function() {
      $.ajax({
        url: '/',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
          console.log(data);
      }
  });
  }
}