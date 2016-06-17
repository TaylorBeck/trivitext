$(document).ready(function() {

  $('#play-again').hide();
  $('#good-luck').hide();
  $('#high-scores').hide();

  $('#text-form').on('submit', function(event){
    event.preventDefault();

    $.ajax({
      method: $(this).attr('method'),
      url: $(this).attr('action'),
      data: $(this).serialize()
    });

    $('#text-form').hide('slow');
    $('#text-form').trigger('reset');
    $('#good-luck').show();
    $('#play-again').show();
    $('#enter-number').hide();
  });

  $('#play-again').on('click', function(event){
    event.preventDefault();

    $('#text-form').trigger('reset');
    $('#enter-number').show('slow');
    $('#play-again').hide();
    $('#good-luck').hide();
    $('#text-form').show('slow');
  })

  $('#high-scores-link').on('click', function(event){
    event.preventDefault();

    $(this).hide();
    $('#high-scores').show('slow');
  });

  $('#hide-scores').on('click', function(event){
    event.preventDefault();

    $('#high-scores').hide('slow');
    $('#high-scores-link').show('slow')
  });

});
