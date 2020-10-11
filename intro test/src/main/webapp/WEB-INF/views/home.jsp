<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
<style type="text/css">
.img_cont img,
.hideme img,
.fadeinleft img,
.slideinleft img {
	width: 100%; 
	transform:scale(1);
}
.hideme
{
    opacity:0;
}
.fadeinleft {
    opacity:0;
    margin-left:-101%;    
    max-width:100%;
}
.slideinleft {
    margin-left:-101%;
    max-width:100%;
}
</style>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d9c368ff4cf37ae1dd9cb56f6a557141&libraries=services"></script>
<script>
$(document).ready(function() {
var imgHeight = $("#id0 img").height();
    /* 1 */
    $(window).scroll( function(){
       	var scrT = $(window).scrollTop();	// 스크롤 탑 
        var txtTop = $("#id00").offset().top;
       	
       	console.log("scrT : ", scrT);
       	console.log("txtTop : ", txtTop);
       	console.log("imgHeight : ", imgHeight);
       	
       	console.log("txtTop - imgHeight : ", (txtTop - imgHeight));
       	console.log("(txtTop - imgHeight) < scrT : ", (txtTop - imgHeight) < scrT);
       	
        $('#id0').each( function(i){
        	var winH =  window.innerHeight; 	// 창크기
        	var divH = $(this).outerHeight();	// div 크기
        	var scrT = $(window).scrollTop();	// 스크롤 탑 
        	var pct = (scrT / divH);
        	
        	var child = $(this).children("img");
        	
//         	console.log("pct : ", pct)
//         	console.log("pct * 12 : ", pct * 12)
        	
        	var v  = 12 - pct * 12;
        	var vx = 1  - pct;
        	var vy = 41 - pct * 41;
        	
// 			console.log("v : ", v);
			if(v <= 1){
				v = 1;
				vx = 0;
				vy = 0;
			}
			
			var chgPoint = (txtTop - imgHeight);
			
// 			if(pct <= 1){
			if(chgPoint > scrT ){// 다음 엘리먼트 - 사진높이 가 스크롤탑 보다 작으면 
        		$(this).css("position", "unset");
        		child.css("position", "fixed");

				$(this).css("margin-top", "0px");
				$(this).css("margin-bottom", "350px");
				
        		child.css("top", "0");
//         		child.css("left", "0");
//         		child.css("padding", "8px");
        		child.css("bottom", "unset");
        		child.css("width", $(this).width());
        		
//         		$("#id0 img").height(imgHeight);
        		child.css("transform", "scale(" + v + ") translateX("+vx+"%) translateY("+vy+"%)");
        	} else {
        		$(this).css("position", "relative");
        		child.css("position", "absolute");
        		
        		$(this).css("margin-top", "350px");
        		$(this).css("margin-bottom", "0");
        		
        		child.css("top", "unset");
//         		child.css("left", "unset");
        		child.css("bottom", "0");
        	}
        });	
    	
    		
        /* 2 */
        $('.hideme').each( function(i){
//         	console.log("hideme");
            var bottom_of_object = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + window.innerHeight;
//             var id = $(this).attr("id");
            
//             console.log("=============id : " + id + "=============");
//             console.log(id + " bottom_of_object : ", bottom_of_object);
//             console.log(id + " bottom_of_window : ", bottom_of_window);
//             console.log(id + " bottom_of_window > bottom_of_object/2 : " + (bottom_of_window > bottom_of_object/2));
            /* 3 */
            if( bottom_of_window > bottom_of_object/2 ){
                $(this).animate({'opacity':'1'},500);
            }
        }); 

        $('.fadeinleft').each( function(i){
//         	console.log("fadeinleft");
            var bottom_of_element = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + window.innerHeight;
//             var id = $(this).attr("id");

//             console.log("=============id : " + id + "=============");
//             console.log(id + " bottom_of_element : ", bottom_of_element);
//             console.log(id + " bottom_of_window : ", bottom_of_window);
//             console.log(id + " bottom_of_window > bottom_of_element : ", (bottom_of_window > bottom_of_element));
            
            if( bottom_of_window > bottom_of_element ){
                $(this).animate({'opacity':'1','margin-left':'0px'},1000);
            }
            
        }); 

        $('.slideinleft').each( function(i){
            var bottom_of_element = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + window.innerHeight;
            
            if( bottom_of_window > bottom_of_element ){
                $(this).animate({'margin-left':'0px'},1000);
            }
        }); 
        
    });

	var pointx = 37.2587574038081;
	var pointy = 127.033619986354;
	var places = new kakao.maps.services.Places();

// 	var callback = function(status, result) {
// 		if (status === kakao.maps.services.Status.OK) {
// 			console.log(result);

// 			pointx = result.places[0].latitude;
// 			pointy = result.places[0].longitude;
// // 		}else{
// // 			pointx='${placePositionX}';
// // 			pointy='${placePositionY}';
// 		}
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				center : new kakao.maps.LatLng(pointx, pointy), // 지도의 중심좌표
				level : 5, // 지도의 확대 레벨
				mapTypeId : kakao.maps.MapTypeId.ROADMAP
			// 지도종류
			};

			// 지도를 생성한다 
			var map = new kakao.maps.Map(mapContainer, mapOption);
			// 지도에 마커를 생성하고 표시한다
			var marker = new kakao.maps.Marker(
					{
						position : new kakao.maps.LatLng(pointx, pointy), // 마커의 좌표
						draggable : false, // 마커를 드래그 가능하도록 설정한다
						map : map
					// 마커를 표시할 지도 객체

					});

			////////////////////////////////////
			// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
			var iwContent = '<div style="padding:5px;">흥섭진주</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
				content : iwContent,
				removable : iwRemoveable
			});

			infowindow.open(map, marker);
			// 마커에 클릭이벤트를 등록합니다
			kakao.maps.event.addListener(marker, 'click', function() {
				// 마커 위에 인포윈도우를 표시합니다
				infowindow.open(map, marker);
			});
			//////////////////////////////////////////////

			// 지도 타입 변경 컨트롤을 생성한다
			var mapTypeControl = new kakao.maps.MapTypeControl();

			// 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
			map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

			// 지도에 확대 축소 컨트롤을 생성한다
			var zoomControl = new kakao.maps.ZoomControl();

			// 지도의 우측에 확대 축소 컨트롤을 추가한다
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

			// 지도 중심 좌표 변화 이벤트를 등록한다
			kakao.maps.event.addListener(map, 'center_changed', function() {
				console.log('지도의 중심 좌표는 ' + map.getCenter().toString()
						+ ' 입니다.');
			});
