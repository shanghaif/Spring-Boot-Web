<%@ page language="java" contentType="text/html; charset=UTF-8"
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
						<h5>导医信息</h5>
					</div>
					<div class="ibox-content">
						<form id="GuideForm" name="GuideForm" class="form-horizontal" method="post">
							<input type="hidden" name="GI_ID" id="GI_ID" value="${pd.GI_ID}" />
							<input type="hidden" name="SYS_UI_ID" id="SYS_UI_ID" value="${pd.SYS_UI_ID}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">姓名：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="GI_NAME" id="GI_NAME" value="${pd.GI_NAME}" />
								</div>
								<label class="col-sm-2 control-label">性别：</label>
							    <div class="col-sm-4">
									<select class="form-control required" name="GI_SEX" id="GI_SEX" value="${pd.GI_SEX}">
										<option value="0" <c:if test="${pd.GI_SEX == 0}">selected="selected"</c:if>>女</option>
										<option value="1" <c:if test="${pd.GI_SEX == 1}">selected="selected"</c:if>>男</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">出生日期：</label>
							    <div class="col-sm-4">
									<input type="text" class="bootstrapdatetimepicker form-control required" name="GI_BIRTHDAY" id="GI_BIRTHDAY" placeholder="请选择出生日期" value="${pd.GI_BIRTHDAY}" />
								</div>
								<label class="col-sm-2 control-label">身份证号：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="GI_IDCARD" id="GI_IDCARD" value="${pd.GI_IDCARD}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">联系手机：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required digits" name="GI_PHONE" id="GI_PHONE" value="${pd.GI_PHONE}" />
								</div>
								<label class="col-sm-2 control-label">家庭地址：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="GI_ADDRESS" id="GI_ADDRESS" value="${pd.GI_ADDRESS}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">学历：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="GI_EDU_LEVEL" id="GI_EDU_LEVEL" value="${pd.GI_EDU_LEVEL}" />
								</div>
								<label class="col-sm-2 control-label">工号：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="GI_EMP_NUM" id="GI_EMP_NUM" value="${pd.GI_EMP_NUM}" />
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
										<font color="red">注：用户可以通过网址<%=basePath %>登录系统，用户账号为所填写的工号，初始密码为123456，用户可在登录后主界面的右上角点击用户名选择修改密码！</font>
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="col-sm-2 col-sm-offset-5 text-center">
									<button id="btn_Save" class="btn btn-primary" type="button" onclick="submitForm();">保存内容</button>
									<button id="btn_Cancel" class="btn btn-white" type="button" onclick="goBack();">取消</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 全局js -->
    <system:jsFooter/>
	<!-- 自定义js -->
	<script type="text/javascript">
		//表单ID
		var formId = "#GuideForm";
		$(document).ready(function(){
	    	//初始化下拉菜单
	    	$("#GI_SEX").createOption();
	    	//表单提交JS验证
			$(formId).validate({
				rules: {
					GI_BIRTHDAY: {
						date: true,
						dateISO: true
					},
					GI_PHONE: {
						rangelength: [11, 11]
					},
					GI_IDCARD: {
						rangelength: [18, 18],
						remote: {
							url: '/validates/validateIdCard',
							type: 'POST',
							dataType: 'JSON',
							data: {
								'IDCARD': function() {
									return $('#GI_IDCARD').val();
								}
							}
						}
					},
					GI_EMP_NUM: {
						remote: {
							url: '/user/hasU',
							type: 'POST',
							dataType: 'JSON',
							data: {
								'USERNAME': function() {
									return $('#GI_EMP_NUM').val();
								},
								"USER_ID": function() {
									return $('#SYS_UI_ID').val();
								}
							}
						}
					}
				},
				messages: {
					GI_BIRTHDAY: "请输入或选择正确的出生日期格式。例如：1970-01-01",
					GI_PHONE: "请输入11位的联系手机。",
					GI_IDCARD: "身份证号不正确，请输入正确身份证号",
					GI_EMP_NUM: "工号已被注册，请更换新工号重试。"
				}
			});
		});
		//表单提交
	    function submitForm(){
	        var id = $('#GI_ID').val();
	    	var action = "";
	    	if(id == ""){
	    		action = "guide/saveAdd";
	    	}else{
	    		action = "guide/saveEdit";
	    	}
	    	$(formId).attr("action", action);
	    	$(formId).submit();
	    }
	    //返回到列表页面 
		function goBack(){
			this.location.href="<%=basePath%>guide/toLists";
		}
	</script>
</body>
</html>