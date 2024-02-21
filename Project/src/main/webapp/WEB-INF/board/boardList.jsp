<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<style>
	.mybutton {
        background-color: gray; /* 버튼 배경색 */
        color: white;
        border: none;
        padding: 5px 10px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        cursor: pointer;
        border-radius: 5px; /* 버튼 모서리 둥글게 */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
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
   	  	<td colspan="4" align="center">
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
	      	<c:if test="${list.member_id eq loginInfo.member_id}">
	      		<a href="detail.board?board_number=${list.board_number}">${list.title}</a>
	      	</c:if>
	      	<c:if test="${list.member_id ne loginInfo.member_id}">
	      		${list.title}
	      	</c:if>
	      </td>
	      <td>${list.member_id}</td>
	      <td><fmt:formatDate value="${list.write_date}" pattern="yyyy-MM-dd"/></td>
	    </tr>
	  </tbody>
	</c:forEach>
  </c:if>
</table>
<br>

<center>
	${pageInfo.pagingHtml}
</center>

<center>
	<form action="product.board" method="get">
		<select name="whatColumn">
			<option value="all">전체검색
			<option value="title">제목
			<option value="member_id">작성자
		</select>
		<input type="text" name="keyword">
		<input type="submit" value="검색">
	</form>
</center>