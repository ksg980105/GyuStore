<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>
<style>
	textarea{
		resize: none;
	}
	th {
        width: 50%;
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
	
	function insertCheck(){
		if(f.pname.value == ""){
			alert('제목을 입력하세요.');
			return false;
		}
		if(f.upload.value == ""){
			alert('상품사진을 등록하세요.');
			return false;
		}
		if(f.publisher.value == ""){
			alert('출판사를 입력하세요.');
			return false;
		}
		if(f.pqty.value == ""){
			alert('수량을 입력하세요.');
			return false;
		}
		if(isNaN(f.pqty.value)){
			alert('수량을 숫자로 입력해주세요.');
			return false;
		}
		if(f.price.value == ""){
			alert('가격을 입력하세요.');
			return false;
		}
		if(isNaN(f.price.value)){
			alert('가격을 숫자로 입력해주세요.');
			return false;
		}
		if(f.summary.value == ""){
			alert('줄거리를 입력하세요.');
			return false;
		}
		if(f.point.value == ""){
			alert('지급포인트를 입력하세요.');
			return false;
		}
		if(isNaN(f.point.value)){
			alert('포인트를 숫자로 입력해주세요.');
			return false;
		}
	}
</script>

</head>
<br>
<form name="f" action="insert.product" method="post" onsubmit="return insertCheck()" enctype="multipart/form-data">
	<table class="table table-bordered border-success" style="width: 600px; margin: auto;">
	  <tr>
	  	<th>카테고리</th>
	  	<td>
		  	<select name="pcategory">
		  		<c:forEach var="category" items="${categoryList}">
			  		<c:if test="${empty categoryList}">
			  			<option value="기타">기타</option>
			  		</c:if>
			  		<c:if test="${not empty category}">
			  			<option value="${category.category_name}">${category.category_name}</option>
			  		</c:if>
		  		</c:forEach>
		  	</select>		
	  	</td>
	  </tr>
	  <tr>
	  	<th>제목</th>
	  	<td>
	  		<input type="text" size="10" name="pname">
	  	</td>
	  </tr>
	  <tr>
	  	<th>상품이미지</th>
	  	<td>
	  		<img id="imgThumb" src="https://static.nid.naver.com/images/web/user/default.png" width="150"><hr>
	  		<input type="file" class="form-control mb-3" id="upload" name="upload" style="border-color: black;" onchange="previewImage()">
	  	</td>
	  </tr>
	  <tr>
	  	<th>출판사</th>
	  	<td>
	  		<input type="text" size="10" name="publisher">
	  	</td>
	  </tr>
	  <tr>
	  	<th>수량</th>
	  	<td>
	  		<input type="text" size="5" name="pqty"> 권
	  	</td>
	  </tr>
	  <tr>
	  	<th>가격</th>
	  	<td>
	  		<input type="text" size="5" name="price"> 원
	  	</td>
	  </tr>
	  <tr>
	  	<th>줄거리</th>
	  	<td>
	  		<textarea rows="5" cols="30" name="summary"></textarea>
	  	</td>
	  </tr>
	  <tr>
	  	<th>포인트</th>
	  	<td>
	  		<input type="text" size="5" name="point"> p
	  	</td>
	  </tr>
	  <tr>
	  	<td colspan="2" align="center">
	  		<input type="submit" class="mybutton" value="등록">
	  		<a href="list.product">
	  			<input type="button" class="mybutton" value="취소">
	  		</a>
	  	</td>
	  </tr>
	</table>
</form>
</html>