/**
	**options to have following keys:
		**searchText: this should hold the value of search text
		**searchPlaceHolder: this should hold the value of search input box placeholder
**/
(function($){
	$.fn.tableSearch = function(options){
		if(!$(this).is('table')){
			return;
		}
		var tableObj = $(this),
			searchText = (options.searchText)?options.searchText:'Search: ',
			searchPlaceHolder = (options.searchPlaceHolder)?options.searchPlaceHolder:'',
			className = (options.className)?options.className:'',
			id = (options.id)?options.id:'';
			divObj = $('<div style="float:right;">'+searchText+'</div><br /><br />'),
			formObject = $('<div class="row"><div class="col-md-12"><form class="form-inline" id="'+id+'"><input type="text" class="'+className+'" placeholder="'+searchPlaceHolder+'" /> <input type="submit" class="btn btn-default" value="Filter" /></form></div></div>'),
			caseSensitive = (options.caseSensitive===true)?true:false,
			searchFieldVal = '',
			pattern = '';
        formObject.on('submit', function(e){
			e.preventDefault();
			searchFieldVal = $(this).find('input').val();
			pattern = (caseSensitive)?RegExp(searchFieldVal):RegExp(searchFieldVal, 'i');
			if(searchFieldVal == '') {
                tableObj.find('tbody tr').show();
			} else {
                tableObj.find('tbody tr').hide().each(function(){
                    var currentRow = $(this);
                    currentRow.find('th').each(function(){
                        if(pattern.test($(this).html())){
                            currentRow.show();
                            return false;
                        }
                    });
                });
			}
		});
		tableObj.before(divObj.append(formObject));
		return tableObj;
	}
}(jQuery));