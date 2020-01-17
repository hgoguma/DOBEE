<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="fixed search-results">
	<head>
		<c:import url="/common/HeadTag.jsp"/>
	</head>
	<body>
		<section class="body">

			<!-- start: header -->
			<c:import url="/common/Top.jsp"/>
			<!-- end: header -->

			<div class="inner-wrapper">
				<!-- start: sidebar -->
				<c:import url="/common/Side.jsp"/>

				<!-- end: sidebar -->

				<section role="main" class="content-body">
					<header class="page-header">
						<h2>프로젝트</h2>
					
						<div class="right-wrapper pull-right">
							<ol class="breadcrumbs">
								<li>
									<a href="index.html">
										<i class="fa fa-home"></i>
									</a>
								</li>
								<li><span>Pages</span></li>
								<li><span>Search</span></li>
							</ol>
					
							<a class="sidebar-right-toggle" data-open="sidebar-right"><i class="fa fa-chevron-left"></i></a>
						</div>
					</header>

					<!-- start: page -->
					<div class="search-content">
						<div class="search-toolbar">
							<ul class="list-unstyled nav nav-pills">
								<li class="active">
									<a href="#everything" data-toggle="tab">2019년 4분기</a>
								</li>
								<li>
									<a href="#medias" data-toggle="tab">2020년 1분기</a>
								</li>
							</ul>
						</div>
						
							<!-- 프로젝트 넣기 -->
						<div class="tab-content">
						
						<div class="row">
							<div class="col-md-12 col-lg-6">
								<div class="row">
									<div class="col-md-12 col-xl-6">
										<section class="panel panel-group">
											<header class="panel-heading bg-primary">
						
												<div class="widget-profile-info">
													<div class="profile-picture">
														<img src="assets/images/!logged-user.jpg">
													</div>
													<div class="profile-info">
														<h4 class="name text-semibold">John Doe</h4>
														<h5 class="role">Administrator</h5>
														<div class="profile-footer">
															<a href="#">(edit profile)</a>
														</div>
													</div>
												</div>
						
											</header>
											<div id="accordion">
												<div class="panel panel-accordion panel-accordion-first">
													<div class="panel-heading">
														<h4 class="panel-title">
															<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse1One">
																<i class="fa fa-check"></i> Tasks
															</a>
														</h4>
													</div>
													<div id="collapse1One" class="accordion-body collapse in">
														<div class="panel-body">
															<ul class="widget-todo-list">
																<li>
																	<div class="checkbox-custom checkbox-default">
																		<input type="checkbox" checked="" id="todoListItem1" class="todo-check">
																		<label class="todo-label" for="todoListItem1"><span>Lorem ipsum dolor sit amet</span></label>
																	</div>
																	<div class="todo-actions">
																		<a class="todo-remove" href="#">
																			<i class="fa fa-times"></i>
																		</a>
																	</div>
																</li>
																<li>
																	<div class="checkbox-custom checkbox-default">
																		<input type="checkbox" id="todoListItem2" class="todo-check">
																		<label class="todo-label" for="todoListItem2"><span>Lorem ipsum dolor sit amet</span></label>
																	</div>
																	<div class="todo-actions">
																		<a class="todo-remove" href="#">
																			<i class="fa fa-times"></i>
																		</a>
																	</div>
																</li>
																<li>
																	<div class="checkbox-custom checkbox-default">
																		<input type="checkbox" id="todoListItem3" class="todo-check">
																		<label class="todo-label" for="todoListItem3"><span>Lorem ipsum dolor sit amet</span></label>
																	</div>
																	<div class="todo-actions">
																		<a class="todo-remove" href="#">
																			<i class="fa fa-times"></i>
																		</a>
																	</div>
																</li>
															</ul>
														</div>
													</div>
												</div>
												<div class="panel panel-accordion">
													<div class="panel-heading">
														<h4 class="panel-title">
															<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse1Two">
																 <i class="fa fa-comment"></i> Messages
															</a>
														</h4>
													</div>
													<div id="collapse1Two" class="accordion-body collapse">
														<div class="panel-body">
															<ul class="simple-user-list mb-xlg">
																<li>
																	<figure class="image rounded">
																		<img src="assets/images/!sample-user.jpg" alt="Joseph Doe Junior" class="img-circle">
																	</figure>
																	<span class="title">Joseph Doe Junior</span>
																	<span class="message">Lorem ipsum dolor sit.</span>
																</li>
																<li>
																	<figure class="image rounded">
																		<img src="assets/images/!sample-user.jpg" alt="Joseph Junior" class="img-circle">
																	</figure>
																	<span class="title">Joseph Junior</span>
																	<span class="message">Lorem ipsum dolor sit.</span>
																</li>
																<li>
																	<figure class="image rounded">
																		<img src="assets/images/!sample-user.jpg" alt="Joe Junior" class="img-circle">
																	</figure>
																	<span class="title">Joe Junior</span>
																	<span class="message">Lorem ipsum dolor sit.</span>
																</li>
																<li>
																	<figure class="image rounded">
																		<img src="assets/images/!sample-user.jpg" alt="Joseph Doe Junior" class="img-circle">
																	</figure>
																	<span class="title">Joseph Doe Junior</span>
																	<span class="message">Lorem ipsum dolor sit.</span>
																</li>
															</ul>
														</div>
													</div>
												</div>
											</div>
										</section>
									</div>
									<div class="col-md-12 col-xl-6">
										<section class="panel">
											<header class="panel-heading bg-tertiary">
												<div class="panel-heading-profile-picture">
													<img src="assets/images/!logged-user.jpg">
												</div>
											</header>
											<div class="panel-body">
												<h4 class="text-semibold mt-sm">John Doe</h4>
												<p>Nullam quiris risus eget urna mollis ornare vel eu leo. Soccis natoque penatibus et magnis dis parturient montes. </p>
												<hr class="solid short">
												<p><a href="#"><i class="fa fa-user mr-xs"></i> My Profile</a></p>
												<p><a href="#"><i class="fa fa-lock mr-xs"></i> Lock Screen</a></p>
												<p><a href="#"><i class="fa fa-power-off mr-xs"></i> Logout</a></p>
											</div>
										</section>
									</div>
								</div>
							</div>
						</div>
						
						
						
						</div>
					<!-- end: page -->
				</section>
			</div>
			
			<!-- 오른쪽 사이드 시작 -->
			<c:import url="/common/RightSide.jsp"/>
			<!-- 오른쪽 사이드 끝 -->
			
		</section>

	<c:import url="/common/BottomTag.jsp"/>


	</body>
</html>