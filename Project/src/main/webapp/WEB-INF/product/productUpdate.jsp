<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품수정</title>
<style>
	textarea{
		resize: none;
	}
	th {
        width: 10%;
        text-align: center;
        background-color: gray; /* 헤더 배경색 */
        color: white;
        padding: 10px;
    }

    td {
        padding: 10px;
    }
	body, html {
	  margin: 0;
	  font-family: Arial;
	}
	
	.tablink {
	  background-color: #555;
	  color: white;
	  float: left;
	  border: none;
	  outline: none;
	  cursor: pointer;
	  padding: 14px 16px;
	  font-size: 17px;
	  width: 25%;
	}
	
	.tablink:hover {
	  background-color: #777;
	}
	
	.tabcontent {
	  color: white;
	  display: none;
	  padding: 100px 20px;
	}
	.mybutton {
        background-color: gray; /* 버튼 배경색 */
        color: white;
        border: none;
        padding: 7px 12px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin-top: 10px;
        cursor: pointer;
        border-radius: 5px; /* 버튼 모서리 둥글게 */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    }
    textarea{
    	resize: none;
    }
</style>

<script type="text/javascript">
	function previewImage() {
	    var input = document.getElementById('upload');
	    var imgThumb = document.getElementById('imgThumb');
	
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	
	        reader.onload = function (e) {
	            imgThumb.src = e.target.result;
	        };
	
	        reader.readAsDataURL(input.files[0]);
	    }
	}
</script>

</head>
<br>
<form name="f" action="update.product" method="post" onsubmit="return updateCheck()" enctype="multipart/form-data">
	<table class="table table-bordered border-success" style="width: 1000px; margin: auto;">
  <tr>
  	<th>번호</th>
  	<th>이미지</th>
  	<th>카테고리</th>
  	<th>제목</th>
  	<th>출판사</th>
  	<th>수량</th>
  	<th>가격</th>
  	<th>줄거리</th>
  	<th>포인트</th>
  </tr>
  <c:forEach var="product" items="${productList}">
	  <tr align="center" style="font: bold;">
	  	<td>${product.pnum}</td>
	  	<td>
	  		<img src="<%=request.getContextPath()%>/resources/productImage/${product.pimage}" width="200"><hr>
	  		<input type="file" class="form-control mb-3" id="upload" name="upload" style="border-color: black;" onchange="previewImage()">
	  	</td>
	  	<td>
			<select name="pcategory">
		  		<c:forEach var="category" items="${categoryList}">
			  		<option value="${category.category_name}" ${product.pcategory == category.category_name ? 'selected' : ''}>${category.category_name}</option>
		  		</c:forEach>
		  	</select>
		</td>
	  	<td>
	  		<input type="text" name="pname" size="5" value="${product.pname}">
	  	</td>
	  	<td>
	  		<input type="text" name="publisher" size="5" value="${product.publisher}">
	  	</td>
	  	<td>
	  		<input type="text" name="pqty" size="5" value="${product.pqty}">
	  	</td>
	  	<td>
	  		<input type="text" name="price" size="5" value="${product.price}">
	  	</td>
	  	<td>
	  		<textarea rows="10" cols="10">${product.summary}</textarea>
	  	</td>
	  	<td>
	  		<input type="text" name="point" size="5" value="${product.point}">
	  	</td>
	  </tr>
  </c:forEach>
  <tr>
  	<td colspan="9" align="center">
  		<input type="submit" class="mybutton" value="수정">
  		<a href="list.product">
  			<input type="button" class="mybutton" value="취소">
  		</a>
  	</td>
  </tr>
</table>
</form>
</html>