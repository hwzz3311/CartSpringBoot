<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'details.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="resources/css/main.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="resources/js/lhgcore.js"></script>
    <script type="text/javascript" src="resources/js/lhgdialog.js"></script>
      <script type="text/javascript" src="resources/js/getParam.js"></script>
      <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    <script type="text/javascript">
        var id = getUrlParam('id');
        $(document).ready(function(){
            $.ajax({
               type : "GET",
               url : "http://127.0.0.1:8081/"+id,
                dataType : "json",
                success : function (data) {
                   if (data["code"]==0){
                       $("#picture").prop("src","resources/images/"+data["data"].picture);
                       $("#buy_now").prop("href","javascript:selflog_show("+id+")");
                       document.getElementById("name").innerHTML = data["data"].name;
                       document.getElementById("city").innerHTML = "产地："+data["data"].city;
                       document.getElementById("price").innerHTML = "价格："+data["data"].price+"￥";
                   }
                }
            });
        });
      function selflog_show(id)
      { 
         var num =  document.getElementById("number").value; 
         J.dialog.get({
             id: 'haoyue_creat',
             title: '购物成功',
             width: 600,
             height:400,
             link: "/success.jsp?id="+id+"&num="+num,
             cover:true
         });
      }
      function add()
      {
         var num = parseInt(document.getElementById("number").value);
         if(num<100)
         {
            document.getElementById("number").value = ++num;
         }
      }
      function sub()
      {
         var num = parseInt(document.getElementById("number").value);
         if(num>1)
         {
            document.getElementById("number").value = --num;
         }
      }
     
    </script>
	
    <style type="text/css">
	   hr{
	     
	     border-color:#FF7F00;
	   }
	   
	   div{
	      float:left;
	      margin-left: 30px;
	      margin-right:30px;
	      margin-top: 5px;
	      margin-bottom: 5px;
	     
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
	   div #cart
	   {
	     margin:0px auto;
	     text-align:right; 
	   }
	   span{
	     padding:0 2px;border:1px #c0c0c0 solid;cursor:pointer;
	   }
	   a{
	      text-decoration: none; 
	   }
	</style>
  </head>
  
  <body>
    <h1>商品详情</h1>
    <a href="/">首页</a> >> <a href="/">商品列表</a>
    <hr>
    <center>
      <table width="750" height="60" cellpadding="0" cellspacing="0" border="0">
        <tr>
          <!-- 商品详情 -->

          <td width="70%" valign="top">
             <table>
               <tr>
                 <td rowspan="5"><img id="picture" width="200" height="160"/></td>
               </tr>
               <tr>
                 <td><B id="name"></B></td>
               </tr>
               <tr>
                 <td id="city"></td>
               </tr>
               <tr>
                 <td id="price"></td>
               </tr>
               <tr>
                 <td>购买数量：<span id="sub" onclick="sub();">-</span><input type="text" id="number" name="number" value="1" size="2"/><span id="add" onclick="add();">+</span></td>
               </tr> 
             </table>
             <div id="cart">
               <img src="resources/images/buy_now.png">
                 <a id="buy_now">
                 <img src="resources/images/in_cart.png"></a>
                 <a href="cart.jsp">
                 <img src="resources/images/view_cart.jpg"/></a>
             </div>
          </td>

          <!-- 浏览过的商品 -->
          <td width="30%" bgcolor="#EEE" align="center">
             <br>
             <b><font color="#FF7F00">您浏览过的商品</font></b><br>
             <!-- 循环开始 -->

             <%--<!-- 循环结束 -->--%>
          </td>
        </tr>
      </table>
    </center>
  </body>
</html>
