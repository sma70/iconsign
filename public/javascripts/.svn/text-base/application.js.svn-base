$j = jQuery.noConflict();

$j(function (){
	//item status change and dates
	$j('#item_start_date').datepicker()
	$j('#item_expiry_date').datepicker()
	$j('#item_item_status_id').change(function(){
		var today = new Date()
		if(this.value==2){//set to for_sale
			$j('#item_start_date').val((today.getMonth()+1) + '/' + today.getDate() + '/' + today.getFullYear())
			$j('#item_expiry_date').val((today.getMonth()+4) + '/' + today.getDate() + '/' + today.getFullYear())
		}
		if(this.value==3){//set to free
			$j('#item_expiry_date').val((today.getMonth()+1) + '/' + today.getDate() + '/' + today.getFullYear())
			$j('#item_price').val(0);
			$j('#item_price').attr("disabled", "disabled");
		}
		else{
			$j('#item_price').attr("disabled", false);
		}
	});
	//item show image and thumnails
	$j('ul.thumbnails li img').hover(function(){
		$j('div.main_img img').attr('src',$j(this).attr('src').replace('thumb','medium'))
	});
	//item edit image prevent adding more than 4 images
	$j('#add_image').click(function(){
		var count = $j('.item_img_thumb').length + $j('.item_add_img fieldset').length
		if(count >= 4 && $j('#add_image:visible'))
			$j('#add_image').hide()
	})
	//item edit image prevent deleting all images
    $j(".img_check").change(function(){
    	if ($j('.img_check:checked').length == $j('.img_check').length){
    		alert("You need to keep at least one image for the item")
    		$j('.img_check').attr("checked", false);
    	}
    })
    //tablesorters
    $j("#my_orders").tablesorter();$j("#my_items").tablesorter()
    $j("#admin_orders1").tablesorter(); $j("#admin_orders2").tablesorter()
    $j("#admin_orders3").tablesorter(); $j("#admin_orders4").tablesorter()
    $j("#admin_orders5").tablesorter(); 
    $j("#admin_items1").tablesorter(); $j("#admin_items2").tablesorter();
    $j("#admin_items3").tablesorter(); $j("#admin_items4").tablesorter(); 
    $j("#admin_items5").tablesorter(); 
    $j("#admin_items5").tablesorter(); 
    
    
});