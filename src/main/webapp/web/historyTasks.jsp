<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>已办任务</title>

    <link rel="shortcut icon" href="favicon.ico"/>
    <link href="${ctx}/scripts/hplus/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${ctx}/scripts/hplus/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet"/>
    <link href="${ctx}/scripts/hplus/css/animate.min.css" rel="stylesheet"/>
    <link href="${ctx}/scripts/hplus/css/style.min.css" rel="stylesheet"/>
    
    <script type="text/javascript" src="${ctx}/scripts/hplus/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/scripts/hplus/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/web/showPage.js"></script>
    <script type="text/javascript">
    	function jumpPage(i){
    		$("#pageNo").val(i);
    		var data =  $("#mainForm").serialize();
    		var url = "${ctx}/flow/task/historyTasks";
    		$.getJSON(url,data,function(redata){
    			if(redata.status){
    				var page = redata.obj;
    				dataPage(page);
    				showPage("page",page);
    			}
    		});
    		
    	}
    	function dataPage(page){
    		 var $table = $("#page");
   		     var content = "";
   		     for(var i=0; i<page.result.length; i++){
   		    	content += "<tr>";
   		    	content +="<td>"+page.result[i].id+"</td>";
   		    	content +="<td>"+page.result[i].title+"</td>";
   		    	content +="<td>"+page.result[i].name+"</td>";
   		    	content +="<td>"+page.result[i].starttime+"</td>";
   		    	content +="<td>"+page.result[i].endtime+"</td>";
   		    	content +="<td>"+page.result[i].fullname+"</td>";
   		    	if(page.result[i].endtime == null){
   		    		content +="<td><a href='javascript:void(0)' onclick='showViews(1,\""+page.result[i].id+"\",\""+page.result[i].executionid+"\",\""+page.result[i].processinstanceid+"\",\""+page.result[i].processdefinitionid+"\",\""+page.result[i].activityid+"\")'>处理</a>"+page.result[i].processinstanceid+"</td>";
   		    	}else{
   		    		content +="<td>已办&nbsp;&nbsp;<a href='javascript:void(0)' onclick='showViews(2,\""+page.result[i].id+"\",\""+page.result[i].executionid+"\",\""+page.result[i].processinstanceid+"\",\""+page.result[i].processdefinitionid+"\",\""+page.result[i].activityid+"\")'>查看</a></td>";
   		    	}
   		    	content +="<td>"+(page.result[i].eendtime == null ? '未结' : '已结')+"</td>";
   		    	content += "</tr>";
   		    }
   		    $table.find("tbody").append(content);
    	}
    	function editDialog(url){
    		var index = parent.layer.open({
    		      type: 2,
    		      title: '编辑',
    		      shadeClose: true,
    		      shade: false,
    		      maxmin: true, //开启最大化最小化按钮
    		      area: ['893px', '600px'],
    		      content: url
    		    });
    		parent.layer.full(index);
    	}
    	$(function(){
    		jumpPage(1);
    	});
    	
    	function showViews(openType,taskId,executionId,processInstanceId,processDefinitionId,activityId){
    		var data = {processDefinitionId:processDefinitionId,activityId:activityId,openType:openType};
    		$.getJSON("${ctx}/flow/task/openViews",data,function(redata){
    			if(redata.status){
    				var url = "${ctx}/web/views.jsp?taskId="+taskId+"&executionId="+executionId+"&forms="+redata.obj.forms+"&fields="+redata.obj.fields+"&processInstanceId="+processInstanceId+"&processDefinitionId="+processDefinitionId+"&activityId="+activityId+"&openType="+openType;
        			window.open(url);
    			}else{
    				alert("服务器错误");
    			}
    			
    		});
    	}
    </script>
</head>

	<body>
	<form id="mainForm" action="${ctx}/flow/task/groupTasks" method="get">
		<input type="hidden" name="lookup" value="${lookup}" />
		<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo}"/>
		<input type="hidden" name="orderBy" id="orderBy" value="${page.orderBy}"/>
		<input type="hidden" name="order" id="order" value="${page.order}"/>
		<div class="ibox-content">
		<div class="row">
                <div class="col-sm-6">
                    <div class="input-group">
                        <input placeholder="字典名称" type="text" class="input-sm form-control" name="filter_LIKES_name" value="${param['filter_LIKES_name']}"/> 
                        <span class="input-group-btn">
                            <button type="button" class="btn btn-sm btn-primary" onclick="jumpPage(1)"> 搜索</button> 
                        </span>
                    </div>
                    
                </div>
				<div class="col-sm-6">	
				  <div class="input-group">
                       <span class="input-group-btn">
						<shiro:hasPermission name="MENUEDIT">
						<a type='button' href="javascript:void(0);" onclick="editDialog('${ctx}/flow/process/create')" class="btn btn-sm btn-primary" >新建</a>
						</shiro:hasPermission>
                       </span>
                       </div>	
                   </div>    
            </div>
            <hr/>
		
		 <div class="table-responsive">
          <table class="table table-striped table-hover table-bordered" id="page">
			<thead>
			<tr>
				<th name="id">编号</th>
		        <th  name="name">标题</th>
		        <th  name="createTime">节点</th>
		        <th  name="assignee">送达时间</th>
		        <th  name="assignee">办结时间</th>
		        <th  name="assignee">提交人</th>
				<th>
					任务状态
				</th>				
				<th>
					流程状态
				</th>				
			</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		</div>
		</div>
	</form>
    </script>
	</body>
</html>


