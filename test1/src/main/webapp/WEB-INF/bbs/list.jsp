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

            <div>
                <select v-model="searchOption">
                    <option value="all">:: 전체 ::</option>
                    <option value="title">:: 제목 ::</option>
                    <option value="iddd">:: 작성자 ::</option>
                </select>
                <input v-model="keyword">
                <button @click="fnList">검색</button>
            </div>

            <div>
                <select v-model="pageSize" @change="fnList">
                    <option value="3">3개씩</option>
                    <option value="5">5개씩</option>
                    <option value="10">10개씩</option>
                    <option value="20">20개씩</option>
                </select>
            </div>

            여기는 비비에스의 리스트페이지입니다!
            세션상 {{sessionIdddd}}님 환영합니다. !
            <table>
                <tr>
                    <th><input type="checkbox" @click="fnAllCheck()"></th>
                    <th>글번호</th>
                    <th>제목</th>
                    <th>조회수</th>
                    <th>글쓴이</th>
                    <th>작성일</th>
                    <th>수정일</th>

                    <th>삭제</th>
                </tr>
                <tr v-for="(item, index) in list">
                    <td>
                        <!-- {{index}} -->
                        <input type="radio" :value="item.bbsNum" v-model="selectItem">
                    </td>
                    <td>{{item.bbsNum}}</td>
                    <td>
                        <!-- <a href="javascript:;" @click="fnView(item.boardNo)">{{item.title}}</a> -->
                        <span v-if="item.hit >= 25"><a href="javascript:;" @click="fnView(item.bbsNum)"
                                style="color: red;">{{item.title}}</a></span>
                        <span v-else><a href="javascript:;" @click="fnView(item.bbsNum)">{{item.title}}</a></span>
                    </td>
                    <td>{{item.hit}}</td>
                    <td>{{item.userId}}</td>
                    <td>{{item.cdatetime}}</td>
                    <td>{{item.udatetime}}</td>



                    <td>
                        <button v-if="sessionIdddd == item.userId || status =='A'"
                            @click="fnRemove(item.boardNo)">삭제</button>
                    </td>
                </tr>
            </table>
            <div>
                <a v-if="page!=1" @click="fnMove(-1)" href="javascript:;">←</a>
                <a v-if="page>=2" href="javascript:;" @click="fnPage(page-1)">◀</a>
                <a else></a>
                <a @click="fnPage(num)" id="index" href="javascript:;" v-for="num in index">
                    <span :class="{active : page == num}"> {{num}} </span>
                    <!-- <span v-if="num==page" class="active">{{num}}</span>
                        <span v-else>{{num}}</span> -->
                </a>
                <a v-if="page!=index" href="javascript:;" @click="fnPage(page+1)">▶</a>
                <a v-else></a>
                <a v-if="page!=index" @click="fnMove(1)" href="javascript:;">→</a>
            </div>

            <div>
                <a href="add.do"><button>글쓰기</button></a>
            </div>
            <div>
                <button @click="fnCkdAllRemove">삭제</button>
            </div>


        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    sessionIdddd: "${sessionId}",
                    status: "${sessionStatus}",
                    list: [],
                    selectItem: [],


                    pageSize: 5, // 한페이지에 출력할 개수
                    page: 1, //현재페이지
                    index: 0, // 최대 페이지 값

                    searchOption: "all", // 검색옵션 (기본: 전체) title iddd 더 있음
                    keyword: "", //검색어
                };
            },

            methods: {
                // 함수(메소드) - (key : function())
                fnList: function () {
                    let self = this;
                    let param = {
                        pageSize : self.pageSize,
                        page : self.page,
                        index : self.index,
                        searchOption : self.searchOption,
                        keyword: self.keyword, //검색어

                        page: (self.page - 1) * self.pageSize, //이래야 최신글이 잘보임... 없으면 최신글만 리스트에서 조회 안됨
                    };
                    $.ajax({
                        url: "/bbs-list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            // alert("어쩃든 성공" + JSON.stringify(data));
                            // self.list = data.list;
                            console.log(data);
                            self.list = data.list;
                            self.index = Math.ceil(data.cnt / self.pageSize);
                        }
                    });
                },

                fnCkdAllRemove: function () {
                    let self = this;
                    // console.log(self.selectItem);
                    // var fList = JSON.stringify(self.selectItem); //이건 여러게 할떄 떳던것 같음...
                    var fList = self.selectItem; //한개만 보낼때는 이렇게....
                    var param = { selectItem: fList }; //서버쪽에 이름을 selectItem로 넘김

                    $.ajax({
                        url: "/bbs/deleteList.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {

                            alert("성공 체크된것 삭제되었습니다.");
                            self.fnList();

                        }
                    });
                },

                fnView: function (bbsNum) {
                    // console.log(boardNo);
                    alert("상세보기로 bbsNum넘겨줌 " + bbsNum);
                    pageChange("/bbs/view.do", { bbsNum: bbsNum });
                },

                fnPage: function (num) {
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