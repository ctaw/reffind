//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree ./vendor/bootstrap
//= require vendor/ekko-lightbox.min.js
//= require_tree .

$(document).ready(function ($) {
    // delegate calls to data-toggle="lightbox"
    $(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
        event.preventDefault();
        return $(this).ekkoLightbox();
    });
});
