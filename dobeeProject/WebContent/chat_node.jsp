<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
  <head>
    <c:import url="/common/tag.jsp"/>
  </head>
  <style>
	@import url(https://fonts.googleapis.com/earlyaccess/nanumbrushscript.css);
	body{
			font-size: 20px; font-family: 'Nanum Brush Script', serif; line-height: 1.5; color: #222222;
	
	}
	h4, span {
			font-size: 20px; font-family: 'Nanum Brush Script', serif; line-height: 1.5; color: #222222;
	
	}

  </style>
 
  <body>
  <div id="app">
    <!-- Side Navbar -->
    <nav class="side-navbar">
    <c:import url="/common/left.jsp" />
    </nav>
  	

    <div class="page">
      <!-- navbar-->
      <c:import url="/common/top.jsp"/>

<div class="card grey lighten-3 chat-room">
  <div class="card-body">

    <!-- Grid row -->
    <div class="row px-lg-2 px-2">

      <!-- Grid column -->
      <div class="col-md-6 col-xl-3 px-0">
        <div class="white z-depth-1 px-3 pt-3 pb-0">
          <ul class="list-unstyled friend-list">
            <li>
            	<div class="row">
            	<div class="col-md-10">
                  <h4 style="display:inline;">Channels</h4>
                </div>
                <div class="col-md-2">
					  <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#exampleModal" data-whatever="@getbootstrap"><strong>+</strong></button>
						<!-- modal -->
						<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
						  <div class="modal-dialog" role="document">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="exampleModalLabel">새 대화 채널 만들기</h5>
						       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						      </div>
						      <div class="modal-body">
						        <form>
						          <div class="form-group">
							          <div class="row">
							          	<div class="col-sm-2">
							          		<label for="channeName" class="col-form-label">채널 이름</label>
							          	</div>
							          	<div class="col-sm-8">
							            	<input type="text" class="form-control" id="channeName">
							            </div>
							          </div>
						          </div>						          
						          <div class="form-group">
						            <label for="message-text" class="col-form-label">대화 상대</label>
						           	<select id="member" name="memeber">
						           		<option>멤버 선택</option>
						           	</select>
						          </div>
						          
						          
						        </form>
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						        <button type="button" class="btn btn-primary">Send message</button>
						      </div>
						    </div>
						  </div>
						</div> 
                </div>
            	</div>
            </li> <br>
            <li>
                 <i class="fab fa-slack-hash"></i>
                  	<span class="chat-room">Design</span>
            </li>
             <li>
                 <i class="fab fa-slack-hash"></i>
                  	<span class="chat-room">IT</span>
            </li>
            <hr>
            <li>
            	<div class="row">
            	<div class="col-md-10">
                  <h4 style="display:inline;">Direct Messages</h4>
                </div>
                <div class="col-md-2"><div>
            	</div>
            </li><br>
            <li>
                 <i class="fas fa-user"></i>
                  	<span>갓경균</span>
            </li>
             <li>
                <i class="fas fa-user"></i>
                  	<span>게다죽</span>
            </li>
          </ul>
        </div>
      </div>
      <!-- Grid column -->

      <!-- Grid column -->
     
      <div class="col-md-6 col-xl-9 pl-md-3 px-lg-auto px-0">
        <div class="chat-message">
		
          <ul class="list-unstyled chat">
            <li class="d-flex justify-content-between mb-4">
            	<div class="row">
            		<div class="col-md-6">
            			<img src="./img/alpaca.jpg" alt="avatar" class="rounded-circle" width="100px;" heigt="100px;">
            		</div>
            		
        			<div class="col-md-6" style="margin-top:20px;">
               			<b style="font-size:40px; text-align:center;">알파카</b>
            		</div>
            	</div>
            </li>
            <hr>
            <br><br>
            <div class="row">
            	<div class="col-md-4">
            		<hr width="70%">
            	</div>
       			<div class="col-md-4">
            		<h3 style="text-align:center;font-size:25px;">오늘 </h3>
            	</div>     
            	<div class="col-md-4">
            		<hr width="70%">
            	</div>
            </div>
            <form id="sendMessage">
				<div style="margin-top:250px;">        
		            <li class="white">
		              <div class="form-group basic-textarea">
		                <textarea class="form-control pl-2 my-0" id="message" rows="3" placeholder="메시지를 입력해주세요"></textarea>
		              </div>
		            </li>
	            </div>
		            	<button type="submit" class="btn btn-dark" style="float:right;">send</button>
	             </ul>
			</form>
        </div>
      </div>
      <!-- Grid column -->

    </div>
    <!-- Grid row -->

  </div>
</div>
      
      
       <c:import url="/common/bottom.jsp"/>
    
   	</div>

   </div>

    <!-- JavaScript files-->
    <script src="./vendor/jquery/jquery.min.js"></script>
    <script src="./vendor/popper.js/umd/popper.min.js"> </script>
    <script src="./vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="./js/grasp_mobile_progress_circle-1.0.0.min.js"></script>
    <script src="./vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="./vendor/chart.js/Chart.min.js"></script>
    <script src="./vendor/jquery-validation/jquery.validate.min.js"></script>
    <script src="./vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
    <script src="./js/charts-home.js"></script>
    <!-- Main File-->
    <script src="./js/front.js"></script>
    <script src="https://kit.fontawesome.com/5d4e7bbd25.js" crossorigin="anonymous"></script>
    
    <!-- socket 연결 -->
    <script src="http://localhost:82/socket.io/socket.io.js"></script>

  <script>
  window.onload = function() {

	  $('#exampleModal').on('show.bs.modal', function (event) {
		  var button = $(event.relatedTarget) // Button that triggered the modal
		  var recipient = button.data('whatever') // Extract info from data-* attributes
		  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
		  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
		  var modal = $(this)
		  modal.find('.modal-title').text('New message to ' + recipient)
		  modal.find('.modal-body input').val()
		})
		
		
	  var socket = io("http://localhost:82");
	  
	  //socket.emit('makeRoom')
	  console.log('소켓 연결 성공');

	  

	      $("#sendMessage").on('submit', function(e){
	    	  var msg = $('#message').val();
	          console.log(msg);
	          socket.emit('send message', msg);
	          $('#message').val("");
	          $("#message").focus();
	          e.preventDefault();

	          
	       })

      /* $('#chat').on('submit', function(e){
    	  var msg = $('#message').val();
          console.log(msg);
          //socket.emit('send message', $('#message').val());
          $('#message').val("");
          $("#message").focus();
          e.preventDefault();
      }); */
      
  }

  
  </script>
    </body>
</html>




