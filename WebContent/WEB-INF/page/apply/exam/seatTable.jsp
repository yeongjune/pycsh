<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>
	生成座位表
</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
     <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
    <script src="/plugin/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="/plugin/lodop/LodopFuncs.js" type="text/javascript"></script>
    
</head>
<body>
    <form method="post" action="seatingsheet.aspx" id="form1">
    <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0"
        height="0">
        <embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="/plugin/lodop/install_lodop.exe"></embed>
    </object>
    <div class="box_tool_mid padding_right5">
        <div style="text-align: left;width:702px; height: 30px;margin:0 auto;">
            <input type="button" value="打印" style="margin-top: 2px; cursor: pointer;margin-left:30px;border:solid 1px #ccc;padding:5px 10px;" onclick="prn1_preview();" />
        </div>
        <div style="width: 702px; margin: 0 auto;" id="printarea">
        	<c:forEach var="seat" items="${seatList }" varStatus="i">
        			<c:if test="${i.index%35==0 }">
        				<!-- 打印页 -->
	                    <div class="page">
	                    	<!-- 页头 -->
	                        <div style="height: 30px; text-align: center; font-size: 25px; margin-top: 20px; line-height: 30px;">${exam.examName }</div>
	                        <div style="height: 25px; text-align: center; font-size: 20px; line-height: 25px;border-bottom: solid 1px #000;">${exam.examArea }考场&nbsp;${seat.roomNo }试室&nbsp;&nbsp;&nbsp;&nbsp;考试时间：<fmt:formatDate value="${exam.examDate }" pattern="yyyy年MM月dd日"/> ${item.examTime}</div>
	                        <!-- 页头结束 -->
	                        <div style="border: 0; width: 700px;">
        			</c:if>		
                    <!-- 打印列开始 共5列 -->
                       <div style="width: 135px; height: 138px; border: 0;float:left;overflow:hidden;">
                           <div style="height: 131px; border: 1px solid #000; width: 120px; margin-left:8px;margin-top:2px;">
                               <div style="width: 78px; margin-left:20px; height: 90px; border-left: solid 1px #000; border-right: solid 1px #000;">
                                   <div style='text-align:center;height:90px;line-height:90px;'>
                                   <img style="width: 100%; height: 90px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px;" alt="" src="${seat.headPicUrl }" qvod="0"/>
                                   </div>
                               </div>
                               <div style="width: 100%; height: 20px; border-top: solid 1px #000; border-bottom: solid 1px #000;text-align: center; line-height: 20px;font-size:10px;">准考证号:${seat.testCard }</div>
                               <div style="height: 20px; font-size: 12px;">
                                   <div style="float: left; width: 58px; border-right: solid 1px #000; height: 19px;line-height: 20px; text-align: center;font-size:10px;">姓名:${seat.name }</div>
                                   <div style="width: 58px; float: left; border: 0; height: 19px; line-height: 20px;text-align: center;font-size:10px;">座位号:${seat.seatNo }</div>
                               </div>
                           </div>
                       </div>
                       <!-- 打印列结束 -->
                       
                       
                       <c:if test="${i.index==fn:length(seatList)-1 }">
                       	 <c:if test="${fn:length(seatList)%35 !=0 }">
                       	 	<!-- 填补满页 -->
		               		<c:set var="addList" value="${35-fn:length(seatList)%35 }"></c:set>
		               		<c:forEach begin="1" end="${addList}" varStatus="j">
			                           <!-- 打印列开始 共5列 -->
			                          <div style="width: 135px; height: 138px; border: 0;float:left;overflow:hidden;">
			                              <div style="height: 131px; border: 1px solid #000; width: 120px; margin-left:8px;margin-top:2px;">
			                                  <div style="width: 78px; margin-left:20px; height: 90px; border-left: solid 1px #000; border-right: solid 1px #000;">
			                                      <div style='text-align:center;height:90px;line-height:90px;'>空座</div>
			                                  </div>
			                                  <div style="width: 100%; height: 20px; border-top: solid 1px #000; border-bottom: solid 1px #000;text-align: center; line-height: 20px;font-size:10px;"></div>
			                                  <div style="height: 20px; font-size: 12px;">
			                                      <div style="float: left; width: 58px; border-right: solid 1px #000; height: 19px;line-height: 20px; text-align: center;font-size:10px;"></div>
			                                      <div style="width: 58px; float: left; border: 0; height: 19px; line-height: 20px;text-align: center;font-size:10px;"></div>
			                                  </div>
			                              </div>
			                          </div>
		               		</c:forEach>
		               		<!-- 填补满页结束 -->
		                 </c:if>
		                 <!-- 打印页结束 -->
	                   </div>
	                 </div>
	                </c:if>
               </c:forEach>
               <c:if test="${empty seatList or fn:length(seatList)==0}">
           			<div class="page">
                 	<!-- 页头 -->
                     <div style="height: 30px; text-align: center; font-size: 25px; margin-top: 20px; line-height: 30px;">${exam.examName }</div>
                     <div style="height: 25px; text-align: center; font-size: 20px; line-height: 25px;border-bottom: solid 1px #000;">${exam.examArea }考场&nbsp;${seat.roomNo }试室&nbsp;&nbsp;&nbsp;&nbsp;考试时间：<fmt:formatDate value="${exam.examDate }" pattern="yyyy年MM月dd日"/> ${item.examTime}</div>
                     <!-- 页头结束 -->
                     <div style="border: 0; width: 700px;">
                     	<c:forEach begin="1" end="35">
                     	<div style="width: 135px; height: 138px; border: 0;float:left;overflow:hidden;">
                           <div style="height: 131px; border: 1px solid #000; width: 120px; margin-left:8px;margin-top:2px;">
                               <div style="width: 78px; margin-left:20px; height: 90px; border-left: solid 1px #000; border-right: solid 1px #000;">
                                   <div style='text-align:center;height:90px;line-height:90px;'>空座</div>
                               </div>
                               <div style="width: 100%; height: 20px; border-top: solid 1px #000; border-bottom: solid 1px #000;text-align: center; line-height: 20px;font-size:10px;"></div>
                               <div style="height: 20px; font-size: 12px;">
                                   <div style="float: left; width: 58px; border-right: solid 1px #000; height: 19px;line-height: 20px; text-align: center;font-size:10px;"></div>
                                   <div style="width: 58px; float: left; border: 0; height: 19px; line-height: 20px;text-align: center;font-size:10px;"></div>
                               </div>
                           </div>
                       </div>
                       </c:forEach>
                     </div>
                 	</div>
               </c:if>
        </div>
    </div>
    </form>
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
