<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="fixed sidebar-left-collapsed">
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
						<h2>채팅</h2>
					
						<div class="right-wrapper pull-right">
							<ol class="breadcrumbs">
								<li>
									<a href="#">
										<i class="fa fa-comments"></i>
									</a>
								</li>
								<li><span>채팅</span></li>
							</ol>
							<a class="sidebar-right-toggle" data-open="sidebar-right"><i class="fa fa-chevron-left"></i></a>
						</div>
					</header>

					<!-- start: page -->
					<section class="content-with-menu mailbox">
						<div class="content-with-menu-container" data-mailbox data-mailbox-view="folder">
							<div class="inner-menu-toggle">
								<a href="#" class="inner-menu-expand" data-open="inner-menu">
									Show Menu <i class="fa fa-chevron-right"></i>
								</a>
							</div>
							
							<menu id="content-menu" class="inner-menu" role="menu">
								<div class="nano">
									<div class="nano-content">
										<div class="inner-menu-toggle-inside">
											<a href="#" class="inner-menu-collapse">
												<i class="fa fa-chevron-up visible-xs-inline"></i><i class="fa fa-chevron-left hidden-xs-inline"></i> Hide Menu
											</a>
										</div>
										<div class="inner-menu-content">
										<button type="button" id="channelModal" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#modalBootstrap"><strong>+</strong></button>
