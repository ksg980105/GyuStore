<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 선택</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        background-color: #f5f5f5;
    }

    select {
        width: 200px;
        padding: 10px;
        border: 2px solid #007BFF;
        border-radius: 5px;
        font-size: 16px;
        color: #007BFF;
        background-color: #ffffff;
        cursor: pointer;
    }

    select:focus {
        outline: none;
        border-color: #0056b3;
    }

    option {
        padding: 10px;
    }
</style>
<script>
    function goToReviewPage() {
        var productSelect = document.getElementById('productSelect');
        var pname = productSelect.options[productSelect.selectedIndex].value;
        var memberId = document.getElementById('memberId').value;
        var orderId = document.getElementById('orderId').value;
        
        if (pname) { // pname이 있는 경우에만 페이지 이동
            location.href = 'insert.review?pname=' + encodeURIComponent(pname) + '&member_id=' + encodeURIComponent(memberId) + '&order_id=' + encodeURIComponent(orderId);
        }
    }
</script>
</head>
<body>

<!-- member_id와 order_id를 위한 숨겨진 입력 필드 -->
<input type="hidden" id="memberId" value="여기에 회원 ID">
<input type="hidden" id="orderId" value="여기에 주문 ID">

<select id="productSelect" onchange="goToReviewPage()">
    <option value="">상품 선택</option>
    <c:forEach items="${pnumToPnameMap}" var="entry">
        <option value="${entry.value}">${entry.value}</option>
    </c:forEach>
</select>


</body>
</html>
