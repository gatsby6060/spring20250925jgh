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
        <script src="/js/page-change.js"></script>
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
            {{sessionId}}님 환영합니다. 멤버목록 페이지입니다!


            <div>

                <div>
                    <select v-model="pageSize" @change="fnList">
                        <option value="3">3개씩</option>
                        <option value="5">5개씩</option>
                        <option value="10">10개씩</option>
                        <!-- <option value="20">20개씩</option> -->
                    </select>
                </div>

                <table>
                    <tr>

                        <th>아이디</th>
                        <th>이름</th>
                        <th>닉네임</th>
                        <th>생년월일</th>
                        <th>성별</th>
                        <th>해제</th>

                    </tr>
                    <tr v-for="(item, index) in list">
                        <td>
                            <a href="javascript:;" @click="fnView(item.userId)"> {{item.userId}} </a>
                        </td>
                        <td>
                            {{item.name}}
                        </td>
                        <td>{{item.nickName}}</td>
                        <td>{{item.cBirth}}</td>
                        <td>{{item.gender}}</td>
                        <td><button @click="fnRemoveCnt(item.userId)" v-if="item.cnt >=5">정지해제</button></td>

                    </tr>
                </table>
                <!-- <div>
                    <a v-if="page!=1" @click="fnMove(-1)" href="javascript:;">←</a>
                    <a v-if="page>=2" href="javascript:;" @click="fnPage(page-1)">◀</a>
                    <a else></a>
                    <a @click="fnPage(num)" id="index" href="javascript:;" v-for="num in index">
                        <span :class="{active : page == num}">{{num}}</span>
                    </a>
                    <a v-if="page!=index" href="javascript:;" @click="fnPage(page+1)">▶</a>
                    <a v-else></a>
                    <a v-if="page!=index" @click="fnMove(1)" href="javascript:;">→</a>
                </div> -->
            </div>
            <!-- <div>
                <button @click="fnAllRemove">삭제</button>
            </div> -->
            <!-- <div>
                <a href="board-add.do"><button>글쓰기</button></a>
            </div> -->

            <div>
                <!-- <a v-if="page!=1" @click="fnMove(-1)" href="javascript:;">←</a> -->
                <a v-if="page>=2" href="javascript:;" @click="fnMove(page-1)">◀</a>
                <a else></a>

                <a @click="fnMove(num)" id="index" href="javascript:;" v-for="num in index">
                    <span :class="{active : page == num}"> {{num}} </span>
                    <!-- <span v-if="num==page" class="active">{{num}}</span>
                        <span v-else>{{num}}</span> -->
                </a>

                <a v-if="page!=index" href="javascript:;" @click="fnMove(page+1)">▶</a>
                <a v-else></a>
                <!-- <a v-if="page!=index" @click="fnMove(1)" href="javascript:;">→</a> -->
            </div>

        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    sessionId: "${sessionId}",

                    list: [],
                    userId: "",

                    // selectItem: "",  //라디오버튼 클릭시 값 들어옴

                    pageSize: 5, // 한페이지에 출력할 개수 기본 5개씩...
                    page: 1, //현재페이지 ex)12345678
                    index: 0, // 최대 페이지 값 ex)8

                    searchOption: "all", // 검색옵션 (기본: 전체) title iddd 더 있음
                    keyword: "", //검색어

                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnList: function () {
                    let self = this;
                    let param = {
                        pageSize: self.pageSize,
                        page: self.page,
                        index: self.index,
                        searchOption: self.searchOption,
                        keyword: self.keyword, //검색어

                        page: (self.page - 1) * self.pageSize,
                    };
                    $.ajax({
                        url: "/mgr/member/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            // alert("회원들 리스트 받기 성공같아요");
                            // alert(JSON.stringify(data));
                            // console.log(data);
                            // self.list = data.list;
                            if (data.result == "success") {
                                // alert("회원들 리스트 받기 성공같아요");
                                console.log(data);
                                self.list = data.list;
                                self.index = Math.ceil(data.cnt / self.pageSize);
                            }

                        }
                    });
                },

                fnRemoveCnt: function (userId) {
                    let self = this;
                    let param = {
                        id: userId //먼저 만들어놓은 xml이 id로 했음 //들어온 파라미터 바로 씀self.은 아님
                    };
                    $.ajax({
                        url: "/mgr/remove-cnt.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            // alert(JSON.stringify(data));
                            // console.log(data.list);
                            // self.list = data.list;
                            if (data.result == "success") {
                                alert("계정 정지가 해제되었습니다.");
                                self.fnList();
                            } else {
                                alert("오류가 발생했습니다.");
                            }
                        }
                    });
                },
                fnView: function (userId) {
                    // /mgr/member/view.do로 이동
                    pageChange("/mgr/member/view.do", { userId: userId });
                },
                fnMove: function (num) { //내가 누른 숫자 num
                    let self = this;
                    // alert("페이징 숫자 클릭됨 " + num);
                    self.page = num;
                    self.fnList();
                },


            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnList();
            }
        });

        app.mount('#app');
    </script>