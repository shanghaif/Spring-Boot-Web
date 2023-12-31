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
					<!-- <div class="ibox-title">
						<h5>专家库信息</h5>
					</div> -->
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							</div>
						</div>
						
						<table id="queryTable" data-mobile-responsive="true" cellpadding="0" cellspacing="0" class="table table-hover table-bordered">
							 <thead>
					            <tr height="5%">
					                <th width="15%" >公司名称</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].name }
					                </td>
					            </tr>
					            <tr height="5%">
					                <th width="15%" data-valign="middle" data-align="center">注册地</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].registeraddr }
					                </td>
					            </tr>
					            <tr>
					                <th width="15%" data-valign="middle" data-align="center">注册时间</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].regitertime }
					                </td>
					            </tr>
					            <tr>
					                <th width="15%" data-valign="middle" data-align="center">服务范围</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].servicerange }
					                </td>
					            </tr>
					            <tr>
					                <th width="15%" data-valign="middle" data-align="center">营业执照扫描件</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].licence }
					                </td>
					            </tr>
					            <tr>
					                <th width="15%" data-valign="middle" data-align="center">负责人</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].legalperson }
					                </td>
					            </tr>
					            <tr>
					                <th width="15%" data-valign="middle" data-align="center">联系方式</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].phone }
					                </td>
					            </tr>
					            <tr>
					                <th width="15%" data-valign="middle" data-align="center">合同电子版地址</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].contract }
					                </td>
					            </tr>
					            <tr>
					                <th width="15%" data-valign="middle" data-align="center">星级</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].starlevel }
					                </td>
					            </tr>
					        </thead>
						</table>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="myModal" class="modal inmodal fade" tabindex="-1" role="dialog"  aria-hidden="true">
	<!-- 全局js -->
	<system:jsFooter/>
	<script type="text/javascript">
	</script>
</body>
</html>