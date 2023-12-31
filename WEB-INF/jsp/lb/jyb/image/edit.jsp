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
						<h5>编辑TV背景图</h5>
					</div>
					<div class="ibox-content">
						<form id="ArticleRotationForm" name="ArticleRotationForm" class="form-horizontal" method="post">
							<div class="form-group">
								<!-- <label class="col-sm-2 control-label">TV青年班背景图：</label> -->
							    <div class="col-sm-6">
									<label class="control-label">TV青年版背景图:</label>
									<input id="inp" type="file" name="file" multiple class="file-loading">
									<input type="hidden" name="TVYoung" id="TVYoung" value="${pd.TVYoung }">
								</div>
								<!-- <label class="col-sm-2 control-label">TV老年班背景图：</label> -->
							    <div class="col-sm-6">
							    	<label class="control-label">TV老年版背景图:</label>
									<input id="inpp" type="file" name="file" multiple class="file-loading">
									<input type="hidden" name="TVOld" id="TVOld" value="${pd.TVOld }">
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<!-- <div class="form-group">
								<div class="col-sm-2 col-sm-offset-5 text-center">
									<button id="btn_Save" class="btn btn-primary" type="button" onclick="submitForm();">保存内容</button>
									<button id="btn_Cancel" class="btn btn-white" type="button" onclick="goBack();">取消</button>
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
		var formId = "#ArticleRotationForm";
		var picturePATH = '';
		var picturePATHS = '';
		var TVYoung = $("#TVYoung").val();
		var TVOld = $("#TVOld").val();
		if(TVYoung != null && TVYoung != ''){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/findByHttpIdOrMasterId?tm=' +  new Date().getTime(),
				data: {
					"IDS": TVYoung,
					"MASTER_ID":TVYoung
				},
				dataType: 'json',
				async:false,
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					console.log("111"+data[0].PATH);
					picturePATH = data[0].PATH;
					initFileName = data[0].FILE_NAME;
				}
			});
		}
		if(TVOld != null && TVOld != ''){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/findByHttpIdOrMasterId?tm=' +  new Date().getTime(),
				data: {
					"IDS": TVOld,
					"MASTER_ID":TVOld
				},
				dataType: 'json',
				async:false,
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					console.log("111"+data)
					picturePATHS = data[0].PATH;
					
				}
			});
		}
			
		var IDSAndPid=[];
		var ids;
		var MASTER_ID=TVYoung;//master_id(参数是举例，请根据实际传参)
		var initFileName=""//初始化照片名(参数是举例，请根据实际传参)
		var initFilePath="D:\\\\20170222\\d8ed7fbd4a9b445cb446f7d727579eb2.jpg"//初始化照片路径(参数是举例，请根据实际传参)
		var initFileID= "d8ed7fbd4a9b445cb446f7d727579eb2"//初始化照片id，如果多的话可设置为数组(参数是举例，请根据实际传参)
	    $("#inp").fileinput({
	    	language: 'zh', //设置语言
	    	browseClass: "btn btn-primary btn-block",
	        showCaption: false,//是否在选择按钮旁边显示文件名
	    	showUpload:false,//是否展示上传按钮
	    	showRemove:false,//是否展示移除按钮
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
			
	 	})
	 	
		.on('filedeleted', function(event, id) {//删除预加载的文件
	        console.log("has filedeleted")
		})
		.on('filecleared', function(event){ //清空的事件
			
		})
		var MASTER_IDS=TVOld;
		var initFileNames=""
		$("#inpp").fileinput({
	    	language: 'zh', //设置语言
	    	browseClass: "btn btn-primary btn-block",
	        showCaption: false,//是否在选择按钮旁边显示文件名
	    	showUpload:false,//是否展示上传按钮
	    	showRemove:false,//是否展示移除按钮
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
	            {caption: initFileNames, width: "120px",url:'/filesUploads/delete',showDelete: true ,key:1,extra: {id: '20e3a27be3d84329833c200772d21a0b'}}        
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
			
	 	})
	 	
		.on('filedeleted', function(event, id) {//删除预加载的文件
	        console.log("has filedeleted")
		})
		.on('filecleared', function(event){ //清空的事件
			
		})
		
		
	</script>
</body>
</html>