<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <style>
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    .jumbotron{
    	padding-top: 0;
    	padding-bottom: 0;
    	margin-bottom: 0;
    }
    .image-area {
	  height: 200px; /* 원하는 높이로 변경 */
	}
	img {
	  height: 200px; /* 원하는 높이로 변경 */
	}
    
  </style>
  <script type="text/javascript" src="resources/js/jquery.js"></script>
  <script type="text/javascript">
	function goLogout(){
		location.href="logout.jsp";
	}
	$(document).ready(function() {
	  $('li a').each(function() {
	    if ($(this).prop('href') == window.location.href) {
	      $(this).parent('li').addClass('active');
	    }
	  });
	});


  </script>
</head>
<body>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="view.main">Portfolio</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
      	<c:if test="${loginInfo.member_id eq 'admin'}">
	        <li><a href="view.main">Home</a></li>
	        <li><a href="list.category">카테고리 관리</a></li>
	        <li><a href="list.product">상품관리</a></li>
	        <li><a href="product.board">회원관리</a></li>
      	</c:if>
      	<c:if test="${loginInfo.member_id ne 'admin'}">
      		<li><a href="view.main">Home</a></li>
	        <li><a href="#">상품</a></li>
	        <li><a href="product.board">상품문의</a></li>
	    </c:if>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      	<c:if test="${empty loginInfo}">
        	<li><a href="login.member"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
        </c:if>
        <c:if test="${not empty loginInfo}">
        	<li><a href="mypage.member"><span class="glyphicon glyphicon-user"></span> MyPage</a></li>
        	<li><a href="javascript:goLogout()"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
        </c:if>
      </ul>
    </div>
  </div>
</nav>

<div class="jumbotron">
  <img src="resources/img/Banner.png" width="100%">
</div>

  
