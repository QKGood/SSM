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
<script type = "text/javascript" src = "/js/main.js"></script>
</head>
<body class="easyui-layout">
		<div data-options="region:'north'" style="height:60px">
			<img src = "<%=path%>/images/logo.jpg" class = "logo"/>
			<div id="wel">
				<a href = "javascript:;" onclick = "refresh()">刷新</a>
				欢迎******
				<a href = "javascript:;">安全退出</a>
			</div>
		</div>
		<div data-options="region:'west',split:true" title="菜单" style="width:235px;">
			<div class="easyui-accordion menu" style="width:235px;">
				<div title="产品管理">
					<ul>
						<li><a href="javascript:;" onclick="addTab('查询产品','<%=path%>/product/product_page');">查询产品</a></li>
						<li><a href="javascript:;" onclick="addTab('系统参数','http://www.jd.com');">系统参数</a></li>
						<li>系统公告</li>
						<li>系统监测</li>
					</ul>
				</div>
				<div title="用户管理">
					<ul>
						<li><a href="javascript:;">修改密码</a></li>
						<li>系统参数</li>
						<li>系统公告</li>
						<li>系统监测</li>
					</ul>
				</div>

			</div>
		</div>
		<div data-options="region:'center'">
			<div id="tabs" class="easyui-tabs" style="width:100%;height:100%;">
				<div title="主页" style="padding:10px">
					主页内容
				</div>
			</div>
		</div>
		<div data-options="region:'south',split:false" class = "down">Q*******&copy;test 2016-2020</div>
</body>
</html>