<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<c:import url="/common/tag.jsp" />
	<script type="text/javascript">
		$(function(){
			/* 권한 코드 select option 만들기*/
			$.ajax({
				url:"ajax/admin/authorityList.do",
				dataType: "JSON",
				success: function(data){
					$.each(data, function(i, elt) {
						if(elt.authCode !=1){
							var option = $("<option>");
							$(option).val(elt.authCode);
							if(elt.authCode == 2){
								$(option).text("사원");
							}
							else{
								$(option).text("팀장");
							}
							$('#authCode').append(option);
						}
					})
				}
			})
	
			/* 팀 목록 select option 만들기 */
			$.ajax({
				url:"ajax/admin/teamList.do",
				dataType:"JSON",
				success: function(data){
					console.log("teamList Ajax");
					console.log(data);
					$.each(data, function(i, elt) {
						var option = $('<option>');
						$(option).val(elt.teamCode);
						$(option).text(elt.teamName);

						$('#teamCode').append(option);
					})
					
				}	
			})
		});
	</script>
</head>
<body>
	<!-- Side Navbar -->
    <nav class="side-navbar">
    <c:import url="/common/Left_Admin.jsp" />
    </nav>

    <div class="page">
      <!-- navbar-->
      <c:import url="/common/top.jsp"/>
      
      <div id="content-wrapper">
            <!-- !! Content !! -->
            <div class="container-fluid">
                <div class="card mb-3">
                    <div class="card-header">
                        <i class="fas fa-user-edit"></i>
                 
                        <b>사원등록</b>
               
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <form action="#" method="post" enctype="multipart/form-data">
                                        	<div class="form-group">
                                                		<div class="form-row">
                                                   			<div class="col-md-6">
                                                        		<div class="form-label-group">
                                                            		
                                                            		<input type="file" id="myPic" name="myPic" class="form-control" accept="image/*" hidden="true">
                                                            		<label for="myPic"><img id="viewPhoto" name="viewPhoto" src="img/avatar.jpg" alt="프로필사진"  style="width:13em; height:100%;"></label>
                                                        		</div>
                                                    		</div>
                                                    		<div class="col-md-6">
                                                        		<div class="form-label-group">
                                                            		<input type="text" id="name" name="name" class="form-control">
                                                            		<label for="name">사원이름</label>
                                                            		<br>
                                                            		<br>
                                                            		<input type="email" id="mail" name="mail" class="form-control">
                                                            		<label for="mail">사원&nbsp;E-mail</label>
                                                        		</div>
                                                    		</div>
                                                		</div>
                                            		</div>
                                            <div class="form-group">
                                                <div class="form-row">
                                                    <div class="col-md-6">
                                                        <div class="form-label-group">
                                                            <input type="text" id="position" name="position" class="form-control" placeholder="직책" required="required" autofocus="autofocus">
                                                            <label for="position">직책</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-label-group">
                                                            <input type="text" id="phone" name="phone" class="form-control" placeholder="전화번호" required="required">
                                                            <label for="authCode">전화번호</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-row">
                                                    <div class="col-md-6">
                                                        <div class="form-label-group">
                                                            <select id="authCode" name="authCode" class="form-control" placeholder="권한 코드" required="required">
                                                            	<option hidden>선택하세요</option>
                                                            </select>
	                                                        <label for="authCode">권한 선택</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-label-group">
                                                           	<select id="teamCode" name="teamCode" class="form-control" placeholder="팀이름" required="required">
                                                           		<option hidden>선택하세요</option>
                                                           	</select>
                                                            <label for="teamCode">팀 선택</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="form-row">
                                           		 <div class="col-md-6">
                                                    <input type="submit" class="btn btn-primary btn-block" value="Edit">
                                                </div>
                                                <div class="col-md-6">
                                                    <input type="button" class="btn btn-danger btn-block" value="Cancel"
                                                        		onClick="location.href='MemberList.do'">
                                                </div>
                                               
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
      
    </div>
</body>
</html>