<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'cart.jsp' starting page</title>
 	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <link type="text/css" rel="stylesheet" href="../resources/css/style1.css" />
	  <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    <script language="javascript">
        /**
        *在页面加载完成时执行从后端获取数据，对数据进行循环遍历，同时写入到前端
        */
		$(document).ready(function(){
		    var itemTable = $("#itemTable tr")
			$.ajax({
				type : "GET",
				dataType :"json",
				url : "http://127.0.0.1:8081/show",
				xhrFields:{withCredentials: true},
				crossDomain: true,
				success : function (data) {
					var itemList = data["data"]
                    for (var i = 1; i <itemList.length ; i++) {
                        itemTable.after("<tr name=\"products\" id=\"product_id_1\">" +
                            "<td class=\"thumb\"><img src=\"../resources/images/" +itemList[i]["picture"]+"\" /><a href=\"\">" +itemList[i]["name"]+
                            "</a></td>" +
                            "<td class=\"number\">" +itemList[i]["price"]+"</td>" +
                            "<td class=\"price\" id=\"price_id_1\">" +
                            "<span id = \"price" +itemList[i]["id"]+"\">"+itemList[i]["price"]*itemList[i]["BuyNumber"]+
                            "</span>" +
                            "<input type=\"hidden\" value=\"\" />" +
                            "</td>" +
                            " <td>购买数量：<span id=\"sub\" onclick=\"sub(" +itemList[i]["id"]+");\" style=\"padding:0 2px;border:1px #c0c0c0 solid;cursor:pointer;\" >-</span>" +
                            " <input type=\"text\" id=\"number" +itemList[i]["id"]+"\" name=\"number\"  onblur=\"judge(" +itemList[i]["BuyNumber"]+"," +itemList[i]["id"]+");\" value= " +itemList[i]["BuyNumber"]+">" +
                            "<span id=\"add\" onclick=\"add(" +itemList[i]["id"]+");\" style=\"padding:0 2px;border:1px #c0c0c0 solid;cursor:pointer;\">+</span>" +
                            "</td>" +
                            "                    <td class=\"delete\">" +
                            "<a href=\"javascript:void(0)\" onclick=\"delcfm(" +itemList[i]["id"]+");\" >删除</a>" +
                            "</td>" +
                            "</tr>")
                    }
                    document.getElementById("total").innerHTML = "总计：" +itemList[0]["allPrice"]+"￥";
                },
			});
        });

        /**
        *执行删除商品的操作
        * @param id "要删除的商品id"
        */
	    function delcfm(id) {
	        if (!confirm("确认要删除？")) {
	            window.event.returnValue = false;
	        }else {
                $.ajax({
                   url:"http://127.0.0.1:8081/"+id,
                   type:'DELETE',
                    dataType: "json",
                    xhrFields:{withCredentials: true},
				    crossDomain: true,
                   success:function (result) {
                           window.location.reload();
                   }
               });
            }
	    }

		/**
		*购买数量减一
		*/
	    function sub(id) {
	        var viewId = document.getElementById("number"+id);
	        var number = viewId.value;
	        if(number>=2)$.ajax({
                type: "PUT",
                url: "http://127.0.0.1:8081/"+id+"/0",
                dataType: "json",
                xhrFields:{withCredentials: true},
				crossDomain: true,
                success: function (data) {
                    window.location.reload()
                },
            });else {
	            alert("最小单位为1");
			}
        }

		/**
		*购买数量加一
		*/
        function add(id) {
            var viewId = document.getElementById("number"+id);
	        var number = viewId.value;
	        if(number<999)$.ajax({
				type: "PUT",
				url : "http://127.0.0.1:8081/"+id+"/1",
				dataType: "json",
                xhrFields:{withCredentials: true},
				crossDomain: true,
				success:function (data) {
					window.location.reload()
                }
	        });
	        else {
	            alert("最大单位为999");
			}
        }
		/**
		*用于判断用户输入的数字是否为正整数
		* @param 用户输入数字之前的值，用于数据回滚
		*/
        function judge(numValue,id) {
            var viewId = document.getElementById("number"+id);
			var number = viewId.value;
			if(number<1){
	            alert("最小单位为1");
	            viewId.value = 1;
			}
			if(number>999){
	            alert("最大单位为999");
	            viewId.value = 999;
			}
			if(!isDot(number)){
			    alert("请输入一个正整数");
			    viewId.value = numValue;
			}
        }

		/**
		*这是一个用原生JS现实的Ajax请求，实现对多种数据的接受略显复杂，建议采用jquery+json
		* @param id商品信息的id
		* @param action 对购物车的操作
		*/
        function postRequest(id ,action) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST","cart");
			var date ="id="+id+"&action="+action;
			xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			xhr.send(date);
			xhr.onreadystatechange = function () {
				// 这步为判断服务器是否正确响应
			  if (xhr.readyState == 4 && xhr.status == 200) {
			      var t = xhr.responseText;
				document.getElementById("number").value =t;
			  }
			  else {
			      return null;
			  }
			}
        }

		/**
		*
		* @param 处理判断是否为合法的正整数函数
		* @returns {boolean}
		*/
        function isDot(val) {
	        if(val === "" || val ==null){//是否为空
				return false;
			}
			//是否为数字
			if(!isNaN(val)){
			    var result = (val.toString()).indexOf(".");
			    //是否包含小数点，找不到result为-1
			    if(result == -1) {//没找到小数点，是想要的数字
			        return true;
				} else {
					return false;
				}
			}else{
				return false;
			}
		}
   </script>
  </head>
  
  <body>
   <h1>我的购物车</h1>
   <a href="/">首页</a> >> <a href="/">商品列表</a>
   <hr> 
   <div id="shopping">
   <form action="" method="">		
			<table id="itemTable">
				<tr>
					<th>商品名称</th>
					<th>商品单价</th>
					<th>商品价格</th>
					<th>购买数量</th>
					<th>操作</th>
				</tr>
				<!-- 循环的开始 -->

                <%--数据通过ajax加载完以后添加到此处--%>

				<!--循环的结束-->

			</table>
			 <div class="total"><span id="total"></span></div>

			<div class="button"><input type="submit" value="" /></div>
		</form>
	</div>
  </body>
</html>
