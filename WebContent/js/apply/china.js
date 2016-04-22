function Dsy() {
	this.Items = new Array();
}

Dsy.prototype.add = function(id, iArray) {
	this.Items[id] = iArray;
};

Dsy.prototype.Exists = function(id) {
	if (typeof (this.Items[id]) == "undefined")
		return false;
	return true;
};

//获取xmlDoc对象
function xml_loadFile(xmlUrl, funcAsync) {
	var xmlDoc = null;
	var isChrome = false;
	var asyncIs = (null != funcAsync); // 是否是异步加载。当funcAsync不为空时，使用异步加载，否则是同步加载。
	// 检查参数
	if ("" == xmlUrl)
		return null;
	if (asyncIs) {
		if ("function" != typeof (funcAsync))
			return null;
	}
	// 创建XML对象
	try {
		xmlDoc = new ActiveXObject("Microsoft.XMLDOM"); // Support IE
	} catch (ex) {
	}
	if (null == xmlDoc) {
		try {
			// Support Firefox, Mozilla, Opera, etc
			xmlDoc = document.implementation.createDocument("", "", null); // 创建一个空的
																			// XML
																			// 文档对象。
		} catch (ex) {
		}
	}
	if (null == xmlDoc)
		return null;
	// 加载XML文档
	xmlDoc.async = asyncIs;
	if (asyncIs) {
		if (window.ActiveXObject) {
			xmlDoc.onreadystatechange = function() {
				if (xmlDoc.readyState == 4) {
					var isError = false;
					if (null != xmlDoc.parseError) {
						isError = (0 != xmlDoc.parseError.errorCode); // 0成功,
																		// 非0失败。
					}
					funcAsync(xmlDoc, isError);
				}
			};
		} else {
			xmlDoc.onload = function() {
				funcAsync(xmlDoc, false);
			};
		}
	}
	try {
		xmlDoc.load(xmlUrl);
	} catch (ex) {
		// alert(ex.message) // 如果浏览器是Chrome，则会catch这个异常：Object # (a Document)
		// has no method "load"
		isChrome = true;
		xmlDoc = null;
	}
	if (isChrome) {
		var xhr = new XMLHttpRequest();
		if (asyncIs) // 异步
		{
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4) {
					funcAsync(xhr.responseXML, xhr.status != 200);
				}
			};
			xhr.open("GET", xmlUrl, true);
			try // 异步模式下，由回调函数处理错误。
			{
				xhr.send(null);
			} catch (ex) {
				funcAsync(null, true);
				return null;
			}
			return xhr; // 注意：返回的是XMLHttpRequest。建议异步模式下仅用null测试返回值。
		} else // 同步
		{
			xhr.open("GET", xmlUrl, false);
			xhr.send(null); // 同步模式下，由调用者处理异常
			xmlDoc = xhr.responseXML;
		}
	}
	return xmlDoc;
}
function windowOnload() {
	// 通过方法获取对象
	// var xmlDoc = getXmlDoc();
	var xmlDoc = xml_loadFile("/js/apply/world.xml");
	// 获取xml文件的根节点
	var root = xmlDoc.documentElement;
	// 获得所有的省节点
	var provinces = root.childNodes;
	addData("0", provinces);
	var cindex = 0;
	for ( var i = 0; i < provinces.length; i++) {
		var citys = provinces[i].childNodes;
		if (citys.length > 0) {
			addData("0_" + cindex, citys);
			var aindex = 0;
			for ( var j = 0; j < citys.length; j++) {
				var area = citys[j].childNodes;
				if (area.length > 0)
					addData("0_" + cindex + "_" + aindex++, area);
			}
			cindex++;
		}
	}
};
var dsy = new Dsy();
function addData(id, es) {
	var arr = new Array();
	var index = 0;
	for ( var i = 0; i < es.length; i++) {
		if (es[i].nodeType == 1) {
			arr[index++] = es[i].getAttribute("name");
		}
	}
	dsy.add(id, arr);
}
function change(v) {
	var str = "0";
	for ( var i = 0; i < v; i++) {
		str += ("_" + (document.getElementById(s[i]).selectedIndex - 1));
	}
	;
	var ss = document.getElementById(s[v]);
	with (ss) {
		length = 0;
		options[0] = new Option(opt0[v], opt0[v]);
		if (v && document.getElementById(s[v - 1]).selectedIndex > 0 || !v) {
			if (dsy.Exists(str)) {
				ar = dsy.Items[str];
				for ( var i = 0; i < ar.length; i++)
					options[length] = new Option(ar[i], ar[i]);
				if (v)
					options[1].selected = true;
			}
		}
		if (++v < s.length) {
			change(v);
		}
	}
}

/*
var s = [ "s1", "s2", "s3" ];
var opt0 = [ "---请选择---", "---请选择---", "---请选择---" ];
function setup(n1, n2, n3) {
	windowOnload();
	for ( var i = 0; i < s.length - 1; i++)
		document.getElementById(s[i]).onchange = new Function("change("
				+ (i + 1) + ")");
	change(0);
	document.getElementById('s1').value = n1;
	change(1);
	document.getElementById('s2').value = n2;
	change(2);
	document.getElementById('s3').value = n3;
};
*/
