<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <title>쇼핑몰 헤더</title>
    <link rel="stylesheet" href="/css/product-style.css">
</head>

<body>
    <div id="app">
        <header>
            <div class="logo">
                <img src="/img/logo.png" alt="쇼핑몰 로고">
            </div>

            <nav>
                <ul>
                    <li class="dropdown">
                        <a href="#">한식</a>
                        <ul class="dropdown-menu">
                            <li><a href="#">비빔밥</a></li>
                            <li><a href="#">김치찌개</a></li>
                            <li><a href="#">불고기</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#">중식</a>
                        <ul class="dropdown-menu">
                            <li><a href="#">짜장면</a></li>
                            <li><a href="#">짬뽕</a></li>
                            <li><a href="#">마파두부</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#">양식</a>
                        <ul class="dropdown-menu">
                            <li><a href="#">피자</a></li>
                            <li><a href="#">파스타</a></li>
                            <li><a href="#">스테이크</a></li>
                        </ul>
                    </li>
                    <li><a href="#">디저트</a></li>
                    <li><a href="#">음료</a></li>
                </ul>
            </nav>
            <div class="search-bar">
                <input type="text" placeholder="상품을 검색하세요...">
                <button>검색</button>
            </div>
            <div class="login-btn">
                <button>로그인</button>
            </div>
        </header>

        <main>
            <section class="product-list">
                <!-- 제품 항목 -->
                <div class="product-item">
                    <img src="/img/image1.jpg" alt="제품 1">
                    <h3>비빔밥</h3>
                    <p>맛있는 한식, 비빔밥!</p>
                    <p class="price">₩9,900</p>
                </div>
                <div class="product-item">
                    <img src="/img/image2.jpg" alt="제품 2">
                    <h3>짜장면</h3>
                    <p>중국의 대표적인 면 요리, 짜장면!</p>
                    <p class="price">₩7,500</p>
                </div>
                <div class="product-item">
                    <img src="/img/image3.jpg" alt="제품 3">
                    <h3>피자</h3>
                    <p>풍부한 치즈가 일품인 피자!</p>
                    <p class="price">₩12,000</p>
                </div>

            </section>
        </main>
    </div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {

            };
        },
        methods: {
            fnLogin() {
                var self = this;
                var nparmap = {};
                $.ajax({
                    url: "login.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);
                    }
                });
            }
        },
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>