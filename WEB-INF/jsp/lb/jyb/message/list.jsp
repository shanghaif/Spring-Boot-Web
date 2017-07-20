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
						<h5>消息推送管理</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
								<input type="text" id="BEGIN_TIME" name="BEGIN_TIME" value="${pd.BEGIN_TIME }" class="bootstrapdatetimepicker form-control" placeholder="开始时间" />
							    <input type="text" id="END_TIME" name="END_TIME" value="${pd.END_TIME }" class="bootstrapdatetimepicker form-control" placeholder="结束时间" />
								<select class="form-control" name="tag" id="tag" value="${pd.tag}">
									<option value="">--选择推送类型--</option>
									<option value="101">导医分单</option>
									<option value="102">代理商分单</option>
									<option value="103">退款完结</option>
									<option value="201">添加家庭成员</option>
									<option value="202">添加好友</option>
									<option value="301">申请加入团队</option>
									<option value="302">加入团对邀请</option>
									<option value="401">活动更新</option>
									<option value="402">团队报名入选</option>
									<option value="403">个人报名入选</option>
									<option value="501">app轮播更新</option>
									<option value="502">健康教育内容更新</option>
								</select>
							    <select class="form-control" name="APP_TYPE_NAME" id="APP_TYPE_NAME" value="${pd.APP_TYPE_NAME}">
									<option value="">--选择终端类型--</option>
									<option value="1">用户</option>
									<option value="2">陪诊</option>
									<option value="3">机构</option>
									<option value="4">医生</option>
								</select>
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
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
			url: 'jyb/message/pageSearch?',
			toolbar:'#toolbar' ,
			columns: [{
		        field: 'TITLE',
		        title: '推送标题',
		        align: 'center',
		        cursor: 'pointer',
		        halign: 'center',
		        formatter:function(value,row,index){
		        	return "<button type=\"button\" class=\"btn btn-link\" onclick=\"uinameDesc('" + row.uiid + "','" + row.oid + "');\">" + row.TITLE + "</button>";
		        } 
		    }, {
		        field: 'tag',
		        title: '推送类型',
		        align: 'center',
		        halign: 'center',
		    }, {
		        field: 'ALERT',
		        title: '推送内容',
		        align: 'center',
		        halign: 'center',
		    }, {
		        field: 'CREATE_TIME',
		        title: '创建时间',
		        align: 'center',
		        halign: 'center',
		    }, {
		        field: 'APP_TYPE_NAME',
		        title: '终端类型',
		        align: 'center',
		        halign: 'center'
		    }]
		};
		//操作
		function formatStatusFun(value, row, index){
			var btnState = " disable = false ";
			if(row.spinfoOID == null || row.spinfoOID == ''){
				btnState = " disabled = true ";
			}
        	var format_v1 = "<button type=\"button\" class=\"btn btn-default btn-primary\" " + btnState + " onclick=\"spDesc('" + row.spinfoOID + "');\">代理商</button>";
        	btnState = " disable = false ";
			if(row.expertlibsOID == null || row.expertlibsOID == ''){
				btnState = " disabled = true ";
			}
        	var format_v2 = "<button type=\"button\" class=\"btn btn-default btn-primary\" " + btnState + " onclick=\"expertLibsDesc('" + row.expertlibsOID + "');\">专家</button>";
        	btnState = " disable = false ";
			if(row.accompanyinfoOID == null || row.accompanyinfoOID == ''){
				btnState = " disabled = true ";
			}
        	var format_v3 = "<button type=\"button\" class=\"btn btn-default btn-primary\" " + btnState + " onclick=\"accompanyDesc('" + row.accompanyinfoOID + "');\">陪诊</button>";
        	btnState = " disable = false ";
			if(row.keynodeOID == null || row.keynodeOID == ''){
				btnState = " disabled = true ";
			}
        	var format_v4 = "<button type=\"button\" class=\"btn btn-default btn-primary\" " + btnState + " onclick=\"keyNodeDesc('" + row.oid + "');\">就诊</button>";
        	btnState = " disable = false ";
			if(row.evaluateOID == null || row.evaluateOID == ''){
				btnState = " disabled = true ";
			}
        	var format_v5 = "<button type=\"button\" class=\"btn btn-default btn-primary\" " + btnState + " onclick=\"orderEvalDesc('" + row.evaluateOID + "');\">评价</button>";
        	return format_v1 + "&nbsp;" + format_v2 + "&nbsp;" + format_v3 + "&nbsp;" + format_v4 + "&nbsp;" + format_v5; 
		}
		$(document).ready(function (){
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
	</script>
</body>
</html>