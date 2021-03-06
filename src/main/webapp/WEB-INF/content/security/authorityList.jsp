<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>权限管理</title>

    <link rel="shortcut icon" href="favicon.ico">
    <link href="${ctx}/scripts/hplus/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctx}/scripts/hplus/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx}/scripts/hplus/css/animate.min.css" rel="stylesheet">
    <link href="${ctx}/scripts/hplus/css/style.min.css" rel="stylesheet">
    
    <script type="text/javascript" src="${ctx}/scripts/hplus/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/scripts/hplus/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    	function jumpPage(i){
    		$("#pageNo").val(i);
    		$("#mainForm")[0].submit();
    	}
    </script>
</head>
	<body>
	<form id="mainForm" action="${ctx}/security/authority?lookup=${lookup }" method="get">
		<input type="hidden" name="lookup" value="${lookup}" />
		<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo}"/>
		<input type="hidden" name="orderBy" id="orderBy" value="${page.orderBy}"/>
		<input type="hidden" name="order" id="order" value="${page.order}"/>
		<div class="ibox-content">
		<div class="row">
                <div class="col-sm-6">
                    <div class="input-group">
                        <input placeholder="权限名称" type="text" class="input-sm form-control" name="filter_LIKES_name" value="${param['filter_LIKES_name']}"/> 
                        <span class="input-group-btn">
                            <button type="button" class="btn btn-sm btn-primary" onclick="jumpPage(1)"> 搜索</button> 
                        </span>
                    </div>
                    
                </div>
				<div class="col-sm-6">	
				  <div class="input-group">
                       <span class="input-group-btn">
                           <c:choose>
							<c:when test="${empty lookup}">
							<shiro:hasPermission name="ORGEDIT">
							<a type='button' href="${ctx}/security/authority/create" class="btn btn-sm btn-primary" >新建</a>
							</shiro:hasPermission>
							</c:when>
							<c:otherwise>
							<input type='button' onclick="javascript:bringback('','')" class='button_70px' value='重置'/>
							</c:otherwise>
						</c:choose>
                       </span>
                       </div>	
                   </div>    
            </div>
            <hr/>
		
		 <div class="table-responsive">
          <table class="table table-striped table-hover table-bordered">
			<thead>
			<tr>
				<th>
					权限名称
				</th>
				<th>
					权限描述
				</th>
				<th>
					操作
				</td>				
			</tr>
			</thead>
			<c:forEach items="${page.result}" var="authority">
				<tr>
					<td>
						${authority.name}&nbsp;
					</td>
					<td>
						${authority.description}&nbsp;
					</td>
					<td>
				    <c:choose>
				    <c:when test="${empty lookup}">
				    <shiro:hasPermission name="AUTHORITYDELETE">
						<a href="${ctx}/security/authority/delete/${authority.id }" class="glyphicon glyphicon-trash" title="删除" onclick="return confirmDel();">删除</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="AUTHORITYEDIT">
						<a href="${ctx}/security/authority/update/${authority.id }" class="glyphicon glyphicon-pencil" title="编辑">编辑</a>
					</shiro:hasPermission>
						<a href="${ctx}/security/authority/view/${authority.id }" class="glyphicon glyphicon-search"  title="查看">查看</a>
					</c:when>
					<c:otherwise>
						<a href="javascript:void(0)" class="glyphicon glyphicon-search"  title="选择" onclick="parent.digCallBack({id:'${authority.id}',name:'${authority.name }'})">选择</a>
					</c:otherwise>
					</c:choose>
					</td>
				</tr>
			</c:forEach>
			<frame:page curPage="${page.pageNo}" totalPages="${page.totalPages }" totalRecords="${page.totalCount }" lookup="${lookup }"/>
		</table>
		</div>
	</div>	
	</form>
	</body>
</html>
