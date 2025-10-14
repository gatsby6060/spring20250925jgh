<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kakao Map & Vue Datepicker 통합</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://unpkg.com/@vuepic/vue-datepicker@latest"></script>
    <link rel="stylesheet" href="https://unpkg.com/@vuepic/vue-datepicker@latest/dist/main.css">

    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=45bdf1dec9fbb56badb6c97f1aa503e8&libraries=services"></script>
    <style>
        /* 기존 스타일은 그대로 유지합니다 */
        .map_wrap,
        .map_wrap * {
            margin: 0;
            padding: 0;
            font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
            font-size: 12px;
        }

        .map_wrap {
            position: relative;
            width: 100%;
            height: 350px;
        }

        #category {
            position: absolute;
            top: 10px;
            left: 10px;
            border-radius: 5px;
            border: 1px solid #909090;
            box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
            background: #fff;
            overflow: hidden;
            z-index: 2;
        }

        #category li {
            float: left;
            list-style: none;
            width: 50px;
            border-right: 1px solid #acacac;
            padding: 6px 0;
            text-align: center;
            cursor: pointer;
        }

        #category li.on {
            background: #eee;
        }

        #category li:hover {
            background: #ffe6e6;
            border-left: 1px solid #acacac;
            margin-left: -1px;
        }

        #category li:last-child {
            margin-right: 0;
            border-right: 0;
        }

        #category li span {
            display: block;
            margin: 0 auto 3px;
            width: 27px;
            height: 28px;
        }

        #category li .category_bg {
            background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;
        }

        #category li .bank {
            background-position: -10px 0;
        }

        #category li .mart {
            background-position: -10px -36px;
        }

        #category li .pharmacy {
            background-position: -10px -72px;
        }

        #category li .oil {
            background-position: -10px -108px;
        }

        #category li .cafe {
            background-position: -10px -144px;
        }

        #category li .store {
            background-position: -10px -180px;
        }

        #category li.on .category_bg {
            background-position-x: -46px;
        }

        .placeinfo_wrap {
            position: absolute;
            bottom: 28px;
            left: -150px;
            width: 300px;
        }

        .placeinfo {
            position: relative;
            width: 100%;
            border-radius: 6px;
            border: 1px solid #ccc;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
            background: #fff;
        }

        .placeinfo:nth-of-type(n) {
            border: 0;
            box-shadow: 0px 1px 2px #888;
        }

        .placeinfo_wrap .after {
            content: '';
            position: relative;
            margin-left: -12px;
            left: 50%;
            width: 22px;
            height: 12px;
            background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
        }

        .placeinfo a,
        .placeinfo a:hover,
        .placeinfo a:active {
            color: #fff;
            text-decoration: none;
        }

        .placeinfo a,
        .placeinfo span {
            display: block;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        }

        .placeinfo span {
            margin: 5px 5px 0 5px;
            cursor: default;
            font-size: 13px;
        }

        .placeinfo .title {
            font-weight: bold;
            font-size: 14px;
            border-radius: 6px 6px 0 0;
            margin: -1px -1px 0 -1px;
            padding: 10px;
            color: #fff;
            background: #d95050;
            background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;
        }

        .placeinfo .tel {
            color: #0f7833;
        }

        .placeinfo .jibun {
            color: #999;
            font-size: 11px;
            margin-top: 0;
        }
    </style>
</head>

<body>
    <div id="app">

        <div id="map" style="width:500px;height:400px;"></div>
        <ul id="category">
            <li id="BK9" data-order="0">
                <span class="category_bg bank"></span>
                은행
            </li>
            <li id="MT1" data-order="1">
                <span class="category_bg mart"></span>
                마트
            </li>
            <li id="PM9" data-order="2">
                <span class="category_bg pharmacy"></span>
                약국
            </li>
            <li id="OL7" data-order="3">
                <span class="category_bg oil"></span>
                주유소
            </li>
            <li id="CE7" data-order="4">
                <span class="category_bg cafe"></span>
                카페
            </li>
            <li id="CS2" data-order="5">
                <span class="category_bg store"></span>
                편의점
            </li>
        </ul>
                
        <h1>Kakao Map & Vue Datepicker</h1>
        <div style="width : 300px; margin-bottom: 20px;">
            <vue-date-picker v-model="date" locale="ko"></vue-date-picker>
            <div>선택한 날짜: **{{ date ? date.toLocaleDateString() : '선택 안 됨' }}**</div>
        </div>
    </div>
</body>

