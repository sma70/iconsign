$j = jQuery.noConflict();

$j(function(){
	$j.getJSON('/items', function(data){	
         if(data != null && data.length !=0)
         	$j('#SearchInput').autocomplete({source:data})
	})
})
