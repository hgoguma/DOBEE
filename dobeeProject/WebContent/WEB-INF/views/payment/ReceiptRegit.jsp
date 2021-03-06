<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="fixed">
<head>


<c:import url="/common/HeadTag.jsp" />
<!--폰트  -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:700&display=swap" rel="stylesheet">
<style>
/* 이미지공간 강제 조정 */
/* img {
	padding: 15px !important;
} */


</style>


<script>
var result = null;
var path = window.location.pathname;
var findCheck = false;
var useDayKey = 0;
var costKey = 0;
                //날짜형태 yyyy-mm-dd 형태로 바꾸는 임의 함수
                Date.prototype.format = function(f) {
                    if (!this.valueOf()) return " ";
                    var weekKorName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
                    var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];
                    var weekEngName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
                    var weekEngShortName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
                    var d = this;
                    return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function($1) {
                        switch ($1) {
                            case "yyyy":
                                return d.getFullYear(); // 년 (4자리)
                            case "yy":
                                return (d.getFullYear() % 1000).zf(2); // 년 (2자리)
                            case "MM":
                                return (d.getMonth() + 1).zf(2); // 월 (2자리)
                            case "dd":
                                return d.getDate().zf(2); // 일 (2자리)
                            case "KS":
                                return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)
                            case "KL":
                                return weekKorName[d.getDay()]; // 요일 (긴 한글)
                            case "ES":
                                return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)
                            case "EL":
                                return weekEngName[d.getDay()]; // 요일 (긴 영어)
                            case "HH":
                                return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)
                            case "hh":
                                return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)
                            case "mm":
                                return d.getMinutes().zf(2); // 분 (2자리)
                            case "ss":
                                return d.getSeconds().zf(2); // 초 (2자리)
                            case "a/p":
                                return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분

                            default:
                                return $1;
                        }
                    });
                };
                String.prototype.string = function(len) {
                    var s = '',
                        i = 0;
                    while (i++ < len) {
                        s += this;
                    }
                    return s;
                };
                String.prototype.zf = function(len) {
                    return "0".string(len - this.length) + this;
                };
                Number.prototype.zf = function(len) {
                    return this.toString().zf(len);
                };


                //문자열에서 숫자만 가져오기
                function fn(str) {
                    var res;
                    res = str.replace(/[^0-9]/g, "");
                    res = res.substring(0, 8);

                    return res;
                }


                //문자열 날짜형태로 바꾸기 함수
                function calculus(str) {
                    var end_ymd = str;
                    var yyyy = end_ymd.substr(0, 4);
                    var mm = end_ymd.substr(4, 2);
                    var dd = end_ymd.substr(6, 2);
                    var com_ymd = new Date(yyyy, mm - 1, dd)
                    var inputdate = com_ymd.format('yyyy-MM-dd'); //임의 함수 써서 포맷팅함

                    return inputdate;
                }


                //영수증 이미지 업로드 함수
                function uploadFile() {
                    var form = $('#FILE_FORM')[0];
                    var formData = new FormData(form);
                    var allPath;
                    var uploadPath;
                    var saveFileName;
                    var checkImg = $("#FILE_TAG")[0].files[0];
                    
                     /*이미지를 업로드하지 않을 경우 업로드 버튼 작동안함 */
                    if(checkImg){
                        console.log("이미지 업로드 되었습니다.");
                    }else{
                       	console.log("이미지가 없습니다.");
                        return;
                    }
                    
                    formData.append("fileObj", $("#FILE_TAG")[0].files[0]);
                    $.ajax({
                        url: 'ajax/receipt/fileUploadAjax.do',
                        processData: false,
                        contentType: false,
                        data: formData,
                        type: 'POST',
                        success: function(result) {
                            // 영수증 파일 업로드 성공시 구글 비전 작동 
                            // 업로드 확인 스윗얼럿창
                        	swal({
                        		   title: "업로드 완료",
                        		   text: "잠시 뒤 구글 비전이 자동으로 입력합니다.",
                        		   icon: "success" //"info,success,warning,error" 중 택1
                        		}).then((YES) => {
                        	});

                            
                            uploadPath = result.uploadPath;
                            saveFileName = result.saveFileName;
                            console.log("uploadPath : " + uploadPath);
                            console.log("saveFileName : " + saveFileName);
                            console.log(saveFileName);
                            allPath = uploadPath + saveFileName;
                            var forder = '/upload/';
                            // var forder = '/dobeeProject/upload/';	AWS ec2 upload 경로
                            var urlPath = forder + saveFileName;
                            $("#uploadImg").html('<img id="imgtag" width="100%" alt="이미지가 보이진 않지만 올라간 상태입니다.">');
                            $("#imgtag").attr("src", urlPath);
                            console.log("이거 이미지 태그에서 src = 요청 주소 : " + urlPath);
                            console.log("이게 이미지 경로 : " + allPath);

                            
                        },
                        complete: function() {
                            console.log("구글 API 시작합니다");
                            $.ajax({
                                    url: 'ajax/googleVision/goGoogleAjax.do',
                                    data: {
                                        "uploadPath": uploadPath,
                                        "saveFileName": saveFileName
                                    },
                                    type: 'POST',
                                    dataType: 'json',
                                    success: function(data) {
                                        console.log(data);
                                        result = data;
                                    	for (var prop in result){
                                            var fcost = result[prop].match("일시불");
                                            if(fcost != null){
                                                costKey = prop;
                                                }
                                           
                                           	var fday = result[prop].match("매]");
                                            if(fday != null){
                                            	useDayKey = prop;
                                         		findCheck=true;
                                            }
                                            // 매]를 찾지 못하면 다시 I구로 찾음
                                            if(findCheck==false){
	                                            fday = result[prop].match("I구");
	                                            if(fday != null){
	                                            	useDayKey = prop;
	                                            	findCheck=true;
	                                            }
	                                            //I구 를 찾지 못 하면 구매로 다시 찾음
	                                            if(findCheck==false){
	                                            	 fday = result[prop].match("구매");
	                                            	 if(fday != null){
														useDayKey = prop;
														findCheck = true;
		                                            	}
		                                        } // 구매 찾기
                                            }//I구 찾기
                                         } // 포문 함수 종료

                                    },
                                    error: function(request,status,error) {
                                        console.log("구글 아작스 요청시 에러");
                                        
                                        //구글 비전 요청시 에러 날 때 
                                      	swal({
                                   		   title: "GoogleVision : 입력 실패",
                                   		   text: "구글 비전 실패.",
                                   		   icon: "error" //"info,success,warning,error" 중 택1
                                   			}).then((YES) => {
                                   		});
                                    },
                                    complete:function (){
                                    	 // 구매와 일시불이 섞인 라인을 찾아서 그 라인의 key 값을 반환
                                       
                                       	setTimeout(function() {
												// 구글 비전으로 받아온 데이터 처리 
										  /* 구매의 '매' 이후의 문자열만 절삭하는 과정 */
											var maeFindIndex = result[useDayKey].indexOf("매");
											var exceptionOther = result[useDayKey].substr(maeFindIndex+2);
	                                       	
											/*  일시불의 같은 라인에서 뒤에서 부터 '/' 을 찾아 절삭하는 과정 */
											var slushIndex = result[costKey].lastIndexOf("/");
											var exceptionStrCost = result[costKey].substr(slushIndex+1);

											
	                                       	/*날짜 처리과정 */
	                                        var temp = fn(exceptionOther);
	                                        var usedate = calculus(temp);

	                                        
	                                        /* 뽑아 낸 텍스트 input tag에 넣기 */ 
	                                        $("#Input2").attr("value", usedate);
	                                        $("#Input3").attr("value", result.key1);
	                                        var usecost = fn(exceptionStrCost);
	                                        $("#Input4").attr("value", usecost);

											// 구글 비전이 할 일을 다하면 보여주는 알림창
	                                      	swal({
	                                  		   title: "GoogleVision : 입력 완료",
	                                  		   text: "다르게 입력된 값이 없는지 확인한 후 등록버튼을 눌러주세요.",
	                                  		   icon: "success" //"info,success,warning,error" 중 택1
	                                  			}).then((YES) => {
	                                  		});   //처리과정 끝 
										}, 1500);   // 딜레이 끝
                                    },
                                }) // 2번째 아작스 끝
                        },  // 업로드 아작스의 컴플릿트 함수 끝
                    }); //업로드 아작스 끝
                }; //uploadFile() 함수 끝 
