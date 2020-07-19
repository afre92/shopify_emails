if ($("#shopify-product-reviews").length > 0) {
  loadReaviews();
  paginationHandler();
};

function loadReaviews() {
  var shopifyId = $("#shopify-product-reviews").data('id');
  getReviews({ id: shopifyId });
}

function paginationHandler(){
  $('body').on('click', 'a.page-link',function(e){
    e.preventDefault();
    var searchParams = new URLSearchParams($(this).attr('href'))
    var shopifyId = $("#shopify-product-reviews").data('id');
    getReviews({ id: shopifyId, page: searchParams.get('page') })
  });
}

function getReviews(params){
  $.get( `${window.location.origin}/a/s`, params)
  .done(function(data){
    $('#reviews-list').html(data)
  })
  .fail(function(){
    console.log("something failed")
  })
}
