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
<!--폰트  -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:700&display=swap" rel="stylesheet">	
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
<!-- Sweet Alert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style type="text/css">
body {
    background: #2e383f;
    width: 100%;
}
</style>
<script type="text/javascript">
$(function(){
 $('#idModal2').click(function(e){
	  
	 if(($.trim($('#password').val())=='')&&($.trim($('#passwordOk').val())=='')){
        swal({
			title: "비밀번호 재설정",
			text: "내용을 입력하세요", 
			icon: "warning", //"info,success,warning,error" 중 택1
			showConfirmButton: true
			//icon: "warning" //"info,success,warning,error" 중 택1
				})
        return false;
        }
	 else if($.trim($('#password').val())==''){
        swal({
			title: "비밀번호 재설정",
			text: "비밀번호를 입력해주세요", 
			icon: "warning", //"info,success,warning,error" 중 택1
			showConfirmButton: true
			//icon: "warning" //"info,success,warning,error" 중 택1
				})
        $('#name').focus();
        return false;    
       }    
    else if($.trim($('#passwordOk').val())==''){
		swal({
			title: "비밀번호 재설정",
			text: "비밀번호 확인을 입력해주세요", 
			icon: "warning", //"info,success,warning,error" 중 택1
			showConfirmButton: true
			//icon: "warning" //"info,success,warning,error" 중 택1
				})
		$('#phone').focus();
		return false;
       }
    else if( ($('#password').val())!==($('#passwordOk').val())){
        swal({
			title: "비밀번호 재설정",
			text: "비밀번호가 일치하지 않습니다. 다시 확인해주세요", 
			icon: "warning", //"info,success,warning,error" 중 택1
			showConfirmButton: true
			//icon: "warning" //"info,success,warning,error" 중 택1
				})
        return false;
        }
    else if( ($('#password').val())==($('#passwordOk').val())){
        var password = $('#password').val();
        console.log("password:"+password);
        var mail = $('#mail').val();
        $.ajax({

            url:'ajax/admin/passwordChange.do',
            data:{"mail": mail, "password":password},
            dataType:"text",
            type : "post",
            success:function(data){
                var pwChange = data;
                console.log("변경비밀번호:"+pwChange);
                swal({
        			title: "비밀번호 재설정",
        			text: "비밀번호가 변경되었습니다", 
        			icon: "success", //"info,success,warning,error" 중 택1
        			button: "true"
        				}).then((YES) => {
        					document.location.href="login.do";
        				});
                
                },
            error:function(request,status,error){
				console.log("code" +request.status+"\n"+"message : "+request.response+"\n"+"error : "+error);
            }
            
            });

    }
	    
  });
});
</script>

</head>
<body>
<!-- start:page -->
<section class="body-sign" style="font-family: 'Nanum Gothic', sans-serif;">
 <div class="center-sign">
					
   <a class="logo pull-left">
	 <img src="img/beemain2.png" height="55"/>
   </a>

   <div class="panel panel-sign">
				
	<div class="panel-title-sign mt-xl text-right">
	  <h2 class="title text-uppercase text-bold m-none"><i class="fa fa-lock mr-xs" ></i>비밀번호 찾기</h2>
	</div>
					
	<div class="panel-body">
	  <form action="" method="post">
						
		<div class="form-group mb-lg">
		  <label>새 비밀번호</label>
		  <div class="input-group input-group-icon">
		  	<input type="hidden" id="mail" name="mail" value="${requestScope.mail }"/>
			<input name="password" type="password" class="form-control input-lg" id="password"/>
				<span class="input-group-addon">
				 <span class="icon icon-lg">
				  <i class="fa fa-lock"></i>
				 </span>
				</span>
		  </div>
		</div>

		<div class="form-group mb-lg">								
		  <label>비밀번호 확인</label>								
		  <div class="input-group input-group-icon">
			<input name="passwordOk" type="password" class="form-control input-lg" id="passwordOk"/>
			   <span class="input-group-addon">
				<span class="icon icon-lg">
				 <i class="fa fa-lock"></i>
				</span>
			   </span>
		  </div>
		</div>	   
		<hr>
		<div class="mb-xs text-center">
		  <a class="btn btn-facebook mb-md ml-xs mr-xs" id="idModal2">비밀번호 변경</a>
		</div>
		</form>
		<p class="text-center">아이디를 잊으셧나요?<a href="findId.do">&nbsp;&nbsp;&nbsp;아이디 찾기</a>
	  </div>  	  
	</div>				
 </div>

</section>
<!-- end: page -->
</body>
</html>