<!-- 										<a class="btn btn-block btn-primary btn-md pt-sm pb-sm text-md" data-toggle="modal" data-target="#modalBootstrap">Bootstrap</a>
 -->										<hr class="separator" />
										
											<div class="sidebar-widget m-none">
												<div class="widget-header">
													<h6 class="title">Channel</h6>
													<span class="widget-toggle">+</span>
												</div>
												<div class="widget-content">
													<ul class="list-unstyled mailbox-bullets">
													 <c:set var="roomNameList" value="${requestScope.roomNameList}"/>
	           											<c:forEach var="roomName" items="${roomNameList}">
												            <li>
													           	<a href='chatGroup.do?roomName=${roomName }' class="menu-item"><span><i class='fa fa-user'></i></span>${roomName}</a>
												     	  	</li>
										          		</c:forEach>
													</ul>
												</div>
											</div>
							
											<hr class="separator" />
							
											<!-- DM 목록 -->
											<div class="sidebar-widget m-none">
												<div class="widget-header">
													<h6 class="title">Direct Messages</h6>
													<span class="widget-toggle">+</span>
												</div>
												<div class="widget-content">
													<ul class="list-unstyled mailbox-bullets">
													<c:forEach var="userList" items="${requestScope.userList}">
											            <li>
												           	<a href='chatDm.do?dmName=${userList.name}&dmMail=${userList.mail}' class="menu-item" value=${userList.mail }><span><i class='fa fa-user'></i></span>${userList.name }</a>
											     	  	</li>
										           </c:forEach>
													</ul>
												</div>
											</div>
											
											
										</div>
									</div>
								</div>
							</menu>
							<div class="inner-body mailbox-folder">
								<!-- START: .mailbox-header -->
								<header class="mailbox-header">
									<div class="row">
										<div class="col-sm-6">
											<h1 class="mailbox-title text-light m-none">
												<a id="mailboxToggleSidebar" class="sidebar-toggle-btn trigger-toggle-sidebar">
													<span class="line"></span>
													<span class="line"></span>
													<span class="line"></span>
													<span class="line line-angle1"></span>
													<span class="line line-angle2"></span>
												</a>
									<c:set var="user" value="${requestScope.user}"/>
               							<b id="chatRoomName" style="font-size:30px;">${user.name}</b>
											</h1>
										</div>
										<div class="col-sm-6">
											
										</div>
									</div>
								</header>
								<!-- END: .mailbox-header -->
							
								<!-- START: .mailbox-actions -->
								 <div class="row">
					            	<div class="col-md-4">
					            		<hr width="70%">
					            	</div>
					       			<div class="col-md-4" id="currentDate">
					            		<h3 style="text-align:center;font-size:25px;">오늘 </h3>
					            	</div>     
					            	<div class="col-md-4">
					            		<hr width="70%">
					            	</div>
					            </div>
								<!-- <div class="mailbox-actions">
									<ul class="list-unstyled m-none pt-lg pb-lg">
										<li class="ib mr-sm">
											<div class="btn-group">
												<a href="#" class="item-action fa fa-chevron-down dropdown-toggle" data-toggle="dropdown"></a>
							
												<ul class="dropdown-menu" role="menu">
													<li><a href="#">All</a></li>
													<li><a href="#">None</a></li>
													<li><a href="#">Read</a></li>
													<li><a href="#">Unread</a></li>
													<li><a href="#">Starred</a></li>
													<li><a href="#">Unstarred</a></li>
												</ul>
											</div>
										</li>
										<li class="ib mr-sm">
											<a class="item-action fa fa-refresh" href="#"></a>
										</li>
										<li class="ib mr-sm">
											<a class="item-action fa fa-tag" href="#"></a>
										</li>
										<li class="ib">
											<a class="item-action fa fa-times text-danger" href="#"></a>
										</li>
									</ul>
								</div> -->
								
								<!-- END: .mailbox-actions -->
							<div class="container content" id="chatMsgMain">
					            <div class="nano-content">
						            <ul class="chat-list" id="chatLog" style="height: 250px; overflow-y: scroll;">
						        	</ul>
								</div>
							</div>
							<form id="sendMessage" method="post">
							<div>        
					            <li class="white">
					              <div class="form-group basic-textarea" stlye="width:300px">
					                <textarea class="form-control pl-2 my-0" id="chatContent" name="chatContent" rows="3" placeholder="메시지를 입력해주세요"></textarea>
									<input type="hidden" id="chatType" name="chatType" value="${requestScope.chatType}">
					                <input type="hidden" id="name" name="name" value="${user.name}">
					              </div>
					            </li>
				            </div>
					            	<button type="submit" class="btn btn-dark" style="float:right;">send</button>
				             </ul>
							</form>
								
								
							</div>
						</div>
					</section>
					<!-- end: page -->
				</section>
			</div>
			
			<!-- 오른쪽 사이드 시작 -->
			<c:import url="/common/RightSide.jsp"/>
			<!-- 오른쪽 사이드 끝 -->
			
			<!-- 채팅방 모달 -->
			<div class="modal fade" id="modalBootstrap" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
				<div class="modal-text text-center">
				
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
								<h4 class="modal-title" id="myModalLabel"><i class="fa fa-pencil"></i>새 대화 채널 만들기</h4>
						</div>
						<div class="modal-body mb-0">
						      <form id="makeChatRoom" name="makeChatRoom" method="post">
						      	<div class="row">
						      		<div class="col-sm-3">
						      			<label for="newChatRoomName" class="col-form-label"><i class="fa fa-comment"></i><span>&nbsp;채널 이름</span></label>
						      		</div>
						      		<div class="col-sm-9">
							          <input type="text" class="form-control" id="newChatRoomName" name="newChatRoomName">
							       </div>
							   </div>
						        <div class="row">
						      		<div class="col-sm-3">
						      			<label for="userList" class="col-form-label"><i class="fa fa-user"></i><span>&nbsp;멤버 초대</span></label>
						      		</div>
						      		<div class="col-sm-9">
		                                    <select class="form-control" id="userSelect" name="userSelect" style="height : 43px">
		                                    <option hidden>멤버</option>
		                                    </select>
						      		</div>
							   </div>
							   <div>
							   <br>
							   <div class="row">
								   <div class="col-sm-3">
							       </div>
							       <div class="col-sm-9" id="chatUserList" style="display:none">
								   </div>
								</div>
							   </div>
							   <br>
							 </form>
						</div>
						
						<div class="modal-footer">
							<button type="button" id="makeChatRoomBtn" class="btn btn-primary modal-confirm">만들기</button>
							<button type="button" class="btn btn-default" data-dismiss="btn btn-default modal-dismiss">Close</button>
						</div>
						</div>
						</div>
						</div>
						</div>
			
			
		</section>
		<c:import url="/common/BottomTag.jsp"/>
		<!-- Specific Page Vendor -->
		<script src="assets/vendor/pnotify/pnotify.custom.js"></script>
    
