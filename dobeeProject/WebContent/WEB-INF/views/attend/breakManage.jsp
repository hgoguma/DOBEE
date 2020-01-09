<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
  <head>
    <c:import url="/common/tag.jsp"/>
    <style>
		body {
		  margin: 40px 10px;
		  padding: 0;
		  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
		  font-size: 14px;
		}
		
		#loading {
		  display: none;
		  position: absolute;
		  top: 10px;
		  right: 10px;
		}
		
		#calendar {
		  max-width: 900px;
		  margin: 0 auto;
		}	  	
    </style>
    
    <link rel="stylesheet" href="./css/jgcss.css">
    
    <!-- Modal -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    
  </head>
 
  <body>
    <!-- Side Navbar -->
    <nav class="side-navbar">
    <c:import url="/common/left.jsp" />
    </nav>

    <div class="page">
      <!-- navbar-->
      <c:import url="/common/top.jsp"/>
	
		<div id="navbar">
		  <b-card title="Card Title" no-body>
		    <b-card-header header-tag="nav">
		      <b-nav card-header pills>
		        <b-nav-item>부재일정 신청</b-nav-item>
		        <b-nav-item><a href="extendApply.do">연장근무 신청</a></b-nav-item>
		        <b-nav-item active >부재 일정 관리</b-nav-item>
		        <b-nav-item><a href="workManage.do">근무 내역 확인</a></b-nav-item>
		        <b-nav-item>부재 관리</b-nav-item>
		        <b-nav-item>연장근무 관리</b-nav-item>
		      </b-nav>
		    </b-card-header>
		
		    <b-card-body class="text-center">
		      <b-card-text>
		     	<h1 style="text-align: left">부재일정 관리</h1>
	
		      </b-card-text>
		    </b-card-body>
		  </b-card>
		</div>
	
		<h3>사용 연차</h3> $ { usedVacation } 일
		<h3>남은 연차</h3> $ { remainingVacation } 일
		<br>
		
		
		<form action="" method="post">
			<select name="year">
				<option value="">년도별</option>
				<option value="2019">2019</option>
				<option value="2020">2020</option>
				
			</select>
			
			<select name="month">
				<option value="">월별</option>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>		
			</select>
			
			<select name="category">
				<option value="">항목별</option>
				<option value="연차">연차</option>
				<option value="외근">외근</option>
				<option value="출장">출장</option>
			</select>
			
			<input type="submit" class="submit" value="검색하기 ">
			아마도 아이콘으로 바꿔야 할듯? ㅎㅎ
		</form>

			
		<section>
			<div class="col-md-12">
			
				<table id="breakTable" class="dataTable display hover" style="width :100%">
					<thead id="thead">
						<tr>
							<th width="13%">부재항목</th>
							<th>기간</th>
							<th width="13%">사용 일수</th>
							<th width="20%">승인여부</th>
						</tr>
					</thead>
			
					<tbody id="tbody">
						<!-- 여기서 뿌려줄겨 -->
						<tr>
							<td class="bcategory">연차</td>
							<td class="tterm">2020.01.03. ~ 2020.01.05</td>
							<td class="tused">3</td>
							<td class="notauth"><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal">미승인</button></td>
						</tr>
						<tr>
							<td class="bcategory">반차</td>
							<td class="tterm">2020.01.05. ~ 2020.01.05</td>
							<td class="tused">0.5</td>
							<td class="notauth"><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal">승인</button></td>
						</tr>
						<tr>
							<td class="bcategory">외근</td>
							<td class="tterm">2020.01.03. ~ 2020.01.05</td>
							<td class="tused">0</td>
							<td class="notauth"><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal">반려</button></td>
						</tr>
					</tbody>
					
					<tfoot>	
					</tfoot>
						
				</table>
			</div>
		</section>
	
	</div>
	
	<section id="modal_breakReason">
		<div class="container">
		  <!-- Modal -->
		  <div class="modal fade" id="myModal" role="dialog">
		    <div class="modal-dialog modal-lg">
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		          <h4 class="modal-title">상세 사유</h4>
		        </div>
		        <div class="modal-body">
		           <h3>부재 사유</h3>
			      <h4>사유</h4>
			      <h5>이러이러하옵니다...</h5>
		        </div>
		        <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
		        </div>
		      </div>
		    </div>
		  </div>
		</div>		
	</section>

	<c:import url="/common/bottom.jsp"/>   
   
    <!-- JavaScript files-->
    <script src="./vendor/jquery/jquery.min.js"></script>
    <script src="./vendor/popper.js/umd/popper.min.js">
					
				</script>
    <script src="./vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="./js/grasp_mobile_progress_circle-1.0.0.min.js"></script>
    <script src="./vendor/jquery.cookie/jquery.cookie.js">
					
				</script>
    <script src="./vendor/chart.js/Chart.min.js"></script>
    <script src="./vendor/jquery-validation/jquery.validate.min.js"></script>
    <script src="./vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
    <script src="./js/charts-home.js"></script>
    <!-- Main File-->
    <script src="./js/front.js"></script>
    <script src="https://kit.fontawesome.com/5d4e7bbd25.js" crossorigin="anonymous"></script>
    
    <link href='./packages/core/main.css' rel='stylesheet' />
	<link href='./packages/daygrid/main.css' rel='stylesheet' />
	<link href='./packages/list/main.css' rel='stylesheet' />
	<script src='./packages/core/main.js'></script>
	<script src='./packages/interaction/main.js'></script>
	<script src='./packages/daygrid/main.js'></script>
	<script src='./packages/list/main.js'></script>
	<script src='./packages/google-calendar/main.js'></script>
  
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script src="/resources/demos/external/globalize/globalize.js"></script>
  <script src="/resources/demos/external/globalize/globalize.culture.de-DE.js"></script>
  <script src="/resources/demos/external/jquery-mousewheel/jquery.mousewheel.js"></script>
  
  	<script>
		window.onload = function(){
			var app = new Vue ({
				el : '#navbar',
				data : []
			});
		}
		
  	</script>
   
    
  </body>
</html>




