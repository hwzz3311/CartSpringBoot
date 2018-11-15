<%--
  Created by IntelliJ IDEA.
  User: zhengzhao
  Date: 2018/8/24
  Time: 9:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加商品</title>
</head>
<body>
<h3>这是一个添加商品的测试页面</h3>
<form method="post" action="/cart/add" enctype="multipart/form-data">
    商品名字：<input type="text" name="name" id="name"></br>
    商品产地：<input type="text" name="city" id="city"></br>
    商品单价：<input type="text" name="price" id="price"></br>
    商品库存：<input type="text" name="number" id="number"></br>
    商品图片：<input type="file" name="picture" id="picture"></br>
    <input type="submit" value="提交">
</form>

</body>
</html>
