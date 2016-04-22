
String.prototype.realLength = function(){
	var realLength = 0, len = this.length, charCode = -1;
	for ( var i = 0; i < len; i++) {
		charCode = this.charCodeAt(i);
		if(charCode>=0 && charCode<=128)realLength += 1;
		else realLength += 2;
	}
	return realLength;
};
String.prototype.subMaxLength = function(maxLength){
	var realLength = 0, len = this.length, charCode = -1;
	var tmp = 0;
	for ( var i = 0; i < len; i++) {
		charCode = this.charCodeAt(i);
		if(charCode>=0 && charCode<=128)realLength += 1;
		else realLength += 2;
		if(realLength>maxLength){
			break;
		}else{
			tmp = i+1;
		}
	}
	return this.substring(0, tmp);
};
String.prototype.trim = function(){
	return this.replace(/(^\s*)|(\s*$)/g,"");
};
String.prototype.startWith = function(val){
	if(val){
		var reg = new RegExp("(^"+val+")","g");
		if(reg.test(this)){
			return true;
		}
		return false;
	}else{
		return true;
	}
};
String.prototype.endWith = function(val){
	if(val){
		var reg = new RegExp("("+val+"$)","g");
		if(reg.test(this)){
			return true;
		}
		return false;
	}else{
		return true;
	}
};
String.prototype.replaceAll = function(regString, string){
	var reg = new RegExp(regString,"g");
	return this.replace(reg, string);
};
/**
 * 判断字符串是否全数字组成
 * @param val
 * @returns {Boolean}
 */
String.prototype.onlyDigit = function(){
	var reg = new RegExp("^[0-9]+$","g");
	if(reg.test(this))return true;
	return false;
};
/**
 * 判断字符串是否数字开头
 * @returns {Boolean}
 */
String.prototype.startWithDigit = function(){
	var reg = new RegExp("^[0-9]+","g");
	if(reg.test(this))return true;
	return false;
};
/**
 * 判断字符串是否数字结尾
 * @returns {Boolean}
 */
String.prototype.endWithDigit = function(){
	var reg = new RegExp("[0-9]+$","g");
	if(reg.test(this))return true;
	return false;
};

function reloadValidCode(o) {
	o.src = "/validCode?timed=" + new Date().getMilliseconds(); 
}
function reloadValidCodeById(id) {
	var o = document.getElementById(id);
	o.src = "/validCode?timed=" + new Date().getMilliseconds(); 
}

/**
 * 全选反选
 * @param elementName checkbox组name
 */
function checkAll(elementName) {
	var theEvent = window.event || arguments.callee.caller.arguments[0];
	var srcElement = theEvent.srcElement ? theEvent.srcElement
			: theEvent.target;
	var checkboxs = $(":checkbox[name='" + elementName + "']");
	$(checkboxs).attr("checked", $(srcElement).attr("checked")=='checked'?true:false);
}
/**
 * 获取name=checkboxName已选中复选框的值，多个以“, ”分隔
 * @param checkboxName
 * @returns {String}
 */
function checkedCheckboxValue(checkboxName){
	var values = '';
	$(":checkbox[name='" + checkboxName + "']").each(function(data){
		if($(this).attr('checked')=='checked'){
			if(values!='')values += ', ';
			values += $(this).val();
		}
	});
	return values;
}

/**
 * 格式化浮点数
 * @param n
 * @param pos 保留小数位数
 * @returns {Number}
 */
function fomatFloat(n, pos){
	return Math.round(n*Math.pow(10, pos))/Math.pow(10, pos);
}

/**
 * 输入数值
 */
function floatInput(){
	//小数位数
	var decimal = 2;
	var theEvent = window.event || arguments.callee.caller.arguments[0];
	var srcElement = theEvent.srcElement ? theEvent.srcElement : theEvent.target;
	var vasdf = new String(srcElement.value);
	var reg = new RegExp('^0+', 'g');
	vasdf = vasdf.replace(reg, "");
	if(decimal && !isNaN(decimal) && decimal>0){
		if(vasdf.charAt(0)=='.'){
			vasdf = "0"+vasdf;
		}
		reg = new RegExp('[^0-9.]+', 'g');
		vasdf = vasdf.replace(reg, "");
		if(vasdf.indexOf('.')>-1){
			var s1 = vasdf.substring(0, vasdf.indexOf('.')+1);
			var s2 = vasdf.substring(vasdf.indexOf('.')+1, vasdf.length);
			reg = new RegExp('[.]+', 'g');
			s2 = s2.replace(reg, "");
			s2 = s2.substring(0, decimal);
			vasdf = s1+s2;
		}
	}else{
		reg = new RegExp('[^0-9]+', 'g');
		vasdf = vasdf.replace(reg, "");
	}
	vasdf = vasdf.length<=0?"0":vasdf;
	$(srcElement).val(vasdf);
}
$('.floatInput').live('paste',function(){return false;});
$('.floatInput').live('keyup',floatInput);

