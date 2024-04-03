<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<style>
  /* 테이블 기본 설정 */
  .table {
    width: 600px;
    margin: auto;
  }

  /* 테이블 헤더 스타일 */
  th {
    background-color: gray; /* Bootstrap의 .border-success 색상 */
    color: white;
    text-align: center;
  }

  /* 테이블 데이터 셀 스타일 */
  td {
    padding: 10px;
    text-align: center;
    border-bottom: 1px solid #ddd;
  }

  /* 마지막 행의 하단 경계선 삭제 */
  tr:last-child td {
    border-bottom: none;
  }

  /* 버튼 스타일 */
  .mybutton {
    background-color: #007bff;
    color: white;
    padding: 5px 10px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    border: none;
    border-radius: 5px; /* 버튼 모서리 둥글게 */
  }

  /* 링크 스타일 제거 */
  a {
    text-decoration: none;
  }
</style>


<br>
<table class="table table-bordered border-success" style="width: 600px; margin: auto;">
	  <tr>
	  	<th>번호</th>
	  	<td>${boardBean.board_number}</td>
	  </tr>
	  <tr>
	  	<th>카테고리</th>
	  	<td>${boardBean.board_category}</td>
	  </tr>
	  <tr>
	  	<th>제목</th>
	  	<td>${boardBean.title}</td>
	  </tr>
	  <tr>
	  	<th>내용</th>
	  	<td>${boardBean.content}</td>
	  </tr>
	  <tr>
	  	<th>작성일</th>
	  	<td><fmt:formatDate value="${boardBean.write_date}" pattern="yyyy-MM-dd"/></td>
	  </tr>
	  <tr>
	  	<th>작성자</th>
	  	<td>${boardBean.member_id}</td>
	  </tr>
	  <tr>
	  	<td colspan="2" align="center">
	  		<a href="update.board?board_number=${boardBean.board_number}">
	  			<input type="button" id="sub" class="mybutton" value="수정">
	  		</a>
	  		<a href="delete.board?board_number=${boardBean.board_number}">
	  			<input type="button" class="mybutton" value="삭제">
	  		</a>
	  		<a href="product.board">
	  			<input type="button" class="mybutton" value="취소">
	  		</a>
	  	</td>
	  </tr>
</table>