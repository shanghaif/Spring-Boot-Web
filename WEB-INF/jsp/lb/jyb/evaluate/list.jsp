﻿﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header/>
<!-- jsp文件头和头部 -->
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>订单评价管理</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="O_NUM" name="O_NUM" class="form-control" placeholder="订单编号" />
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
							    </button>
							    <button type="button" class="btn btn-default btn-danger" onclick="toDel();">
							       	 删除
							    </button>
							</div>
						</div>
						<table id="queryTable" data-mobile-responsive="true"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="myModal" class="modal inmodal fade" tabindex="-1" role="dialog"  aria-hidden="true"></div>
	<!-- 全局js -->
	<system:jsFooter/>
	<script type="text/javascript">
		//表格ID
		var tableId = "#queryTable";
		//表格请求及数据
		var tableColumns = {
			url: 'evaluate/pageSearch?tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'EVA_ID',
		        visible: false
		    }, {
		        field: 'O_NUM',
		        title: '订单编号',
		        align: 'center',
		        halign: 'center',
		        width: '12%',
		        formatter: formatOrderNumFun
		    }, {
		        field: 'O_TIME',
		        title: '下单时间',
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'EVA_CONTENT',
		        title: '评价内容',
		        align: 'left',
		        halign: 'center',
		        width: '35%',
		        formatter: formatOrderContentFun
		    }, {
		        field: 'LEVEL_DL',
		        title: '星级-代理商',
		        align: 'center',
		        halign: 'center',
		        width: '5%',
		       formatter: formatStarFunByDL
		    }, {
		        field: 'LEVEL_ZJ',
		        title: '星级-专家',
		        align: 'center',
		        halign: 'center',
		        width: '5%',
		        formatter: formatStarFunByZJ 
		    }, {
		        field: 'LEVEL_PZ',
		        title: '星级-陪诊人员',
		        align: 'center',
		        halign: 'center',
		        width: '8%',
		        formatter: formatStarFunByPZ 
		    }, {
		        field: 'DEL_STATE',
		        title: '操作',
		        align: 'center',
		        halign: 'center',
		        width: '8%',
		        formatter: formatOrderShow
		    }]
		};
		$(document).ready(function (){
			//初始化下拉菜单
			//$("#M_TYPE_ID").createOption();
			//初始化及查询生成表格内容
			table = $(tableId).bootstrapTable(tableColumns);
		});
		//查询刷新表格
		function searchRefreshTable(){
			//销毁表格
			$(tableId).bootstrapTable('destroy');
			$(tableId).bootstrapTable(tableColumns);
		}
		//导出Excel
		function toExport(){
			$(tableId).bootstrapTable('exportTable', {
				type : 'excel'
			});
		}
		//批量删除数据
		function toDel(){
			var ids = getBstCheckedId('EVA_ID');
			if((ids.length < 1)){
				layer.msg('请选中信息再进行删除。');
				return false;
			}
			var idsStr = ids.toString();
			layer.confirm('确定删除已选信息吗？', {
				btn: ['确认','取消'],
				shade: false,
				yes: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>evaluate/toDelete?tm=' +  new Date().getTime(),
						data: {
							IDS: idsStr
						},
						dataType: 'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data) {
							if (data.msg == 'success') {
								layer.msg('删除信息成功');
								bstQuery();
							} else {
								layer.msg('删除信息失败');
							}
						}
					});
				}
			});
		}
		//浏览
		function toView(O_ID,SP_ID){
			if(O_ID != null && O_ID != ""){
				layer.full(
					layer.open({
						type: 2,
						title: '订单详情',//窗体标题
						area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
						fix: false,//窗体位置不固定
						maxmin: false,//最大、小化是否显示
						scrollbar: true,//整体页面滚动条是否显示
						content: ['/hospitalGuide/toLists_onumDesc?O_ID=' + O_ID + "&spinfoOID="+SP_ID+"&expertlibsOID=&accompanyinfoOID=&keynodeOID=&evaluateOID=null", 'yes'],//URL地址
						closeBtn: 1,//显示关闭按钮
						btn: ['关闭']
					})
				);
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//浏览评价
		function toEvalView(EVA_ID){
			if(EVA_ID != null && EVA_ID != ""){
				layer.open({
					type: 2,
					title: '订单评价详情',//窗体标题
					area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: false,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/evaluate/toView?EVA_ID=' + EVA_ID, 'yes'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				});
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//根据评分显示星级图片-代理商
		function formatStarFunByDL(value, row, index){
			var format_v = "<img src='<%=basePath%>/images/stars/star_" + row.LEVEL_DL + ".png' style='width:100px;' />";
			return format_v;
		}
		//根据评分显示星级图片-专家
		function formatStarFunByZJ(value, row, index){
			var format_v = "<img src='<%=basePath%>/images/stars/star_" + row.LEVEL_ZJ + ".png' style='width:100px;' />";
			return format_v;
		}
		//根据评分显示星级图片-陪诊
		function formatStarFunByPZ(value, row, index){
			var format_v = "<img src='<%=basePath%>/images/stars/star_" + row.LEVEL_PZ + ".png' style='width:100px;' />";
			return format_v;
		}
		//订单编号
		function formatOrderNumFun(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toView('" + row.O_ID + "','"+row.SP_ID+"');\">" + row.O_NUM + "</button>";
			return format;
		}
		//订单内容
		function formatOrderContentFun(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toEvalView('" + row.EVA_ID + "');\">" + row.EVA_CONTENT + "</button>";
			return format;
		}
		//设置是否显示按钮
		function formatOrderShow(value, row, index){
			if(row.DEL_STATE == '1'){
				var format = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toChange('" + row.O_ID + "');\">" + "显示" + "</button>";
			}
			if(row.DEL_STATE == '2'){
				var format = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toChangeShow('" + row.O_ID + "');\">" + "不显示" + "</button>";
			}	
			return format;
		}
		//改变显示状态为不显示
		function toChange(O_ID){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>evaluate/change?tm=' +  new Date().getTime(),
				data: {
					O_ID: O_ID
				},
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					if (data.msg == 'success') {
						layer.msg('更改状态成功');
						bstQuery();
					} else {
						layer.msg('更改状态失败');
					}
				}
			});
		}
		//更改状态为显示
		function toChangeShow(O_ID){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>evaluate/changeShow?tm=' +  new Date().getTime(),
				data: {
					O_ID: O_ID
				},
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					if (data.msg == 'success') {
						layer.msg('更改状态成功');
						bstQuery();
					} else {
						layer.msg('更改状态失败');
					}
				}
			});
		}
		
	</script>
</body>
</html>