$('textarea').live('blur',function(){
	var theEvent = window.event || arguments.callee.caller.arguments[0];
	var srcElement = theEvent.srcElement ? theEvent.srcElement : theEvent.target;
	var vasdf = new String(srcElement.value);
	var reg = new RegExp('\t', 'g');
	vasdf = vasdf.replace(reg, "    ");
	$(srcElement).val(vasdf);
});
$('input[type="text"]').live('blur',function(){
	var theEvent = window.event || arguments.callee.caller.arguments[0];
	var srcElement = theEvent.srcElement ? theEvent.srcElement : theEvent.target;
	var vasdf = new String(srcElement.value);
	var reg = new RegExp('\t', 'g');
	vasdf = vasdf.replace(reg, "    ");
	$(srcElement).val(vasdf);
});

/**
 * 限制只能输入数字
 */
function numerals(){
	var theEvent = window.event || arguments.callee.caller.arguments[0];
	var key_code;
	if(window.event){
		key_code = theEvent.keyCode;
		if(isNumeralsOrCursorOperation(key_code))theEvent.returnValue = false;
	}else{
		key_code = theEvent.which;
		if(isNumeralsOrCursorOperation(key_code))theEvent.preventDefault();
	}
}
/**
 * 判断按键是否是数字、光标移动或删除操作
 * @param key_code
 * @returns {Boolean}
 */
function isNumeralsOrCursorOperation(key_code){
	if((key_code<48 && key_code!=8 && key_code!=37 && key_code!=39 && key_code!=46) || (key_code>105) || (key_code>57 && key_code<96))return true;
	return false;
}
$('.numerals').live('paste',function(){return false;});
$('.numerals').live('keydown',numerals);

//限制文本输入的最大长度，比如textarea，需要添加maxlength属性，maxlength缺省值20(代码开始)
function cutMaxLength(){
	if($(this).attr('class')=='ke-edit-textarea')return;
	var maxLength = $(this).attr('maxlength');
	if(maxLength && !isNaN(maxLength)){
		maxLength = parseInt(maxLength);
	}
	maxLength = maxLength && maxLength>0?maxLength:255;
	if (this.value.realLength() > maxLength) {
		var value = new String(this.value);
		this.value = value.subMaxLength(maxLength);
	}
}
$("input, textarea").live('keydown', cutMaxLength);
$("input, textarea").live('keyup', cutMaxLength);
$("input, textarea").live('drop', cutMaxLength);
$("input, textarea").live('paste', cutMaxLength);
//$("input, textarea").live('change', cutMaxLength);
//限制文本输入的最大长度，比如textarea，需要添加maxlength属性，maxlength缺省值20(代码结束)

var isLoading = false;
/**
 * 异步操作时锁屏（需要主动调用）
 */
function lockWindow(){
	if(isLoading){
		
	}else{
		isLoading = true;
		$('body').append(
				'<div id="lockWindow" style="background: #000; opacity: 0.2; filter:alpha(opacity=20); width: 100%; height: 100%; z-index: 200; position:fixed; _position:absolute; top:0; left:0;">'+
				'</div>'+
				'<div id="lockContent" style="left:50%; margin-left:-20px; top:50%; margin-top:-20px; position:fixed; _position:absolute; height: "+h+"px; width: "+w+"px; z-index: 201; overflow: hidden;">'+
				'	<div class="nodata"><img src="/skins/blue/images/loading.gif"></img></div>'+
				'</div>'
		);
	}
}
/**
 * 异步操作完成时，解除锁屏（需要主动调用）
 */
function openLock(){
	isLoading = false;
	$('#lockWindow').remove();
	$('#lockContent').remove();
}

var urlPageIsLoading = false;
/**
 * 加载url返回的页面到main_right_content
 * @param url
 * @param params
 */
function loadUrlPage(url, params){
	if(urlPageIsLoading){
		
	}else{
		urlPageIsLoading = true;
		lockWindow();
		$.ajax({
			url: url,
			type: 'POST',
			data: params,
			error: function(request, status, error){
				openLock();
				alert(error);
				window.location.href='/login/index.action';
			},
			success: function(data, dataType){
				$(document).die();
				$('#main_right_content').html(data);
				urlPageIsLoading = false;
				openLock();
			}
		});
	}
}


var params_cache = {};
/**
 * 分页查询
 * @param url 请求地址，如：'/user/load.action'
 * @param params 请求参数，如：{name:value, name:value}
 * @param func 列表展示函数，参数pageList.list
 */
