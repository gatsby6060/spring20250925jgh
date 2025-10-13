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
                    <li class="dropdown" v-for="item in menuList" >
                        <a href="#" v-if="item.depth == 1" @click ="fnList(item.menuNo, '')" v-model="topkindword"> 
                            {{item.menuName}}
                        </a>
                         <ul class="dropdown-menu" v-if="item.cnt>0">
                            <span v-for="subItem in menuList" >
                                <li v-if="item.menuNo == subItem.menuPart">
                                    <a href="#" @click="fnList('',subItem.menuNo)">{{subItem.menuName}}</a>
                                </li>
                            </span>
                        </ul> 
                    </li>
<!--
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
-->
                </ul>
            </nav>
            <div class="search-bar">
                <input v-model="keyword"  @keyup.enter="fnList" type="text" placeholder="상품을 검색하세요..." >
                <!-- <button @click="fnSearch">검색</button> -->
                <button @click="fnList">검색</button>
            </div>
            <div class="login-btn">
                <button>로그인</button>
            </div>
        </header>

        <main>
            <section class="product-list">
                <!-- 제품 항목 -->
                <div v-for="item in list" class="product-item">
                    <img :src="item.filePath" alt="제품 1">
                    <h3>{{item.foodName}}</h3>
                    <p>{{item.foodInfo}}</p>
                    <p class="price">₩{{item.price.toLocaleString()}}</p>
                </div>
                <!--
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
                -->
            </section>
        </main>
    </div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                list : [],
                keyword : "",
                menuList : [],
                topkindword : "",
            };
        },
        methods: {
            fnList : function (part, menuNo) {
                var self = this;
                var nparmap = {
                    keyword : self.keyword,
                    menuPart : part,
                    menuNo : menuNo
                };
                $.ajax({
                    url: "/product/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                        self.menuList = data.menuList;
                    }
                });
            },
            // fnSearch : function () {
            //     var self = this;
            //     var nparmap = {
            //         keyword: self.keyword,
            //     };
            //     $.ajax({
            //         url: "/product/search.dox",
            //         dataType: "json",
            //         type: "POST",
            //         data: nparmap,
            //         success: function (data) {
            //             console.log(data);
            //             self.list = data.list;
            //         }
            //     });
            // },
            fnTopKind : function () {
                var self = this;
                // alert("프론트 fnTopKind 합수 진입");
                alert("topkindword은"+ self.topkindword);
                var nparmap = {
                    topkindword: self.topkindword,
                };
                $.ajax({
                    url: "/product/TopKindClick.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                    }
                });
            }
        },
        mounted() {
            var self = this;
            self.fnList();
        }
    });
    app.mount('#app');
</script>