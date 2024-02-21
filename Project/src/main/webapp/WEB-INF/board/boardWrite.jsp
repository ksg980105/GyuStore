<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

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

<script type="text/javascript">
	function insertCheck(){
		if(f.title.value == ""){
			alert('제목을 입력하세요.');
			return false;
		}
		if(f.content.value == ""){
			alert('내용을 입력하세요.');
			return false;
		}
	}
</script>

<br>

<form name="f" action="write.board" method="post" onsubmit="return insertCheck()">
	<input type="hidden" name="member_id" value="${loginInfo.member_id}">
	<table class="table table-bordered border-success" style="width: 600px; margin: auto;">
	  <tr>
	  	<th>카테고리</th>
	  	<td>
	  		<select name="board_category">
	  		 	<option value="사이즈문의">사이즈문의</option>
	  		 	<option value="배송문의">배송문의</option>
	  		 	<option value="제품문의">제품문의</option>
	  		 	<option value="기타">기타</option>
	  		</select>
		</td>
	  </tr>
	  <tr>
	  	<th>제목</th>
	  	<td>
	  		<input type="text" name="title" placeholder="제목을 입력하세요.">
	  	</td>
	  </tr>
	  <tr>
	  	<th>내용</th>
	  	<td>
			<textarea rows="8" cols="35" name="content" placeholder="내용을 입력하세요."></textarea>
		</td>
	  </tr>
	  <tr>
	  	<th>작성일</th>
	  	<td>
	  		<c:set var="date" value="<%=new java.util.Date()%>" />
			<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" />
	  	</td>
	  </tr>
	  <tr>
	  	<th>작성자</th>
	  	<td>${loginInfo.member_id}</td>
	  </tr>
	  <tr>
	  	<td colspan="2" align="center">
	  		<input type="submit" class="mybutton" value="등록">
	  		<a href="product.board">
	  			<input type="button" class="mybutton" value="취소">
	  		</a>
	  	</td>
	  </tr>
	</table>
</form>