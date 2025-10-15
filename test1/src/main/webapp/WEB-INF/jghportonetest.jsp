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
        <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=jquy82alxa"></script>
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
             <button @click="request_pay">결재하기</button>
        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnList: function () {
                    let self = this;
                    let param = {};
                    $.ajax({
                        url: "",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {

                        }
                    });
                },

                IMP.request_pay(
                    {
                        channelKey: "{콘솔 내 연동 정보의 채널키}",
                        pay_method: "card",
                        merchant_uid: `payment-${crypto.randomUUID()}`, // 주문 고유 번호
                        name: "노르웨이 회전 의자",
                        amount: 64900,
                        buyer_email: "gildong@gmail.com",
                        buyer_name: "홍길동",
                        buyer_tel: "010-4242-4242",
                        buyer_addr: "서울특별시 강남구 신사동",
                        buyer_postcode: "01181",
                    },
                    function (response) {
                        // 결제 종료 시 호출되는 콜백 함수
                        // response.imp_uid 값으로 결제 단건조회 API를 호출하여 결제 결과를 확인하고,
                        // 결제 결과를 처리하는 로직을 작성합니다.
                    },
                );

            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
            }
        });

        app.mount('#app');
    </script>