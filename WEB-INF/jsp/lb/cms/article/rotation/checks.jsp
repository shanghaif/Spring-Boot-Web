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
						<h5>APP图片轮播信息审核</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="ARTICLE_TITLE" name="ARTICLE_TITLE" class="form-control" placeholder="标题" />
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toCheck();">
									审核
							    </button>
							</div>
						</div>
						<table id="queryTable" data-mobile-responsive="true"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="myModal" class="modal inmodal fade" tabindex="-1" role="dialog"  aria-hidden="true">
	<!-- 全局js -->
	<system:jsFooter/>
	<script type="text/javascript">
		//表格ID
		var tableId = "#queryTable";
		//表格请求及数据
		var tableColumns = {
			url: 'articleRotation/pageSearch?CHECK_STATE=${pd.CheckState}&tm=' + new Date().getTime(),
			toolbar: '#toolbar',
			columns: [{
		        field: 'ARTICLE_ID',
		        visible: false,
		        halign: 'center',
		    }, {
		        field: 'ARTICLE_TITLE',
		        title: '标题',
		        align: 'left',
		        halign: 'center',
		        width: '45%',
		        formatter: formatNameFun
		    }, {
		        field: 'ARTICLE_TYPE',
		        title: '类型',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'PUBLISH_NAME',
		        title: '发表人',
		        align: 'left',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'PUBLISH_DEPT',
		        title: '发表单位',
		        align: 'left',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'PUBLISH_STATE',
		        title: '发布状态',
		        visible: false,
		        align: 'center',
		        halign: 'center',
		        width: '5%'
		    }, {
		        field: 'ARCHIVE_STATE',
		        title: '归档状态',
		        visible: false,
		        align: 'center',
		        halign: 'center',
		        width: '5%'
		    }, {
		        field: 'T_CHECK_STATE',
		        title: '审核状态',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
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
		//审核
		function toCheck(){
			var ids = getBstCheckedId('ARTICLE_ID');
			if((ids.length < 1)){
				layer.msg('请选中信息再进行审核。');
				return false;
			}
			var idsStr = ids.toString();
			
			layer.confirm('信息审核', {
				btn: ['通过','不通过','取消'],
				shade: false,
				btn1: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>articleRotation/toCheck?CHECK_STATE=${pd.CheckState + 1}&tm=' +  new Date().getTime(),
						data: {
							IDS: idsStr
						},
						dataType: 'json',
						cache: false,
						success: function(data) {
							if (data.msg == 'success') {
								layer.msg('信息审核成功！');
								bstQuery();
								layer.close(index);
							} else {
								layer.msg('信息审核失败！');
								
							}
						}
					});
				},btn2: function(index, layero){
				    //按钮【按钮二】的回调
				    
					layer.open({
						type: 2,
						title: '信息审核',//窗体标题
						area: ['500px', '360px'],//整个窗体宽、高，单位：像素px
						fix: false,//窗体位置不固定
						maxmin: false,//最大、小化是否显示
						scrollbar: false,//整体页面滚动条是否显示
						content: ['/articleRotation/toBackReason', 'no'],//URL地址
						closeBtn: 0,//不显示关闭按钮
						btn: ['确认',  '取消'],
						btn1: function(index, layero){
							var backReason = $(layero).find("iframe")[0].contentWindow.formData();
							if(backReason != null){
								$.ajax({
									type: "POST",
									url: '<%=basePath%>articleRotation/toCheck?CHECK_STATE=6&tm=' +  new Date().getTime(),
									data: {
										IDS: idsStr,
										Res: backReason
									},
									dataType: 'json',
									cache: false,
									success: function(data) {
										if (data.msg == 'success') {
											layer.msg('信息未通过，退回成功！');
											bstQuery();
										} else {
											layer.msg('信息未通过，退回失败！');
										}
									}
								});
							}else{
								layer.msg('未通过需填写退回原因！');
							}
						},
					});
				    
				  },btn3: function(index, layero){
				    //按钮【按钮三】的回调
				    layer.closeAll('dialog');//关闭按钮
				  }
			});
		}
		//浏览
		function toView(ARTICLE_ID){
			if(ARTICLE_ID != null && ARTICLE_ID != ""){
				layer.full(layer.open({
					type: 2,
					title: '信息浏览',//窗体标题
					area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/articleRotation/toView?ARTICLE_ID=' + ARTICLE_ID, 'yes'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				}));
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//APP轮播标题
		function formatNameFun(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toView('" + row.ARTICLE_ID + "');\">" + row.ARTICLE_TITLE + "</button>";
			return format;
		}
	</script>
</body>
</html>