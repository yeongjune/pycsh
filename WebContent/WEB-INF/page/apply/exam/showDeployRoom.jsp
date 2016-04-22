<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	 <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
	 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
     <title>考场分配情况</title>
    <script src="/plugin/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="/plugin/lodop/LodopFuncs.js" type="text/javascript"></script>
     <style type="text/css">
     *{margin:0px;padding:0px;}
     </style>
</head>
<body>
	<form method="post" action="#" id="form1">
    <div class="box_tool_mid padding_right5">
        <div style="text-align: left;width:702px; height: 30px;margin:0 auto;">
            <input type="button" value="打印" style="margin-top: 2px; cursor: pointer;margin-left:30px;border:solid 1px #ccc;padding:5px 10px;" onclick="prn1_preview();" />
        </div>
        <div style="width:702px; margin: 0 auto;" id="printarea">
        		<c:forEach begin="1" end="${fn:length(seatMapList)}" varStatus="i">
        			<c:set var="roomNo" value="0${i.index}"></c:set>
        			<c:set var="entry" value="${seatMapList[roomNo]}"></c:set>
        			<c:forEach var="seat" items="${entry}" varStatus="j">
        			 <c:if test="${j.index==0}">
		         		 <!-- 页开始 -->
		                 <div class="page">
		                 	<c:choose>
		                     		<c:when test="${fn:length(entry)%42==0}">
		                     			<c:set var="totalPage" value="${fn:length(entry)/42 }"></c:set>
		                     		</c:when>
		                     		<c:otherwise>
		                     			<c:set value="${(fn:length(entry)/42)+1}" var="tempttt"></c:set>
		                     			<c:set var="totalPage" value="${(fn:split(tempttt,'.'))[0] }"></c:set>
		                     		</c:otherwise>
		                     </c:choose>
			                 <!-- 页头 -->
		                     <div style="height: 30px; text-align: center; font-size: 25px; margin-top: 20px;line-height: 30px;">${exam.examName }</div>
		                     <div style="height: 25px; text-align: center; font-size: 20px; line-height: 25px; border-bottom: solid 1px #000;">${seat.watingRoomNo }候考室&nbsp;${seat.roomNo }考室&nbsp;&nbsp;&nbsp;&nbsp;考试时间：<fmt:formatDate value="${exam.examDate }" pattern="yyyy年MM月dd日"/> ${exam.examTime} 
		                     	页码 1/<c:out value="${totalPage}"></c:out>
		                     </div>
		                     <!-- 页头结束 -->
	                         <div style="width:702px;border:none;">
	                         	<ul style="list-style: none;width:702px">
	                 </c:if>
	                 
	                 <c:if test="${j.index!=0 and j.index%42==0 }">
	                  	  	</ul><!-- 列表结束 -->
	                       </div><!-- 表内容结束 -->
	                      <div style="clear: both;"></div>
	                  	 </div><!-- 页结束 -->
	                  	 
	                  	 <c:if test="${j.index != fn:length(entry)-1 }">
	                  	 	 <c:choose>
		                     		<c:when test="${fn:length(entry)%42==0}">
		                     			<c:set var="totalPage" value="${fn:length(entry)/42 }"></c:set>
		                     		</c:when>
		                     		<c:otherwise>
		                     			<c:set value="${(fn:length(entry)/42)+1}" var="tempttt"></c:set>
		                     			<c:set var="totalPage" value="${(fn:split(tempttt,'.'))[0] }"></c:set>
		                     		</c:otherwise>
		                     </c:choose>
		                  	 <!-- 页开始 -->
			                 <div class="page">
				                 <!-- 页头 -->
			                     <div style="height: 30px; text-align: center; font-size: 25px; margin-top: 20px;line-height: 30px;">${exam.examName }</div>
			                     <div style="height: 25px; text-align: center; font-size: 20px; line-height: 25px; border-bottom: solid 1px #000;">${seat.watingRoomNo }候考室&nbsp;${seat.roomNo }考室&nbsp;&nbsp;&nbsp;&nbsp;考试时间：<fmt:formatDate value="${exam.examDate }" pattern="yyyy年MM月dd日"/> ${exam.examTime} 
			                     	页码 <fmt:formatNumber value="${j.index/42+1 }" maxFractionDigits="0"></fmt:formatNumber>/<c:out value="${totalPage}"></c:out>
			                     	</div>
			                     <!-- 页头结束 -->
		                         <div style="width:702px;border:none;">
		                         	<ul style="list-style: none;width:702px">
                         </c:if>
	                  </c:if>		
	                  
	                      <li style="width:220px; height: 60px; border: 0;float:left;margin:10px 10px 0px 0px;">
	                            <div style="height: 60px; border: 1px solid #000; width: 220px; margin-top:3px;font-size: 14px;">                                        
	                               <div style="width: 100%; height: 30px;border-bottom: solid 1px #000;text-align: left; line-height: 30px;">
	                               		学校:<c:choose>
	                               			<c:when test="${fn:length(seat.graduate)>12 }">${fn:substring(seat.graduate,0,10) }...</c:when>
	                               			<c:otherwise>${seat.graduate}</c:otherwise>
	                               		</c:choose>
	                               	</div>
	                               <div style="width: 100%; height: 30px;text-align: center; line-height: 30px;text-align: left">姓名:${seat.name }</div>
	                            </div>
	                       </li>
                       
                       
	                  	  
	                  <c:if test="${j.index==fn:length(entry)-1 and  j.index%42 != 0}"> 
		                    	<c:if test="${ fn:length(entry)%42 < 42}">
		                    		<c:forEach begin="1" end="${42-fn:length(entry)%42 }">
		                    			<li style="width:220px; height: 60px; border: 0;float:left;margin:10px 10px 0px 0px;">
				                            <div style="height: 60px; border: 1px solid #000; width: 220px; margin-top:3px;font-size: 14px;">                                        
				                               <div style="width: 100%; height: 30px;border-bottom: solid 1px #000;text-align: left; line-height: 30px;"> </div>
				                               <div style="width: 100%; height: 30px;text-align: center; line-height: 30px;text-align: left"> </div>
				                            </div>
				                       </li>
		                    		</c:forEach>
		                    	</c:if>
	                       	</ul><!-- 列表结束 -->
	                       </div><!-- 表内容结束 -->
	                      <div style="clear: both;"></div>
	                  	 </div><!-- 页结束 -->
	                 </c:if>
	                  	 
	                  	  
                  </c:forEach>
             	</c:forEach>
        </div>
    </div>
    </form>
    <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0">
        <embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="/plugin/lodop/install_lodop.exe"></embed>
    </object>
    
    <script language="javascript" type="text/javascript">
    var LODOP = getLodop(document.getElementById('LODOP'), document.getElementById('LODOP_EM'));  
        function prn1_preview() {
            CreateOneFormPage();
            LODOP.PREVIEW();
        };
        function CreateOneFormPage() {
            LODOP.PRINT_INIT("打印");
            LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");
            $(".page").each(function () {
                var $this = $(this);
                LODOP.NewPage();
                LODOP.SET_PRINT_TEXT_STYLE(1, "宋体", 18, 1, 0, 0, 1);
                LODOP.ADD_PRINT_HTM(0, 30, 700, 1200, $this.html());
            });
        };	
    </script>
</body>
</html>
