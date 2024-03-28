<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
  <style>
	th{
		width: 25%;
		background-color: #E2E2E2;
		text-align: right;
	}
	
	.btn-secondary:hover {
	    color: #fff !important;  // 글자색을 흰색으로 변경
	}
  </style>
	
  <script type="text/javascript">
		
  </script>
</head>
<body>
	<div class="container" style="width: 1000px;">
		<div class="row">
			<h2><b>영수증</b></h2>
			<hr>
			
			<table border="1" class="table" style="width: 100%;">
				<tr>
					<th>아이디</th>
					<td>${orderBean.member_id}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${orderBean.email}</td>
				</tr>
				<tr>
					<th>휴대폰번호</th>
					<td>${orderBean.phone}</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>${orderBean.address1} ${orderBean.address2}</td>
				</tr>
				<tr>
					<th>상품명</th>
					<td>${orderBean.pname}</td>
				</tr>
				<tr>
					<th>수량</th>
					<td>${orderBean.pop_out}</td>
				</tr>
				<tr>
					<th>요청사항</th>
					<td>${orderBean.requestOrder}</td>
				</tr>
				<tr>
					<th>가격</th>
					<td>${orderBean.productPrice - orderBean.using_point}</td>
				</tr>
			</table>
			
			<br><br><br><br><br>
		</div>
	</div>
	</body>
</html>