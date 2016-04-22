
/**
 * 分页查询
 * @param url 请求地址，如：'/user/load.action'
 * @param params 请求参数，如：{name:value, name:value}
 * @param func 列表展示函数，参数pageList.list
 */
function loadByPage(url, params, func, container){
	var t = typeof container!='undefined'?container:$('#tableBody')[0];
	var e = $('#page_d')[0]?$('#page_d')[0]:$('.table_under_btn .flip')[0];
	var settings = {
			params: params,
			container: t,
			pagingContainer: e,
			pageSizeSelectValues: [10, 20, 30, 50, 100]
	};
	var pagedQuery = new PagedQuery(url, settings, func);
	pagedQuery.post();
}

/**
 * 分页查询类
 * @param url 请求地址
 * @param params 请求参数 {id:1, name:"tom", ...}
 * @param callback 数据处理回调函数，参数：pageList.list，需要返回处理好的html内容
 * @param settings {container:（列表数据容器，DOM对象）, pagingContainer:（分页操作栏的容器DOM对象）, pageSizeSelectValues:（每页显示数量下拉值Array）
 * }
 * @returns {PagedQuery}
 */
function PagedQuery(url, settings, callback){
	if(typeof url!='string')return null;
	if(typeof settings=='function'){
		this.callback = settings;
		settings = {};
	}else if(typeof callback=='function'){
		this.callback = callback;
	}else{
		return null;
	}
	this.loadingImage = '/skins/blue/images/loading.gif';
	this.url = url;
	this.params = typeof settings.params!='undefined'?settings.params:{};
	this.pageSize = (typeof this.params.pageSize!='undefined' && this.params.pageSize.constructor==Number)?parseInt(this.params.pageSize):0;
	this.container = settings.container;
	this.pagingContainer = typeof settings.pagingContainer=='object' ? settings.pagingContainer : null;
	this.pageSizeSelectValues = (typeof settings.pageSizeSelectValues=='object' && settings.pageSizeSelectValues.constructor==Array) ? settings.pageSizeSelectValues : [];
	/**
	 * 分页数据请求
	 */
	this.post = function(){
		if(this.isLoading)return;
		this.lockWindow();
		var pq = this;
		if(this.pageSizeSelect){
			$(this.pageSizeSelect).attr('disabled', 'disabled');
			this.params.pageSize = this.pageSizeSelect.value;
		}
		$.post(url, this.params, function(data){
			if(typeof data == 'string')data = data.replaceAll('\t', '&nbsp;&nbsp;&nbsp;&nbsp;');
			var pageList = $.parseJSON(data);
			if(pageList){
				pq.params.currentPage = pageList.currentPage;
				pq.params.pageSize = pageList.pageSize;
				pq.updatePaging(pageList);
				var html = pq.callback(pageList.list);
				if(pq.container!=null)$(pq.container).html(html);
			}else{
				if(this.pagingContainer)$(pq.pagingContainer).empty();
			}
			pq.openLock();
		});
	};
	/**
	 * 首页按钮对象
	 */
	this.firstPageButton = null;
	/**
	 * 上一页按钮对象
	 */
	this.prevPageButton = null;
	/**
	 * 当前页码显示对象
	 */
	this.currentPageSpan = null;
	/**
	 * 总页数显示对象
	 */
	this.totalPageSpan = null;
	/**
	 * 下一页按钮对象
	 */
	this.nextPageButton = null;
	/**
	 * 尾页按钮对象
	 */
	this.lastPageButton = null;
	/**
	 * 每页数量显示对象
	 */
	this.pageSizeSelect = null;
	/**
	 * 总记录数显示对象
	 */
	this.totalSizeSpan = null;
	/**
	 * 初始化分页操作栏
	 */
	this.paging = function(){
		if(this.pagingContainer==null)return;
		$(this.pagingContainer).empty();
		var pq = this;
		if(this.firstPageButton==null){
			this.firstPageButton = document.createElement('a');
			this.firstPageButton.innerHTML = '首页';
			$(this.firstPageButton).css('cursor', 'not-allowed');
			$(this.firstPageButton).click(function(){pq.toFirstPage();});
		}
		$(this.pagingContainer).append(this.firstPageButton);
		if(this.prevPageButton==null){
			this.prevPageButton = document.createElement('a');
			this.prevPageButton.innerHTML = '上一页';
			$(this.prevPageButton).css('cursor', 'not-allowed');
			$(this.prevPageButton).click(function(){pq.toPrevPage();});
		}
		$(this.pagingContainer).append(this.prevPageButton);
		if(this.currentPageSpan==null){
			this.currentPageSpan = document.createElement('span');
		}
		$(this.pagingContainer).append(this.currentPageSpan);
		$(this.pagingContainer).append('/');
		if(this.totalPageSpan==null){
			this.totalPageSpan = document.createElement('span');
		}
		$(this.pagingContainer).append(this.totalPageSpan);
		if(this.nextPageButton==null){
			this.nextPageButton = document.createElement('a');
			this.nextPageButton.innerHTML = '下一页';
			$(this.nextPageButton).css('cursor', 'not-allowed');
			$(this.nextPageButton).click(function(){pq.toNextPage();});
		}
		$(this.pagingContainer).append(this.nextPageButton);
		if(this.lastPageButton==null){
			this.lastPageButton = document.createElement('a');
			this.lastPageButton.innerHTML = '尾页';
			$(this.lastPageButton).css('cursor', 'not-allowed');
			$(this.lastPageButton).click(function(){pq.toLastPage();});
		}
		$(this.pagingContainer).append(this.lastPageButton);
		
		if(this.pageSize>0){
			var hs = new HashSet(this.pageSizeSelectValues);
			hs.add(this.pageSize);
			hs.sort(function(a, b){return a>b;});
		}
		this.minPageSize = 0;
		if(this.pageSizeSelectValues && this.pageSizeSelectValues.length>0){
			if(this.pageSizeSelect==null){
				this.pageSizeSelect = document.createElement('select');
				var pq = this;
				$(this.pageSizeSelect).change(function(){pq.post();});
				for ( var item in this.pageSizeSelectValues) {
					var optionValue = this.pageSizeSelectValues[item];
					if(optionValue>0 && (this.minPageSize==0 || this.minPageSize>optionValue))this.minPageSize=optionValue;
					var option = document.createElement('option');
					option.value = optionValue;
					option.innerHTML = optionValue;
					if(this.params && this.pageSize && this.pageSize==parseInt(optionValue)){
						option.selected = 'selected';
					}
					this.pageSizeSelect.appendChild(option);
				}
				$(this.pageSizeSelect).attr('disabled', 'disabled');
			}
			$(this.pagingContainer).append(' 每页显示');
			$(this.pagingContainer).append(this.pageSizeSelect);
			$(this.pagingContainer).append('条 ');
		}
		if(this.totalSizeSpan==null){
			this.totalSizeSpan = document.createElement('span');
		}
		$(this.pagingContainer).append(this.totalSizeSpan);
	};
	this.paging();
	/**
	 * 更新分页操作栏信息
	 */
	this.updatePaging = function(pageList){
		if(this.pagingContainer==null)return;
		if(pageList.totalSize<=this.minPageSize){
			$(this.pagingContainer).empty();
			return;
		}
		this.totalPage = pageList.totalPage;
		if(pageList.currentPage>1){
			$(this.firstPageButton).css('cursor', 'pointer');
			$(this.prevPageButton).css('cursor', 'pointer');
		}else{
			$(this.firstPageButton).css('cursor', 'not-allowed');
			$(this.prevPageButton).css('cursor', 'not-allowed');
		}
		if(pageList.currentPage<this.totalPage){
			$(this.lastPageButton).css('cursor', 'pointer');
			$(this.nextPageButton).css('cursor', 'pointer');
		}else{
			$(this.lastPageButton).css('cursor', 'not-allowed');
			$(this.nextPageButton).css('cursor', 'not-allowed');
		}
		this.currentPageSpan.innerHTML = ' '+pageList.currentPage;
		this.totalPageSpan.innerHTML = this.totalPage+' ';
		if(this.pageSizeSelect!=null){
			$(this.pageSizeSelect).children().each(function(){
				if($(this).val()==pageList.pageSize){
					$(this).attr('selected', 'selected');
				}else{
					$(this).removeAttr('selected');
				}
			});
			$(this.pageSizeSelect).removeAttr('disabled');
		}
		this.totalSizeSpan.innerHTML = " 共 "+pageList.totalSize+" 记录";
	};

	/**
	 * 到首页
	 */
	this.toFirstPage = function(){
		if(this.params.currentPage>1){
			this.params.currentPage = 1;
			this.post();
		}
	};
	/**
	 * 上一页
	 */
	this.toPrevPage = function(){
		if(this.params.currentPage>1){
			this.params.currentPage--;
			this.post();
		}
	};
	/**
	 * 下一页
	 */
	this.toNextPage = function(){
		if(this.params.currentPage<this.totalPage){
			this.params.currentPage++;
			this.post();
		}
	};
	/**
	 * 到尾页
	 */
	this.toLastPage = function(){
		if(this.params.currentPage<this.totalPage){
			this.params.currentPage = this.totalPage;
			this.post();
		}
	};
	
	this.isLoading = false;
	this.maskLayer = null;
	this.maskLayerContent = null;
	/**
	 * 锁屏
	 */
	this.lockWindow = function(){
		if(this.isLoading){
			
		}else{
			this.isLoading = true;
			if(this.maskLayer==null){
				this.maskLayer = $('<div style="background: #000; opacity: 0.2; filter:alpha(opacity=20); width: 100%; height: 100%; z-index: 200; position:fixed; _position:absolute; top:0; left:0;"></div>');
			}
			if(this.maskLayerContent==null){
				this.maskLayerContent = $('<div id="lockContent" style="left:50%; margin-left:-20px; top:50%; margin-top:-20px; position:fixed; _position:absolute; z-index: 201; overflow: hidden;">'+
				'	<div class="nodata"><img src="'+this.loadingImage+'"></img></div>'+
				'</div>');
			}
			$('body').append(this.maskLayer);
			$('body').append(this.maskLayerContent);
		}
	};
	/**
	 * 解除锁屏
	 */
	this.openLock = function(){
		this.isLoading = false;
		$(this.maskLayer).remove();
		$(this.maskLayerContent).remove();
	};
}
function HashSet(arr){
	var array = (typeof arr!='undefined' && arr.constructor==Array)?arr:new Array();
	this.add = function(obj){
		var isContaine = false;
		for ( var item in array) {
			if(array[item]==obj){
				isContaine = true;
				break;
			}
		}
		if(isContaine)return;
		array.push(obj);
	};
	this.addAll = function(_arr){
		if(typeof _arr!='undefined' && _arr.constructor==Array){
			for ( var item in _arr) {
				this.add(_arr[item]);
			}
		}
	};
	this.getArray = function(){
		return array;
	};
	this.remove = function(obj){
		var tmp = new Array();
		for ( var item in array) {
			if(array[item]==obj)continue;
			tmp.push(array[item]);
		}
		array = tmp;
	};
	this.clear = function(){
		array = new Array();
	};
	this.sort = function(callback){
		if(typeof callback=='function'){
			for ( var i = 0; i < array.length; i++) {
				for ( var j = i+1; j < array.length; j++) {
					if(callback(array[i], array[j])){
						var tmp = array[i];
						array[i] = array[j];
						array[j] = tmp;
					}
				}
			}
		}
	};
}

//获取记录开始序号 add by lfq
function getIndex(list){
	if($(".flip > span").length>0){
		var pageSize=$(".flip > select:eq(0)").val().trim();
		var currentPage=$(".flip > span:first").text().trim();
		return (currentPage-1)*pageSize;
	}else{
		return 0;
	}
}