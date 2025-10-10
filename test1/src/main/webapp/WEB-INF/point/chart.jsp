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

            #index {
                margin-right: 5px;
                text-decoration: none;
            }

            .active {
                color: black;
                font-weight: bold;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            여기는 /point/chart.jsp 파일입니다.
            <div>
                <table>
                    <tr>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>주소</th>
                        <th>성별</th>
                        <th>현재포인트</th>
                        <th>마지막포인트시간</th>
                    </tr>
                    <tr v-for="(item) in list">
                        <td>
                            <a href="javascript:;" @click=""> {{item.userId}} </a>
                        </td>
                        <td>{{item.name}}</td>
                        <td>{{item.address}}</td>
                        <td>{{item.gender}}</td>
                        <td>{{item.aPoint}}</td>
                        <td>{{item.cDate}}</td>

                    </tr>
                </table>
            </div>
        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    list : [],
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnList: function () {
                    let self = this;
                    let param = {};
                    $.ajax({
                        url: "/point/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            // alert(JSON.stringify(data));
                            // console.log(data);
                            self.list = data.list;
                        }
                    });
                }
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnList();
            }
        });

        app.mount('#app');
    </script>