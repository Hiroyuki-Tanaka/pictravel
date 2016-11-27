



$(function(){


   // プルダウンメニュー
   // ======================================================

   var flag1 = 0;
   var flag2 = 0;

   $("#toggle").click(function(){

      if(flag1 == 1){ flag1 = 0; }
      else{ flag1 = 1; }

      $("#menu").slideToggle();
      return false;

   });

   $("#toggleS").click(function(){

      if(flag2 == 1){ flag2 = 0; }
      else{ flag2 = 1; }

      $("#headSearch").slideToggle();
      return false;

   });

   $(window).resize(function(){

      var win = window.innerWidth;
      //var win = $(window).width();
      var p = 767;

      if(win > p){

         $("#menu").show();
         $("#headSearch").show();

      }
      else {

         if(flag1 == 0){

            $("#menu").hide();

         }

         if(flag2 == 0){

            $("#headSearch").hide();

         }

      }

   });


   // トップに戻る
   // ======================================================

   $("#backtop").hide();
	
   $(function () {

      $(window).scroll(function () {

         if ($(this).scrollTop() > 100) {

            $('#backtop').fadeIn();

         }
         else {

            $('#backtop').fadeOut();

         }

      });

      $('#backtop a').click(function () {

         $('body,html').animate({

            scrollTop: 0

         }, 500);

         return false;

      });

   });


});



