<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<style>
	/* 상품평 컨테이너 스타일링 */
	.review-container {
	    max-width: 900px;
	    margin: 20px auto;
	    background-color: #f8f8f8;
	    padding: 20px;
	    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
	    border-radius: 8px;
	}
	
	/* 리뷰 박스 스타일링 */
	.review {
	    padding: 15px;
	    border-bottom: 1px solid #eee;
	    margin-bottom: 10px;
	    border-radius: 5px;
	    background-color: #f8f8f8;
	}
	
	.review:last-child {
	    border-bottom: none;
	}
	
	/* 리뷰 내용 스타일링 */
	.review h3, .review h2 {
	    color: #333;
	}
	
	.review p {
	    color: #666;
	    line-height: 1.5;
	}
	
	/* 사용자 ID 및 작성 날짜 스타일링 */
	.review h3 {
	    display: inline;
	    font-size: 1rem;
	}
	
	.review h2 {
	    display: inline;
	    font-size: 0.8rem;
	    color: #999;
	    margin-left: 10px;
	}
	
	/* 평점 스타일링 */
	.review p:last-child {
	    font-weight: bold;
	    color: #007bff;
	}
	
	/* 별 스타일 */
	.star-rating {
	    color: #ffc107; /* 노란색 */
	    font-size: 1.25rem;
	}
	
	/* 리뷰 내용에서 평점 숫자를 숨깁니다. */
	.review p.rating {
	    display: none;
	}
	
	.container {
    margin-top: 50px;
	}
	
	.col-md-5 img {
	    max-width: 100%;
	    height: auto;
	    margin-left: 100px;
	}
	
	.product-details {
	    margin-left: 50px;
	}
	
	.product-details h3 {
	    font-size: 24px;
	    color: #333;
	}
	
	.product-details p {
		margin: 0;
        padding: 0;
        text-align: left;
	    font-size: 16px;
	    color: #555;
	    margin-bottom: 10px;
	}
	
	.product-details span.badge {
	    padding: 5px 10px;
	}
	
	.product-details hr {
	    border: 0;
	    border-top: 1px solid #ccc;
	    margin: 20px 0;
	}
	
	.product-details button {
	    background-color: #007bff;
	    color: #fff;
	    border: none;
	    padding: 5px 10px;
	    border-radius: 3px;
	    cursor: pointer;
	}
	
	.product-details button:hover {
	    background-color: #0056b3;
	}
	
	.btn-container {
	    margin-top: 20px;
	}
	
	.btn-container .btn {
	    margin-right: 10px;
	}
	
	.summary-content {
	    display: block;
	    margin-left: 60px;
	}
	
	
</style>

