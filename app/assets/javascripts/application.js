// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require turbolinks
//= require bootstrap
//= require_tree .

(function () {
  var t;
  t = function () {
    var t, e, n;
    return n = $(".tech__main__inner__side"), t = $(".tech__main__footer"), e = $(".footer-inner"), n.height() > 0 ? e.show() : $(window).on("scroll", function () {
      return $(window).scrollTop() + $(window).height() > t.offset().top + t.outerHeight() / 4 ? e.fadeIn() : e.fadeOut()
    })
  }, $(document).on("turbolinks:load", t)
}).call(this),
(function () {
  var t;
  t = function () {
    var t, e, n;
    return e = $(".toggle-menu"), t = $(".tech__menu"), e.on("click", function (e) {
      return e.preventDefault(), "0px" === t.css("left") ? t.animate({
        left: -200
      }, 300) : t.animate({
        left: 0
      }, 300)
    }), n = t.find("nav").attr("data-tag-request"), t.find("nav li").removeClass("active"), t.find('nav li[data-tag="' + n + '"]').addClass("active")
  }, $(document).on("turbolinks:load", t)
}).call(this);
