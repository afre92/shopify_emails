function loadReaviews() {
  var shopifyId = $("#shopify-product-reviews").data('id');
  $.get( `${window.location.origin}/a/s`, { id: shopifyId })
    .done(function(data){
      $('#reviews-list').html(data)
    })
    .fail(function(){
      console.log("something failed")
    })
  // console.log("hello there in the produc page")
  }
if ($("#shopify-product-reviews").length > 0) {
loadReaviews();
};