</script>



            
            
            

</head>
<body>
	<section class="body">

		<!-- start: header -->
		<c:import url="/common/Top.jsp" />
		<!-- end: header -->

		<div class="inner-wrapper">
			<!-- start: sidebar -->
			<c:import url="/common/Side.jsp" />
			<!-- end: sidebar -->

			<!-- start : main Content -->
			<section role="main" class="content-body" style="font-family: 'Nanum Gothic', sans-serif;">
				<header class="page-header">
					<h2>정산 신청</h2>

					<div class="right-wrapper pull-right">
						<ol class="breadcrumbs">
							<li><a href="index.html"> <i class="fa fa-home"></i>
							</a></li>
							<li><span>비용</span></li>
							<li><span>정산 신청</span></li>
							<li style="padding-right:30px;"><a href="#" style="cursor:default;"> <i class="fa fa-chevron-left"></i></a></li>
						</ol>
					</div>
				</header>
				<!-- 작업 여기부터~!~!~!~~! -->
				
				
				<!-- 우측에 영수증파일 업로드 되고 -->
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-6 imgshow">
                            <div id="uploadImg" style="border: 1px solid #2e383f;">
                                <img src="assets/images/receiptmain.jpg" width="100%">
                                <!-- 이미지 없을 때 기본으로 보이는 이미지 -->
                            </div>
                            <!-- 파일 업로드  부분 -->
                            <form id="FILE_FORM" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
                            		<label for="FILE_TAG" class="btn btn-primary">영수증 등록
                                    <input type="file" id="FILE_TAG" name="FILE_TAG" onchange="uploadFile()"  style="display:none !important;" >
                                    </label>
                            </form>
                        </div>


                        <div class="col-lg-6 textshow">
                            <!-- 좌측에 영수증사진에 대한 텍스트  -->
                            <!--  여기에는 사용자가 텍스트 수정해야할 부분은 수정하게 해줘야함 -->
                            <form id="costlistInfo" action="addFinalReceipt.do" method="POST">
                                <div class="form-group">
                                    <label for="exampleFormControlInput1">사원 메일</label>
                                    <input type="text" class="form-control" id="Input1" name='mail' readonly="readonly">
                                </div>
                                <div class="form-group">
				   					 <label for="exampleFormControlInput1">등록일</label>
				    				<input type="date" class="form-control" id="Input0" name='regitReceiptDate' readonly="readonly">
				  				</div>
                                <div class="form-group">
                                    <label for="exampleFormControlSelect1">법인카드</label>
                                    <select class="form-control" name='cardNum' id="Select1">
				    				</select>
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlSelect2">비용 항목</label>
                                    <select class="form-control" name='costCode' id="Select2">
				    				</select>
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlInput1">사용일</label>
                                    <input type="date" class="form-control" id="Input2" name='useDate' placeholder="ex)2020-02-02">
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlInput1">사용처</label>
                                    <input type="text" class="form-control" id="Input3" name='useAt' placeholder="ex)E-MART, 마루가메 제면 (정확한 상호명 입력)">
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlInput1">사용 금액</label>
                                    <input type="text" class="form-control" id="Input4" name='cost' placeholder="ex)2000 (숫자만 입력)">
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlInput1">상세 내용</label>
                                    <input type="text" class="form-control" id="Input5" name='detail' placeholder="ex) 이마트에서 필요한 간식이랑 사무용품들 구매하였습니다.">
                                </div>
                      <!--           <button type="button" onclick="showInput()"> 자 콘솔창을 보자 </button> -->
                      			<br>
                                <button type='submit' class="btn btn-primary" style="width:auto; float:right;">신청</button>
                            </form>
                        </div>
                    </div>
                </div>
				<!-- <a href="javascript:location.href='googleDrivePicker.do'">고 구글 드라이브</a> -->
				<!-- start: page -->




				<!-- end: page -->
				
			</section>
		</div>

	</section>
	
	<c:import url="/common/BottomTag.jsp" />
	
	 <script>
                //영수증 업로드시 이미지 이름 올라가게하는 스크립트
                $(document).ready(function() {
                    $(".custom-file-input").on("change", function() {
                        var fileName = $(this).val().split("\\").pop();
                       /*  $(this).siblings(".custom-file-label").addClass("selected").html(fileName); */
                    });
                });

			
                
    </script>
            
            
    <script>	
              
                    $.ajax({
                        url: 'ajax/receipt/nowEmpEmail.do',
                        type: 'POST',
                        success: function(result) {
                            $("#Input1").attr("value", result);
                        },
                        complete: function() {
                            //법인 카드 목록 불러오기 아작스 실행
                            $.ajax({
                                    url: 'ajax/receipt/cardListtoReceipt.do',
                                    type: 'POST',
                                    success: function(result) {
                                        console.log("법인카드 리스드" + result);
                                        for (let i = 0; i < result.length; i++) {
                                            $("#Select1").append("<option>" + result[i].cardNum + "</option>");
                                        }
                                    },
                                    error: function(request,status,error) {
                                        console.log("법인카드 목록 불러오기 아작스 에러남");
                                    },
                                    complete: function() {
                                        // 비용항목 불러오기 아작스 실행
                                        $.ajax({
                                            url: 'ajax/receipt/debitCodeList.do',
                                            type: 'POST',
                                            success: function(result) {
                                                
                                                for (let i = 0; i < result.length; i++) {
                                                    $("#Select2").append("<option value="+result[i].costCode+ ">" + result[i].entry + "</option>");
                                                }
                                            },
                                            error: function(request,status,error) {
                                                console.log("비용항목 아작스에서 에러남")
                                            },
                                        })
                                    },
                                 
                                }); // 비용 항목 불러오기 아작스 끝
                        }// 컴플릿트 끝
                    }); // 법인 카드 목록 불러오기 아작스끝
</script>        
            
            
            
            
            
            
    <script>
	//등록일 자동으로 현재 그 날 날짜 박아넣기
	//문자열에서 숫자만 가져오기
	function fn1(str){
	    var res;
	    res = str.replace(/[^0-9]/g,"");
	    var y = res.substring(0,4);
	    var m = res.substring(4,5);
	    var rm
	    if(m < 10){
		    rm = "0"+m;
		}
		var d = res.substring(5,8);
		var full = y+rm+d;
		
	    return full;
	}

	//문자열 날짜형태로 바꾸기 함수
	function calculus1(str){    
	    var end_ymd = str;    
	    var yyyy = end_ymd.substr(0,4);
	    var mm = end_ymd.substr(4,2);
	    var dd = end_ymd.substr(6);  
	    var com_ymd = new Date(yyyy,mm-1,dd)
	    var inputdate = com_ymd.format('yyyy-MM-dd');  //임의 함수 써서 포맷팅함
	    
	    return inputdate;
	}
	var today = new Date();
	var date = today.toLocaleDateString('ko-KR');
	var numberDate = fn1(date);
	var regitDate = calculus1(numberDate);
	$("#Input0").attr("value", regitDate);	
	</script>
	
</body>
</html>