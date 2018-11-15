<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <title>商品展示</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
	<style type="text/css">
	   hr{
	    border-color:#FF7F00;
	   }
	   div{
	      float:left;
	      margin: 10px;
	   }
	   div dd{
	      margin:0px;
	      font-size:10pt;
	   }
	   div dd.dd_name
	   {
	      color:blue;
	   }
	   div dd.dd_city
	   {
	      color:#000;
	   }
	</style>
    <script type="text/javascript">
          $(document).ready(function(){
                $.ajax({
                type : "GET",
                url :"http://127.0.0.1:8081",
                dataType:'json',
                success :function(data){
                    if (data["code"]=="0"){
                        var content = document.getElementById("goodContent");
                        var contentStr = "";
                        for (var i =0 ;i<data["data"].length;i++){
                            contentStr+='<div>' +
                                '<dl>' +
                                    '<dt>' +
                                        '<a href="/details.jsp?id=' +data["data"][i].id+'">' +
                                        '<img src="resources/images/' +data["data"][i].picture+'" width="120" height="90" border="1"/>' +
                                        '</a>' +
                                    '</dt>' +
                                    '<dd class="dd_name">' +data["data"][i].name+'</dd>' +
                                    '<dd class="dd_city">产地:' +data["data"][i].city+'&nbsp;&nbsp;价格:￥ ' +data["data"][i].price+'</dd>' +
                                '</dl>' +
                            '</div>'
                        }
                        content.innerHTML = contentStr;
                    }
                },
                });
            })
      </script>
  </head>
  
  <body>
    <h1>商品展示</h1>
    <hr>
  
    <center>
    <table width="750" height="60" cellpadding="0" cellspacing="0" border="0">
      <tr>
        <td id="goodContent">
            <!-- 商品循环开始 -->


          <!-- 商品循环结束 -->
        </td>
      </tr>
    </table>
    </center>
  </body>
</html>