// 	};
	    
});

</script>
</head>
<body>
<div id="container">
    <div class="img_cont" id="id0" style="height:800px; margin-bottom: 350px;">
		<img alt="aa" src="<%=request.getContextPath()%>/resources/luminar/PGH_0976_57.jpg" style="position:fixed; top:0; transform : scale(12) translateX(4%) translateY(41%)">
    </div>
    <div id="id00">
		<h1>
			흥섭 진주 결혼합니다.
		</h1>
		<P>2021년 3월 28일 오후 1시</P>
		<P>호텔리츠컨벤션 : 경기도 수원시 팔달구 권광로 134번길 46</P>
    </div>
    <div style="text-align: center;">
    	<div id="map" style="width: 80%; height: 80%; display: inline-block;"></div>
	</div>
    <div class="hideme" id="id1">
		<img alt="aa" src="<%=request.getContextPath()%>/resources/luminar/PGH_0005_1.jpg">
    </div> 
    <div class="fadeinleft" id="id2">
		<img alt="aa" src="<%=request.getContextPath()%>/resources/luminar/PGH_0158_10.jpg">
    </div>
    <div class="slideinleft" id="id22">
		<img alt="aa" src="<%=request.getContextPath()%>/resources/luminar/PGH_0712_37.jpg">
    </div>
    <div class="slideinleft" id="id23">
		<img alt="aa" src="<%=request.getContextPath()%>/resources/luminar/PGH_1041_58.jpg">
    </div>
    <div class="fadeinleft" id="id3">
		<img alt="aa" src="<%=request.getContextPath()%>/resources/luminar/PGH_0933_52.jpg">
    </div>
    <div class="hideme" id="id4"> 
		<img alt="aa" src="<%=request.getContextPath()%>/resources/luminar/PGH_0364_20.jpg">
    </div>
</div>

</body>
</html>
