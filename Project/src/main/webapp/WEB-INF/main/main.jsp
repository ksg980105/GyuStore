<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<style>
  body {
    background-color: #f4f4f4;
  }

  .container-dd {
    max-width: 90%;
    margin: auto;
    background-color: #fff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 20px;
    border-radius: 15px;
    margin-bottom: 20px;
  }

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

  .row {
    margin: 0 -15px;
  }

  .col-sm-3 {
    padding: 0 15px;
    margin-bottom: 15px;
  }

  hr {
    margin-top: 20px;
    margin-bottom: 20px;
    border-color: #eee;
  }
</style>

<br>
<div class="container-dd bg-3 text-center" style="width: 90%;">
  <h2 align="left">인기상품</h2>
  <div class="row">
      <c:forEach var="countList" items="${productCountList}" varStatus="loop">
      	<c:if test="${loop.count <= 8}">
		    <c:if test="${loop.index%4 == 0}">
		    	</div><div class="row"><hr>
		    </c:if>
		    <div class="col-sm-3" align="center">
		        <a href="detail.product?pnum=${countList.pnum}">
		      	  <img src="<%=request.getContextPath()%>/resources/productImage/${countList.pimage}" class="img-responsive product-image">
		        </a>
		      <font size="3"><b>${countList.pname}</b></font><br>
		      <font size="2"><b><fmt:formatNumber pattern="###,###,###" value="${countList.price}"/> 원 </b></font>
		    </div>
	    </c:if>
      </c:forEach>
  </div>
</div>

<div class="container-dd bg-3 text-center" style="width: 90%;">
  <h2 align="left">최신상품</h2>
  <div class="row">
      <c:forEach var="newList" items="${productNewList}" varStatus="loop">
      	<c:if test="${loop.count <= 8}">
		    <c:if test="${loop.index%4 == 0}">
		    	</div><div class="row"><hr>
		    </c:if>
		    <div class="col-sm-3" align="center">
		        <a href="detail.product?pnum=${newList.pnum}">
		      	  <img src="<%=request.getContextPath()%>/resources/productImage/${newList.pimage}" class="img-responsive product-image">
		        </a>
		      <font size="3"><b>${newList.pname}</b></font><br>
		      <font size="2"><b><fmt:formatNumber pattern="###,###,###" value="${newList.price}"/> 원 </b></font>
		    </div>
	    </c:if>
      </c:forEach>
  </div>
</div>


