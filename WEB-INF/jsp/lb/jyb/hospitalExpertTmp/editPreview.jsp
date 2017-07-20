<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header/>
<!-- jsp文件头和头部 -->
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"> </script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
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
						<h5>专家信息预览</h5>
					</div>
					<div class="ibox-content">
						<form id="ArticleRotationForm" name="ArticleRotationForm" class="form-horizontal" method="post">
							<input type="hidden" name="HEL_ID" id="HEL_ID" value="${pd.HEL_ID}" />
							<%-- <div class="form-group">
								<label class="col-sm-2 control-label">标题：</label>
							    <div class="col-sm-10">
									<input type="text" class="form-control required" name="ARTICLE_TITLE" id="ARTICLE_TITLE" value="${pd.ARTICLE_TITLE}" />
								</div>
							</div> --%>
							<div class="form-group">
								<label class="col-sm-2 control-label">姓名：</label>
							    <div class="col-sm-4">
									${pd.HEL_NAME}
								</div>
								<label class="col-sm-2 control-label">定价：</label>
							    <div class="col-sm-4">
									${pd.HEL_PRICE}
								</div>
								
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">性别：</label>
							    <div class="col-sm-4">
							    	<c:if test="${pd.HEL_SEX ==1}">男</c:if>
							    	<c:if test="${pd.HEL_SEX ==0}">女</c:if>
								</div>
								<label class="col-sm-2 control-label">职务：</label>
							    <div class="col-sm-4">
									${pd.HEL_DUTY}
								</div>
							</div>
							<div class="form-group">
								
								<label class="col-sm-2 control-label">所属代理商：</label>
							    <div class="col-sm-4">
									${pd.SP_NAME}
								</div>
								<label class="col-sm-2 control-label">手机号：</label>
							    <div class="col-sm-4">
									${pd.PHONENUM} 
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">所属医院：</label>
							    <div class="col-sm-4">
									${pd.HE_HOSPITAL}
								</div>
								<label class="col-sm-2 control-label">所属科室：</label>
							    <div class="col-sm-4">
									${pd.HD_NAME}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">所属区域：</label>
							    <div class="col-sm-4">
									${pd.CAA_NAME}
								</div>
								<label class="col-sm-2 control-label">出生日期：</label>
							    <div class="col-sm-4">
									${pd.HEL_BIRTHDAY}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">相关荣誉：</label>
							    <div class="col-sm-4">
									${pd.HEL_HONOR}
								</div>
								<label class="col-sm-2 control-label">擅长专业：</label>
							    <div class="col-sm-4">
									${pd.HEL_GOODPRO}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">教学背景：</label>
							    <div class="col-sm-4">
									${pd.HEL_EDU}
								</div>
								<label class="col-sm-2 control-label">提交状态：</label>
							    <div class="col-sm-4">
									${pd.HE_SUBMIT}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">审核状态：</label>
							    <div class="col-sm-4">
									${pd.HE_AUDIT}
								</div>
								<label class="col-sm-2 control-label">合并状态：</label>
							    <div class="col-sm-4">
									${pd.HE_MERGE}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">模板状态：</label>
							    <div class="col-sm-4">
									${pd.HE_TEMPLATE}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">用户头像：</label>
							    <div class="col-sm-4">
							    	<input type="hidden" name="HEL_PHOTO" id="HEL_PHOTO" value="${pd.HEL_PHOTO}" />
									<img src="" id="PHOTO" width="200px" height="200px" name="PHOTO">
								</div>
								<label class="col-sm-2 control-label">手机用户头像：</label>
							    <div class="col-sm-4">
							    	<input type="hidden" name="HEL_PHOTO_PHONE" id="HEL_PHOTO_PHONE" value="${pd.HEL_PHOTO_PHONE}" />
									<img src="" id="PHOTOS" width="200px" height="200px" name="PHOTOS">
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<!-- <div class="form-group">
								<div class="col-sm-2 col-sm-offset-5 text-center">
									<button id="btn_Cancel" class="btn btn-primary" type="button" onclick="g()">返回列表</button>
								</div>
							</div> -->
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
		var keyId = $("#HEL_PHOTO").val();
		//查询图片路径
		$.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/findByHttpIdOrMasterId?tm=',
				data: {
					"ID": keyId
				},
				dataType: 'json',
				async:false,
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					picturePATH = data[0].PATH;
					console.log(picturePATH)
					$("#PHOTO").attr("src",picturePATH);
				}
			});
		
		//表单ID
		var keyIdS = $("#HEL_PHOTO_PHONE").val();
		//查询图片路径
		$.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/findByHttpIdOrMasterId?tm=',
				data: {
					"ID": keyIdS
				},
				dataType: 'json',
				async:false,
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					picturePATH = data[0].PATH;
					console.log(picturePATH)
					$("#PHOTOS").attr("src",picturePATH);
				}
			});
	  
	</script>
</body>
</html>