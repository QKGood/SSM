<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
    	String path = request.getContextPath();
    %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

<link rel = "stylesheet" href = "/jquery-easyui/themes/default/easyui.css"/>
<link rel = "stylesheet" href = "/jquery-easyui/themes/icon.css"/>
<link rel = "stylesheet" href = "/css/main.css"/>
<script type = "text/javascript" src = "/js/jquery.min.js"></script>
<script type = "text/javascript" src = "/jquery-easyui/jquery.min.js"></script>
<script type = "text/javascript" src = "/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type = "text/javascript" src = "/js/json2.js"></script>
<script type = "text/javascript" src = "/js/main.js"></script>

<script>
	$(function() {
		setPagination("list");
	});
	
	function showAddProductWin(){
		$("#addWin").window("open");// 打开指定的window， open表示打开，close表示关闭
		$("#addForm").form("clear"); // 清除表单数据
	}
	function showEditProductWin(){
		//var row = $("#list").datagrid("getSelected"); // 获取数据表格中被选中的行数据
		var rows = $("#list").datagrid("getSelections");
		if(rows.length  > 1 ){
			$.messager.alert("提示","请选择一个要修改的产品","info");
		}else if(rows.length == 1){
			var row = rows[0];
			if(row){
				$("#editForm").form("load", row);
				$("#editWin").window("open");
			}
		}else if(rows.length == 0){
			$.messager.alert("提示","请选择一个要修改的产品","info");
		}
		
	}
	
	function showEditProductWin1(index){
		 var row = $('#list').datagrid('getData').rows[index];
			if(row){
				var json1 = json.replace("_id",row.id).replace("_title",row.title).replace("_price",row.price).replace("_des",row.des);
				$("#editForm").form("load", JSON.parse(json1)); // 直接获取表单的数据
				$("#editWin").window("open");
			}
		
	}
	
	function addProduct() {
		if($("#addForm").form("validate")){
			$.post("<%=path%>/product/add",
					$("#addForm").serialize(),
				function(data){
					if(data.result == "success"){
						$("#addWin").window("close"); // 关闭窗口
						$("#list").datagrid("reload"); // 重新加载指定数据网格数据
						$.messager.alert("提示",data.message,"info");
					}else if(data.result == "fail"){
						$.messager.alert("提示",data.message,"info");
					}
			},"json");
		}else{
			$.messager.alert("提示","请输人正确的数据","info");
		}
	}
	
	function editProduct(){
		if($("#editForm").form("validate")){
			$.post("<%=path%>/product/update",
					$("#editForm").serialize(),
				function(data){
					if(data.result == "success"){
						$("#editWin").window("close"); // 关闭窗口
						$("#list").datagrid("reload"); // 重新加载指定数据网格数据
						$.messager.alert("提示",data.message,"info");
					}else if(data.result == "fail"){
						$.messager.alert("提示",data.message,"info");
					}
			},"json");
		}else{
			$.messager.alert("提示","请输人正确的数据","info");
		}
	
	}
	function removeProduct(){
		//var row = $("#list").datagrid("getSelected"); // 获取数据表格中被选中的行数据
		var rows = $("#list").datagrid("getSelections");
		if(rows.length > 0){
			var ids = "";
			for(var i = 0, len = rows.length; i < len; i++){
				if(ids == ""){
					ids = rows[i].id;
				}else{
					ids += ","+rows[i].id
				}
			}
			if(ids != ""){
				$.messager.confirm('提示', '确定要删除吗?', function(r){
					if (r){
						$.get("<%=path%>/product/deleteById?ids=" + ids,
								function(data){
							$("#list").datagrid("reload"); // 重新加载指定数据网格数据
						},"json");
					}
				});
			}
		}else{
			$.messager.alert("提示","请选中想要删除的产品","info");
		}
	}
	
	function removeProduct1(index){
		var row = $('#list').datagrid('getData').rows[index];
			if(row){
				$.messager.confirm('提示', '确定要删除吗?', function(r){
					if (r){
						$.get("<%=path%>/product/deleteById/" + row.id,
								function(data){
							$("#list").datagrid("reload"); // 重新加载指定数据网格数据
						},"json");
					}
				});
		}else{
			$.messager.alert("提示","请选中想要删除的产品","info");
		}
	}
	
	function formatterOpt(value,row,index){
		return "<a href = 'javascript:;'onclick = 'showEditProductWin1("+index+")'>编辑</a>&nbsp&nbsp"+
			"<a href = 'javascript:;' onclick = 'removeProduct1("+index+")'>删除</a>";
	}
