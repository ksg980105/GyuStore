<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<style>
	.col-sm-10{
		display: flex;
	}
	.container{
		background-repeat: no-repeat;
		background-position: right;
		background-size: 350px;
	}
	body{
  		width: 100%;
  		height: 100%;
  		margin: 0;
  		padding: 0;
  		background-attachment: fixed;
  	}
  	.background-overlay{
  		position: absolute;
  		top: 0;
  		right: 0;
  		bottom: 0;
  		left: 0;
  		background-size: cover;
  		background-attachment: fixed;
  		opacity: 0.2;
  		z-index: -1;
  	}
  	.container{
  		z-index: 100;
  		background-color: rgba(255,255,255,0.0);
  		padding: 10px;
  	}
  	.form-horizontal{
  		padding-left: 300px;
  	}
  	.mybutton {
        background-color: gray; /* 버튼 배경색 */
        color: white;
        border: none;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        cursor: pointer;
        border-radius: 5px; /* 버튼 모서리 둥글게 */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    }
</style>
<script type="text/javascript">
	function findpwcheck(){
		if(f.member_id.value == ""){
			alert('아이디를 입력하세요.');
			return false;
		}
		if(f.phone.value == ""){
			alert('휴대폰번호를 입력하세요.');
			return false;
		}
		if(f.email.value == ""){
			alert('이메일주소를 입력하세요.');
			return false;
		}
	}
</script>
</head>
<body>
	<div class="background-overlay"></div>
	<div class="container" style="margin-top: 0;">
	  <h2 align="center">비밀번호 찾기</h2><hr>
	  <form name="f" class="form-horizontal" action="findPw.member" method="post" onSubmit="return findpwcheck()">
	    <div class="form-group">
	      <label class="control-label col-sm-2" for="member_id">아이디:</label>
	      <div class="col-sm-10">
	        <input type="text" class="form-control" style="width:200px;" placeholder="Enter id" name="member_id">&nbsp;
	      </div>
	    </div>
	    <div class="form-group">
	      <label class="control-label col-sm-2" for="phone">휴대폰번호:</label>
	      <div class="col-sm-10">
	        <input type="text" class="form-control" style="width:200px; opacity: 1;" maxlength="11" placeholder="Enter phone" name="phone">
	      </div>
	    </div>
	    <div class="form-group">
	      <label class="control-label col-sm-2" for="ssn">이메일주소:</label>
	      <div class="col-sm-10">
	        <input type="text" class="form-control" style="width:200px;" placeholder="Enter email" name="email">
	      </div>
	    </div>
	    <hr>
	    <div class="form-group">        
	      <div class="col-sm-offset-2 col-sm-10">
	        <input type="submit" class="mybutton" value="비밀번호 찾기">&nbsp;
	        <a href="login.member">
	        	<input type="button" class="mybutton" value="취소">
	        </a>
	      </div>
	    </div>
	  </form>
	</div>
</body>
</html>