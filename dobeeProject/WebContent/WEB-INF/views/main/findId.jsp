<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="fixed">
<head>
<c:import url="/common/HeadTag.jsp"/>
<c:import url="/common/BottomTag.jsp"/>
<!-- Specific Page Vendor CSS -->
<link rel="stylesheet" href="assets/vendor/jquery-ui/css/ui-lightness/jquery-ui-1.10.4.custom.css" />
<link rel="stylesheet" href="assets/vendor/select2/select2.css" />
<link rel="stylesheet" href="assets/vendor/bootstrap-tagsinput/bootstrap-tagsinput.css" />
<link rel="stylesheet" href="assets/vendor/bootstrap-colorpicker/css/bootstrap-colorpicker.css" />
<link rel="stylesheet" href="assets/vendor/bootstrap-timepicker/css/bootstrap-timepicker.css" />
<link rel="stylesheet" href="assets/vendor/dropzone/css/basic.css" />
<link rel="stylesheet" href="assets/vendor/dropzone/css/dropzone.css" />
<link rel="stylesheet" href="assets/vendor/bootstrap-markdown/css/bootstrap-markdown.min.css" />
<link rel="stylesheet" href="assets/vendor/summernote/summernote.css" />
<link rel="stylesheet" href="assets/vendor/summernote/summernote-bs3.css" />	
<!-- Specific Page Vendor -->
<script src="assets/vendor/jquery-ui/js/jquery-ui-1.10.4.custom.js"></script>
<script src="assets/vendor/select2/select2.js"></script>
<script src="assets/vendor/jquery-maskedinput/jquery.maskedinput.js"></script>
<script src="assets/vendor/bootstrap-tagsinput/bootstrap-tagsinput.js"></script>
<script src="assets/vendor/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
<script src="assets/vendor/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
<script src="assets/vendor/fuelux/js/spinner.js"></script>
<script src="assets/vendor/dropzone/dropzone.js"></script>
<script src="assets/vendor/bootstrap-markdown/js/markdown.js"></script>
<script src="assets/vendor/bootstrap-markdown/js/to-markdown.js"></script>
<script src="assets/vendor/bootstrap-markdown/js/bootstrap-markdown.js"></script>
<script src="assets/vendor/summernote/summernote.js"></script>
<script src="assets/vendor/bootstrap-maxlength/bootstrap-maxlength.js"></script>
<script src="assets/vendor/ios7-switch/ios7-switch.js"></script>
<!-- Examples -->
<script src="assets/javascripts/forms/examples.advanced.form.js" /></script>
<script src="assets/vendor/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<style type="text/css">
body {
    background: #23394A;
    width: 100%;
}
</style>
<script type="text/javascript">
$(function(){

 $('#idModal2').click(function(e){
	 
	 console.log("done???");
	 $('#findMail').trigger('reset');

	 if(($.trim($('#name').val())=='')&&($.trim($('#phone').val())=='')){
         alert("내용을 입력하지 않았습니다");
         return false;
         }
	 else if($.trim($('#name').val())==''){
         alert("이름을 입력하세요");
         $('#name').focus();
         return false;    
     }    
     else if($.trim($('#phone').val())==''){
		alert("휴대폰번호를 입력하세요");
		$('#phone').focus();
		return false;
     }
   });

	$('#idModal2').click('show.bs.modal',function(e){
	 var name = $('#name').val();
     var phone = $('#phone').val();
     
     $.ajax({
         url:'ajax/admin/findId.do',
         data: {"name":name, "phone":phone},
         dataType : "text",
         success:function(data){
			console.log(data);
             var mail = data;
       
             if(mail === ""){
            	 $('#findMail').val("찾은 이메일 값이 없습니다.");       	 
             }else{
               $('#findMail').val(mail);
             }
         },
         error : function(request,status,error){
				console.log("code" +request.status+"\n"+"message : "+request.response+"\n"+"error : "+error);
         }
     });
 });   
 });	
</script>

</head>
<body>
<!-- start:page -->
<section class="body-sign">
 <div class="center-sign">
			
			
   <a class="logo pull-left">
	 <img src="img/beemain2.png" height="45"/>
   </a>


   <div class="panel panel-sign">
				
	<div class="panel-title-sign mt-xl text-right">
	  <h2 class="title text-uppercase text-bold m-none"><i class="fa fa-envelope-o mr-xs" ></i>메일 찾기</h2>
	</div>
					
	<div class="panel-body">
	  <form action="" method="post">
						
		<div class="form-group mb-lg">
		  <label>이름</label>
		  <div class="input-group input-group-icon">
			 <input name="name" type="text" class="form-control input-lg" id="name"/>
				<span class="input-group-addon">
				 <span class="icon icon-lg">
				  <i class="fa fa-user"></i>
				 </span>
				</span>
		  </div>
		</div>

		<div class="form-group mb-lg">								
		  <label>휴대폰번호</label>								
		  <div class="input-group input-group-icon">
			<input name="phone" type="text" class="form-control input-lg" id="phone"/>
			   <span class="input-group-addon">
				<span class="icon icon-lg">
				 <i class="fa fa-phone"></i>
				</span>
			   </span>
		  </div>
		</div>

	   
		<hr>

		<div class="mb-xs text-center">
		  <a class="btn btn-facebook mb-md ml-xs mr-xs" data-toggle="modal" data-target="#modalBootstrap"
		     href="#modalBootstrap" id="idModal2">아이디 찾기</a>
		  <a class="btn btn-twitter mb-md ml-xs mr-xs" href="login.do">로그인 </a>
		</div>
		</form>

		<p class="text-center">비밀번호를 잊으셧나요?<a href="findPassWord.do">&nbsp;&nbsp;&nbsp;비밀번호 찾기</a>

	  </div>
	  	  
	</div>

				
 </div>
 
<!-- Modal -->
<div class="modal fade" id="modalBootstrap" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
 <div class="modal-dialog">
  <div class="modal-content">
  
   <div class="modal-header">
	<button type="button" class="close" data-dismiss="modal">
	 <span aria-hidden="true">&times;</span>
	 <span class="sr-only">Close</span>
	</button>
	<h4 class="modal-title" id="myModalLabel">찾은 메일</h4>
   </div>
   
   <div class="modal-body">
	<h4><input id="findMail" type="text" name="mail" class="input-line" value="" readonly="readonly"
	     style="border:none; width:100%; height:100%;"/></h4>
   </div>
   
   <div class="modal-footer">
	<button type="button" data-dismiss="modal"class="btn btn-primary">
	 <span aria-hidden="true"></span>확인</button>
	
   </div>
   
  </div>
 </div>
</div>
<!-- Modal -->
 
</section>
<!-- end: page -->



</body>
</html>