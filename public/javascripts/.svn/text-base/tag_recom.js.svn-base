$j = jQuery.noConflict();
var res_list = new Array()
//array naming = underscore
//str naming = camelCased

$j(function(){
	// var origList = $j("#item_tag_list").val()
	// if(origList.length > 0 )
		// origList += ','
	
	$j("#tag_instr").hide()
	$j.getJSON('/items', function(data){	
         if(data != null && data.length !=0)
         	tag_list = data
	})
	var desc = $j("#item_description").val()
	//parse description
	parseInput(desc)
	
	$j("#item_description").keydown(function(event){
		if($j('#item_description').val().length > 2){
			parseInput($j('#item_description').val().toString())
			processText()
		}
	})
	
	$j("#item_tag_list").click(function(){
		var innerHtml = ""
		//var tagList = ""
		for(var i=0; i<res_list.length; i++){
			//tagList += res_list[i] + ","
			innerHtml += '<a href="##" onclick=tagClicker("' +  res_list[i]  + '")>' + res_list[i] + '</a>&nbsp;'
		}
		$j("#rec_list").html(innerHtml)
		
		//tagList = tagList.slice(0,tagList.length-1)
		//$j("#item_tag_list").val( origList + tagList)
		//$j("#rec_list").text($j("#rec_list").val() + res_list)
		if(res_list.length > 0)
			$j("#tag_instr").show()
	})

})

function tagClicker(word){
	//var origList = $j("#item_tag_list").val()
	var list =$j("#item_tag_list").val().replace(/^\s\s*/, '').replace(/\s\s*$/, '').replace(/,\s*|\s+/g,',').toLowerCase().split(',')
	if(!inList(list,word)){
		list.push(word)
		var plist= list.toString()
		if(plist.substring(0,1)==',')
			plist=plist.substring(1,plist.length)
		$j("#item_tag_list").val(plist)
	}
}

function parseInput(str){//deliminater= space or comma
	newStr = str.replace(/,\s*|\s+/g,',').toLowerCase()
	word_list = newStr.split(',')
}

function processText(){
	for(var i=0; i<word_list.length; i++){
		var exist_list =  $j("#item_tag_list").val().replace(/,\s*|\s+/g,',').toLowerCase().split(',')
		if(inList(tag_list,word_list[i]) && !inList(res_list,word_list[i]) && !inList(exist_list,word_list[i]))
			res_list.push(word_list[i])
	}
}

function inList(list,word){
	for(var i=0; i<list.length; i++){
		if(word==list[i])
			return true
	}	
	return false
}

