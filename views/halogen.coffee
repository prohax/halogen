resize_photos: ->
  $('.photos li').css {
    'width': $(window).width(),
    'height': $(window).height()
  }

window.get_dimensions: (sizes) ->
  {
    'width': sizes.image_w,
    'height': sizes.image_h
  }

$(window).resize resize_photos

# domready
$ ->
  $('.photos').flickr {
    'api_key': '4d24030c9ead700bb60d5abfc7a21faf',
    'photoset_id': '72157623711281550',
    'callback': resize_photos
  }
