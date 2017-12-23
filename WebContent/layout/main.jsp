<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js_framework/jquery-easyui-1.5/jquery.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="js_framework/jquery-easyui-1.5/jquery.easyui.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="js_framework/jquery-easyui-1.5/pagingquery.js" charset="UTF-8"></script>
<script type="text/javascript" src="js_framework/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js" charset="UTF-8"></script>
<link rel="stylesheet" href="js_framework/jquery-easyui-1.5/themes/gray/easyui.css">
<link rel="stylesheet" href="js_framework/jquery-easyui-1.5/themes/icon.css">
<title>Insert title here</title>
<style type="text/css"> 
        #fm{margin: 0;padding: 10px 30px;} 
        .ftitle{font-size: 14px;font-weight: bold;padding: 5px 0; 
                margin-bottom: 10px;border-bottom: 1px solid #ccc;} 
        .fitem{margin-bottom: 5px;} 
        .fitem label {display: inline-block;width: 80px;}
        .datagrid-row-selected {background: black;color:#fff;font-weight:bold;} 
        .fitem label{text-align: right;}
       #doubleClick .fitem{margin:15px 0 15px 0;}
    </style> 
<script type="text/javascript" charset="UTF-8">
      $(function(){
    	  $('#tb').datagrid({
    		  url:'queryDict',
    		  striped:true,
    		  pagination:true,
    		  pageSize:10,
    		  editorHeight:50,
    		  title:'字典信息',
    		  toolbar:'#toolbar',
    		  pageList:[10,15,20,25,30,35,40],
    		  nowrap:true,
    		  fitColumns:true,
    		  fit:true,
    		  singleSelect:true,
    		  rownumbers:true,
    		  idField:'ID',
    		  columns:[[
						{field:'SORT',title:'序列',width:50,checkbox:true,align:'left'},
						{field:'CHECK_ID',title:'检核编号',width:50,align:'left',hidden:true},
						{field:'ID',title:'编号',width:50,align:'left'},
    		            {field:'LABEL',title:'标签',width:100,align:'left'},
    		            {field:'TYPE',title:'数据类型',width:150,align:'left',sortable:true},
    		            {field:'DESCRIPTION',title:'描述',width:100,align:'left'},
    		            {field:'UPDATE_DATE',title:'修改日期',width:100,align:'left'}
    		           ]],
    	  	  loadMsg : '数据加载中,请稍候......',
    	  		rowStyler: function(index,row){
    			if (row.TYPE=='sys_data_scope'){
    				return 'background-color:#eee;color:black;';
    			}
    		  },
    		  onDblClickRow:function(index,row){
    			  $('#doubleClick').window({title:'查看字典信息'});
    			  $('#doubleClick').window('open').window('refresh');
    			  $('#bianhao').textbox('setValue',row.ID);
    			  $('#biaoqian').textbox('setValue',row.LABEL);
    			  $('#leixing').textbox('setValue',row.TYPE);
    			  $('#miaoshu').textbox('setValue',row.DESCRIPTION);
    			  $('#time').datebox('setValue',row.UPDATE_DATE);
    		  }

    	  });
    	  function Open(text, url) {
      	        var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';

      	        if ($("#tabs").tabs('exists', text)) {
      	            $('#tabs').tabs('select', text);
      	        } else {
      	            $('#tabs').tabs('add', {
      	                title : text,
      	                closable : true,
      	                content : content
      	            });
      	        }
      	    }
    	  $('#cc').tree({
    		multiple:true,
    		checkbox:false,
    		url:'getTrees',
    		onClick:function(node, data){
    			console.log(node.url);
    			if (node.attributes) {
                    Open(node.text, node.url);
                }
    		}
      	});
    	//在右侧center区域打开菜单，新增tab
    	  
    	//绑定tabs的右键菜单
    	    $("#tabs").tabs({
    	        onContextMenu : function (e, title) {
    	            e.preventDefault();
    	            $('#tabsMenu').menu('show', {
    	                left : e.pageX,
    	                top : e.pageY
    	            }).data("tabTitle", title);
    	        }
    	    });
   	    //实例化menu的onClick事件
   	    $("#tabsMenu").menu({
   	        onClick : function (item) {
   	            CloseTab(this, item.name);
   	        }
   	    });
   	//几个关闭事件的实现
   	    function CloseTab(menu, type) {
   	        var curTabTitle = $(menu).data("tabTitle");
   	        var tabs = $("#tabs");

   	        if (type === "close") {
   	            tabs.tabs("close", curTabTitle);
   	            return;
   	        }

   	        var allTabs = tabs.tabs("tabs");
   	        var closeTabsTitle = [];

   	        $.each(allTabs, function () {
   	            var opt = $(this).panel("options");
   	            if (opt.closable && opt.title != curTabTitle && type === "Other") {
   	                closeTabsTitle.push(opt.title);
   	            } else if (opt.closable && type === "All") {
   	                closeTabsTitle.push(opt.title);
   	            }
   	        });

   	        for (var i = 0; i < closeTabsTitle.length; i++) {
   	            tabs.tabs("close", closeTabsTitle[i]);
   	        }
   	    }
      });
      
      
      
      
      
      
      
      function addUser(){
    	  
    	   $("#dlg").dialog('open').dialog("setTitle","新增字典信息");
    	   $("#fm").form('clear');
      }
      function editUser(){
    	   var row = $("#tb").datagrid("getSelected");
    	   console.log(row);
    	   if(row){
    		   $("#dlg").dialog("open").dialog('setTitle', '修改字典信息');
    		   $("#fm").form("load", row);
    	   }else{
    		   $.messager.alert("提示","请选择一条记录");
    		   return;
    	   }
      }
      
      function deleteUser(){
    	  var row = $("#tb").datagrid("getSelected");
    	  console.log(row);
    	  if(row){
    		   $.messager.confirm('警告','您确认删除这条记录吗？',function(r){
    			    if(r){
    			    	$.ajax({
    			    		url:'delete?id='+row.ID,
    			    		success:function(data){
    			    			if(data=='ok'){
    			    			   $.messager.alert('提示','操作成功');
    			    			   searchDict();
    			    			}else{
    			    			   $.messager.alert('提示','操作失败');
    			    			   searchDict();
    			    			}
    			    		}
    			    	})
    			    }
    		   })
    	  }else{
    		  $.messager.alert("提示","请选择一条记录");
    		  return;
    	  }
    	  
      }
      
      function searchDict(){
    	   $('#tb').datagrid('reload',{
    		   id : $("#id").textbox('getValue'),
    		   update_date : $("#update_date").datebox('getValue'),
    		   type : $("#type").textbox('getValue')
    	   });
      }
      function reset(){
    	  $('#id').textbox('clear');
    	  $('#update_date').textbox('clear');
    	  $('#type').textbox('clear');
    	  searchDict(); 
      }
      
      function submit(){
    	  $('#fm').form('submit',{
    		  url:'submit',
    		  onSubmit:function(){
    		  },
    		  success:function(data){
   		       if(data=='ok'){
   		    	   $.messager.alert('提示','操作成功');
   		    	$("#dlg").window('close');
   	    	 	searchDict();
   		       }else if(data=='fail'){
   		    	   $.messager.alert('提示','操作失败');
   		       }
   		  }
    	 })
    	 
    	 /*  $.ajax({
    		  url:'submit',
    		  data:$('#fm').serialize(),
    		  success:function(data){
   		       if(data=='ok'){
   		    	   $.messager.alert('提示','操作成功');
   		       }else{
   		    	   $.messager.alert('提示','操作失败');
   		       }
   		  }
    	 })
    	 $("#dlg").window('close');
    	 searchDict(); */
      }
      function uploadExcel(){
		  $('#upload').dialog('open').dialog("setTitle","excel上传");
		  $('#batchUpload').form('clear');
	  }
      
      function excelUpload_(){
    	  $('#batchUpload').form('submit', {
    		    url:'upload',
    		    onSubmit: function(param){    
    		          
    		    },  
    		    success: function(data){    
    		        if (data=='ok'){    
    		        	$.messager.alert('提示','操作成功'); 
    		        }    
    		    }    
    		});  

      }
     
       
</script>
</head>
<body style="background:#eee;" class="easyui-layout"> 
       	<div region="north" split="true" border="false" style="overflow: hidden; height: 45px;
          background: url(images/layout-browser-hd-bg.gif) #7f99be repeat-x center 50%;
          line-height: 40px;color: #fff; font-family: Verdana, 微软雅黑,黑体">
    <span style="float:right; padding-right:20px;" class="head">
     	 欢迎 管理员
      <a href="#" id="loginOut">安全退出</a>
    </span>
    <span style="padding-left:10px; font-size: 16px; ">
      <img src="images/blocks.gif" width="20" height="20" align="absmiddle" /> 娱乐娱乐
    </span>
  </div>
	    <!-- <div data-options="region:'east',iconCls:'icon-reload',title:'East',split:true" style="width:100px;"></div> -->   
	    <div data-options="region:'west',title:'West',split:true" style="width:200px;">
	    		<ul id="cc"></ul>
	    </div>   
	    <div region="center" title="">
	      <div class="easyui-tabs" fit="true" border="false" id="tabs">
	        <div title="首页"></div>
	      </div>
    	</div>
    	<div id="tabsMenu" class="easyui-menu" style="width:120px;">  
	      <div name="close">关闭</div>  
	      <div name="Other">关闭其他</div>  
	      <div name="All">关闭所有</div>
    	</div> 
		
        <div id="toolbar">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-add" onclick="addUser()" plain="true">添加</a> 
            <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-edit" onclick="editUser()" plain="true">修改</a> 
            <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-remove" onclick="deleteUser()" plain="true">删除</a>
        	<label> 编号: </label><input id="id" type="text" name="ID" class="easyui-textbox" style="width:100px;"/>
        	<label> 修改日期: </label><input id="update_date" class="easyui-datebox" name="UPDATE_DATE"/>
        	<label> 数据类型: </label><input id="type" class="easyui-textbox" name="TYPE" style="width:150px;"/>
        	<a class="easyui-linkbutton" iconcls="icon-search" onclick="searchDict()">查询</a>
        	<a class="easyui-linkbutton" iconcls="icon-reload" onclick="reset()">重置</a>
        	<a class="easyui-linkbutton" onclick="uploadExcel()">上传</a>
        </div>
        <div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px;" buttons="#dlg-buttons" closed="true" modal="true">
      		<div class="ftitle"> 
         			信息编辑 
     		</div>
       		<form id="fm" method="post"> 
       			   <div class="fitem"> 
			           <label>检核编号</label> 
			           <input id="check_id" name="CHECK_ID" readonly="readonly" placeholder="系统自动生成"/> 
			       </div> 
			       <div class="fitem"> 
			          <!--  <label>编号</label>  -->
			           <input id="id_" name="ID" class="easyui-validatebox" required="true" hidden="true" /> 
			       </div> 
			       <div class="fitem"> 
			           <label>标签</label> 
			           <input name="LABEL" type="text"  class="easyui-validatebox" required="true" /> 
			       </div> 
			       <div class="fitem"> 
			           <label>数据类型</label> 
			           <input name="TYPE" type="text" class="easyui-validatebox" required="true" /> 
			       </div> 
			       <div class="fitem"> 
			           <label>修改日期</label> 
			           <input name="UPDATE_DATE" type="text" class="easyui-datebox" required="true" /> 
			       </div> 
			       <!-- <input type="hidden" name="action" id="hidtype" /> 
			       <input type="hidden" name="ID" id="Nameid" />  -->
      		 </form> 
   		</div>
   		<div id="dlg-buttons"> 
		        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submit()" iconcls="icon-save">保存</a> 
		        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')" iconcls="icon-cancel">取消</a> 
   		</div> 
   		
   		<div id="doubleClick" class="easyui-window" data-options="modal:true,closed:true" style="width:390px;height:360px;padding:15px;">
   		     	   <div class="fitem"> 
			           <label>编号</label>
			           <input id="bianhao" name="ID" class="easyui-textbox" readonly="readonly"/> 
			       </div> 
			       <div class="fitem"> 
			           <label>标签</label> 
			           <input id="biaoqian" name="LABEL" class="easyui-textbox" readonly="readonly"/> 
			       </div> 
			       <div class="fitem"> 
			           <label>数据类型</label> 
			           <input id="leixing" name="TYPE" class="easyui-textbox" readonly="readonly"/> 
			       </div>
			       <div class="fitem"> 
			           <label>描述</label> 
			           <input id="miaoshu" name="desc" class="easyui-textbox" readonly="readonly"/> 
			       </div> 
			       <div class="fitem"> 
			           <label>修改日期</label> 
			           <input id="time" name="UPDATE_DATE" class="easyui-datebox" readonly="readonly" /> 
			       </div> 
   		 </div>
   		 <div id="upload" class="easyui-dialog" style="width:400px;height:100px;padding:10px 20px;" closed="true" modal="true">
   		 			<form id="batchUpload" >  
					    <input type="file"/>                
					    <button id="excelUpload" onclick="excelUpload_()">上传</button>
					</form>
   		 </div>
      	
        
</body>
</html>
