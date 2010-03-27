/*
 * jQuery Flickr - jQuery plug-in
 * Version 1.0, Released 2008.04.17
 *
 * Copyright (c) 2008 Daniel MacDonald (www.projectatomic.com)
 * Dual licensed GPL http://www.gnu.org/licenses/gpl.html 
 * and MIT http://www.opensource.org/licenses/mit-license.php
 */
(function($) {
  $.fn.flickr = function(o) {
    var s = {
      api_key: null,
      photoset_id: null
    };
    return this.each(function() {
      var list = $('<ul>');
      $(this).html(list);
      $.getJSON($.flickr.format($.extend(s, o)), function(r) {
        console.log(r);
        if (r.stat != "ok") {
          for (i in r) {
            $('<li>').text(i + ': ' + r[i]).appendTo(list);
          }
        } else {
          $(r.photoset.photo).each(function(i, elem) {
            list.append(
              $.flickr.build_photo_markup(elem).data({
                width: elem.width_o,
                height: elem.height_o
              })
            );
          });
          if (o.callback) o.callback();
        }
      });
    });
  };

  $.flickr = {
    build_photo_markup: function(photo) {
      return $('<li />').append(
        $('<h2 />').html(photo.title)
      ).append(
        $('<img />').attr('src', photo['url_o']).attr('alt', photo['title'])
      )
    },
    format: function(s) {
      return 'http://api.flickr.com/services/rest/?format=json&jsoncallback=?&api_key=' + s.api_key +
             '&method=flickr.photosets.getPhotos&photoset_id=' + s.photoset_id +
             '&extras=original_format,url_o';
    }
  };
})(jQuery);
