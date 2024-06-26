<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품리스트</title>
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
</style>

<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	    $(".more-link").click(function(e) {
	      e.preventDefault();
	      var $summaryContainer = $(this).closest('.summary-container');
	      $summaryContainer.find('.summary-short').hide();
	      $summaryContainer.find('.summary-full').show();
	      $(this).hide();
	      $summaryContainer.find('.less-link').show();
	    });
	    
	    $(".less-link").click(function(e) {
	        e.preventDefault();
	        var $summaryContainer = $(this).closest('.summary-container');
	        $summaryContainer.find('.summary-full').hide();
	        $summaryContainer.find('.summary-short').show();
	        $(this).hide();
	        $summaryContainer.find('.more-link').show();
	    });
	    
	    $(".less-link").hide();
	});
  
	function deleteNum(){
		var deleteNum = prompt("삭제할 번호를 입력하세요.", "");
		if(deleteNum == "" || isNaN(deleteNum)){
			alert('잘못 입력되었습니다.');
		}else if(deleteNum == null){
			alert('취소했습니다.');
		}else{
			location.href="delete.product?pnum=" + deleteNum;
		}
	}
	
	function updateNum(){
		var updateNum = prompt("수정할 번호를 입력하세요.", "");
		if(updateNum == "" || isNaN(updateNum)){
			alert('잘못 입력되었습니다.');
		}else if(updateNum == null){
			alert('취소했습니다.');
		}else{
			location.href = "update.product?pnum=" + updateNum;
		}
	}
</script>

</head>
<br>
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
  <c:if test="${empty productList}">
  	<tr>
  		<td colspan="9" align="center">
  			등록된 상품이 없습니다.
  		</td>
  	</tr>
  </c:if>
  <c:if test="${not empty productList}">
	  <c:forEach var="product" items="${productList}">
		  <tr align="center" style="font: bold;">
		  	<td>${product.pnum}</td>
		  	<td>
		  		<a href="detail.product?pnum=${product.pnum}">
		  			<img src="<%=request.getContextPath()%>/resources/productImage/${product.pimage}" width="200">
		  		</a>
		  	</td>
		  	<td>${product.pcategory}</td>
		  	<td>${product.pname}</td>
		  	<td>${product.publisher}</td>
		  	<td>${product.pqty}</td>
		  	<td>${product.price}</td>
		  	<td>
				<div class="summary-container">
				<c:if test="${fn:length(product.summary) >= 10}">
			        <div class="summary-short">${product.summary.substring(0, 10)}...</div>
			        <div class="summary-full" style="display: none;">${product.summary}</div>
			        <a href="#" class="more-link">더보기</a>
			        <a href="#" class="less-link">닫기</a>
			    </c:if>
			    <c:if test="${fn:length(product.summary) < 10}">
			        <div class="summary-short">${product.summary}</div>
			    </c:if>
			        
			    </div>
			</td>
		  	<td>${product.point}</td>
		  </tr>
	  </c:forEach>
  </c:if>
  <c:if test="${empty productList}">
  	<tr>
  		<td colspan="9" align="center">
	  		<a href="insert.product">
	  			<input type="button" class="mybutton" value="등록">
	  		</a>
  		</td>
    </tr>
  </c:if>
  <c:if test="${not empty productList }">
	  <tr>
	  	<td colspan="9" align="center">
	  		<a href="insert.product">
	  			<input type="button" class="mybutton" value="등록">
	  		</a>
	  		<input type="button" class="mybutton" value="수정" onClick="updateNum()">
	  		<input type="button" class="mybutton" value="삭제" onClick="deleteNum()">
	  	</td>
	  </tr>
  </c:if>
</table>
</html>