<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>生成桌贴</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
     <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
    <script src="/plugin/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="/plugin/lodop/LodopFuncs.js" type="text/javascript"></script>
     <style type="text/css">
     *{margin:0px;padding:0px;}
     </style>
</head>
<body>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0"
        height="0">
        <embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="/plugin/lodop/install_lodop.exe"></embed>
    </object>
    <form method="post" action="#" id="form1">
    <script language="javascript" type="text/javascript">
        var LODOP = getLodop(document.getElementById('LODOP'), document.getElementById('LODOP_EM'));  
    </script>
    <div class="box_tool_mid padding_right5">
        <div style="text-align: left;width:702px; height: 30px;margin:0 auto;">
            <input type="button" value="打印" style="margin-top: 2px; cursor: pointer;margin-left:30px;border:solid 1px #ccc;padding:5px 10px;" onclick="prn1_preview();" />
        </div>
        <div style="width:702px; margin: 0 auto;" id="printarea">
        
        		<c:forEach var="seat" items="${seatList }" varStatus="i">
        			 <c:if test="${i.index%(exam.everyRoomSeatCount)==0 }">
	         		 <!-- 页开始 -->
	                 <div class="page">
	                 	<!-- 页头 -->
	                     <div style="height: 30px; text-align: center; font-size: 25px; margin-top: 20px;line-height: 30px;">${exam.examName }</div>
	                     <div style="height: 25px; text-align: center; font-size: 20px; line-height: 25px; border-bottom: solid 1px #000;">${exam.examArea }考场&nbsp;${seat.roomNo }试室&nbsp;&nbsp;&nbsp;&nbsp;考试时间：<fmt:formatDate value="${exam.examDate }" pattern="yyyy年MM月dd日"/> ${item.examTime}</div>
	                     <!-- 页头结束 -->
                         <div style="width:702px;border:none;">
                         	<ul style="list-style: none;width:702px">
	                 </c:if>
	                 
                      <li style="width:220px; height: 60px; border: 0;float:left;margin:10px 10px 0px 0px;">
                           <div style="height: 60px; border: 1px solid #000; width: 220px; margin-top:3px;font-size: 14px;">                                        
                               <div style="width: 100%; height: 30px;border-bottom: solid 1px #000;text-align: center; line-height: 30px;">准考证:${seat.testCard }</div>
                               <div style="height: 30px; ">
                                   <div style="float: left; width: 118px; border-right: solid 1px #000; height: 29px;line-height: 30px; text-align: center;">姓名:${seat.name }</div>
                                   <div style="width: 100px; float: left; border: 0; height: 29px; line-height: 30px;text-align: center;">座位号:${seat.seatNo }</div>
                               </div>
                           </div>
                       </li>
                       
                       <c:if test="${i.index==fn:length(seatList)-1 }">
                       		<c:if test="${fn:length(seatList)%(exam.everyRoomSeatCount)!=0 }">
                       			<!-- 补充表格 -->
                       			<c:set var="addList" value="${exam.everyRoomSeatCount-fn:length(seatList)%(exam.everyRoomSeatCount) }"></c:set>
                       			<c:forEach begin="0" end="${addList-1 }">
                       				<li style="width:220px; height: 60px; border: 0;float:left;margin:10px 10px 0px 0px;">
			                           <div style="height: 60px; border: 1px solid #000; width: 220px; margin-top:3px;font-size: 14px;">                                        
			                               <div style="width: 100%; height: 30px;border-bottom: solid 1px #000;text-align: center; line-height: 30px;"> </div>
			                               <div style="height: 30px; ">
			                                   <div style="float: left; width: 118px; border-right: solid 1px #000; height: 29px;line-height: 30px; text-align: center;"> </div>
			                                   <div style="width: 100px; float: left; border: 0; height: 29px; line-height: 30px;text-align: center;"> </div>
			                               </div>
			                           </div>
			                       </li>
                       			</c:forEach>
                       		</c:if>
                       		</ul><!-- 列表结束 -->
                       	   </div><!-- 表内容结束 -->
                         </div><!-- 页结束 -->
                       </c:if>
             	</c:forEach>
             	
             	<c:if test="${empty seatList or fn:length(seatList)==0}">
             		<div class="page">
	                 	<!-- 页头 -->
	                     <div style="height: 30px; text-align: center; font-size: 25px; margin-top: 20px;line-height: 30px;">${exam.examName }</div>
	                     <div style="height: 25px; text-align: center; font-size: 20px; line-height: 25px; border-bottom: solid 1px #000;">${exam.examArea }考场&nbsp;${seat.roomNo }试室&nbsp;&nbsp;&nbsp;&nbsp;考试时间：<fmt:formatDate value="${exam.examDate }" pattern="yyyy年MM月dd日"/> ${item.examTime}</div>
	                     <!-- 页头结束 -->
                         <div style="width:702px;border:none;">
                         	<ul style="list-style: none;width:702px">
                         		<c:forEach begin="1" end="${exam.everyRoomSeatCount }">
                       				<li style="width:220px; height: 60px; border: 0;float:left;margin:10px 10px 0px 0px;">
			                           <div style="height: 60px; border: 1px solid #000; width: 220px; margin-top:3px;font-size: 14px;">                                        
			                               <div style="width: 100%; height: 30px;border-bottom: solid 1px #000;text-align: center; line-height: 30px;"> </div>
			                               <div style="height: 30px; ">
			                                   <div style="float: left; width: 118px; border-right: solid 1px #000; height: 29px;line-height: 30px; text-align: center;"> </div>
			                                   <div style="width: 100px; float: left; border: 0; height: 29px; line-height: 30px;text-align: center;"> </div>
			                               </div>
			                           </div>
			                       </li>
                       			</c:forEach>
                         	</ul>
                         </div>
                    </div>
             	</c:if>
        </div>
    </div>
    </form>
    <script language="javascript" type="text/javascript">
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
