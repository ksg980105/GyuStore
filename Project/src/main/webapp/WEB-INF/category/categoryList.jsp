<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<style>
	textarea{
		resize: none;
	}
	th {
        width: 25%;
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
	function deleteNum(){
		var num = prompt("삭제할 번호를 입력하세요.", "");
		if(num == "" || isNaN(num)){
			alert('잘못 입력되었습니다.');
		}else{
			location.href="delete.category?category_number=" + num;
		}
	}
</script>

<br>
<table class="table table-bordered border-success" style="width: 400px; margin: auto;">
  <tr>
  	<th>번호</th>
  	<th>카테고리명</th>
  </tr>
  <c:if test="${empty categoryList}">
  	<tr>
  		<td colspan="2" align="center">
  			등록된 카테고리가 없습니다.
  		</td>
  	</tr>
  </c:if>
  <c:if test="${not empty categoryList}">
	  <c:forEach var="category" items="${categoryList}">
		  <tr align="center" style="font: bold;">
		  	<td>${category.category_number}</td>
		  	<td>${category.category_name}</td>
		  </tr>
	  </c:forEach>
  </c:if>
  <c:if test="${empty categoryList}">
  	<tr>
  		<td colspan="2" align="center">
	  		<a href="insert.category">
	  			<input type="button" class="mybutton" value="등록">
	  		</a>
  		</td>
    </tr>
  </c:if>
  <c:if test="${not empty categoryList}">
	  <tr>
	  	<td colspan="2" align="center">
	  		<a href="insert.category">
	  			<input type="button" class="mybutton" value="등록">
	  		</a>
	  		<a href="update.category">
	  			<input type="button" class="mybutton" value="수정">
	  		</a>
	  		<input type="button" class="mybutton" value="삭제" onClick="deleteNum()">
	  	</td>
	  </tr>
  </c:if>
</table>
