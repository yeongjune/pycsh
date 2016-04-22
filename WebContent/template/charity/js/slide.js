/**
 * 幻灯片动画
 * @param imageUl 图片ul
 * @param dotUl 点ul
 * @param callback 动画完成后的回调函数
 * @param timeout 图片切换时间
 * @param animateTime 动画时间
 * @constructor
 */
function ImageSlide(imageUl, dotUl, callback, timeout, animateTime){
    var currentId = 0;
    var imaLiLeng = imageUl.children('li').length;
    var dotLiLeng = dotUl.children('li').length;
    var intervalId;
    /**
     * 跳转到
     * @param index
     */
    function to(index){
        if(intervalId)
            clearInterval(intervalId);
        var left = imageUl.children('li').eq(index).position().left;
        imageUl.animate({
            left : (0 -left)
        }, animateTime || 700, function(){
            currentId = index;
            startInterval();
            if(callback && typeof callback == 'function' )
                callback(index);
        });
    }

    function start(){
        currentId++;
        if(currentId > imaLiLeng - 1 )
            currentId = 0;
        to(currentId);
    }

    /**
     * 向下size张跳转幻灯片
     * @param size 跳转数量
     */
    this.next = function(size){
        if(size)
            currentId += size;
        else
            currentId++;
        if(currentId > imaLiLeng - 1 ){
            currentId = (currentId % imaLiLeng);
        }
        to(currentId);
    };

    /**
     * 向上size张跳转幻灯片
     * @param size 跳转数量
     */
    this.prev = function(size){
        if(size)
            currentId -= size;
        else
            currentId--;
        currentId = (currentId % imaLiLeng);
        if(currentId < 0 ){
            currentId += imaLiLeng;
        }
        to(currentId);
    };

    function startInterval(){
        intervalId = setInterval(start, timeout || 5000);
    }

    function init(){
        if(imaLiLeng > 1 && imaLiLeng == dotLiLeng){

            dotUl.children('li').each(function(i){
                $(this).attr('data-index', i);
            });
            dotUl.children('li').on('click', function(){
                var index = $(this).attr('data-index');
                if(index)
                    to(index);
            });
            startInterval();
        }
        return this;
    }

    return init();
}

/**
 * 水平流式图片滚动
 * @param ulParent ul标签的父级标签
 * @param minLen 最小图片数量，小于此值则不开启动画
 * @constructor dzf
 */
function FlowImage(ulParent, minLen, time){
    var mainBoList = ulParent;
    var isStartAnimation = mainBoList.find('li').length > ( minLen || 4);// 是否需要开启动画
    var animationInt; // 定时事件索引
    var object =this;
    var spreed = time || 3000;
    function startAnimation(){
        var firstLi = mainBoList.find('li:first');
        return window.setInterval(function(){
            // 动画实现.
            var ul = mainBoList.find('ul');
            var nowLeft = ul.css('left');
            if( !nowLeft ) nowLeft = '0px';
            nowLeft = nowLeft.replace(/[^0-9-]/g, '')
            if( nowLeft == '' ) nowLeft = '0';
            nowLeft = parseInt(nowLeft);
            ul.css('left', nowLeft-1);
            firstLi = mainBoList.find('li:first');
            if( (nowLeft-1) < (0 - firstLi.outerWidth(true)) ){
                firstLi.insertAfter(mainBoList.find('li:last'));
                ul.css('left', 0);
            }
        }, spreed / firstLi.outerWidth(true) );
    }

    function init(){
        if( isStartAnimation ){
            animationInt = startAnimation();
            mainBoList.find('li').hover(function(){
                if(animationInt) window.clearInterval(animationInt);
            }, function(){
                animationInt = startAnimation();
            });
        }
        return object;
    }

    return init();
}