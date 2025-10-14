<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>카카오맵 + Swiper 통합</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>

        <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=45bdf1dec9fbb56badb6c97f1aa503e8&libraries=services"></script>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
        <script src="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.js"></script>

        <style>
            .map_wrap,
            .map_wrap * {
                margin: 0;
                padding: 0;
                font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
                font-size: 12px;
            }

            .map_wrap {
                position: relative;
                width: 500px;
                /* 지도의 가로 길이에 맞춤 */
                height: 400px;
                /* 지도의 세로 길이에 맞춤 */
                overflow: hidden;
                /* 영역을 벗어나는 요소 처리 */
            }

            #map {
                width: 100%;
                height: 100%;
            }

            /* 💡 Swiper 컨테이너 스타일 추가 및 위치 조정 */
            .swiper-container-wrap {
                position: absolute;
                top: 10px;
                left: 50%;
                transform: translateX(-50%);
                width: 90%;
                /* 지도의 너비에 맞춰 적절히 조정 */
                max-width: 480px;
                /* 최대 너비 설정 */
                z-index: 10;
                /* 지도 요소들보다 상위에 배치 */
                background-color: rgba(255, 255, 255, 0.9);
                padding: 10px 0;
                /* 좌우 패딩은 버튼 때문에 0 */
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            /* 💡 Swiper 슬라이드 스타일 */
            .swiper-slide {
                height: 80px;
                /* 슬라이드 높이 설정 */
                line-height: 80px;
                text-align: center;
                font-size: 16px;
                background: #f0f0f0;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            /* 💡 Swiper 버튼 스타일 */
            .swiper-button-next,
            .swiper-button-prev {
                color: #d95050;
                /* 버튼 색상 변경 */
                top: 50%;
                /* 가운데 정렬 */
                transform: translateY(-50%);
            }

            /* 기존 카테고리 스타일 (z-index를 2로 유지하여 Swiper 아래에 위치) */
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
                /* Swiper(z-index: 10)보다 아래에 위치 */
            }

            /* 이하 기존 스타일 유지 */
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

            /* 인포윈도우 스타일 유지 */
            .placeinfo_wrap {
                position: absolute;
                bottom: 28px;
                left: -150px;
                width: 300px;
            }

            .placeinfo {
                /* ... 기존 스타일 ... */
                position: relative;
                width: 100%;
                border-radius: 6px;
                border: 1px solid #ccc;
                border-bottom: 2px solid #ddd;
                padding-bottom: 10px;
                background: #fff;
            }

            .placeinfo .title {
                /* ... 기존 스타일 ... */
                font-weight: bold;
                font-size: 14px;
                border-radius: 6px 6px 0 0;
                margin: -1px -1px 0 -1px;
                padding: 10px;
                color: #fff;
                background: #d95050;
                background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;
            }

            .placeinfo_wrap .after {
                /* ... 기존 스타일 ... */
            }
        </style>
    </head>

    <body>
        <div id="app">
            여기는 mapjhg2 입니다.

            <div class="map_wrap">
                <div id="map" style="width:100%;height:100%;"></div>



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
            </div>

            <!-- <div class="swiper-container-wrap"> -->
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide">슬라이드 1 : 안녕하세요!</div>
                        <div class="swiper-slide">슬라이드 2 : Vue 3 + Swiper</div>
                        <div class="swiper-slide">슬라이드 3 : 통합 완료! 👍</div>
                        <div class="swiper-slide">슬라이드 4 : 자동 재생 중입니다</div>
                        <div class="swiper-slide">슬라이드 5 : 추가 슬라이드</div>
                    </div>
                    <div class="swiper-pagination"></div>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                </div>
            <!-- </div> -->


        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    // 기존 카카오맵 관련 변수
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
                        center: new kakao.maps.LatLng(37.566826, 126.9786567),
                        level: 5
                    },
                    // 💡 Swiper 관련 변수 추가
                    mySwiper: null,
                };
            },
            methods: {
                // 기존 카카오맵 관련 메소드 유지 (searchPlaces, placesSearchCB, displayPlaces, addMarker, removeMarker, displayPlaceInfo, addCategoryClickEvent, onClickCategory, changeCategoryClass)
                addEventHandle(target, type, callback) {
                    let self = this;
                    if (target.addEventListener) {
                        target.addEventListener(type, callback);
                    } else {
                        target.attachEvent('on' + type, callback);
                    }
                },

                searchPlaces() {
                    let self = this;
                    if (!self.currCategory) {
                        return;
                    }
                    self.placeOverlay.setMap(null);
                    self.removeMarker();
                    self.ps.categorySearch(
                        self.currCategory,
                        self.placesSearchCB.bind(self),
                        { useMapBounds: true }
                    );
                },

                placesSearchCB(data, status) {
                    let self = this;
                    if (status === kakao.maps.services.Status.OK) {
                        self.displayPlaces(data);
                    }
                },

                displayPlaces(places) {
                    let self = this;
                    var order = document.getElementById(self.currCategory).getAttribute('data-order');
                    self.removeMarker(); // 마커를 제거하는 로직이 중복되지만, 안전을 위해 유지

                    for (var i = 0; i < places.length; i++) {
                        var marker = self.addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);

                        (function (marker, place) {
                            kakao.maps.event.addListener(marker, 'click', function () {
                                self.displayPlaceInfo(place);
                            });
                        })(marker, places[i]);
                    }
                },

                addMarker(position, order) {
                    let self = this;
                    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png',
                        imageSize = new kakao.maps.Size(27, 28),
                        imgOptions = {
                            spriteSize: new kakao.maps.Size(72, 208),
                            spriteOrigin: new kakao.maps.Point(46, (order * 36)),
                            offset: new kakao.maps.Point(11, 28)
                        },
                        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                        marker = new kakao.maps.Marker({
                            position: position,
                            image: markerImage
                        });

                    marker.setMap(self.map);
                    self.markers.push(marker);
                    return marker;
                },

                removeMarker() {
                    let self = this;
                    for (var i = 0; i < self.markers.length; i++) {
                        self.markers[i].setMap(null);
                    }
                    self.markers = [];
                },

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

                addCategoryClickEvent() {
                    let self = this;
                    var category = document.getElementById('category'),
                        children = category.children;
                    for (var i = 0; i < children.length; i++) {
                        children[i].onclick = (e) => self.onClickCategory(e.currentTarget);
                    }
                },

                onClickCategory(target) {
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
                        self.changeCategoryClass(target);
                        self.searchPlaces();
                    }
                },

                changeCategoryClass(el) {
                    var category = document.getElementById('category'),
                        children = category.children;

                    for (var i = 0; i < children.length; i++) {
                        children[i].className = '';
                    }

                    if (el) {
                        el.className = 'on';
                    }
                },

                // 💡 Swiper 초기화 함수 추가
                initSwiper() {
                    this.mySwiper = new Swiper('.swiper-container', {
                        // 기본 옵션 설정 (선생님 코드 반영)
                        loop: true, // 반복
                        autoplay: {
                            delay: 2500,
                            disableOnInteraction: false, // 사용자 상호작용 후 자동재생 비활성화 안함
                        },
                        slidesPerView: 3, // 한 번에 3개의 슬라이드 표시
                        spaceBetween: 10, // 슬라이드 간 간격 10px
                        pagination: {
                            el: '.swiper-pagination',
                            clickable: true,
                        },
                        navigation: {
                            nextEl: '.swiper-button-next',
                            prevEl: '.swiper-button-prev',
                        },
                        // 반응형 옵션 예시
                        breakpoints: {
                            640: {
                                slidesPerView: 1,
                            },
                            768: {
                                slidesPerView: 2,
                            },
                            1024: {
                                slidesPerView: 3,
                            }
                        },
                    });
                }

            }, // methods
            mounted() {
                let self = this;

                // 1. 카카오맵 초기화 로직 (기존 코드)
                self.placeOverlay = new kakao.maps.CustomOverlay({ zIndex: 1 });
                self.contentNode = document.createElement('div');
                self.markers = [];
                self.currCategory = '';

                self.mapContainer = document.getElementById('map');
                self.map = new kakao.maps.Map(self.mapContainer, self.mapOption);
                self.ps = new kakao.maps.services.Places(self.map);

                kakao.maps.event.addListener(self.map, 'idle', self.searchPlaces.bind(self)); // 💡 this 바인딩 적용

                self.contentNode.className = 'placeinfo_wrap';
                self.addEventHandle(self.contentNode, 'mousedown', kakao.maps.event.preventMap);
                self.addEventHandle(self.contentNode, 'touchstart', kakao.maps.event.preventMap);
                self.placeOverlay.setContent(self.contentNode);

                self.addCategoryClickEvent();

                // 2. 💡 Swiper 초기화 로직 (Vue DOM 렌더링 후 실행)
                self.$nextTick(() => {
                    self.initSwiper();
                });

            } //mounted
        });

        app.mount('#app');
    </script>