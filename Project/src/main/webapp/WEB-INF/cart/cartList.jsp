<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css">
    <style>
        .cart-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
        }
        .cart-body {
            padding-top: 20px;
        }
        .cart-footer {
            padding-top: 20px;
            padding-bottom: 20px;
        }
        .total-price {
            font-weight: bold;
        }
        /* 결제하기 버튼 스타일 추가 */
        .checkout-btn {
            float: right; /* 오른쪽으로 정렬 */
            background-color: green; /* 배경색 */
            color: white; /* 글자색 */
            border-radius: 5px;
            padding: 10px 20px; /* 내부 여백 */
            text-decoration: none; /* 밑줄 제거 */
            font-size: 16px; /* 글자 크기 */
        }
        .clearfix::after {
            content: "";
            clear: both;
            display: table;
        }
    </style>
</head>
<body>

    <div class="jumbotron jumbotron-fluid">
        <div class="container">
            <h3 class="display-4" align="center">장바구니</h3>
        </div>
    </div>
    <br><br>
    <div class="container" style="width: 1000px;">
        <div class="row clearfix">
            <table class="table">
                <thead class="cart-header">
                    <tr>
                        <th scope="col">상품명</th>
                        <th scope="col">수량</th>
                        <th scope="col">가격</th>
                        <th scope="col">작업</th>
                    </tr>
                </thead>
                <tbody>
                	<c:if test="${empty cartList}">
                		<tr>
                			<td colspan="4" align="center">장바구니가 비어있습니다.</td>
                		</tr>
                	</c:if>
                	<c:if test="${not empty cartList}">
                		<c:set var="totalPrice" value="0"/>
						<c:forEach var="cart" items="${cartList}">
		                    <tr>
		                        <td>${cart.product_name}</td>
		                        <td>${cart.pqty}</td>
		                        <td><b>${cart.price * cart.pqty} ₩</b></td>
		                        <td><a href="delete.cart?product_name=${cart.product_name}" class="btn btn-danger btn-sm">삭제</a></td>
		                    </tr>
	                    <c:set var="totalPrice" value="${totalPrice + (cart.price * cart.pqty)}" />
	                    </c:forEach>
                    </c:if>
                    <!-- 상품 행 끝 -->
                    <tr class="cart-footer">
                        <td colspan="2"></td>
                        <td class="total-price">총액</td>
                        <td><b>${totalPrice} ₩</b></td>
                    </tr>
                </tbody>
            </table>
            <a href="#" class="btn btn-secondary">쇼핑 계속하기 &raquo;</a>
            <!-- 결제하기 버튼 위치 및 스타일 수정 -->
            <a href="#" class="checkout-btn">결제하기</a>
        </div>
        <hr/>
    </div>
    
</body>
</html>
