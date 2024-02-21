<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<style>
	textarea{
		resize: none;
	}
	th {
        width: 40%;
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
		if(f.category_name.value == ""){
			alert('카테고리명을 입력하세요.');
			return false;
		}
	}
</script>

<br>
<form name="f" action="insert.category" method="post" onsubmit="return insertCheck()">
	<table class="table table-bordered border-success" style="width: 400px; margin: auto;">
	  <tr>
	  	<th>카테고리명</th>
	  	<td>
	  		<input type="text" name="category_name">
	  	</td>
	  </tr>
	  <tr>
	  	<td colspan="2" align="center">
	  		<a href="insert.category">
	  			<input type="submit" class="mybutton" value="등록">
	  		</a>
	  		<a href="list.category">
	  			<input type="button" class="mybutton" value="취소">
	  		</a>
	  	</td>
	  </tr>
	</table>
</form>
