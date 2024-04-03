<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<style>
.row {
	width: 80%;
	margin: auto;
}

/* 상품 이미지 스타일링 */
.product-image {
    width: 80%;
    height: 200px;
    object-fit: fill;
    border-radius: 5px;
}

/* 가격 정렬 옵션 스타일링 */
.price-sort-option {
    cursor: pointer;
    color: #007bff;
    margin: 0 10px;
}

.price-sort-option:hover {
    text-decoration: underline;
}

/* 상품 목록 스타일링 */
.product-item {
    margin-bottom: 20px;
}

/* 상품 이름과 가격 스타일링 */
.product-name, .product-price {
    display: block;
    margin: 5px 0;
}

/* 검색 폼 스타일링 */
.search-form {
    margin: 20px 0;
}

.search-form select, .search-form input[type="text"] {
    padding: 5px 10px;
    margin-right: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.search-form input[type="submit"] {
    background-color: #007bff;
    color: white;
    padding: 5px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.search-form input[type="submit"]:hover {
    background-color: #0056b3;
}
</style>


<script type="text/javascript" src="../../resources/js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function () {
    var form = $('form[action="view.product"]');

    // 낮은가격순 텍스트 클릭 시
    $('#low_price').click(function () {
        updatePriceOrder('low');
    });

    // 높은가격순 텍스트 클릭 시
    $('#high_price').click(function () {
        updatePriceOrder('high');
    });

    function updatePriceOrder(order) {
        var isSearch = $('select[name="whatColumn"]').val() !== 'all' || $('input[name="keyword"]').val() !== '';

        if (isSearch) {
            // 현재 검색 중인 경우에만 추가
            $('input[name="price_order"]').remove(); // 기존 input 삭제
            form.append('<input type="hidden" name="price_order" value="' + order + '">'); // 새로운 input 추가
        } else {
            // 현재 검색 중이 아닌 경우에는 URL의 'price_order' 파라미터만 변경
            var currentUrl = window.location.href;
            var urlParts = currentUrl.split('?');

            if (urlParts.length > 1) {
                // URL에 파라미터가 있을 경우
                var params = urlParts[1].split('&');

                for (var i = 0; i < params.length; i++) {
                    if (params[i].startsWith('price_order=')) {
                        params.splice(i, 1); // 기존 'price_order' 파라미터 삭제
                        break;
                    }
                }

                params.push('price_order=' + order); // 새로운 'price_order' 파라미터 추가
                window.location.href = urlParts[0] + '?' + params.join('&');
            } else {
                // URL에 파라미터가 없을 경우
                window.location.href = currentUrl + '?price_order=' + order;
            }

            return;
        }

        form.submit(); // form 제출
    }
});

</script>

<br>
<div class="container-fluid bg-3 text-center">
  <span class="price-sort-option" id="low_price">낮은가격순</span> | 
  <span class="price-sort-option" id="high_price">높은가격순</span>
  
  <c:if test="${empty productList}">
	    <br><font size="5"><b>등록된 상품이 없습니다.</b></font>
  </c:if>
  
  <!-- 상품 목록 출력 -->
  <div class="row">
      <c:forEach var="product" items="${productList}" varStatus="loop">
        <c:if test="${loop.index%4 == 0}">
          </div><div class="row"><hr>
        </c:if>
        <div class="col-sm-3 product-item" align="center">
            <a href="detail.product?pnum=${product.pnum}&pageNumber=${productPageInfo.pageNumber}">
              <img src="<%=request.getContextPath()%>/resources/productImage/${product.pimage}" class="img-responsive product-image">
            </a>
          <span class="product-name"><b>${product.pname}</b></span>
          <span class="product-price"><b><fmt:formatNumber pattern="###,###,###" value="${product.price}"/> 원 </b></span>
        </div>
      </c:forEach>
  </div>
</div><br>

<center>
	${productPageInfo.pagingHtml}
</center>

<center class="search-form">
	<form action="view.product" method="get">
		<select name="whatColumn">
			<option value="all">전체검색
			<option value="pname">제목
			<option value="pcategory">카테고리
		</select>
		<input type="text" name="keyword">
		<input type="submit" value="검색">
	</form>
</center>