</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 달력 변수 추가
                date: new Date(),

                // 기존 지도 변수
                infowindow: null,
                map: null,
                gCode: "",
                mapContainer: null,
                ps: null,
                category: "",
                markerList: [],
                placeOverlay: new kakao.maps.CustomOverlay({ zIndex: 1 }),
                contentNode: document.createElement('div'),
                markers: [],
                currCategory: '',
                mapOption: {
                    center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                    level: 5 // 지도의 확대 레벨
                },
            };
        },
        // 달력 컴포넌트 등록
        components: {
            VueDatePicker // 달력 컴포넌트를 사용하기 위해 등록
        },
        methods: {
            // 함수(메소드) - (key : function())
            // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
            addEventHandle(target, type, callback) {
                let self = this;
                if (target.addEventListener) {
                    target.addEventListener(type, callback);
                } else {
                    target.attachEvent('on' + type, callback);
                }
            },

            // 카테고리 검색을 요청하는 함수입니다
            searchPlaces() {
                let self = this;
                if (!self.currCategory) {
                    return;
                }

                // 커스텀 오버레이를 숨깁니다 
                self.placeOverlay.setMap(null);

                // 지도에 표시되고 있는 마커를 제거합니다
                self.removeMarker();

                self.ps.categorySearch(
                    self.currCategory,
                    self.placesSearchCB.bind(self), // 💡 this(self)를 바인딩하여 콜백 내부에서 Vue 인스턴스에 접근 가능하게 함
                    { useMapBounds: true }
                );
            },

            // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
            placesSearchCB(data, status, pagination) {
                let self = this;
                if (status === kakao.maps.services.Status.OK) {
                    // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
                    self.displayPlaces(data);
                } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                    // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

                } else if (status === kakao.maps.services.Status.ERROR) {
                    // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요

                }
            },

            // 지도에 마커를 표출하는 함수입니다
            displayPlaces(places) {
                let self = this;

                // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
                var order = document.getElementById(self.currCategory).getAttribute('data-order');

                for (var i = 0; i < places.length; i++) {

                    // 마커를 생성하고 지도에 표시합니다
                    var marker = self.addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);

                    // 마커와 검색결과 항목을 클릭 했을 때
                    // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
                    (function (marker, place) {
                        kakao.maps.event.addListener(marker, 'click', function () {
                            self.displayPlaceInfo(place);
                        });
                    })(marker, places[i]);
                }
            },

            // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
            addMarker(position, order) {
                let self = this;
                var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                    imageSize = new kakao.maps.Size(27, 28), // 마커 이미지의 크기
                    imgOptions = {
                        spriteSize: new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
                        spriteOrigin: new kakao.maps.Point(46, (order * 36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                        offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                    },
                    markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                    marker = new kakao.maps.Marker({
                        position: position, // 마커의 위치
                        image: markerImage
                    });

                marker.setMap(self.map); // 지도 위에 마커를 표출합니다
                self.markers.push(marker);  // 배열에 생성된 마커를 추가합니다

                return marker;
            },

            // 지도 위에 표시되고 있는 마커를 모두 제거합니다
            removeMarker() {
                let self = this;
                for (var i = 0; i < self.markers.length; i++) {
                    self.markers[i].setMap(null);
                }
                self.markers = [];
            },

            // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
            displayPlaceInfo(place) {
                let self = this;
                var content = '<div class="placeinfo">' +
                    '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';

                if (place.road_address_name) {
                    content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
                        '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
                } else {
                    content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
                }

                content += '    <span class="tel">' + place.phone + '</span>' +
                    '</div>' +
                    '<div class="after"></div>';

                self.contentNode.innerHTML = content;
                self.placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
                self.placeOverlay.setMap(self.map);
            },


            // 각 카테고리에 클릭 이벤트를 등록합니다
            addCategoryClickEvent() {
                let self = this;
                var category = document.getElementById('category'),
                    children = category.children;
                for (var i = 0; i < children.length; i++) {
                    children[i].onclick = (e) => self.onClickCategory(e.currentTarget); // e.currentTarget을 명시적으로 전달
                }
            },

            // 카테고리를 클릭했을 때 호출되는 함수입니다
            onClickCategory(target) { // 인자 이름을 target으로 변경하여 명확하게 함
                let self = this;
                const id = target.id;
                const className = target.className;

                self.placeOverlay.setMap(null);

                if (className === 'on') {
                    self.currCategory = '';
                    self.changeCategoryClass();
                    self.removeMarker();
                } else {
                    self.currCategory = id;
                    self.changeCategoryClass(target); // el 인자로 target을 전달
                    self.searchPlaces();
                }
            },

            // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
            changeCategoryClass(el) {
                let self = this;
                var category = document.getElementById('category'),
                    children = category.children,
                    i;

                for (i = 0; i < children.length; i++) {
                    children[i].className = '';
                }

                if (el) {
                    el.className = 'on';
                }
            },


        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;


            // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
            self.placeOverlay = new kakao.maps.CustomOverlay({ zIndex: 1 });
            self.contentNode = document.createElement('div'); // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
            self.markers = []; // 마커를 담을 배열입니다
            self.currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다

            self.mapContainer = document.getElementById('map'); // 지도를 표시할 div 
            self.mapOption = {
                center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                level: 5 // 지도의 확대 레벨
            };

            // 지도를 생성합니다    
            self.map = new kakao.maps.Map(self.mapContainer, self.mapOption);

            // 장소 검색 객체를 생성합니다
            self.ps = new kakao.maps.services.Places(self.map);

            // 지도에 idle 이벤트를 등록합니다
            kakao.maps.event.addListener(self.map, 'idle', self.searchPlaces);

            // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
            self.contentNode.className = 'placeinfo_wrap';

            // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
            // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
            self.addEventHandle(self.contentNode, 'mousedown', kakao.maps.event.preventMap);
            self.addEventHandle(self.contentNode, 'touchstart', kakao.maps.event.preventMap);

            // 커스텀 오버레이 컨텐츠를 설정합니다
            self.placeOverlay.setContent(self.contentNode);

            // 각 카테고리에 클릭 이벤트를 등록합니다
            self.addCategoryClickEvent();
        } //mounted
    });

    app.mount('#app');
</script>