<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">

	window.addEventListener('DOMContentLoaded', (event) => {
	    document.querySelectorAll('.rating').forEach(function(ratingElem) {
	        const ratingValue = parseInt(ratingElem.textContent);
	        let stars = '';
	        for (let i = 0; i < 5; i++) {
	            if (i < ratingValue) {
	                stars += '★'; // 별 표시
	            } else {
	                stars += '☆'; // 별 표시되지 않음
	            }
	        }
	        
	        const starsSpan = document.createElement('span');
	        starsSpan.innerHTML = stars;
	        starsSpan.classList.add('star-rating');
	        ratingElem.parentNode.insertBefore(starsSpan, ratingElem.nextSibling);
	    });
	});
    
    function plusCount(pqty, price) {
        var currentCount = parseInt(document.getElementById("pop_out").value);
        if (currentCount < pqty) {
            document.getElementById("pop_out").value = currentCount + 1;
            updateTotalPrice(currentCount + 1, price);
        } else {
            alert('재고수량 부족!');
        }
    }
    
    function minusCount(pqty, price) {
          var currentCount = document.getElementById("pop_out").value;
          if(currentCount > 1 && currentCount <= pqty) {
              document.getElementById("pop_out").value = currentCount - 1;
              updateTotalPrice(currentCount - 1, price);
          }
    }
    
    // Total 가격을 업데이트하는 함수
    function updateTotalPrice(quantity, price) {
        var totalPrice = quantity * price;
        // 숫자를 원하는 형식으로 형식화하여 문자열로 변환
        var formattedPrice = new Intl.NumberFormat('ko-KR').format(totalPrice);
        // Total 가격을 출력하는 요소에 업데이트된 가격을 설정
        document.getElementById("price").innerHTML = "<b>Total : " + formattedPrice + " 원</b>";
    }
    
    
    function goLogin(){
        alert('로그인 후 이용해주세요.');
    }
    
    //장바구니 추가
    function addToCart(pname, price, pqty) {
    	if(pqty == 0){
        	alert('재고가 없습니다.');
        	return;
        }
    	
        if(confirm('해당 상품을 장바구니에 추가하겠습니까?')) {
            var popOut = document.getElementById('pop_out').value;
            
            $.ajax({
                type: "GET",
                url: "insert.cart",
                data: {
                    pname: pname,
                    pqty: popOut,
                    price: price
                },
                success: function(response) {
                    console.log(response);
                    if (confirm('장바구니에 추가가 완료되었습니다. \n 장바구니로 이동하시겠습니까?')) {
                        window.location.href = "list.cart"; // 장바구니 목록 페이지로 이동
                    }
                },
                error: function(error) {
                    //에러 처리
                    console.error("장바구니 추가 에러:", error);
                    alert("장바구니 추가에 실패했습니다.");
                }
            });
        }
    }
    
    // 주문 누르면 상품번호, 주문갯수 넘김
    function goToOrder(pnum, pqty) {
    	if(pqty == 0){
        	alert('재고가 없습니다.');
        	return;
        }
    	
        var popOut = document.getElementById('pop_out').value;
        location.href = "order.product?pnum=" + pnum + "&pop_out=" + popOut;
    }
    
    function toggleStar(pnum) {
        var image = document.getElementById("starImage");
        var currentPath = "<%=request.getContextPath()%>/resources/img/";
        
        if (image.src.includes("staroff.jpeg")) {
            image.src = currentPath + "staron.jpeg";
            
            //DB에 데이터 추가
            $.ajax({
                url: 'insert.favorite',
                type: 'GET',
                data: { pnum: pnum },
                success: function(response) {
                    alert('즐겨찾기 추가되었습니다.');
                },
                error: function() {
                    alert('즐겨찾기 추가 실패');
                }
            });
            
        } else {
            image.src = currentPath + "staroff.jpeg";
            
          	//DB에 데이터 삭제
            $.ajax({
                url: 'delete.favorite',
                type: 'GET',
                data: { pnum: pnum },
                success: function(response) {
                	alert('즐겨찾기 해제되었습니다.');
                },
                error: function() {
                    alert('즐겨찾기 추가 실패');
                }
            });
        }
    }
    
    //즐겨찾기 상태 확인
    function checkFavoriteStatus(pnum) {
    	// 세션에 로그인 정보가 있는지 확인
        var isLoggedIn = <%= session.getAttribute("loginInfo") != null %>;
    	
        //로그인정보가 있을때만 실행
        if(isLoggedIn){
	        $.ajax({
	            url: 'check.favorite',
	            type: 'GET',
	            data: { pnum: pnum },
	            success: function(isFavorite) { //true false로 상태 확인
	                var image = document.getElementById("starImage");
	                var currentPath = "<%=request.getContextPath()%>/resources/img/";
	                if (isFavorite == "true") {
	                    image.src = currentPath + "staron.jpeg";
	                } else {
	                    image.src = currentPath + "staroff.jpeg";
	                }
	            },
	            error: function(xhr, status, error) {
	                alert('즐겨찾기 확인 실패');
	            }
	        });
        }
    }
</script>

<html>
<head>
  <meta charset="UTF-8">
  <title>상품 상세 정보</title>