<!-- socket 연결 -->
<!-- <script src="http://192.168.6.2:5000/socket.io/socket.io.js"></script> -->
<script>
	$(function(){

		$.ajax({
			 
	  		url:"getUserList.do",
	  		dataType:"json",
	  		type:"post",
	  		success:function(data){
	  			$.each(data, function(index, element){
					let option = $("<option></option>");
					$(option).text(element.name+"("+element.mail+")");
					$(option).val(element.name+":"+element.mail);
					$("#userSelect").append(option);
				})
	  		}
	  	});

	  	

		var chatType = $("#chatType").val();
		var chatRoomName = $("#chatRoomName").text();
		var fromName = $("#name").val();
		/* var socket = io.connect( 'http://192.168.6.2:5000/self', {
					path: '/socket.io'
				});
				
				$("#sendMessage").on('submit', function(e){
					chatContent = $('#chatContent').val();

					socket.emit('send message to self', chatRoomName, chatType, chatContent, fromName);
					$('#chatContent').val("");
					$("#chatContent").focus();
					e.preventDefault();
					
					});
				
				socket.on('receive message to self', function(chatContent,currentDate){
						$('#chatLog').append('<div id="scroll"> <li class="out"><div class="chat-img" >'
								+'<img alt="Avtar" src="./img/alpaca.jpg"></div>'
								+'<div class="chat-body"><div class="chat-message">'
								+'<span>'+chatContent+'</span>&nbsp;&nbsp;&nbsp;<span>'+currentDate+'</span>'
								+'</div></div></li></div><br>');
						$('#scroll').scrollTop($('#scroll')[0].scrollHeight);
					}); */
		
		
		  
		
	var count = 0;
	
	$("#userSelect").change(function(){
		 console.log('이거 실행됨?');
		var userInfo = $("select[name='userSelect'] option:selected").val().split(":");
		var userName = userInfo[0]			
		var userMail = userInfo[1];
		$("#chatUserList").append("<div style='display:inline' class='list'><i class='fa fa-user'><span name='name' id='name"+(count++)+"'>"
						+userName+"</span><input type='hidden' name='userMail' value='"+userMail+"'>&nbsp;&nbsp;</i></div>");
	
		$("#chatUserList").css("display","block");
	
		});
	
	$("#makeChatRoomBtn").on('click', function(e){
		if($("#newChatRoomName").val() == "" || $("#newChatRoomName").val() == null){
			swal({
				title: "채널명",
				text: "채널명을 입력하세요",
				icon: "warning" //"info,success,warning,error" 중 택1
					}).then((YES) => {
						if (YES) {
							$("#newChatRoomName").focus();
							}
						})
						$("#newChatRoomName").focus();
			}else{
				var chatUserList = new Array();
				$("input[name=userMail]").each(function(index, item){
					chatUserList.push($(item).val());
					});
				var chatRoom = {
						"newChatRoomName" : $("#newChatRoomName").val(),
	 	    			"chatUserList" : chatUserList
	 	    			};
	 			$.ajax({
	 	 			url:"makeChatRoom.do",
	 				data: chatRoom ,
	 				dataType: "text",
	 				contentType :   "application/x-www-form-urlencoded; charset=UTF-8",
	 				type:"post",
	 				success:function(responsedata){
	 					console.log(responsedata);
	 					if(responsedata == "success"){ //채팅방 생성 완료
	 	 					console.log('채팅방 만듦')
	 	 					swal({
	 						   title: "채널 생성 완료",
	 						   text: "채널이 만들어졌습니다.",
	 						   icon: "success" //"info,success,warning,error" 중 택1
	 						}).then((YES) => {
	 							if (YES) {
	 								location.reload(true); 
	 							     }
	 							})
	 					
	 	 					}
	 				},
	 				error:function(){
	 					
	 				}
	 			});
	 			}
			});
	});
</script>
	</body>
</html>