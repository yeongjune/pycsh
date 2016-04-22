/* 
* @Author: Marte
* @Date:   2016-03-26 16:07:17
* @Last Modified by:   Marte
* @Last Modified time: 2016-03-26 21:49:33
*/

$(function(){

    //控制banner图
        var shunxu=0
        var timer=null
        //点击指示器
        $(".banner ol li").click(function(){
            shunxu++;
            $(this).addClass('o_l_hover').siblings().removeClass()
            var index=$(this).index()
            shunxu=index
            $(".banner ul").stop().animate({left:-100*shunxu+'%'},500)
        })
       

        //自动播放模块
        function func(){
            shunxu++
            if(shunxu>2){shunxu=0}
            $(".banner ul").stop().animate({left:-100*shunxu+'%'},500)
            $(".banner ol li").eq(shunxu).addClass('o_l_hover').siblings().removeClass()
        }
        timer=setInterval(func, 5000) 


        $(".banner").hover(function(){
         clearInterval(timer)
        },function(){
            clearInterval(timer)
            timer=setInterval(func, 5000)
        })




       
        
    });
function maxImgWidth(thi){
	var $maxWidth=$(thi).width();
	$(thi).find("img").each(function(){
		if($(this).width()>$maxWidth){
			$(this).width($maxWidth);
		}
	});
}