<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환불처리</title>
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
<body>
<div class="center">
    <h2>환불 처리</h2>
    <table class="table">
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
              <td colspan="6">환불 신청 상품이 없습니다.</td>
          </tr>
      </c:if>
      <c:if test="${not empty refundList}">
          <c:forEach var="refund" items="${refundList}">
              <tr>
                  <td>${refund.order_id}</td>
                  <td>${refund.member_id}</td>
                  <td>${refund.pname}</td>
                  <td>${refund.pop_out}</td>
                  <td>${refund.reason}</td>
                  <td>
                      <button class="mybutton" onclick="approveRefund('${refund.order_id}')">환불승인</button>
                  </td>
              </tr>
          </c:forEach>
      </c:if>
    </table>
</div>
</body>
</html>
