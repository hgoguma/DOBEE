<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

<c:import url="/common/tag.jsp" />



<!-- 루트 컴포넌트 연결 -->

<script type="text/javascript" charset="utf-8"> <c:import url="/WEB-INF/views/payment/app.js" /></script>
<script src="https://cdn.jsdelivr.net/npm/http-vue-loader@1.4.1/src/httpVueLoader.min.js"></script>
<script>  <c:import url="/WEB-INF/views/payment/route/vue-router.js" />  </script>
<script>  <c:import url="/WEB-INF/views/payment/route/router.js" /> </script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

</head>




<body>

	<!-- Side Navbar -->
	<nav class="side-navbar">
		<c:import url="/common/left.jsp" />
	</nav>

	 <div class="page">
		<c:import url="/common/top.jsp" />


				<div id='app'>
					<router-view></router-view>
				</div>
					
	
		<c:import url="/common/bottom.jsp" />
</div>




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
	<script
		src="./vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
	<script src="./js/charts-home.js"></script>
	 <!— Main File—>
    <script src="./js/front.js"></script>
    <script src="https://kit.fontawesome.com/5d4e7bbd25.js" crossorigin="anonymous"></script>
</body>


</html>