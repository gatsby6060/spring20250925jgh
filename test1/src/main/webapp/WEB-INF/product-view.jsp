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
        <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            여기는 product-view.jsp 페이지입니다~~!!
            {{info}}
            {{sessionId}}
            <table id="board">
                <tr>
                    <th>이미지</th>
                    <td>
                        <img :src="info.filePath" width="300" height="300"><br>

                    </td>
                </tr>
                <tr>
                    <th>정보</th>
                    <td>{{info.foodInfo}}</td>
                </tr>
                <tr>
                    <th>음식이름</th>
                    <td>{{info.foodName}}</td>
                </tr>
                <tr>
                    <th>음식고유키값</th>
                    <td>{{info.foodNo}}</td>
                </tr>
                <tr>
                    <th>메뉴번호?</th>
                    <td>{{info.menuNo}}</td>
                </tr>
                <!-- <tr>
                    <th>메뉴의 상위소속</th>
                    <td>{{info.menuPart}}</td>
                </tr> -->
                <tr>
                    <th>가격</th>
                    <td>{{info.price}}</td>
                </tr>
                <tr>
                    <th>개수</th>
                    <td><input v-model="num"></td>
                </tr>
                <tr>
                    <th>주문여부</th>
                    <td>
                        <button @click="fnPayment">주문하기</button>
                    </td>
                </tr>
                <!-- <tr>
                    <th>사용중여부</th>
                    <td>{{info.sellYn}}</td>
                </tr> -->


            </table>

        </div><!--app끝-->
    </body>

    </html>

    <script>
        IMP.init("imp03303441"); // 예: imp00000000
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    sessionId: "${sessionId}",
                    num: 1,

                    foodNo: "${foodNo}", // 하드코딩시... ex) "1"
                    info: "",
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnInfo: function () {
                    let self = this;
                    let param = {
                        foodNo: self.foodNo,
                    };
                    console.log("서버로보내기직전 파람" + JSON.stringify(param));
                    $.ajax({
                        url: "/product/view.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) { //리턴받은것은 여기 data안에 있음

                            // alert(JSON.stringify(data)); //댓글 등록이나 삭제도 시간 나면 ㄱㄱ
                            console.log(data); //요런 형식으로 찍어야 잘보임 얼럿창 보단 이게 나은듯

                            self.info = data.info;
                            // self.commentList = data.commentList;
                            // self.fileList = data.fileList;
                        }
                    });
                },

                fnPayment: function () {
                    let self = this;
                    IMP.request_pay({
                        pg: "html5_inicis",
                        pay_method: "card",
                        merchant_uid: "merchant_" + new Date().getTime(),
                        name: self.info.foodName,  //"테스트 결제",
                        amount: 1, //self.info.price * self.num, // 1,
                        buyer_tel: "010-0000-0000",
                    }, function (rsp) { // callback
                        if (rsp.success) {
                            // 결제 성공 시
                            alert("결제 성공");
                            console.log(rsp);
                            self.fnPayHisory(rsp.imp_uid, rsp.paid_amount);
                        } else {
                            // 결제 실패 시
                            alert("결제 실패");
                        }
                    });
                },

                fnPayHisory(uid, amount){
                    alert("fnPayHis함수 진입");
                    let self = this;
                    let param = {
                        foodNo : self.foodNo,
                        uid : uid,
                        amount : amount,
                        userId: self.sessionId,
                    };
                    console.log("서버에 결제 히스토리 테이블로 인서트 하기 위한 param" + JSON.stringify(param));
                    $.ajax({
                        url: "/product/paymenthi.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) { //리턴받은것은 여기 data안에 있음

                           
                            console.log("최종적으로 서버에서 받은 data" + JSON.stringify(data)); //요런 형식으로 찍어야 잘보임 얼럿창 보단 이게 나은듯
                            if(data.result == "success"){
                                alert("결제 후 히스토리에 인서트 되었습니다.");
                            }else{
                                alert("결제 후 히스토리 저장 실패");
                            }
                            
                        }
                    });
                },

            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnInfo();
            }
        });

        app.mount('#app');
    </script>