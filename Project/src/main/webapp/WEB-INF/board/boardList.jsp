<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<style>
	  .table {
	    border-collapse: collapse;
	    width: 800px;
	    margin: auto;
	    box-shadow: 0 2px 3px #ccc;
	    background-color: #f8f9fa;
	  }
	  
	  .table th, .table td {
	    text-align: center;
	    padding: 8px;
	    border-bottom: 1px solid #ddd;
	  }
	  
	  .mybutton {
	    background-color: #007bff;
	    color: white;
	    border: none;
	    cursor: pointer;
	    padding: 5px 10px;
	    border-radius: 5px;
	  }
	  
	  .mybutton:hover {
	    background-color: #0056b3;
	  }
	  
	  select, input[type="text"], input[type="submit"] {
	    padding: 5px;
	    margin: 5px;
	    border-radius: 5px;
	    border: 1px solid #ccc;
	  }
	  
	  input[type="submit"] {
	    background-color: #007bff;
	    color: white;
	    cursor: pointer;
	  }
	  
	  input[type="submit"]:hover {
	    background-color: #0056b3;
	  }
	.center {
	  text-align: center;
	}
</style>

<script type="text/javascript">
	function writeBoard(){
		if(${loginInfo == null}){
			alert('로그인 후 이용하세요.');
			location.href="login.member";
		}else{
			location.href="write.board";
		}
	}
</script>

<br>
<table class="table" style="width: 800px; margin: auto;">
  <thead>
    <tr>
      <th scope="col">번호</th>
      <th scope="col" width="30%">
	     제목
      </th>
      <th scope="col">작성자</th>
      <th scope="col">작성일</th>
      <th width="5%">
      	<input type="button" class="mybutton" value="글쓰기" onclick="writeBoard()">
      </th>
    </tr>
  </thead>
  <c:if test = "${empty lists}">
   	  <tr>
   	  	<td colspan="5" align="center">
   	  		검색된 항목이 없습니다.
   	  	</td>
   	  </tr>
  </c:if>
  <c:if test="${!empty lists}">
  	<c:forEach var="list" items="${lists}">
	  <tbody>
	    <tr>
	      <th>${list.board_number}</th>
	      <td>
	      	<c:choose>
			    <c:when test="${loginInfo.member_id == 'admin'}">
			        <a href="detail.board?board_number=${list.board_number}">${list.title}</a>
			    </c:when>
			    <c:when test="${list.member_id eq loginInfo.member_id}">
			        <a href="detail.board?board_number=${list.board_number}">${list.title}</a>
			    </c:when>
			    <c:otherwise>
			        ${list.title}
			    </c:otherwise>
			</c:choose>
	      </td>
	      <td>${list.member_id}</td>
	      <td><fmt:formatDate value="${list.write_date}" pattern="yyyy-MM-dd"/></td>
	    </tr>
	  </tbody>
	</c:forEach>
  </c:if>
</table>
<br>

<div class="center">
  ${pageInfo.pagingHtml}
</div>

<div class="center">
  <form action="product.board" method="get">
    <select name="whatColumn">
      <option value="all">전체검색
      <option value="title">제목
      <option value="member_id">작성자
    </select>
    <input type="text" name="keyword">
    <input type="submit" value="검색">
  </form>
</div>
