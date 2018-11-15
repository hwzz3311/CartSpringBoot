<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <title>My JSP 'success.jsp' starting page</title>
  	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
            <script type="text/javascript" src="resources/js/getParam.js"></script>
      <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    <script type="text/javascript">
        var id = getUrlParam("id");
        var num = getUrlParam("num");
        $(document).ready(function () {
            $.ajax({
               type : "POST",
               dataType : "json",
               url : "http://127.0.0.1:8081/"+id,
                xhrFields:{withCredentials: true},
				crossDomain: true,
                data : {
                    num:num
                },
                success: function (data) {
                   if (data["code"]==0){
                       document.getElementById("content").innerHTML = "您成功购买了" +num+
                        "件商品编号为" +id+
                        "的商品&nbsp;&nbsp;&nbsp;&nbsp;";
                   }else {
                       document.getElementById("content").innerHTML = data["data"]["msg"]
                   }
                }
            });
        });

    </script>

  </head>
  
  <hr>
    <hr>
      <img src="resources/images/add_cart_success.jpg"/>
      <hr id="content">
        <br>
      <br>
      <br>
    </center>
  </body>
</html>
