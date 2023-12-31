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
						<h5>陪诊信息</h5>
					</div>
					<div class="ibox-content">
						<form id="GuideForm" name="GuideForm" class="form-horizontal" method="post">
							<input type="hidden" name="AI_ID" id="AI_ID" value="${pd.AI_ID}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">姓名：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="AI_NAME" id="AI_NAME" value="${pd.AI_NAME}" />
								</div>
								<label class="col-sm-2 control-label">性别：</label>
							    <div class="col-sm-4">
									<select class="form-control required" name="AI_SEX" id="AI_SEX" value="${pd.AI_SEX}">
										<option value="0" <c:if test="${pd.AI_SEX == 0}">selected="selected"</c:if>>女</option>
										<option value="1" <c:if test="${pd.AI_SEX == 1}">selected="selected"</c:if>>男</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">出生日期：</label>
							    <div class="col-sm-4">
									<input type="text" class="bootstrapdatetimepicker form-control required" name="AI_BIRTHDAY" id="AI_BIRTHDAY" placeholder="请选择出生日期" value="${pd.AI_BIRTHDAY}" />
								</div>
								<label class="col-sm-2 control-label">身份证号：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="AI_IDCARD" id="AI_IDCARD" value="${pd.AI_IDCARD}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">联系手机：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required digits" name="AI_PHONE" id="AI_PHONE" value="${pd.AI_PHONE}" onkeypress="return event.keyCode >= 48 && event.keyCode <= 57"/>
								</div>
								<%-- <label class="col-sm-2 control-label">头像地址：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="AI_PHOTO" id="AI_PHOTO" value="${pd.AI_PHOTO}" />
								</div> --%>
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
	    	$("#AI_SEX").createOption();
	    	//表单提交JS验证
			$(formId).validate({
				rules: {
					AI_BIRTHDAY: {
						date: true,
						dateISO: true
					},
					AI_PHONE: {
						rangelength: [11, 11],
						remote: {
							url: '/accompanyInfo/selectPhone',
							type: 'POST',
							dataType: 'JSON',
							data: {
								'AI_PHONE': function() {
									return $('#AI_PHONE').val();
								},
								'ID' : function(){
									return $('#SYS_UI_ID').val();
								}
							}
						}
					},
					AI_IDCARD: {
						rangelength: [18, 18],
						remote: {
							url: "/validates/validateIdCard",
							type: "POST",
							dataType: 'JSON',
							data: {
								'IDCARD' : function() {
									return $('#AI_IDCARD').val();
								}
							}
						}
					}
				},
				messages: {
					AI_BIRTHDAY: "请输入或选择正确的出生日期格式。例如：1970-01-01",
					AI_PHONE: "输入的手机号格式不正确，或该手机号已被注册。",
					AI_IDCARD: "身份证号不正确，请输入正确身份证号。"
				}
			});
		});
		//表单提交
	    function submitForm(){
	        var id = $('#AI_ID').val();
	    	var action = "";
	    	if(id == ""){
	    		action = "accompanyInfos/saveAdd";
	    	}else{
	    		action = "accompanyInfos/saveEdit";
	    	}
	    	$(formId).attr("action", action);
	    	$(formId).submit();
	    }
	    //返回到列表页面 
		function goBack(){
			this.location.href="<%=basePath%>accompanyInfos/toLists";
		}
	</script>
</body>
</html>