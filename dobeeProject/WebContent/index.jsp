<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>DOBEE</title>
	<style type="text/css">
		*{
			margin: 0;
			padding: 0;
			font-family: "montserrat",sans-serif;
		}
		
		body{
			height: 100vh;
			background: linear-gradient(0deg,#ffc107 50%, #fff 0%);
			display: flex;
			justify-content: center;
			align-items: center;
		}
		
		.floating-text{
			text-transform: uppercase;
			font-size: 80px;
			font-weight:900;
			letter-spacing: 6px;
			color: #000;
			transform: translateY(0);
			animation: fl1 3s infinite linear
		}
		
		.floating-text::before{
			content: attr(data-text);
			position: absolute;
			color: #ffffff40;
			clip-path: polygon(0 0,100% 0,100% 50%,0 50%);
			animation: fl2 3s infinite linear
		}
		
		@keyframes fl1{
			30%{
				transform: translateY(10%) rotate(4deg);
			}
			70%{
				transform: translateY(10%) rotate(-4deg);
			}
		}
		@keyframes fl2{
			30%{
				clip-path: polygon(0 0,100% 0,100% 24%,0 56%);
			}
			70%{
				clip-path: polygon(0 0,100% 0,100% 56%,0 24%);
			}
		}
		
		
		
	</style>
	
	<script type="text/javascript">
		
		window.onload = function(){
			console.log("JavaScript Onload!!");
			setTimeout(function() {
				window.location.href = "login.do";
			}, 3000)
		};
	</script>
</head>
<body>
	<div class="floating-text" data-text="DoBee">DoBee</div>
</body>
</html>