<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
									${pd.AI_PHOTO}
								</div>
								<label class="col-sm-2 control-label">星级：</label>
							    <div class="col-sm-4">
									${pd.AI_START_LEVEL}
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
		$(document).ready(function(){
		});
	</script>
</body>
</html>