function loadByPage(url, params, func){
	lockWindow();
	$.post(url, params, function(data){
		if(data!="<script>window.location.href='/login/index.action';</script>"){
			var pageList = $.parseJSON(data);
			var totalSize = pageList.totalSize;
			var totalPage = pageList.totalPage;
			if(totalPage>1){
				$('.table_under_btn .flip').html(
						'<a href="#" id="firstPage">首页</a>'+
						'<a href="#" id="prevPage">上一页</a>'+
						' <span id="currentPage"></span>/<span id="totalPage"></span> '+
						'<a href="#" id="nextPage">下一页</a>'+
						'<a href="#" id="lastPage">尾页</a>' +
						'<span>跳至<select id="changePage"></select>页</span>'
				);
				$('#totalPage').text(totalPage);
				params_cache.totalPage = totalPage;
				var currentPage = pageList.currentPage;
				$('#currentPage').text(currentPage);
				var pageSize = pageList.pageSize;
				params_cache.url=url;
				params_cache.params=params;
				params_cache.func=func;
				if(currentPage>1){
					$('#firstPage').attr("href", "javascript:firstPage()");
					$('#prevPage').attr("href", "javascript:prevPage()");
				}else{
					$('#firstPage').removeAttr("href");
					$('#prevPage').removeAttr("href");
				}
				if(currentPage<totalPage){
					$('#nextPage').attr("href", "javascript:nextPage()");
					$('#lastPage').attr("href", "javascript:lastPage()");
				}else{
					$('#nextPage').removeAttr("href");
					$('#lastPage').removeAttr("href");
				}
				for(var i = 1; i<=totalPage;i++){
					$("#changePage").append('<option '+(currentPage == i ? 'selected="selected"':'')+'>'+i+'</option>');
				}
				$('#changePage').on('change',function(){
					changePage($('#changePage').children('option:selected').val());
				});
			}else{
				$('.table_under_btn .flip').html('');
			}
			func(pageList.list,totalSize, pageList.pageSize);
		}
		openLock();
	},"text");
}
function firstPage(){
	params_cache.params.currentPage=1;
	loadByPage(params_cache.url, params_cache.params, params_cache.func);
}
function prevPage(){
	params_cache.params.currentPage = params_cache.params.currentPage?params_cache.params.currentPage:1;
	params_cache.params.currentPage = params_cache.params.currentPage-1;
	loadByPage(params_cache.url, params_cache.params, params_cache.func);
}
function nextPage(){
	params_cache.params.currentPage = params_cache.params.currentPage?params_cache.params.currentPage:1;
	params_cache.params.currentPage = params_cache.params.currentPage+1;
	loadByPage(params_cache.url, params_cache.params, params_cache.func);
}
function lastPage(){
	params_cache.params.currentPage=params_cache.totalPage;
	loadByPage(params_cache.url, params_cache.params, params_cache.func);
}
function changePage(pageNum){
	params_cache.params.currentPage=parseInt(pageNum);
	loadByPage(params_cache.url, params_cache.params, params_cache.func);
}


/**
 * 使输入框提示属性placeholder在IE 8.0或以下生效(模拟)
 * @author dzf
 */
function inputPlaceholderAttr(){
	//输入框提示,属性placeholder
	if(navigator.userAgent.toUpperCase().indexOf('MSIE 8.0') != -1 || navigator.userAgent.toUpperCase().indexOf('MSIE 9.0') != -1
			|| navigator.userAgent.toUpperCase().indexOf('MSIE 7.0') != -1 || navigator.userAgent.toUpperCase().indexOf('MSIE 6.0') != -1){
		$(':input').each(function(){
			var placeholder = $(this).attr('placeholder');
			if(placeholder && placeholder != null && placeholder != ''){
				var height = $(this).outerHeight();
				var lineHeightStyle = '';
				var lineHeight = $(this).css('line-height');
				if( lineHeight && lineHeight != '' ){
					lineHeightStyle = lineHeight;
				}else{
					lineHeightStyle = (height += 'px');
				}
				var styleStr = '';
				var copystyle = ['padding','padding-left','padding-bottom','padding-right','padding-top',
				                 'margin','margin-left','margin-bottom','margin-right','margin-top',
				                 'font-size'];
				for ( var j = 0; j < copystyle.length; j++) {
					var style_name = copystyle[j];
					var style_value = $(this).css(style_name);
					if( style_value && style_value != ''){
						styleStr += (style_name+':'+style_value+';');
					}
				}
				var html = '<span class="placeholder_span" style="position: absolute;color:#A9A9A9;line-height: '+lineHeightStyle+';cursor: text;width: auto;text-align: left;'+styleStr+'" onclick="$(this).next().focus();">'+placeholder+'</span>';
				//input 元素浮动处理
				var float = $(this).css('float');
				if( float && float != '' && float != 'none'){
					$(this).wrap('<span style="float:'+float+';"></span>');
					$(this).css('float','none');
				}
				if( $(this).val() == ''){
					$(this).before(html);
				}
				$(this).focus(function(){
					if($(this).data('input_placeholder_data') == undefined ){
						$(this).data('input_placeholder_data', html);
						var labels = $(this).prev('.placeholder_span');
						if(labels.length == 1){
							labels.remove();
						}
					}
				});
				$(this).blur(function(){
					if($(this).val() == ''){
						$(this).before($(this).data('input_placeholder_data'));
						$(this).removeData('input_placeholder_data');
					}
				});
			}
		});
	}
}

/**js格式化金额（1234.123 => 1,234.12 ）
 * @param s 源数据
 * @param n 格式化小数点后的位数
 * @returns string
 */
function formatMoney(s, n) {  
    n = n > 0 && n <= 20 ? n : 2;  
    s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";  
    var l = s.split(".")[0].split("").reverse(), r = s.split(".")[1];  
    t = "";  
    for (i = 0; i < l.length; i++) {  
        t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");  
    }  
    return t.split("").reverse().join("") + "." + r;  
}  
