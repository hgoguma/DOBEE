<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
	<c:import url="/common/tag.jsp"/>
	<meta charset="EUC-KR">
	<script type="text/javascript">
		/* Authcode�������� */
		${function(){
			$.ajax({
				url:"getAuthCode.ajax",
				dataType:"json",
				success:function(data){
					console.log("getAuthCode.ajax success");
					console.log(data);
				}
			});
		}}
	</script>
<title>DOBEE</title>
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
			<c:set var="emp" value="${requestScope.emp }"/>
            <div class="container-fluid">
                <div class="card mb-3">
                    <div class="card-header">
                        <i class="fas fa-user-edit"></i>
                 
                        <b>������</b>
               
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
                                                            		<label for="myPic"><img id="viewPhoto" name="viewPhoto" src="img/avatar.jpg" alt="�����ʻ���"  style="width:13em; height:100%;"></label>
                                                        		</div>
                                                    		</div>
                                                    		<div class="col-md-6">
                                                        		<div class="form-label-group">
                                                            		<input type="text" id="name" name="name" class="form-control">
                                                            		<label for="name">����̸�</label>
                                                            		<br>
                                                            		<br>
                                                            		<input type="email" id="mail" name="mail" class="form-control">
                                                            		<label for="mail">���&nbsp;E-mail</label>
                                                        		</div>
                                                    		</div>
                                                		</div>
                                            		</div>
                                            <div class="form-group">
                                                <div class="form-row">
                                                    <div class="col-md-6">
                                                        <div class="form-label-group">
                                                            <input type="text" id="position" name="position" class="form-control" placeholder="��å" required="required" autofocus="autofocus">
                                                            <label for="position">��å</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-label-group">
                                                            <input type="text" id="phone" name="phone" class="form-control" placeholder="��ȭ��ȣ" required="required">
                                                            <label for="authCode">��ȭ��ȣ</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-row">
                                                    <div class="col-md-6">
                                                        <div class="form-label-group">
                                                            <select id="authCode" name="authCode" class="form-control" placeholder="���� �ڵ�" required="required">
                                                            	<option hidden>�����ϼ���</option>
                                                            </select>
	                                                        <label for="authCode">���� �ڵ�</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-label-group">
                                                            <input type="text" id="teamCode" name="teamCode" class="form-control" placeholder="�� �ڵ�" required="required">
                                                            <label for="teamCode">�� �ڵ�</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-row">
                                                    <div class="col-md-6">
                                                        <div class="form-label-group">
                                                            <input type="number" id="deptno" name="deptno" class="form-control" placeholder="Dept No" required="required"
                                                            			value="${emp.deptno}">
                                                            <label for="deptno">Dept No</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-label-group">
                                                        	<input type="number" id="mgr" name="mgr" class="form-control" placeholder="Manager" required="required"
                                                        				value="${emp.mgr}">
                                                        	<label for="mgr">Manager</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="form-row">
                                                    <div class="col-md-6">
                                                        <div class="form-label-group">
                                                            <input type="number" id="sal" name="sal" class="form-control" placeholder="Sal" required="required"
                                                            			value="${emp.sal}">
                                                            <label for="sal">Salary</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-label-group">
                                                            <input type="number" id="comm" name="comm" class="form-control" placeholder="Commission" required="required"
                                                            			value="${emp.comm}">
                                                            <label for="comm">Commission</label>
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