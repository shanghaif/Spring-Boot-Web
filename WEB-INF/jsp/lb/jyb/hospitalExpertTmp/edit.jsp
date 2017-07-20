<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header/>
<!-- jsp文件头和头部 -->
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"> </script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>专家信息管理</h5>
					</div>
					<div class="ibox-content">
						<form id="ArticleRotationForm" name="ArticleRotationForm" class="form-horizontal" method="post">
							<input type="hidden" name="HEL_ID" id="HEL_ID" value="${pd.HEL_ID}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">姓名：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="HEL_NAME" id="HEL_NAME" value="${pd.HEL_NAME}" />
								</div>
								
								<label class="col-sm-2 control-label">手机号：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="PHONENUM" id="PHONENUM" value="${pd.PHONENUM}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">性别：</label>
							    <div class="col-sm-4">
							    	<select class="form-control required" name="HEL_SEX" id="HEL_SEX" value="${pd.HEL_SEX}">
					                   <option value="0" <c:if test="${pd.HEL_SEX == 0}">selected="selected"</c:if>>女</option>
					                   <option value="1" <c:if test="${pd.HEL_SEX == 1}">selected="selected"</c:if>>男</option>
					                 </select>
								</div>
								<label class="col-sm-2 control-label">职务：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="HEL_DUTY" id="HEL_DUTY" value="${pd.HEL_DUTY}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">定价：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="HEL_PRICE" id="HEL_PRICE" value="${pd.HEL_PRICE}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
								</div>
								
								<label class="col-sm-2 control-label">所属区域：</label>
							    <div class="col-sm-2">
							    	<select class="form-control required" name="HE_AREA" id="HE_AREA" value="${pd.HE_AREA}" onchange="changePcode();"
                                    	 ajax--url="dic/getDicAreaForSelect" ajax--column="ID,TEXT">
                     				 </select>
								</div>
								<div class="col-sm-2">
							    	<select class="form-control required" name="caa_pcode" id="caa_pcode" value="${pd.caa_pcode}"
                                    	 ajax--url="dic/getSubDicAreaListByProvinceCode" ajax--column="ID,TEXT">
                     				 </select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">所属医院：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="HE_HOSPITAL" id="HE_HOSPITAL" value="${pd.HE_HOSPITAL}" />
								</div>
								<label class="col-sm-2 control-label">所属科室：</label>
							    <div class="col-sm-4">
								<select class="form-control required" name="HD_ID" id="HD_ID" value="${pd.HD_ID}"
                                    ajax--url="hospDept/getHospDeptForSelect" ajax--column="ID,TEXT">
                                    <option value="">--所属科室--</option>
                     			</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">出生日期：</label>
							    <div class="col-sm-4">
									<input type="text" class="bootstrapdatetimepicker form-control required" name="HEL_BIRTHDAY" id="HEL_BIRTHDAY" placeholder="请选择出生日期" value="${pd.HEL_BIRTHDAY}" />
								</div>
								<label class="col-sm-2 control-label">教学背景：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control" name="HEL_EDU" id="HEL_EDU" value="${pd.HEL_EDU}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">相关荣誉：</label>
							    <div class="col-sm-4">
									<input type="textarea" class="form-control" name="HEL_HONOR" id="HEL_HONOR" value="${pd.HEL_HONOR}" />
								</div>
								<label class="col-sm-2 control-label">擅长专业：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control" name="HEL_GOODPRO" id="HEL_GOODPRO" value="${pd.HEL_GOODPRO}" />
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-6">
										<div class="form-group">
											<label class="col-sm-12 control-label"><p class="text-center">用户头像</p></label>
										</div>
										<div class="form-group">
											<div class="col-sm-12">
												<input id="inp" type="file" name="file" multiple class="file-loading">
												<input type="hidden" name="HEL_PHOTO" id="HEL_PHOTO" value="${pd.HEL_PHOTO }">
											</div>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="form-group">
											<label class="col-sm-12 control-label"><p class="text-center">用户手机端头像</p></label>
										</div>
										<div class="form-group">
											<div class="col-sm-12">
												<input id="inpp" type="file" name="file" multiple class="file-loading">
												<input type="hidden" name="HEL_PHOTO_PHONE" id="HEL_PHOTO_PHONE" value="${pd.HEL_PHOTO_PHONE }">
											</div>
										</div>
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
			var formId = "#ArticleRotationForm";
			var picturePATH = '';
			var picturePATHS = '';
			var HEL_PHOTO = $("#HEL_PHOTO").val();
			var HEL_PHOTO_PHONE = $("#HEL_PHOTO_PHONE").val();
			if(HEL_PHOTO != null && HEL_PHOTO != ''){
				$.ajax({
					type: "POST",
					url: '<%=basePath%>filesUploads/findByHttpIdOrMasterId',
					data: {
						"ID": HEL_PHOTO,
						"MASTER_ID":HEL_PHOTO
					},
					dataType: 'json',
					async:false,
					//beforeSend: validateData,
					cache: false,
					success: function(data) {
						picturePATH = data[0].PATH;
						initFileName = data[0].FILE_NAME;
					}
				});
			}
			if(HEL_PHOTO_PHONE != null && HEL_PHOTO_PHONE != ''){
				$.ajax({
					type: "POST",
					url: '<%=basePath%>filesUploads/findByHttpIdOrMasterId',
					data: {
						"ID": HEL_PHOTO_PHONE,
						"MASTER_ID":HEL_PHOTO_PHONE
					},
					dataType: 'json',
					async:false,
					//beforeSend: validateData,
					cache: false,
					success: function(data) {
						picturePATHS = data[0].PATH;
						initFileName = data[0].FILE_NAME;
					}
				});
			}
	    	//初始化下拉菜单
	    	$("#ARTICLE_TYPE").createOption();
	    	$("#HE_AREA").createOption();
	    	$("#HD_ID").createOption();
	    	$("#SP_REGISTER_ADDR").createOption();
	    	$("#caa_pcode").createOption();
	    	//表单提交JS验证
			$(formId).validate({
				rules: {
					PHONENUM: {
						rangelength: [11, 11],
						remote: {
							url: '/hospitalExpertTmp/selectPhone',
							type: 'POST',
							dataType: 'JSON',
							data: {
								'HEL_PHOTO': function() {
									return $('#PHONENUM').val();
								},
								'ID' : function(){
									return $('#HEL_ID').val();
								}
							}
						}
					}
				},
				messages: {
					PHONENUM: "输入的手机号格式不正确，或该手机号已被注册",
				}
			});
		//表单提交
	    function submitForm(){
	        var id = $('#HEL_ID').val();
	        var HEL_PHOTO = $("#HEL_PHOTO").val();
	        if(HEL_PHOTO != null && HEL_PHOTO != '' && HEL_PHOTO_PHONE != null && HEL_PHOTO_PHONE != ''){
	           	$.ajax({
					type: "POST",
					url: '<%=basePath%>hospitalExpertTmp/checkKeyWords?tm=' +  new Date().getTime(),
					data: $(formId).serialize(),
					dataType: 'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data) {
						if (data.msg == 'success') {
				        	var action = "";
					    	if(id == ""){
					    		action = "hospitalExpertTmp/saveAdd";
					    	}else{
					    		action = "hospitalExpertTmp/saveEdit";
					    	}
					    	$(formId).attr("action", action);
					    	$(formId).submit();
						} else {
							layer.msg(data.error_tip);
						}
					}
				});
	        	
	        } else{
	        	layer.msg("无用户头像不能保存");
	        }
	    	
	    }
		/* 二级联动 */
	    function changePcode(){
    		var addr=$("#HE_AREA").val();
    		$("#caa_pcode").createOptions({"caa_pcode":addr});
    	};
	    //返回到列表页面 
		function goBack(){
			this.location.href="<%=basePath%>hospitalExpertTmp/toLists";
		}
		var IDSAndPid=[];
		var ids;
		var MASTER_ID=HEL_PHOTO;//master_id(参数是举例，请根据实际传参)
		var initFileName=""//初始化照片名(参数是举例，请根据实际传参)
		var initFilePath="D:\\\\20170222\\d8ed7fbd4a9b445cb446f7d727579eb2.jpg"//初始化照片路径(参数是举例，请根据实际传参)
		var initFileID= "d8ed7fbd4a9b445cb446f7d727579eb2"//初始化照片id，如果多的话可设置为数组(参数是举例，请根据实际传参)
	    $("#inp").fileinput({
	    	language: 'zh', //设置语言
	    	browseClass: "btn btn-primary btn-block",
	        showCaption: false,//是否在选择按钮旁边显示文件名
	    	showUpload:false,//是否展示上传按钮
	    	showRemove:true,//是否展示移除按钮
	    	//showClose:false,//是否展示关闭按钮

	    	//showDelete: false,//是否显示删除图标
	    	//showZoom: false//是否显示预览
	    	showUploadedThumbs:false,//上传完成后是否显示缩略图
	    	uploadUrl:'/filesUploads/fileUpd',//上传的url
	    	uploadAsync: true,//异步支持
	    	//previewFileType: ["text","image"],//文件類型
	    	allowedFileExtensions: ["gif", "jpeg", "tiff", "bmp",'jpg','png','psd','svg'],//允许上传的文件扩展名
	    	overwriteInitial: true,
	        initialPreviewAsData: true,
	    	initialPreview: [//初始化预览
	    		picturePATH
	        ],
	        initialPreviewConfig: [//初始化设置 {标题 宽度 删除的url 是否顯示刪除 顺序  扩展字符}
	            {caption: initFileName, width: "120px",url:'/filesUploads/delete',showDelete: true ,key:1,extra: {id: '20e3a27be3d84329833c200772d21a0b'}}        
	        ],
	        uploadExtraData: {//上传时附加的参数额外的参数，注意，此处jquery无效。
	        	"IDS": MASTER_ID,
	            "MASTER_ID":MASTER_ID
	        },
	        //maxFileCount: 10, //表示允许同时上传的最大文件个数
	        //showCaption: false,//是否显示标题   
	        //dropZoneEnabled: false//是否显示拖拽区域
	        //minImageWidth: 50, //图片的最小宽度
	        //minImageHeight: 50,//图片的最小高度
	        //maxImageWidth: 1000,//图片的最大宽度
	        //maxImageHeight: 1000,//图片的最大高度
	        //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
	        //minFileCount: 0,
	        //enctype: 'multipart/form-data',
	        //validateInitialCount:true,
	    }).on('fileselect', function(event, numFiles, label) {//选择文件时
	    	$(this).fileinput("upload");//选择完文件后立即上传
	    })
	    .on('fileuploaded', function(event, data, previewId, index) {//文件上传成功后
			var IDS=JSON.parse(data.jqXHR.responseText)[0].id;
			var path=JSON.parse(data.jqXHR.responseText)[0].path;
			picturePATH = path;
			/* $("#I_IDY").val(IDS);
			console.log(IDS); */
			$("#HEL_PHOTO").val(IDS);
	 	})
	 	
		.on('filedeleted', function(event, id) {//删除预加载的文件
	        console.log("has filedeleted")
	        $("#HEL_PHOTO").val("");
		})
		.on('filecleared', function(event){ //清空的事件
			$("#HEL_PHOTO").val("");
		})
		.on('fileremoved', function(event, id) {
			$("#HEL_PHOTO").val("");
		})
		
		
		
		var MASTER_IDS=HEL_PHOTO_PHONE;
		var initFileNames=""
	    $("#inpp").fileinput({
	    	language: 'zh', //设置语言
	    	browseClass: "btn btn-primary btn-block",
	        showCaption: false,//是否在选择按钮旁边显示文件名
	    	showUpload:false,//是否展示上传按钮
	    	showRemove:true,//是否展示移除按钮
	    	//showClose:false,//是否展示关闭按钮

	    	//showDelete: false,//是否显示删除图标
	    	//showZoom: false//是否显示预览
	    	showUploadedThumbs:false,//上传完成后是否显示缩略图
	    	uploadUrl:'/filesUploads/fileUpd',//上传的url
	    	uploadAsync: true,//异步支持
	    	//previewFileType: ["text","image"],//文件類型
	    	allowedFileExtensions: ["gif", "jpeg", "tiff", "bmp",'jpg','png','psd','svg'],//允许上传的文件扩展名
	    	overwriteInitial: true,
	        initialPreviewAsData: true,
	    	initialPreview: [//初始化预览
	    		picturePATHS
	        ],
	        initialPreviewConfig: [//初始化设置 {标题 宽度 删除的url 是否顯示刪除 顺序  扩展字符}
	            {caption: initFileName, width: "120px",url:'/filesUploads/delete',showDelete: true ,key:1,extra: {id: '20e3a27be3d84329833c200772d21a0b'}}        
	        ],
	        uploadExtraData: {//上传时附加的参数额外的参数，注意，此处jquery无效。
	        	"IDS": MASTER_IDS,
	            "MASTER_ID":MASTER_IDS
	        },
	        //maxFileCount: 10, //表示允许同时上传的最大文件个数
	        //showCaption: false,//是否显示标题   
	        //dropZoneEnabled: false//是否显示拖拽区域
	        //minImageWidth: 50, //图片的最小宽度
	        //minImageHeight: 50,//图片的最小高度
	        //maxImageWidth: 1000,//图片的最大宽度
	        //maxImageHeight: 1000,//图片的最大高度
	        //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
	        //minFileCount: 0,
	        //enctype: 'multipart/form-data',
	        //validateInitialCount:true,
	    }).on('fileselect', function(event, numFiles, label) {//选择文件时
	    	$(this).fileinput("upload");//选择完文件后立即上传
	    })
	    .on('fileuploaded', function(event, data, previewId, index) {//文件上传成功后
			var IDS=JSON.parse(data.jqXHR.responseText)[0].id;
			var path=JSON.parse(data.jqXHR.responseText)[0].path;
			picturePATHS = path;
			/* $("#I_IDY").val(IDS);
			console.log(IDS); */
			$("#HEL_PHOTO_PHONE").val(IDS);
	 	})
	 	
		.on('filedeleted', function(event, id) {//删除预加载的文件
	        console.log("has filedeleted")
	        $("#HEL_PHOTO_PHONE").val("");
		})
		.on('filecleared', function(event){ //清空的事件
			$("#HEL_PHOTO_PHONE").val("");
		})
		.on('fileremoved', function(event, id) {
			$("#HEL_PHOTO_PHONE").val("");
		})
		
		
	</script>
</body>
</html>