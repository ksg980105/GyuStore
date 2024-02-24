<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="top.jsp" %>

<h2 align="center">상품</h2>
<br>
<br>
<div class="container-fluid bg-3 text-center" style="width: 80%;">    
  <div class="row">
      <c:forEach var="product" items="${productList}" varStatus="loop">
	    <c:if test="${loop.index%4 == 0}">
	    	</div><div class="row"><hr>
	    </c:if>
	    <div class="col-sm-3">
	      <p>Some text..</p>
	      <img src="<%=request.getContextPath()%>/resources/productImage/${product.pimage}" class="img-responsive" width="200">
	    </div>
	    
      </c:forEach>
    
  </div>
</div><br>