</head>
<body onload="checkFavoriteStatus('${productBean.pnum}')">
    <br><br>
    <div class="container" align="center">
    <div class="row">
        <div class="col-md-5">
            <img src="<%=request.getContextPath()%>/resources/productImage/${productBean.pimage}" alt="${productBean.pname}">
        	<c:if test="${not empty loginInfo}">
        		<img src="<%=request.getContextPath()%>/resources/img/staroff.jpeg" id="starImage" width="30px;" align="right" style="margin-right: 27px; cursor: pointer;" onclick="toggleStar('${productBean.pnum}')">
        	</c:if>
        	<c:if test="${empty loginInfo}">
        		<img src="<%=request.getContextPath()%>/resources/img/staroff.jpeg" id="starImage" width="30px;" align="right" style="margin-right: 27px; cursor: pointer;" onclick="goLogin()">
        	</c:if>
        </div>
        <div class="col-md-6 product-details">
            <h3><b>${productBean.pname}</b></h3>
            <p><b>카테고리:</b> <span class="badge badge-danger">${productBean.pcategory}</span></p>
            <p><b>출판사:</b> ${productBean.publisher}</p>
            <p><b>줄거리:</b><span class="summary-content">${productBean.summary}</span></p>
            <p><b>재고 수:</b>
                <c:choose>
                    <c:when test="${productBean.pqty == 0}">
                        <font color="red">품절</font>
                    </c:when>
                    <c:otherwise>
                        ${productBean.pqty} 권
                    </c:otherwise>
                </c:choose>
            </p>
            <p><b>포인트:</b> ${productBean.point} p</p>
            <p><b>수량:</b>
                <button type="button" onclick="minusCount(${productBean.pqty}, ${productBean.price})">-</button>
                <input type="text" name="pop_out" id="pop_out" value="1" readonly="readonly" style="text-align:center; width: 50px;"/>
                <button type="button" onclick="plusCount(${productBean.pqty}, ${productBean.price})">+</button>
            </p>
            <hr>
            <h4 id="price">
                <b>Total: <fmt:formatNumber pattern="###,###,###" value="${productBean.price}"/> 원</b>
            </h4>
            <div class="btn-container">
                <c:choose>
                    <c:when test="${empty loginInfo or loginInfo.member_id == 'admin'}">
                        <a href="" class="btn btn-info" onclick="goLogin()">바로구매&raquo;</a>
                        <a href="" class="btn btn-warning" onclick="goLogin()">장바구니 담기&raquo;</a>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:void(0);" onclick="goToOrder('${productBean.pnum}','${productBean.pqty}');" class="btn btn-info">바로구매&raquo;</a>
                        <a href="javascript:void(0);" class="btn btn-warning" onclick="addToCart('${productBean.pname}', '${productBean.price}','${productBean.pqty}');">장바구니 담기&raquo;</a>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${empty pageNumber}">
                        <a href="view.main" class="btn btn-success">상품목록&raquo;</a>
                    </c:when>
                    <c:otherwise>
                        <a href="view.product?pageNumber=${pageNumber}" class="btn btn-success">상품목록&raquo;</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
	</div>
    <hr>
    <h3 style="padding-left: 260px;">상품평</h3>
    <div class="review-container">
	    <div class="review-list">
	        <!-- 상품평 리스트 -->
	        <c:if test="${empty reviewList}">
	        	<div class="review">
	        		<p>아직 등록된 리뷰가 없습니다.</p>
	        	</div>
	        </c:if>
	        <c:if test="${not empty reviewList}">
		        <c:forEach var="review" items="${reviewList}">
		        <div class="review">
		            <h3>${review.user_id}</h3> <h2>${review.write_date}</h2>
		            <p class="rating">${review.rating}</p>
		            <p>${review.content}</p>
		        </div>
		        </c:forEach>
	        </c:if>
	    </div>
	</div>
    <br><br><br><br>
</body>
</html>
