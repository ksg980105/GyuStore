<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<style>
.product-image {
    height: 150px;
    width: auto;
    border-radius: 10px;
    margin-bottom: 15px;
  }
  .product-container {
    margin-top: 20px;
  }
  .product-name {
    color: #333;
  }
  .product-price {
    color: #007bff;
  }
</style>

<div class="container-fluid bg-3 text-center" style="width: 90%;">
  <h2 align="left">인기상품</h2>
  <div class="row">
      <c:forEach var="product" items="${productList}" varStatus="loop">
	    <c:if test="${loop.index%4 == 0}">
	    	</div><div class="row"><hr>
	    </c:if>
	    <div class="col-sm-3" align="center">
	        <a href="detail.product?pnum=${product.pnum}">
	      	  <img src="<%=request.getContextPath()%>/resources/productImage/${product.pimage}" class="img-responsive product-image">
	        </a>
	      <font size="3"><b>${product.pname}</b></font><br>
	      <font size="2"><b><fmt:formatNumber pattern="###,###,###" value="${product.price}"/> 원 </b></font>
	    </div>
	    
      </c:forEach>
  </div>
</div>