</script>
</head>
<body id = "body">
	<table id = "list"class="easyui-datagrid" 
			data-options="toolbar:'#tb',singleSelect:false,
			collapsible:true,
			url:'<%=path %>/product/query_pager',
			method:'get',
			rownumbers:true,
			autoRowHeight:true,
			pagination:true,
			pageSize:20"
			style = "height:100%;"
			>
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'name',width:100,align:'center'">名称</th>
				<th data-options="field:'price',width:80,align:'center'">价格</th>
				<th data-options="field:'des',width:80,align:'center'">描述</th>
				<th data-options="field:'caozuo',width:100,align:'center'" formatter="formatterOpt">操作</th>
			</tr>
		</thead>
	</table>
	<div id="tb" style="padding:5px;height:auto">
		<div style="margin-bottom:5px">
			<a href="javascript:;" onclick = "showAddProductWin()"class="easyui-linkbutton" iconCls="icon-add" >添加</a>
			<a href="javascript:;" onclick = "showEditProductWin()" class="easyui-linkbutton" iconCls="icon-edit">编辑</a>
			<a href="javascript:;" onclick = "removeProduct()"class="easyui-linkbutton" iconCls="icon-remove">删除</a>
		</div>
		<div>
			名称: <input class="easyui-textbox" style="width:80px">
			价格: <input class="easyui-textbox" style="width:80px">
			<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
		</div>
	</div>
	
	<div id="addWin" class="easyui-window" title="添加产品" data-options="closed:true" data-options="iconCls:'icon-save'" style="width:380px;height:350px;padding:5px;">
		<form id = "addForm">
			<table>
				<tr>
					<td>商品名称</td>
					<td><input class="easyui-validatebox textbox" name="name" data-options="required:true,validType:'length[2,20]'"/></td>
				</tr>
				<tr>
					<td>商品价格</td>
					<td><input class="easyui-numberbox" name="price" data-options = "precision:2,required:true" /></td>
				</tr>
				<tr>
					<td>商品描述</td>
					<td><input class="easyui-textbox" data-options="multiline:true" name="des" style="height:100px;"/></td>
				</tr>
				<tr>
					<td>
						<a href="javascript:;" onclick="addProduct();"class="easyui-linkbutton" data-options="iconCls:'icon-add'">确认</a>
					</td>
				</tr>
			</table>
		</form>	
	</div>
	
	<div id="editWin" class="easyui-window" title="修改产品" data-options="closed:true" data-options="iconCls:'icon-save'" style="width:380px;height:350px;padding:5px;">
		<form id = "editForm">
			<table>
			<tr><td><input type="hidden" name = "id"/></td></tr>
				<tr>
					<td>商品名称</td>
					<td><input class="easyui-validatebox textbox" name="name" data-options="required:true,validType:'length[2,20]'" /></td>
				</tr>
				<tr>
					<td>商品价格</td>
					<td><input class="easyui-numberbox" name="price" data-options = "precision:2,required:true"/></td>
				</tr>
				<tr>
					<td>商品描述</td>
					<td><input class="easyui-textbox" data-options="multiline:true" name="des" style="height:100px;"/></td>
				</tr>
				<tr>
					<td>
						<a href="javascript:;" onclick="editProduct();"class="easyui-linkbutton" data-options="iconCls:'icon-add'">确认</a>
					</td>
				</tr>
			</table>
		</form>	
	</div>
</body>
</html>