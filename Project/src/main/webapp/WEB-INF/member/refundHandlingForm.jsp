<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환불처리</title>
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

	body, html {
	  margin: 0;
	  font-family: Arial;
	}

</style>

<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">
	function approveRefund(order_id){
		$.ajax({
            type: "POST",
            url: "refundHandle.member", // 서버의 환불 처리 컨트롤러 경로
            data: {
            	order_id: order_id
            },
            success: function(response) {
                alert("환불처리가 완료되었습니다.");
                location.reload();
            },
            error: function() {
                alert("환불승인 처리중 문제가 발생했습니다.");
            }
        });
	}
</script>

</head>
<br>
<table class="table table-bordered border-success" style="width: 1000px; margin: auto;">
  <tr>
  	<th>주문아이디</th>
  	<th>주문자</th>
  	<th>상품명</th>
  	<th>수량</th>
	<th>환불신청 사유</th>
	<th>환불처리</th>
  </tr>
  <c:if test="${empty refundList}">
  	<tr>
  		<td colspan="9" align="center">
  			환불 신청 상품이 없습니다.
  		</td>
  	</tr>
  </c:if>
  <c:if test="${not empty refundList}">
	  <c:forEach var="refund" items="${refundList}">
		  <tr align="center" style="font: bold;">
		  	<td>${refund.order_id}</td>
		  	<td>${refund.member_id}</td>
		  	<td>${refund.pname}</td>
		  	<td>${refund.pop_out}</td>
		  	<td>${refund.reason}</td>
		  	<td>
		  		<input type="button" value="환불승인" onClick="approveRefund('${refund.order_id}')">
		  	</td>
		  </tr>
	  </c:forEach>
  </c:if>
</table>
</html>