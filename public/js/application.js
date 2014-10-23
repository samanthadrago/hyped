$(document).ready(function () {
  bindEvents();
  console.log('blah')
});

function bindEvents() {
  $('form.search-movies').on('submit', searchMovies);
  $('.search-results').delegate('button.add-movie', 'click', addMovie);
  $('.list').delegate('button.mark-watched', 'click', markWatched);
  $('.list').delegate('button.favorite', 'click', favorite);
};

function searchMovies(e) {
  e.preventDefault();
  $.ajax({
    url: '/movies',
    type: 'get',
    data: $('form.search-movies').serialize()
  }).done(displayMovie)
};

function displayMovie(response){
  $('div.search-results').empty();
  $('div.search-results').append(response)
};

function addMovie(e) {
  e.preventDefault();
  var data = {
    id: $('.movie-result').attr('id'),
    title: $('.result-title').html(),
    year: $('.result-year').html(),
    rating: $('.result-rating').html(),
    img: $('.result-img').attr('src'),
    url: $('p.result-url > a').attr('href'),
    similar_url: $('p.result-url > a').attr('href'),
  };
  // debugger;
  $.ajax({
    url: '/movies',
    type: 'post',
    data: data
  }).done(refreshHyplist)
};

function refreshHyplist(response) {
  $('.list').empty();
  $('.search-results').empty();
  $('.list').append(response)
}

function markWatched(e) {
  e.preventDefault();
  var data = {
    id: $(this).closest('div').attr('id')
  };
  // debugger;
    $.ajax({
    url: '/watched',
    type: 'post',
    data: data
  }).done(refreshHyplist)
};

function favorite(e) {
  e.preventDefault();
  var data = {
    id: $(this).closest('div').attr('id')
  };
  debugger;
    $.ajax({
    url: '/favorite',
    type: 'post',
    data: data
  }).done(refreshWatchedList)
};

function refreshWatchedList(response) {
  $('section.watched-list').empty();
  $('section.watched-list').append(response)
}