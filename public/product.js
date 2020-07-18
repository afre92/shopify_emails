function loadReaviews() {
  var shopifyId = $("#shopify-product-reviews").data('id');
  $.get( `${window.location.origin}/a/s`, { id: shopifyId })
    .done(function(data){
      
      console.log('dara recieved')
      // data.replace(/&quot;/g, '"').replace(/&ldquo;/g, '"').replace(/&rdquo;/g, '"').replace(/lsquo;/g, '"').replace(/&rsquo;/g, '"').replace(/&lt;/g, '<').replace(/&gt;/g, '>')
      debugger
      var list = data.map((review) => {
      `<div class="review" style="border-bottom: 1px black solid;">
              <div>
                number of stars here
              </div>
              <div style="padding-top:10px; padding-bottom: 10px;">
                <div>
                  <b>Title </b>
                </div>
                <div>
                  Andres Rojas
                </div>
              </div>
              <div style="padding-bottom: 20px;">
                and the description goes here
              </div>
            </div>`})
            debugger
            
    })
    .fail(function(){
      console.log("something failed")
    })
  // console.log("hello there in the produc page")
  }
if ($("#shopify-product-reviews").length > 0) {
loadReaviews();
};