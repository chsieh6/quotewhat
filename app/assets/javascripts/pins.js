$(function(){

  // Load all the pins on Isotope once the page is ready
  function loadPin() {
    $container.imagesLoaded(function(){
      $container.masonry({
        itemSelector: '.box',
        isFitWidth: true
      });
    });
    // Load all the buttons that goes onto the pins
    pageLoad();
  }

  // Function that loads all the buttons and its animation when hover overs the images
  function pageLoad() {
    $('.add_button').hide();
    $('.like_button').hide();
      
     //If it is not the current user
    $('.box').hover(function(){
      $($(this).find('.add_button, .like_button')).show();
    }, function (){
      $($(this).find('.add_button, .like_button')).hide();
    });
  }

  // Start of Pin Initialization
  var $container = $('#masonry-container');
  loadPin();

  // Infinite Scroll setup with a isotope callback
  $container.infinitescroll({
    navSelector  : '.pagination',    // selector for the paged navigation 
    nextSelector : '.next_page a',  // selector for the NEXT link (to page 2)
    itemSelector : '.box',     // selector for all items you'll retrieve
    loading: {
        finishedMsg: 'No more images to load.',
        img: 'http://i.imgur.com/qkKy8.gif'
      }
    },
    // Call Isotope as a callback to reorganize the pins
    function( newElements ) {
      var $newElems = $(newElements);
      $newElems.imagesLoaded(function(){
        $container.masonry('appended', $newElems );
      });
      pageLoad();
    }
  );

})
