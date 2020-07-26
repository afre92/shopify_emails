if ($("#shopify-product-reviews").length > 0) {
  loadReviews();
  paginationHandler();
};

function loadReviews() {
  var shopifyId = $("#shopify-product-reviews").data('id');
  getReviews({ id: shopifyId, method: 'reviews' });
}

function paginationHandler(){
  $('body').on('click', 'a.page-link',function(e){
    e.preventDefault();
    var searchParams = new URLSearchParams($(this).attr('href'))
    var shopifyId = $("#shopify-product-reviews").data('id');
    getReviews({ id: shopifyId, page: searchParams.get('page') })
  });
}

function loadReviewImages(id) {
  var shopifyId = $("#shopify-product-reviews").data('id');

  // getReviews({ id: shopifyId, method: 'reviews' });
}


$('body').on('click', '.review-photo',function(e){
  var reviewId = $(this).parent('div.review-images-wrapper').data('review-id');
  $.get( `${window.location.origin}/a/s`, {review_id: reviewId, method: 'review_images'})
  .done(function(data){
    $('#moda-container-99').html(data)
    debugger
    $('#reviewModal').show();
    // try to find source code for modal and if not then add bootrap js :/
    // paste modal and show
  })
  .fail(function(){
    console.log("something failed")
  })
})

function getReviews(params){
  $.get( `${window.location.origin}/a/s`, params)
  .done(function(data){
    $('#reviews-list').html(data)
  })
  .fail(function(){
    console.log("something failed")
  })
}
