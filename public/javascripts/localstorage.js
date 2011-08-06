var TOP_ITEMS = 5
var stopList = new Array();
var countList = new Array();
//var session = sessionStorage;
var local = localStorage;
var path = window.location.pathname
document.observe("dom:loaded", function() {
	// if($("most_viewed_label"))
		// $("most_viewed_label").hide()
	storeCountList()
	var ind = path.indexOf('items')
	if(ind != -1){//in show page
		var parts = path.slice(ind).split('/')
		if(parts.length==2 && !isNaN(parts[1])){
			if(!local.getItem(parts[1]))
				local.setItem(parts[1],[1,$("title").innerHTML])
			else
				local.setItem(parts[1], [parseInt(local.getItem(parts[1]))+ 1,$("title").innerHTML])
		}
	}
	else//in index
		mostViewed();
});

function storeCountList(){
	if(local.length > 0){
		//$("most_viewed_label").show()
		for(var i=0; i<local.length; i++){
			var val=local.getItem(local.key(i))
			countList.push(val.substring(0,val.indexOf(',')))
		}
	}		
}

function mostViewed(){
	var rank = new Array();
	origList = countList.slice(0)
	countList.sort(function(a,b){return b-a})
	var tops = countList.slice(0,TOP_ITEMS);
	var index
	for(var i=0; i<TOP_ITEMS && i < countList.length; i++){
		index = origList.indexOf(tops[i])
		rank.push(local.key(index))
		origList[index]=0;
	}
	if(rank.length > 0)
		displayResult(rank)
}

		
function displayResult(list){
	var html='<h3>Most Viewed Items</h3><ul>';
	for(var i = 0 ; i < list.length;i++){
		var url = window.location.host + "/items/" + list[i]
		//alert(url)
		var val = local.getItem(list[i])
		var name = val.substring(val.indexOf(',')+1)
		if(name.length > 15)
			name = name.substring(0,15) + ".."
		html += '<li>Top&nbsp;' + (i+1) + ':&nbsp;<a href="http://' + url + '">' + name + '</a></li>'
	}
	html += '</ul>'
	$("most_viewed").innerHTML = html
}

function storeStopList() {
	//get stop word
	if(local.length ==0) {
		new Ajax.Request("/get_stop", {
			method: 'get',
			onSuccess: function(transport) {
				var data = transport.responseText.evalJSON();
				for(var i=0;i<data.length; i++) {
					local[data[i]] = 1
				}
			}
		});
	}
}