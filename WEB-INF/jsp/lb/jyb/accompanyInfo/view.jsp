<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header/>
<!-- jsp文件头和头部 -->
</head>
<style>
.col-sm-4{margin-top: 7px !important;}
</style>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>陪诊人员：${pd.AI_NAME}</h5>
					</div>
					<div class="ibox-content">
						<form id="GuideForm" name="GuideForm" class="form-horizontal" method="post">
							<div class="form-group">
								<label class="col-sm-2 control-label">性别：</label>
							    <div class="col-sm-4">
									${pd.T_AI_SEX}
								</div>
								<label class="col-sm-2 control-label">出生日期：</label>
							    <div class="col-sm-4">
									${pd.AI_BIRTHDAY}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">身份证号：</label>
							    <div class="col-sm-4">
									${pd.AI_IDCARD}
								</div>
								<label class="col-sm-2 control-label">联系手机：</label>
							    <div class="col-sm-4">
									${pd.AI_PHONE}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">头像地址：</label>
							    <div class="col-sm-4">
									<img id="PHOTO" name="PHOTO" src="" width="40%" height="40%">
									<input type="hidden" class="form-control" name="AI_PHOTO" id="AI_PHOTO" value="${pd.AI_PHOTO}" >
								</div>
								<label class="col-sm-2 control-label">星级：</label>
							    <div class="col-sm-4">
									${pd.AI_START_LEVEL}
								</div>
							</div>
							<div class="form-group">
								<c:if test="${pd.REJECT_REASON != null && pd.REJECT_REASON  != ''}">
									<label class="col-sm-2 control-label">退回理由：</label>
								    <div class="col-sm-10">
										${pd.REJECT_REASON }
									</div>
								</c:if>
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
		$(document).ready(function(){
			var picturePATH = '';
			var AI_PHOTO = $("#AI_PHOTO").val();
			if(AI_PHOTO != null && AI_PHOTO != ''){
				$.ajax({
					type: "POST",
					url: '<%=basePath%>filesUploads/findByHttpIdOrMasterId',
					data: {
						"ID": AI_PHOTO,
						"MASTER_ID":AI_PHOTO
					},
					dataType: 'json',
					async:false,
					//beforeSend: validateData,
					cache: false,
					success: function(data) {
						picturePATH = data[0].PATH;
						$("#PHOTO").attr("src",picturePATH);
					}
				});
			}
		});
	</script>
</body>
</html>