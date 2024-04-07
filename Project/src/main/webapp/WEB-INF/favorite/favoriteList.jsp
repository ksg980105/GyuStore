<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품 카드 예시</title>
<style>
  .products-container {
  	margin-top: 20px;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
  }

  .product-card {
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
    transition: 0.3s;
    width: 35%;
    border-radius: 5px;
    display: flex;
    margin-bottom: 30px;
  }

  .product-card:hover {
    box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
  }

  .product-image-container {
    flex: 1;
  }

  .product-info {
    flex: 1;
    padding: 2px 16px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }

  .product-image {
    width: 80%;
    border-top-left-radius: 5px;
    border-top-right-radius: 5px;
    object-fit: cover;
  }

  .product-name {
    font-size: 16px;
    color: #333;
  }

  .product-price {
    color: grey;
    font-size: 14px;
  }
</style>
</head>
<body>
  <div class="products-container">
    <c:if test="${empty favoriteProducts}">
      <h2 align="center"><b>즐겨찾기 등록된 상품이 없습니다.</b></h2>
    </c:if>
    <c:if test="${not empty favoriteProducts}">
      <c:forEach var="favorite" items="${favoriteProducts}">
        <div class="product-card">
          <div class="product-image-container">
            <a href="detail.product?pnum=${favorite.pnum}">
              <img src="<%=request.getContextPath()%>/resources/productImage/${favorite.pimage}" class="product-image">
            </a>
          </div>
          <div class="product-info">
            <b class="product-name">${favorite.pname}</b>
            <p class="product-price">₩${favorite.price}</p> 
          </div>
        </div>
      </c:forEach>
    </c:if>
  </div>
</body>
</html>
