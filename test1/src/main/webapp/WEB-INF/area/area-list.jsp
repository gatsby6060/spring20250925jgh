<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <style>
            table,
            tr,
            td,
            th {
                border: 1px solid black;
                border-collapse: collapse;
                padding: 5px 10px;
                text-align: center;
            }

            th {
                background-color: beige;
            }

            tr:nth-child(even) {
                background-color: azure;
            }

            .index {
                margin-right: 10px;
                text-decoration: none;
                color : black
            }

            .active {
                color: red;
                font-weight: bold;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
             <div>
                도/특별시 : 
                <select v-model="si" @change="fnList">
                    <option value="">:: 전체 ::</option>
                    <option :value="item.si" v-for="item in siList">{{item.si}}</option>
                </select>
             </div>
            <table>
                <tr>
                    <th>도/특별시</th>
                    <th>구</th>
                    <th>동</th>
                    <th>nx</th>
                    <th>yx</th>

                </tr>

                <tr v-for="item in list">
                    <td>{{item.si}}</td>
                    <td>{{item.gu}}</td>
                    <td>{{item.dong}}</td>
                    <td>{{item.nx}}</td>
                    <td>{{item.ny}}</td>
                </tr>
            </table>
            <div>
                <a v-if="page!=1" @click="fnMove(-1)" href="javascript:;">←</a>
                <a v-if="page>=2" href="javascript:;" @click="fnPage(page-1)">◀</a>
                <!-- <a else></a> -->
               
              
                <a @click="fnPage(num)" class="index" href="javascript:;" v-for="num in index">
                    <span :class="{active : page == num}">{{num}}</span>
                    <!-- <span v-if="num==page" class="active">{{num}}</span>
                        <span v-else>{{num}}</span> -->
                </a>
                

                <!-- <div>
                <a @click="fnPage(num)" class="index" href="javascript:;" v-for="num in perTenCnt">
                <span :class="{active : page == num}">{{num}}</span>
                </a>
                </div> -->
                
                <a v-if="page!=index" href="javascript:;" @click="fnPage(page+1)">▶</a>
                <!-- <a v-else></a> -->
                <a v-if="page!=index" @click="fnMove(1)" href="javascript:;">→</a>
            </div>


        </div> <!--앱끝-->
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    list: [],

                    pageSize: 20, // 한페이지에 출력할 개수
                    page: 1, //현재페이지
                    index: 0, // 최대 페이지 값
                    perTenCnt : [], // 한번에 보여줄때 총 몇개의 페이징 숫자를 보여줄지 결정
                    siList : [],

                    si : "", //선택한 시
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnList: function () {
                    let self = this;
                    let param = {
                        pageSize: self.pageSize,
                        page: (self.page - 1) * self.pageSize,
                        
                        si : self.si, //self.si는 위에 있는 변수 si다 그 앞에는 서버에 '키'로 전달할때 쓰는 si다
                    };
                    // alert("여기서 얼럿이 가능?" + si); //불가능
                    $.ajax({
                        url: "/area/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            // console.log("성공했으면 뭐라도 받았겠지");
                            console.log(data);
                            self.list = data.list;
                            // alert("이거 3559나와야함" + data.cnt );
                            // alert("이거 20나와야함" + self.pageSize );
                            self.index = Math.ceil(data.cnt / self.pageSize);
                            // alert("이거 178나와야함" + self.index );
                            perTenCnt = [10,11,12,13,14,15,16,17,18,19,20]; //일단 뭐 하드코딩...
                        }
                    });
                },
                fnPage: function (num) {
                    let self = this;
                    // alert("페이징 숫자 클릭됨 " + num);
                    self.page = num;
                    self.fnList();
                },
                fnMove: function (num) {
                    let self = this;
                    self.page += num;
                    self.fnList();
                },
                fnSiList: function () {
                    let self = this;
                    let param = {
                    };
                    $.ajax({
                        url: "/area/si.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            // console.log("성공했으면 뭐라도 받았겠지");
                            console.log(data);
                            self.siList = data.list;
               
                        }
                    });
                },
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnList();
                self.fnSiList();
            }
        });

        app.mount('#app');
    </script>