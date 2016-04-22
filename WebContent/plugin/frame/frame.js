
function Frame(){
	/**
	 * 框架自动高度适用
	 */
	this.autoHeight = function(){
		var headHeight = $('#frame_head').height();
		var menubarHeight = $('#frame_menubar').height();
		var footHeight = $('#frame_foot').height();
		var centerHeight = headHeight + menubarHeight + footHeight + 10;
		$('#frame_center').css('height', ($(window).height()-centerHeight) + 'px');
		$('#frame_left').css('height', ($(window).height()-centerHeight) + 'px');
		$('#frame_right').css('height', ($(window).height()-centerHeight) + 'px');
	};
	/**
	 * 初始化折叠菜单容器
	 */
	this.initAccordionContainer = function(){
		var frame = this;
		var ac_index = 0;
		$('.accordion_container').each(function(){
			$(this).attr('ac_id', ac_index);
			var ap_index = 0;
			$(this).find('.accordion_pane').each(function(){
				$(this).find('.head').attr('aph_id', ap_index);
				$(this).find('.body').attr('apb_id', ap_index);
				$(this).find('.head').attr('pid', ac_index);
				$(this).find('.body').attr('pid', ap_index);
				ap_index++;
			});
			ac_index++;
			
			$(this).find('.accordion_pane .head').bind('click', function(){
				var head = this;
				$(this).parent().parent().find('.body').each(function(){
					if($(head).attr('aph_id')==$(this).attr('apb_id')){
						$(this).prev().addClass('hover');
						$(this).slideDown();
					}else{
						$(this).prev().removeClass('hover');
						$(this).slideUp();
					}
				});
			});
			
			frame.accordionContainerAutoHeight();
			
			var index = 0;
			$(this).find('.accordion_pane .body').each(function(){
				if(index>0){
					$(this).prev().removeClass('hover');
					$(this).slideUp();
				}else{
					$(this).prev().addClass('hover');
					$(this).slideDown();
				}
				index++;
			});
		});
	};
	/**
	 * 折叠菜单容器自动高度适应
	 */
	this.accordionContainerAutoHeight = function(){
		$('.accordion_container').each(function(){
			$(this).css('height', $('#frame_left').height()+'px');
			var accordion_pane_count = $(this).find('.accordion_pane').length;
			var h = $('#frame_left').height()-accordion_pane_count*32;
			$('.accordion_pane .body').css('height', h+'px');
		});
	};
}