<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--<script type="text/javascript" src="/js/cw/jquery-ui.js"></script>--%>
<link rel="stylesheet" href="/css/cw/workspace/icono.min.css" />
<link rel="stylesheet" href="/css/cw/workspace-new.css?v=<%=System.currentTimeMillis() %>" />
<link rel="stylesheet" href="/css/cw/cw-prj-workspace.css?v=<%=System.currentTimeMillis() %>" />
<link rel="stylesheet" href="/css/toastr.min.css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet"> <!-- 나눔고딕 대신 noto sans -->


<style>
#kaist5-container {
    /*min-width: 1944px;*/
    min-width: 2444px;
    width: 1416px;
    margin: 0 auto;
    display: flex;
}

#kaist5-text-wrapper {
    min-width: 680px;
    margin: 0px 8px 0px 0px;
    padding: 16px 20px;
    border: 1px solid #f0f0f7;
    border-radius: 4px;
    height: 960px;
    font-size: 16px;
    line-height: 1.5;
    word-break: keep-all;
    /*height: 900px;*/
    overflow-y: scroll;
}

#kaist5-text-edit-wrapper {
    min-width: 450px;
    margin: 0px 0px 0px 0px;
    padding: 16px 20px;
    border: 1px solid #f0f0f7;
    border-radius: 4px;
    height: 900px;
    overflow-y: scroll;
}

#kaist5-text-edit-section1 {

}

#kaist5-text-edit-section2 {
    position: relative;
}

.group-data {
    position: relative;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

#kaist5-text-edit-wrapper div h5 {
    margin: 0px 0px 8px 0px;
}

#kaist5-text-edit-wrapper p#select-text {
    background-color: #f0f0f7;
    padding: 8px;
    min-height: 35px;
    border-radius: 4px;
    margin: 0px 0px 12px 0px;
}

#kaist5-groups,
#kaist5-groups2 {
    min-width: 420px;
    border: 1px solid #f0f0f7;
    margin: 0px 8px 0px 0px;
    height: 900px;
    /*overflow-y: scroll;*/
}

#kaist5-groups .text_edit_button {
    cursor: pointer;
}

#kaist5-groups .text_edit_button:hover,
#kaist5-groups .remove_group_button:hover,
#kaist5-groups .edit_group_button:hover,
#kaist5-groups .preview_group_button:hover {
    background-color: #cacbcd;
}

#kaist5-groups .edit_group_button[data-type="item"] {
    position: absolute;
    top: 38px;
    left: 14px;
    font-size: 12px;
}

#kaist5-groups .text_edit_button[data-type="item"] {
    position: absolute;
    top: 38px;
    right: 14px;
    margin: 0px !important;
}

#kaist5-groups .remove_group_button[data-type="item"] {
    position: absolute;
    top: 38px;
    right: 50px;
}

#kaist5-groups .preview_group_button[data-type="group"] {
    position: absolute;
    top: 38px;
    left: 82px;
}

#kaist5-group-list-1 .preview_group_button[data-type="group"],
#kaist5-group-list-2 .preview_group_button[data-type="group"] {
    position: absolute;
    top: 12px;
    right: 10px;
}

.kaist5-text-edit-section2-wrapper {
    background-color: rgba(0,0,0,0.5);
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0px;
    left: 0px;
    border-radius: 3px;
}

p.item {
    margin: 0px 0px 8px 0px;
}

/*p.item::before {*/
/*    content: "- ";*/
/*    !*margin-left: 12.5px;*!*/
/*}*/

span.kaist-sentence-word:hover {
    /*background: #e7ffd7;*/
    border-radius: 3px;
    /*font-weight: 700;*/
    text-decoration: underline;
    /*font-style: italic;*/
}

span.kaist-sentence-word.selected {
    /*background-color: #b5f9b8;*/
    border-radius: 3px;
    /*font-weight: 700;*/
    text-decoration: underline;
}

span.kaist-sentence-word.preview {
    /*background-color: #f9bcee;*/
    border-radius: 3px;
    /*border: 1px dashed #f934b7;*/
    font-weight: 900;
    color: #E91E63;
}

span.kaist-sentence-word.preview-item {
    /*background-color: #f9d7f3;*/
    border-radius: 3px;
    font-weight: 900;
    color: #E91E63;
}

span.kaist-sentence-word.preview_1 {
    background-color: rgba(100,53,201,0.3);
    border-radius: 3px;
    /*border: 3px dashed rgba(100,53,201,0.5);*/
}

span.kaist-sentence-word.preview-item_1 {
    background-color: rgba(100,53,201,0.3);
    border-radius: 3px;
    /*border: 2px dashed rgba(100,53,201,0.5);*/
}

span.kaist-sentence-word.preview_2 {
    /*background-color: #f9bcee;*/
    border-radius: 3px;
    border: 3px dashed rgba(100,53,201,0.7);
}

span.kaist-sentence-word.preview-item_2 {
    /*background-color: #f9d7f3;*/
    border-radius: 3px;
    border: 3px dashed rgba(100,53,201,0.7);
}

.preview_group_active {
    background-color: #E91E63 !important;
    color: #fff !important;
}

.preview_group_active_1 {
    background-color: #6435c9 !important;
    color: #fff !important;
}

.preview_group_active_2 {
    background-color: #6435c9 !important;
    color: #fff !important;
}

.preview_item_active {
    color: #E91E63 !important;
}

.preview_item_active_1 {
    color: #6435c9 !important;
}

.preview_item_active_2 {
    color: #6435c9 !important;
}

/* f2711c */

.add_memo,
.edit_item_button,
.remove_item_button {
    /*background-color: #cacbcd;*/
    cursor: pointer;
}

.add_memo:hover,
.edit_item_button:hover,
.remove_item_button:hover {
    color: #0b0b0b;
    font-weight: 500;
}

.hide {
    display: none !important;
}

.content-item-wrapper {
    display: flex;
    justify-content: space-between;
}

.cw_comment {
    background-color: #f0f0f7;
    padding: 8px;
    min-height: 35px;
    border-radius: 4px;
    margin: 0px 0px 12px 0px;
}

.checked {
    background-color: #4CAF50 !important;
}

</style>
<!-- Loader -->
<div class="ui dimmer" id="dimmer">
    <div class="ui massive text loader">
        <h3>Loading</h3>
    </div>
</div>
<div id="cw-workspace" class="new-workspace">

    <div class="one-line-notice marquee" style="display:none;">
        <p id="one-line-text"></p>
    </div>

    <div class="new-con">
        <!-- ##### header ##### -->
        <div class="prj_renov prj_header">
            <div class="inner_header">
                <div class="wrap_header">
                    <h1 class="tit_prj">${prjNm}</h1>
                    <p class="txt_info">${prjDesc}</p>
                </div>
                <div class="wrap_btn">
                    <strong class="tit_complete">
                        <c:if test="${pageType eq 'work'}">작업완료: </c:if>
                        <c:if test="${pageType eq 'check'}">검수완료: </c:if>
                        <span id="taskNum" class="txt_tasknum">0</span>건
                    </strong>

                    <a href="#" class="btn_g bg_nuetral link_goguide cw-guide">
                        <span class="ico_cw ico_exclamation"></span>작업가이드
                    </a>

                    <c:if test="${pageType eq 'check'}">
                        <a href="#" class="btn_g bg_nuetral link_goinspection cw-guide">
                            <span class="ico_cw ico_exclamation"></span>검수가이드
                        </a>
                    </c:if>

                    <c:if test="${faqUrl ne '' && faqUrl ne null}">
                        <a href="${faqUrl}" class="btn_g bg_warning link_gofaq" target="_blank">
                            <span class="ico_cw ico_exclamation2"></span>작업수행 FAQ
                        </a>
                    </c:if>

                    <a href="#" id="inquiry" class="btn_g bg_warning link_goinquiry">
                        <span class="ico_cw ico_question"></span>문의하기
                    </a>
                </div>
            </div>
        </div>
        <!-- ##### header ##### -->


        <c:if test="${pageType eq 'work'}">
            <!-- ######################### 자가진단 START ############################## -->
            <div class="self-test-row" style="display:none;">
                <div class="ui segment center">
                    <strong>${cwMember.nickname}</strong>님 자가진단 (<span id="guide_item_no"></span>/<span id="guide_max_no"></span>)
                </div>

                <h2 class="ui header">
                    <i class="question icon"></i>
                    <div class="content">
                        보기 및 문제
                    </div>
                </h2>

                <div class="self-test-space">
                    <div class="column">
                        <div class="ui raised segment">
                            <a class="ui red ribbon label">보기</a>
                            <div class="self-test-text ui message">

                            </div>
                            <a class="ui blue ribbon label">문제</a>
                            <div class="self-test-question ui success message">

                            </div>
                        </div>
                    </div>

                    <h2 class="ui header">
                        <i class="pencil alternate icon"></i>
                        <div class="content">
                            정답
                        </div>
                    </h2>
                    <div class="ui segment self-test-answers">

                    </div>
                </div>

                <div class="ui bottom attached warning message">
                    <i class="warning icon"></i>
                    자가진단 미통과 시에는 해당 작업을 참여하지 못합니다.
                </div>
            </div>

            <%--<div class="sel_btn" data-value="O">O</div><div class="sel_btn" data-value="X">X</div>--%>
            <%--<span class="write">주관식 : </span><input type="text" style="width: 50%;font-size: 1em;padding: 0.5em;border: 1px solid #aaa;" class="write" id="answer_write"/>--%>


            <!-- ######################## 자가진단 END ############################### -->
        </c:if>

        <!-- 작업 영역 -->
<%--        <div class="ui work-row" style="overflow-x: scroll;">--%>
        <div class="ui work-row">
            <!-- ######################### WORK SPACE ############################ -->

            <section id="kaist5-container">
                <%-- 상호참조해결집합 --%>
                <div id="kaist5-groups2" class="ui segment">
<%--                    <div>--%>
<%--                        <button class="fluid ui button text_edit_button" style="margin: 0px 0px 28px 0px;" data-type="group">상호참조해결집합 추가</button>--%>
<%--                    </div>--%>
<%--                    <div style="overflow-y:scroll;height:800px;padding:1px;">--%>
<%--                        <div id="kaist5-group-list" class="ui styled accordion"></div>--%>
<%--                    </div>--%>
<%--                    <div>--%>
<%--                        <button class="fluid ui button text_edit_button" style="margin: 0px 0px 28px 0px;" data-type="group">상호참조해결집합 추가</button>--%>
<%--                    </div>--%>
<%--                    <div class="ui top attached tabular menu">--%>
<%--&lt;%&ndash;                      <a class="active item" data-tab="first">결과데이터</a>&ndash;%&gt;--%>
<%--                      <a class="item" data-tab="first">작업 1</a>--%>
<%--                      <a class="item" data-tab="second">작업 2</a>--%>
<%--                    </div>--%>
<%--&lt;%&ndash;                    <div class="ui bottom attached active tab segment" data-tab="first">&ndash;%&gt;--%>
<%--&lt;%&ndash;                      <div style="overflow-y: scroll; height: 732px; padding: 1px; border-top: 1px solid rgba(34,36,38,.15); border-radius: 4px; border-bottom: 1px solid rgba(34,36,38,.15);">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <div id="kaist5-group-list" class="ui styled accordion"></div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                      </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </div>&ndash;%&gt;--%>
<%--                    <div class="ui bottom attached tab segment" data-tab="first">--%>
<%--                        <div style="overflow-y: scroll; height: 792px; padding: 1px; border: 1px solid rgba(34,36,38,.15); border-radius: 4px;">--%>
<%--                            <div id="kaist5-group-list-1" class="ui styled accordion"></div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="ui bottom attached tab segment" data-tab="second">--%>
<%--                        <div style="overflow-y: scroll; height: 792px; padding: 1px; border: 1px solid rgba(34,36,38,.15); border-radius: 4px;">--%>
<%--                            <div id="kaist5-group-list-2" class="ui styled accordion"></div>--%>
<%--                        </div>--%>
<%--                    </div>--%>

                    <div style="display: flex;"><h5 style="padding: 12px;">작업 1</h5> <div style="width: 50px;height:20px;background-color: rgba(100,53,201,0.3);margin-top:11px;"></div></div>
                    <div style="overflow-y: scroll; height: 817px; padding: 1px; border: 1px solid rgba(34,36,38,.15); border-radius: 4px; margin-bottom: 10px;">
                        <div id="kaist5-group-list-1" class="ui styled accordion"></div>
                    </div>
<%--                    <div><h5 style="padding: 12px;">작업 2</h5></div>--%>
<%--                    <div style="overflow-y: scroll; height: 817px; padding: 1px; border: 1px solid rgba(34,36,38,.15); border-radius: 4px;">--%>
<%--                        <div id="kaist5-group-list-2" class="ui styled accordion"></div>--%>
<%--                    </div>--%>

                </div>

                <%-- 상호참조해결집합 --%>
                <div id="kaist5-groups2" class="ui segment">
                    <div style="display: flex;"><h5 style="padding: 12px;">작업 2</h5> <div style="width: 50px;height:20px;border: 3px dashed rgba(100,53,201,0.3);rgba(100,53,201,0.3);margin-top:12px;"></div></div>
                    <div style="overflow-y: scroll; height: 817px; padding: 1px; border: 1px solid rgba(34,36,38,.15); border-radius: 4px;">
                        <div id="kaist5-group-list-2" class="ui styled accordion"></div>
                    </div>
                </div>

                <%-- 문서 텍스트 영역 (문어/구어) --%>
                <div id="kaist5-text-wrapper" class="ui segment">
                    <div id="kaist-sentence"></div>
                </div>

                <%-- 상호참조해결집합 --%>
                <div id="kaist5-groups" class="ui segment">
                    <div>
                        <button class="fluid ui button text_edit_button" style="margin: 0px 0px 28px 0px;" data-type="group">상호참조해결집합 추가</button>
                    </div>
                    <div style="overflow-y: scroll; height: 800px; padding: 1px; border: 1px solid rgba(34,36,38,.15); border-radius: 4px;">
                        <div id="kaist5-group-list" class="ui styled accordion"></div>
                    </div>
                </div>

                <%-- 데이터 편집 --%>
                <div id="kaist5-text-edit-wrapper" class="ui segment">

                    <div id="kaist5-text-edit-section1" class="ui segment">
                        <h5>선택 어절</h5>
                        <p id="select-text"></p>
                    </div>

                    <div id="kaist5-text-edit-section2" class="ui segment" style="position: relative;">

                        <div class="kaist5-text-edit-section2-wrapper hide">
                            <div style="display: flex;align-items: center;justify-content: center; height: 100%;">
                                <%--                                <p id="rework-text-edit"></p>--%>
                            </div>
                        </div>

                        <div style="display:flex;justify-content: space-between;">
                            <h5 style="margin: 4px 0px 0px 0px;">형태소 분절</h5>
                            <button class="mini ui button" id="init-work">선택 취소</button>
                        </div>
                        <!-- <button class="tiny ui button" id="text_edit_button">데이터 편집</button> -->
                        <table class="ui celled table">
                            <thead>
                                <tr>
                                    <th>형태소 분절 결과</th>
                                    <th>데이터 편집 포함 여부</th>
                                </tr>
                            </thead>
                            <tbody id="kaist5-morp-table"></tbody>
                        </table>

                    </div>


                    <div id="kaist5-text-edit-section3" class="ui segment">
                        <div style="display:flex;justify-content: space-between;">
                            <h5 style="margin: 4px 0px 0px 0px;">데이터 편집</h5>
                            <button class="mini ui button hide" id="rework-text-edit">데이터 편집 취소</button>
                        </div>
                        <div id="group-data-list" style="margin: 1em 0px 0px 0px;">

                        </div>
                    </div>

                </div>




            </section>

            <!-- ######################### WORK SPACE ############################ -->


            <!-- 모니터링 페이지 영역 -->
            <c:if test="${pageType eq 'monitoring'}">
                <%--모니터링 페이지에서 최종 결과데이터 수정 시 사용--%>
                <%--<div id="monitoring-area" class="ui form hideDiv">
                    <div class="field">
                        <label style="font-size:1em;">※ 작업수정 사유</label>
                        <textarea id='updat-reason' rows="2"></textarea>
                    </div>
                </div>--%>

                <!-- 모니터링 페이지 추가부분 Start -->
                <div id="workingList" class="ui right very wide sidebar">
                    <table class="ui selectable single line blue table">
                        <thead>
                        <tr>
                            <th class='center aligned five wide'>dataID</th>
                            <th class='center aligned four wide'>상태</th>
                            <th class='center aligned four wide'>작업자</th>
                            <th class='center aligned four wide'>작업완료시간</th>
                            <th class='center aligned four wide'>검수자</th>
                            <th class='center aligned four wide'>검수완료시간</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>

                    <div class="ui labeled input work_status_filter">
                        <div class="ui label">
                            <i class="filter icon"></i>상태
                        </div>
                        <select id="select_work_status_type">
                            <option value="">전체</option>
                            <option value="WORK_END">작업완료</option>
                            <option value="PROBLEM_Y">작업불가</option>
                            <option value="CHECK_END">검수완료</option>
                            <option value="CHECK_REJECT">반려</option>
                            <option value="ALL_FINISHED">종료</option>
                            <option value="CHECK_REWORK">재작업</option>
                            <option value="CHECK_ING">검수중</option>
                        </select>
                    </div>

                    <div class="ui pagination menu">
                        <a class="icon item page_btn" id="page_ppre" pageNo="1">
                            <i class="angle double left icon"></i>
                        </a>
                        <a class="icon item page_btn" id="page_pre" pageNo="">
                            <i class="angle left icon"></i>
                        </a>
                        <!-- 페이지 넘버링 -->
                        <a class="icon item page_btn" id="page_nxt" pageNo="">
                            <i class="angle right icon"></i>
                        </a>
                        <a class="icon item page_btn" id="page_last" pageNo="">
                            <i class="angle double right icon"></i>
                        </a>
                    </div>

                    <button id="btnClosedWorkList" class="ui blue basic button">닫기</button>
                </div>
                <div class="pusher"></div>

            </c:if>
            <!-- 모니터링 페이지 추가부분 End -->

            <!-- 작업반려 메시지  -->
            <c:if test="${pageType eq 'work'}">
                <div id="reject-area" class="ui form">
                    <div class="field">
                        <label style="font-size:1em;">※ 작업반려사유</label>
                        <textarea id='reject-reason' rows="2" readonly="readonly"></textarea>
                    </div>
                </div>
                <div id="checkRejectMsg" style="margin-top:20px;"></div>
            </c:if>

            <!-- 검수자 확인 영역 -->
            <c:if test="${pageType eq 'check' || pageType eq 'monitoring'}">
                <div id="checkingArea" class="ui form">
                    <div class="three fields">
                        <div class="field">
                            <label style="font-size:1em;">작업자 정보</label>
                            <textarea id="worker_info" rows="3" readonly="readonly"></textarea>
                        </div>
                        <div class="field">
                            <label style="font-size:1em;">※ 작업불가사유</label>
                            <textarea id="problem-reason" class="problemReasonStr" rows="3" readonly="readonly"></textarea>
                        </div>
                        <div class="field">
                            <label style="font-size:1em;">※ 작업반려사유</label>
                            <select id="select-reject-reason" disabled>
                                <option value="">직접 작성</option>
                            </select>
                            <textarea class="rejectReasonStr" rows="3"></textarea>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${pageType eq 'work'}">
                <div id="workingArea" class="ui form">
                    <div class="field rejectArea">
                        <label style="font-size:1em;">※ 작업반려사유</label>
                        <textarea class="rejectReasonStr" rows="3"></textarea>
                    </div>
                </div>
            </c:if>
        </div>
        <!-- ######################## BUTTONS START ############################### -->
        <div class="ui bottom-button-row grid row">
            <div class="ui wide column text-right btn-group"
                 data-work-buttons='["tempSave","next","disable"]'
                 data-check-buttons='["end","reject","delete","pre","refresh"]'
                 data-monitor-buttons='["workList"]'>
            </div>
        </div>
        <!-- ######################## BUTTONS END ############################### -->

    </div>
</div>

<!-- 기초 타입 -->
<input type="hidden" name="projectId" id="projectId" value="${projectId}">
<input type="hidden" name="taskId" id="taskId" value="${taskId}">
<input type="hidden" name="dataId" id="dataId" value="${dataId}">
<input type="hidden" name="srcId" id="srcId" value="${srcId}">
<input type="hidden" name="workUser" id="workUser" value="${workUser}">
<input type="hidden" name="checkUser" id="checkUser" value="${checkUser}">
<input type="hidden" name="workUserBirthday" id="workUserBirthday" value="${cwMember.birthday}">
<input type="hidden" name="workUserGenderCd" id="workUserGenderCd" value="${cwMember.genderCd}">
<input type="hidden" name="workUserName" id="workUserName" value="${cwMember.memberNm}">
<input type="hidden" name="rejectReasonList" id="rejectReasonList" value="${rejectReasonList}">
<!-- 페이지 타입 -->
<input type="hidden" id="pageType" value="${pageType}">
<input type="hidden" name="checkerId" id="checkerId" value="${checkerId}"> <!-- 모니터링 검수자 분류 -->
<script type="text/javascript" src="/js/cw/toastr.min.js"></script>
<script type="text/javascript" src="/js/cw/workspace/cw-workspace.min.js?v=<%=System.currentTimeMillis() %>">/* 공통 스크립트 */</script>
<script>

    window.onload = function () {

        // 자동옵션 삽입
        let opt = '${workConfig}';
        if ( opt ) {
            opt = JSON.parse(opt);
        }

        // 작업객체 생성
        cw = new crowdworks(opt);
        cw.morpDatas = [];
        cw.kaist5_groups = [];
        cw.edit_text_flag = false;
        cw.group_edit_flag = false;
        cw.result_groups1 = {};
        cw.result_groups2 = {};

        // 공용 데이터 로드 후, 별개 데이터 준비구간 재정의
        cw.ready = function (pageType, json, jsonCont, jsonValue, jsonData) {

            let data = {};

            $('.ui.accordion').accordion({
                exclusive: false
            });

            $('.menu .item').tab();

            if ( jsonData ) {
                data = jsonData;
                cw.kaist5_groups = jsonData.groups;

                cw.result_groups1 = jsonCont.cont.resultData[0].groups;
                cw.result_groups1_problem_reason = jsonCont.cont.resultData[0].problem_reason;
                cw.result_groups2 = jsonCont.cont.resultData[1].groups;
                cw.result_groups2_problem_reason = jsonCont.cont.resultData[1].problem_reason;

                cw.event.loadGroupList();
                cw.event.loadGroupList_12();
            } else {

                if ( jsonCont.cont ) {
                    data = jsonCont.cont;
                } else {
                    console.log('load jsonCont error...');
                }

                cw.result_groups1 = jsonCont.cont.resultData[0].groups;
                cw.result_groups1_problem_reason = jsonCont.cont.resultData[0].problem_reason;
                cw.result_groups2 = jsonCont.cont.resultData[1].groups;
                cw.result_groups2_problem_reason = jsonCont.cont.resultData[1].problem_reason;

                cw.event.loadGroupList();
                cw.event.loadGroupList_12();
                $('.item[data-tab="second"]').click();
            }

            cw.jsonCont = $.extend(true, {}, data);

            cw.event.loadSentence(cw.jsonCont);
            cw.event.writeSentence();
        };

        // 이벤트 바인딩 구간 재정의
        cw.bind = function () {
            // // 클릭시 selected Class 추가
            // $('.work-row').on('click', '.oxbtn', function () {
            //     $('.selected').removeClass('selected');
            //     $(this).addClass('selected');
            //     return false;
            // });

            $('#kaist-sentence').on('click', '.kaist-sentence-word', function (e) {

                if ( cw.edit_text_flag === true ) {
                    alert("데이터 편집을 하는 동안 선택할 수 없습니다.");
                    return false;
                }

                if ( $(this).hasClass("complete") ) {
                    return false;
                }
                $(this).toggleClass("selected");

                const startElement_paragraph_id = $("#kaist-sentence .selected:first").data("paragraph-id");
                const startElement_sentence_id = $("#kaist-sentence .selected:first").data("sentence-id");
                const endElement_paragraph_id = $(this).data("paragraph-id");
                const endElement_sentence_id = $(this).data("sentence-id");

                console.log('startElement_paragraph_id: ', startElement_paragraph_id);
                console.log('endElement_paragraph_id: ', endElement_paragraph_id);

                if ( (startElement_paragraph_id !== undefined) && (startElement_paragraph_id !== endElement_paragraph_id) ) {
                    alert("다른 문장의 단어를 연달아 선택하실 수 없습니다.");
                    $("#kaist5-text-wrapper .selected").removeClass('selected');
                    return false;
                }

                if ( (startElement_sentence_id !== undefined) && (startElement_sentence_id !== endElement_sentence_id) ) {
                    alert("다른 문장의 단어를 연달아 선택하실 수 없습니다.");
                    $("#kaist5-text-wrapper .selected").removeClass('selected');
                    return false;
                }

                let startOn = false;
                const startElement = $("#kaist-sentence .selected:first").data("widx"); // ㅇㅇ. 일단 widx 가 저 선택 이벤트 처리하는건 알았고...
                let endElement = $(this).data("widx");
                if ( !$(this).hasClass("selected") ) {
                    endElement = endElement - 1;
                }

                cw.event.rangeSelection(startElement, endElement);
                return false;
            });

            $('#kaist5-groups').on('click', '.text_edit_button', function (e) {

                if ( $('#kaist5-morp-table input[type="checkbox"]:checked').length === 0 ) {
                    alert("데이터 편집에 포함할 데이터가 없습니다. 체크박스를 확인해주세요.");
                    return false;
                }

                if ( $("#kaist5-text-wrapper .selected").length === 0 ) {
                    alert("선택한 어절이 없습니다.");
                    return false;
                }

                $('.kaist5-text-edit-section2-wrapper').removeClass('hide');
                $('#rework-text-edit').removeClass('hide');

                let type = $(this).data('type');
                let selWords = [];
                let checkedData = { data: {}, positions: [] };
                let paragraphIds = [],
                    sentenceIds = [],
                    lemmaIds = "",
                    wordIds = "",
                    characterIds = [],
                    wIdxs = [];
                cw.morpDatas = [];

                if ( $(this).data('group-id') !== undefined ) {
                    cw.selected_group_id = $(this).data('group-id');
                }

                if ( cw.group_edit_flag ) {
                    type = 'edit';
                }

                for (let i = 0; i < $('.kaist-sentence-word.selected').length; i++) {
                    selWords.push($($('.kaist-sentence-word.selected')[i]).data('word_id'));
                }

                for (let i = 0; i < $('#kaist5-morp-table input[type="checkbox"]').length; i++) {
                    if ( true == $($('#kaist5-morp-table input[type="checkbox"]')[i]).prop('checked') ) {

                        let $paragraph_id = $($('#kaist5-morp-table input[type="checkbox"]')[i]).closest('tr').data('paragraph-id'),
                            $sentence_id = $($('#kaist5-morp-table input[type="checkbox"]')[i]).closest('tr').data('sentence-id'),
                            $lemma_id = $($('#kaist5-morp-table input[type="checkbox"]')[i]).closest('tr').data('lemma_id'),
                            $word_id = $($('#kaist5-morp-table input[type="checkbox"]')[i]).closest('tr').data('word_id'),
                            $text = $($('#kaist5-morp-table input[type="checkbox"]')[i]).closest('tr').find('.morp-result').text(),
                            $widx = $($('#kaist5-morp-table input[type="checkbox"]')[i]).closest('tr').data('widx');

                        if ( $lemma_id !== undefined && $word_id !== undefined ) {

                            if ( !checkedData.data["" + ($word_id) + ""] ) {
                                checkedData.data["" + ($word_id) + ""] = {
                                    text: "",
                                    lemma_id: [],
                                    word_id: ($word_id),
                                    paragraph_id: $paragraph_id,
                                    sentence_id: $sentence_id
                                };
                                wordIds += (wordIds == "" ? ($word_id) : "," + ($word_id));
                                checkedData.data["" + ($word_id) + ""].text = "";
                            }
                            checkedData.data["" + ($word_id) + ""].lemma_id.push(Number($lemma_id));
                            checkedData.data["" + ($word_id) + ""].text += $text;
                            lemmaIds += (lemmaIds == "" ? Number($lemma_id) + "" : "," + Number($lemma_id));
                            wIdxs.push(Number($widx));
                            paragraphIds.push(Number($paragraph_id));
                            sentenceIds.push(Number($sentence_id));
                        }
                    }
                }

                checkedData.paragraphIds = paragraphIds.filter((item, index) => paragraphIds.indexOf(item) === index);
                checkedData.sentenceIds = sentenceIds.filter((item, index) => sentenceIds.indexOf(item) === index);
                checkedData.lemmaIds = lemmaIds;
                checkedData.wordIds = wordIds;
                checkedData.wIdxs = wIdxs.filter((item, index) => wIdxs.indexOf(item) === index);

                let getPositions = cw.event.getPositions(checkedData.paragraphIds[0], checkedData.sentenceIds[0]);
                console.log("getPositions: ", getPositions);

                if (getPositions.result === "SUCCESS") {
                    checkedData.positions.push(getPositions.startPosition);
                    checkedData.positions.push(getPositions.endPosition);
                    checkedData.positions.sort();
                }

                cw.morpDatas.push(checkedData);

                cw.event.showResultData(type);

                cw.edit_text_flag = true;

                return false;
            });

            $('#kaist5-text-edit-wrapper').on('click', '#edit_group_button', function (e) {
                if ( $('#kaist5-morp-table input[type="checkbox"]:checked').length === 0 ) {
                    alert("데이터 편집에 포함할 데이터가 없습니다. 체크박스를 확인해주세요.");
                    return false;
                }

                if ( $('.group-data input').val() === "" ) {
                    alert("데이터 편집 텍스트가 없습니다.");
                    $('.group-data input').focus();
                    return false;
                }

                if ( $(this).data('type') === "group") {

                    let lemmas = [];

                    for (let i = 0; i < cw.selectedNEs.length; i++ ) {

                        for (let j = 0; j < cw.morpDatas[0].lemmaIds.split(',').length; j++) {
                            if ( cw.selectedNEs[i].lemma_id == cw.morpDatas[0].lemmaIds.split(',')[j] ) {
                                lemmas.push(cw.selectedNEs[i]);
                            }
                        }

                    }

                    for (let i = 0; i < cw.kaist5_groups.length; i++) {
                        if ( cw.kaist5_groups[i].group.group_id === cw.selected_group_id ) {
                            cw.kaist5_groups[i].group = {
                                "group_id": cw.selected_group_id, // 1
                                "paragraph_ids": cw.morpDatas[0].paragraphIds, // 2
                                "sentence_ids": cw.morpDatas[0].sentenceIds, // 3
                                "lemma_ids": cw.morpDatas[0].lemmaIds, // 4
                                "word_ids": cw.morpDatas[0].wordIds, // 5
                                "positions": cw.morpDatas[0].positions, // 6
                                "text": $('.group-data input').val(), // 7
                                "lemmas": lemmas, // 8
                                "widxs": cw.morpDatas[0].wIdxs,
                                "active": true
                            };

                            break;
                        }
                    }
                }

                if ( $(this).data('type') === "item") {

                    let lemmas = [];

                    for (let i = 0; i < cw.selectedNEs.length; i++ ) {

                        for (let j = 0; j < cw.morpDatas[0].lemmaIds.split(',').length; j++) {
                            if ( cw.selectedNEs[i].lemma_id == cw.morpDatas[0].lemmaIds.split(',')[j] ) {
                                lemmas.push(cw.selectedNEs[i]);
                            }
                        }

                    }

                    for (let i = 0; i < cw.kaist5_groups.length; i++) {
                        if ( cw.kaist5_groups[i].group.group_id === cw.selected_group_id ) {

                            for ( let j = 0; j < cw.kaist5_groups[i].items.length; j++ ) {

                                if ( cw.kaist5_groups[i].items[j].item_id === cw.selected_item_id ) {
                                    let cw_comment = undefined;
                                    if ( cw.kaist5_groups[i].items[j].cw_comment !== undefined ) {
                                        cw_comment = cw.kaist5_groups[i].items[j].cw_comment;
                                    }
                                    cw.kaist5_groups[i].items[j] = {
                                        "item_id": cw.selected_item_id,
                                        "paragraph_ids": cw.morpDatas[0].paragraphIds, // 2
                                        "sentence_ids": cw.morpDatas[0].sentenceIds, // 3
                                        "lemma_ids": cw.morpDatas[0].lemmaIds, // 4
                                        "word_ids": cw.morpDatas[0].wordIds, // 5
                                        "positions": cw.morpDatas[0].positions, // 6
                                        "text": $('.group-data input').val(), // 7
                                        "lemmas": lemmas, // 8
                                        "widxs": cw.morpDatas[0].wIdxs,
                                        "cw_comment": cw_comment
                                    }
                                }

                            }

                            break;
                        }
                    }
                }

                cw.event.loadGroupList();

                // init
                $('#select-text').text("");
                $('#kaist5-morp-table').empty();
                $('#group-data-list').empty();
                $("#kaist5-text-wrapper .selected").removeClass('selected');
                $('.kaist5-text-edit-section2-wrapper').addClass('hide');
                $('#rework-text-edit').addClass('hide');

                // $(".text_edit_button[data-type='group']").removeAttr('data-isedit');
                // $(".text_edit_button[data-type='group']").data('isedit', undefined);
                $(".text_edit_button[data-type='group']").text('상호참조해결집합 추가');
                cw.group_edit_flag = false;
                cw.edit_text_flag = false;

            });


            $('#kaist5-text-edit-wrapper').on('click', '#add_group_button', function (e) {

                if ( $('#kaist5-morp-table input[type="checkbox"]:checked').length === 0 ) {
                    alert("데이터 편집에 포함할 데이터가 없습니다. 체크박스를 확인해주세요.");
                    return false;
                }

                if ( $('.group-data input').val() === "" ) {
                    alert("데이터 편집 텍스트가 없습니다.");
                    $('.group-data input').focus();
                    return false;
                }

                let type = $(this).data('type'),
                    group_id = $(this).data('group-id'),
                    group_data = { group: {}, items: [] };


                if ( type === "group" ) {
                    let lemmas = [];

                    // if ( countNE > 0 ) {

                    for (let i = 0; i < cw.selectedNEs.length; i++ ) {

                        for (let j = 0; j < cw.morpDatas[0].lemmaIds.split(',').length; j++) {
                            if ( cw.selectedNEs[i].lemma_id == cw.morpDatas[0].lemmaIds.split(',')[j] ) {
                                lemmas.push(cw.selectedNEs[i]);
                            }
                        }

                    }


                    group_data.group = {
                        "group_id": group_id, // 1
                        "paragraph_ids": cw.morpDatas[0].paragraphIds, // 2
                        "sentence_ids": cw.morpDatas[0].sentenceIds, // 3
                        "lemma_ids": cw.morpDatas[0].lemmaIds, // 4
                        "word_ids": cw.morpDatas[0].wordIds, // 5
                        "positions": cw.morpDatas[0].positions, // 6
                        "text": $('.group-data input').val(), // 7
                        "lemmas": lemmas, // 8
                        "widxs": cw.morpDatas[0].wIdxs,
                        "active": true
                    };

                    cw.kaist5_groups.push(group_data);
                    cw.selected_group_id = group_id;
                    // } else {
                    //     alert("그룹명으로 등록할 수 없는 개체입니다.")
                    // }

                } else if ( type === "item" ) {

                    let current_group_idx = 0,
                        lemmas = [];

                    for (let i = 0; i < cw.selectedNEs.length; i++ ) {

                        for (let j = 0; j < cw.morpDatas[0].lemmaIds.split(',').length; j++) {
                            if ( cw.selectedNEs[i].lemma_id == cw.morpDatas[0].lemmaIds.split(',')[j] ) {
                                lemmas.push(cw.selectedNEs[i]);
                            }
                        }

                    }

                    for (let i = 0; i < cw.kaist5_groups.length; i++) {
                        if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                            current_group_idx = i;
                        }
                    }
                    cw.kaist5_groups[current_group_idx].items.push({
                        "item_id": new Date().getTime(),
                        "paragraph_ids": cw.morpDatas[0].paragraphIds, // 2
                        "sentence_ids": cw.morpDatas[0].sentenceIds, // 3
                        "lemma_ids": cw.morpDatas[0].lemmaIds, // 4
                        "word_ids": cw.morpDatas[0].wordIds, // 5
                        "positions": cw.morpDatas[0].positions, // 6
                        "text": $('.group-data input').val(), // 7
                        "lemmas": lemmas, // 8
                        "widxs": cw.morpDatas[0].wIdxs,
                        "cw_comment": undefined
                    });
                }

                cw.event.loadGroupList();

                // init work space
                $('#select-text').text("");
                $('#kaist5-morp-table').empty();
                $('#group-data-list').empty();
                $("#kaist5-text-wrapper .selected").removeClass('selected');
                $('.kaist5-text-edit-section2-wrapper').addClass('hide');
                $('#rework-text-edit').addClass('hide');
                $('.preview').removeClass('preview');
                $('.preview-item').removeClass('preview-item');

                cw.edit_text_flag = false;

            });

            $('#kaist5-morp-table').on('change', 'input', function (e) {
                let target = $('#kaist5-morp-table').find('input');
                let f1 = $(target[0]).prop('checked');
                let f2 = null;
                let f3 = null;

                for (let i = 0; i < target.length; i++) {
                    //f2나오기전까지 돌리다가 f1과 값이 다른경우
                    if ( $(target[i]).prop('checked') != f1 && f2 == null && i != 0 ) {
                        f2 = $(target[i]).prop('checked');
                        console.log("f2:" + f2);
                        continue;
                    }

                    if ( f2 != null && $(target[i]).prop('checked') != f2 && f3 == null && i != 0 && f1 == false && f2 == true ) {
                        f3 = $(target[i]).prop('checked');
                        console.log("f3:" + f3);
                        continue;
                    }
                    if ( f2 != null && $(target[i]).prop('checked') != f2 && f3 == null && i != 0 && f1 == true && f2 == false ) {
                        alert('중간에 갑자기 체크박스가 달라지면 안됩니다.');
                        $(e.target).prop('checked', !$(e.target).prop('checked'));
                        console.log("!!f2");
                        return false;
                    }
                    if ( f3 != null && $(target[i]).prop('checked') != f3 && i != 0 ) {
                        alert('중간에 갑자기 체크박스가 달라지면 안됩니다.');
                        $(e.target).prop('checked', !$(e.target).prop('checked'));
                        console.log("!!f3");
                        return false;
                    }
                }
                return true;
            });

            $('#kaist5-text-edit-wrapper').on('click', '#cancle_add_group_button', function (e) {
                $('#select-text').text("");
                $('#kaist5-morp-table').empty();
                $('#group-data-list').empty();
                $("#kaist5-text-wrapper .selected").removeClass('selected');
                $('.kaist5-text-edit-section2-wrapper').addClass('hide');
                $('#rework-text-edit').addClass('hide');

                cw.edit_text_flag = false;
            });

            $('#kaist5-text-edit-wrapper').on('click', '#rework-text-edit', function (e) {
                $('#group-data-list').empty();
                $('.kaist5-text-edit-section2-wrapper').addClass('hide');
                $('#rework-text-edit').addClass('hide');

                cw.edit_text_flag = false;
            });

            $('#kaist5-text-edit-wrapper').on('click', '#init-work', function (e) {
                $('#select-text').text("");
                $('#kaist5-morp-table').empty();
                $('#group-data-list').empty();
                $("#kaist5-text-wrapper .selected").removeClass('selected');
                $('.kaist5-text-edit-section2-wrapper').addClass('hide');
                $('#rework-text-edit').addClass('hide');

                cw.edit_text_flag = false;
            });

            $('#kaist5-groups').on('click', '.edit_item_button', function (e) {

                if ( $(this).data('isedit') === true ) {
                    if ( confirm("개체를 수정하시겠습니까?") ) {

                        $('.kaist-sentence-word.selected').removeClass('selected');

                        const group_id = $(this).data('group-id'),
                            item_id = $(this).data('item-id');
                        let target_group = {},
                            target_item = {},
                            preview_text = "";

                        for (let i = 0; i < cw.kaist5_groups.length; i++) {
                            if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                                target_group = cw.kaist5_groups[i];

                                for ( let j = 0; j < target_group.items.length; j++ ) {
                                    if ( target_group.items[j].item_id === item_id ) {
                                        target_item = target_group.items[j];
                                    }
                                }
                            }
                        }

                        for (let i = 0; i < target_item.widxs.length; i++) {
                            $('.kaist-sentence-word[data-widx="' + target_item.widxs[i] + '"]').addClass('selected');
                        }

                        // for ( let i = 0; i < $('.kaist-sentence-word.selected').length; i++ ) {
                        //     preview_text += $($('.kaist-sentence-word.selected')[i]).text() + " ";
                        // };

                        preview_text = target_item.text;

                        preview_text.trim();

                        let selectedWord = preview_text;
                        $("#select-text").html(preview_text);

                        $('#kaist5-morp-table').html('');
                        let selWord = $('#kaist-sentence .kaist-sentence-word.selected');

                        cw.selectedNEs = [];

                        // for (let i = 0; i < selWord.length; i++) {

                        // let a = cw.morpsGroup["mg-"+($(selWord[i]).data('word_id') < 10 ? "0" + $(selWord[i]).data('word_id') : $(selWord[i]).data('word_id'))];
                        // this.corefs["c-" + (corefs[i].paragraph_id + "" + corefs[i].sentence_id)] = corefs[i];
                        // let a = cw.corefs["c-" + ($(selWord[i]).data('paragraph-id') + "" + $(selWord[i]).data('sentence-id'))],
                        //     word_id = $(selWord[i]).data('word_id'),
                        //     widx = $(selWord[i]).data('widx'),
                        let resultArr = [];

                        for (let i = 0; i < target_item.lemmas.length; i++) {

                            resultArr.push({
                                "NEs": target_item.lemmas[i],
                                "ids": {
                                    "paragraph-id": target_item.paragraph_ids[0],
                                    "sentence-id": target_item.sentence_ids[0],
                                    "widx": target_item.widxs[i] ? target_item.widxs[i] : target_item.widxs[0]               // 이걸 어떻게 가져오지...
                                }
                            });

                        }
                        cw.event.createMorpTable(resultArr);

                        for (let i = 0; i < resultArr.length; i++) {
                            cw.selectedNEs.push(resultArr[i].NEs);
                        }
                        // }

                        cw.selected_group_id = target_group.group.group_id;
                        cw.selected_item_id = target_item.item_id;

                        cw.event.loadGroupList();

                        $('.edit_item_button[data-item-id="' + target_item.item_id + '"]').text("개체수정완료");
                        $('.edit_item_button[data-item-id="' + target_item.item_id + '"]').attr("data-isedit", "edit_item");

                        $('.text_edit_button').attr('disabled', true);
                        $('#kaist5-groups').find('.text_edit_button').attr('disabled', true);
                        $('#kaist5-groups').find('.remove_group_button').attr('disabled', true);
                        $('#kaist5-groups').find('.edit_group_button').attr('disabled', true);


                        // $(".text_edit_button[data-type='group']").attr('data-isedit', true);
                        // $(".text_edit_button[data-type='group']").text('수정');
                        // $(".text_edit_button[data-type='item']").data('type', 'item');
                        // $(".text_edit_button[data-type='group']").click();

                    }
                } else {
                    $('.kaist5-text-edit-section2-wrapper').removeClass('hide');
                    $('#rework-text-edit').removeClass('hide');

                    $('.text_edit_button').removeAttr('disabled');
                    $('#kaist5-groups').find('.text_edit_button').removeAttr('disabled');
                    $('#kaist5-groups').find('.remove_group_button').removeAttr('disabled');
                    $('#kaist5-groups').find('.edit_group_button').removeAttr('disabled');

                    let type = $(this).data('type');
                    let selWords = [];
                    let checkedData = { data: {}, positions: [] };
                    let paragraphIds = [],
                        sentenceIds = [],
                        lemmaIds = "",
                        wordIds = "",
                        characterIds = [],
                        wIdxs = [];
                    cw.morpDatas = [];

                    if ( $(this).data('group-id') !== undefined ) {
                        cw.selected_group_id = $(this).data('group-id');
                    }

                    if ( $(this).data('isedit') !== undefined ) {
                        type = $(this).data('isedit');
                    }

                    for (let i = 0; i < $('.kaist-sentence-word.selected').length; i++) {
                        selWords.push($($('.kaist-sentence-word.selected')[i]).data('word_id'));
                    }

                    for (let i = 0; i < $('#kaist5-morp-table input[type="checkbox"]').length; i++) {
                        if ( true == $($('#kaist5-morp-table input[type="checkbox"]')[i]).prop('checked') ) {

                            let $paragraph_id = $($('#kaist5-morp-table input[type="checkbox"]')[i]).closest('tr').data('paragraph-id'),
                                $sentence_id = $($('#kaist5-morp-table input[type="checkbox"]')[i]).closest('tr').data('sentence-id'),
                                $lemma_id = $($('#kaist5-morp-table input[type="checkbox"]')[i]).closest('tr').data('lemma_id'),
                                $word_id = $($('#kaist5-morp-table input[type="checkbox"]')[i]).closest('tr').data('word_id'),
                                $text = $($('#kaist5-morp-table input[type="checkbox"]')[i]).closest('tr').find('.morp-result').text(),
                                $widx = $($('#kaist5-morp-table input[type="checkbox"]')[i]).closest('tr').data('widx');

                            if ( $lemma_id !== undefined && $word_id !== undefined ) {

                                if ( !checkedData.data["" + ($word_id) + ""] ) {
                                    checkedData.data["" + ($word_id) + ""] = {
                                        text: "",
                                        lemma_id: [],
                                        word_id: ($word_id),
                                        paragraph_id: $paragraph_id,
                                        sentence_id: $sentence_id
                                    };
                                    wordIds += (wordIds == "" ? ($word_id) : "," + ($word_id));
                                    checkedData.data["" + ($word_id) + ""].text = "";
                                }
                                checkedData.data["" + ($word_id) + ""].lemma_id.push(Number($lemma_id));
                                checkedData.data["" + ($word_id) + ""].text += $text;
                                lemmaIds += (lemmaIds == "" ? Number($lemma_id) + "" : "," + Number($lemma_id));
                                wIdxs.push(Number($widx));
                                paragraphIds.push(Number($paragraph_id));
                                sentenceIds.push(Number($sentence_id));
                            }
                        }
                    }

                    checkedData.paragraphIds = paragraphIds.filter((item, index) => paragraphIds.indexOf(item) === index);
                    checkedData.sentenceIds = sentenceIds.filter((item, index) => sentenceIds.indexOf(item) === index);
                    checkedData.lemmaIds = lemmaIds;
                    checkedData.wordIds = wordIds;
                    checkedData.wIdxs = wIdxs.filter((item, index) => wIdxs.indexOf(item) === index);

                    let getPositions = cw.event.getPositions(checkedData.paragraphIds[0], checkedData.sentenceIds[0]);
                    console.log("getPositions: ", getPositions);

                    if (getPositions.result === "SUCCESS") {
                        checkedData.positions.push(getPositions.startPosition);
                        checkedData.positions.push(getPositions.endPosition);
                        checkedData.positions.sort();
                    }

                    cw.morpDatas.push(checkedData);

                    cw.event.showResultData(type);

                    cw.edit_text_flag = true;

                    return false;
                }



            });

            $('#kaist5-groups').on('click', '.remove_item_button', function (e) {

                if ( confirm("개체를 삭제하시겠습니까?") ) {
                    const item_id = $(this).data('item-id'),
                        group_id = $(this).data('group-id');

                    for ( let i = 0; i < cw.kaist5_groups.length; i++ ) {
                        if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                            for ( let j = 0; j < cw.kaist5_groups[i].items.length; j++ ) {
                                if ( cw.kaist5_groups[i].items[j].item_id === item_id ) {
                                    cw.kaist5_groups[i].items.splice(j,1);
                                    break;
                                }
                            }
                        }
                    }

                    cw.event.loadGroupList();

                    $('#select-text').text("");
                    $('#kaist5-morp-table').empty();
                    $('.kaist-sentence-word.selected').removeClass('selected');

                    $('.text_edit_button').removeAttr('disabled');
                    $('#kaist5-groups').find('.text_edit_button').removeAttr('disabled');
                    $('#kaist5-groups').find('.remove_group_button').removeAttr('disabled');
                    $('#kaist5-groups').find('.edit_group_button').removeAttr('disabled');
                }
            });

            $('#kaist5-groups').on('click', '.remove_group_button', function (e) {

                if ( confirm("그룹을 삭제하시겠습니까?") ) {
                    const group_id = $(this).data('group-id');

                    for (let i = 0; cw.kaist5_groups.length; i++) {
                        if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                            cw.kaist5_groups.splice(i,1);
                            break;
                        }
                    }

                    cw.event.loadGroupList();
                }

            });

            $('#kaist5-groups').on('click', '.edit_group_button', function (e) {

                if ( confirm("그룹을 수정하시겠습니까?") ) {

                    $('.kaist-sentence-word.selected').removeClass('selected');

                    const group_id = $(this).data('group-id');
                    let target_group = {},
                        preview_text = "";

                    for (let i = 0; i < cw.kaist5_groups.length; i++) {
                        if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                            target_group = cw.kaist5_groups[i].group;
                        }
                    }

                    for (let i = 0; i < target_group.widxs.length; i++) {
                        $('.kaist-sentence-word[data-widx="' + target_group.widxs[i] + '"]').addClass('selected');
                    }

                    // for ( let i = 0; i < $('.kaist-sentence-word.selected').length; i++ ) {
                    //     preview_text += $($('.kaist-sentence-word.selected')[i]).text() + " ";
                    // };

                    preview_text = target_group.text;

                    preview_text.trim();

                    let selectedWord = preview_text;
                    $("#select-text").html(preview_text);

                    $('#kaist5-morp-table').html('');
                    let selWord = $('#kaist-sentence .kaist-sentence-word.selected');

                    if ( target_group ) {
                        cw.selectedNEs = [];

                        // for (let i = 0; i < selWord.length; i++) {

                        // let a = cw.morpsGroup["mg-"+($(selWord[i]).data('word_id') < 10 ? "0" + $(selWord[i]).data('word_id') : $(selWord[i]).data('word_id'))];
                        // this.corefs["c-" + (corefs[i].paragraph_id + "" + corefs[i].sentence_id)] = corefs[i];
                        // let a = cw.corefs["c-" + ($(selWord[i]).data('paragraph-id') + "" + $(selWord[i]).data('sentence-id'))],
                        //     word_id = $(selWord[i]).data('word_id'),
                        //     widx = $(selWord[i]).data('widx'),
                        let resultArr = [];

                        for (let i = 0; i < target_group.lemmas.length; i++) {

                            resultArr.push({
                                "NEs": target_group.lemmas[i],
                                "ids": {
                                    "paragraph-id": target_group.paragraph_ids[0],
                                    "sentence-id": target_group.sentence_ids[0],
                                    "widx": target_group.widxs[i] ? target_group.widxs[i] : target_group.widxs[0]               // 이걸 어떻게 가져오지...
                                }
                            });
                        }
                        cw.event.createMorpTable(resultArr);

                        for (let i = 0; i < resultArr.length; i++) {
                            cw.selectedNEs.push(resultArr[i].NEs);
                        }
                        // }
                    } else {
                        cw.selectedNEs = [];

                        for (let i = 0; i < selWord.length; i++) {

                            // let a = cw.morpsGroup["mg-"+($(selWord[i]).data('word_id') < 10 ? "0" + $(selWord[i]).data('word_id') : $(selWord[i]).data('word_id'))];
                            // this.corefs["c-" + (corefs[i].paragraph_id + "" + corefs[i].sentence_id)] = corefs[i];
                            let paragraph_id = ("" + $(selWord[i]).data('paragraph-id')).length > 1 ? $(selWord[i]).data('paragraph-id') : "0" + $(selWord[i]).data('paragraph-id');

                            let a = cw.corefs["c-" + (paragraph_id + "-" + $(selWord[i]).data('sentence-id'))],
                                word_id = $(selWord[i]).data('word_id'),
                                widx = $(selWord[i]).data('widx'),
                                resultArr = [];

                            for (let i = 0; i < a.NEs.length; i++) {
                                if ( a.NEs[i].word_id === word_id ) {
                                    resultArr.push({
                                        "NEs": a.NEs[i],
                                        "ids": {
                                            "paragraph-id": a.paragraph_id,
                                            "sentence-id": a.sentence_id,
                                            "widx": widx
                                        }
                                    });
                                }
                            }
                            cw.event.createMorpTable(resultArr);

                            for (let i = 0; i < resultArr.length; i++) {
                                cw.selectedNEs.push(resultArr[i].NEs);
                            }
                        }
                    }


                    cw.selected_group_id = target_group.group_id;

                    cw.event.loadGroupList();
                    cw.group_edit_flag = true;

                    $('#kaist5-group-list').find('.text_edit_button').attr('disabled', true);
                    $('#kaist5-group-list').find('.remove_group_button').attr('disabled', true);
                    $('#kaist5-group-list').find('.edit_group_button').attr('disabled', true);

                    // $(".text_edit_button[data-type='group']").attr('data-isedit', true);
                    $(".text_edit_button[data-type='group']").text('수정');
                    // $(".text_edit_button[data-type='group']").click();
                }

            });

            $('#kaist5-groups').on('click', '.title', function(e) {
                let group_id = $(this).data('group-id');

                if ( $(this).hasClass('active') ) {

                    for (let i = 0; i < cw.kaist5_groups.length; i++) {
                        if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                            cw.kaist5_groups[i].group.active = true;
                        }
                    }

                } else {

                    for (let i = 0; i < cw.kaist5_groups.length; i++) {
                        if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                            cw.kaist5_groups[i].group.active = false;
                        }
                    }

                }
            });

            $('#kaist5-groups').on('mouseover', '.preview_group_button', function(e) {
                // console.log($(this).data('group-id'));
                // console.log("들어왔다.");

                let group_id = $(this).data('group-id'),
                    target_group;

                for (let i = 0; i < cw.kaist5_groups.length; i++) {
                    if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                        target_group = cw.kaist5_groups[i];
                    }
                }

                if ( target_group === undefined ) {
                    for (let i = 0; i < cw.result_groups2.length; i++) {
                        if ( cw.result_groups2[i].group.group_id === group_id ) {
                            target_group = cw.result_groups2[i];
                        }
                    }
                }

                for (let i = 0; i < target_group.group.widxs.length; i++) {
                    $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview');
                }

                if ( target_group.items.length !== 0 ) {
                    for (let i = 0; i < target_group.items.length; i++) {

                        for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                            $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').addClass('preview-item');
                        }

                    }
                }

            });

            // 그룹 미리보기
            $('#kaist5-groups').on('click', '.preview_group_button', function(e) {
               if ( $(this).hasClass('preview_group_active') ) {
                   $(this).removeClass('preview_group_active');
                   $('.preview_item_button[data-group-id="' + $(this).data('group-id') + '"]').removeClass('preview_item_active');

                   let group_id = $(this).data('group-id'),
                       target_group;

                   for (let i = 0; i < cw.kaist5_groups.length; i++) {
                       if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                           target_group = cw.kaist5_groups[i];
                       }
                   }

                   if ( target_group === undefined ) {
                       for (let i = 0; i < cw.result_groups2.length; i++) {
                           if ( cw.result_groups2[i].group.group_id === group_id ) {
                               target_group = cw.result_groups2[i];
                           }
                       }
                   }

                   for (let i = 0; i < target_group.group.widxs.length; i++) {
                       $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').removeClass('preview');
                   }

                   if ( target_group.items.length !== 0 ) {
                       for (let i = 0; i < target_group.items.length; i++) {

                           for (let j = 0; j < target_group.items[i].widxs.length; j++) {
                               $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').removeClass('preview-item');
                           }

                       }
                   }
               } else {
                   $('.preview_group_active').removeClass('preview_group_active');
                   $('.preview_item_active').removeClass('preview_item_active');
                   $('.preview').removeClass('preview');
                   $('.preview-item').removeClass('preview-item');

                   $(this).addClass('preview_group_active');
                   $('.preview_item_button[data-group-id="' + $(this).data('group-id') + '"]').addClass('preview_item_active');

                   let group_id = $(this).data('group-id'),
                       target_group;

                   for (let i = 0; i < cw.kaist5_groups.length; i++) {
                       if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                           target_group = cw.kaist5_groups[i];
                       }
                   }

                   if ( target_group === undefined ) {
                       for (let i = 0; i < cw.result_groups2.length; i++) {
                           if ( cw.result_groups2[i].group.group_id === group_id ) {
                               target_group = cw.result_groups2[i];
                           }
                       }
                   }

                   for (let i = 0; i < target_group.group.widxs.length; i++) {
                       $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview');
                   }

                   if ( target_group.items.length !== 0 ) {
                       for (let i = 0; i < target_group.items.length; i++) {

                           for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                               $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').addClass('preview-item');
                           }

                       }
                   }
               }
            });



            $('#kaist5-groups').on('mouseleave', '.preview_group_button', function(e) {

                if ( $(this).hasClass('preview_group_active') ) {
                    return false;
                } else {
                    let group_id = $(this).data('group-id'),
                        target_group;

                    for (let i = 0; i < cw.kaist5_groups.length; i++) {
                        if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                            target_group = cw.kaist5_groups[i];
                        }
                    }

                    if ( target_group === undefined ) {
                        for (let i = 0; i < cw.result_groups2.length; i++) {
                            if ( cw.result_groups2[i].group.group_id === group_id ) {
                                target_group = cw.result_groups2[i];
                            }
                        }
                    }

                    for (let i = 0; i < target_group.group.widxs.length; i++) {
                        $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').removeClass('preview');
                    }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++) {
                                $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').removeClass('preview-item');
                            }

                        }
                    }
                }
            });

            $('#kaist5-groups').on('mouseover', 'p.item', function(e) {
                // console.log($(this).data('group-id'));
                // console.log("들어왔다.");

                let group_id = $(this).parent().parent().parent().prev().data('group-id'),
                    item_id = $(this).data('item-id'),
                    target_group;

                for (let i = 0; i < cw.kaist5_groups.length; i++) {
                    if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                        target_group = cw.kaist5_groups[i];
                    }
                }

                // for (let i = 0; i < target_group.group.widxs.length; i++) {
                //     $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview');
                // }

                if ( target_group.items.length !== 0 ) {
                    for (let i = 0; i < target_group.items.length; i++) {

                        for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                            if ( target_group.items[i].item_id === item_id) {
                                $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').addClass('preview-item');
                            }
                        }

                    }
                }

            });

            // 개체 미리보기 클릭 이벤트
            $('#kaist5-groups').on('click', 'p.item', function(e) {
                // console.log($(this).data('group-id'));
                // console.log("들어왔다.");

                if ( $('.preview_item_button[data-item-id="' + $(this).data('item-id') + '"]').hasClass("preview_item_active") ) {
                    let group_id = $(this).parent().parent().parent().prev().data('group-id'),
                        item_id = $(this).data('item-id'),
                        target_group;

                    for (let i = 0; i < cw.kaist5_groups.length; i++) {
                        if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                            target_group = cw.kaist5_groups[i];
                        }
                    }

                    // for (let i = 0; i < target_group.group.widxs.length; i++) {
                    //     $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview');
                    // }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                                if ( target_group.items[i].item_id === item_id) {
                                    $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').removeClass('preview-item');
                                }
                            }

                        }
                    }

                    $('.preview_item_button[data-item-id="' + item_id + '"]').removeClass('preview_item_active');
                } else {
                    let group_id = $(this).parent().parent().parent().prev().data('group-id'),
                        item_id = $(this).data('item-id'),
                        target_group;

                    for (let i = 0; i < cw.kaist5_groups.length; i++) {
                        if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                            target_group = cw.kaist5_groups[i];
                        }
                    }

                    // for (let i = 0; i < target_group.group.widxs.length; i++) {
                    //     $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview');
                    // }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                                if ( target_group.items[i].item_id === item_id) {
                                    $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').addClass('preview-item');
                                }
                            }

                        }
                    }

                    $('.preview_item_button[data-item-id="' + item_id + '"]').addClass('preview_item_active');
                }

            });

            $('#kaist5-groups').on('mouseleave', 'p.item', function(e) {

                if ( $('.preview_item_button[data-item-id="' + $(this).data('item-id') + '"]').hasClass("preview_item_active") ) {
                    return false;
                } else {
                    let group_id = $(this).parent().parent().parent().prev().data('group-id'),
                        item_id = $(this).data('item-id'),
                        target_group;

                    for (let i = 0; i < cw.kaist5_groups.length; i++) {
                        if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                            target_group = cw.kaist5_groups[i];
                        }
                    }

                    // for (let i = 0; i < target_group.group.widxs.length; i++) {
                    //     $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview');
                    // }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                                if ( target_group.items[i].item_id === item_id) {
                                    $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').removeClass('preview-item');
                                }
                            }

                        }
                    }

                    $('.preview_item_button[data-item-id="' + item_id + '"]').removeClass('preview_item_active');
                }

                // $('.preview-item').removeClass('preview-item');
            });

            $('#kaist5-groups').on('click', '.add_memo', function(e) {

                if ( $(this).next().text() === "수정" ) {
                    let group_id = $(this).data('group-id'),
                        item_id = $(this).data('item-id');

                    $(this).closest('.content').append('<div class="ui tiny input" id="comment" style="width: 100%;"><input id="memo_content" type="text" placeholder="메모"><button class="tiny ui button" id="confirm_memo" data-group-id="' + group_id + '" data-item-id="' + item_id + '">확인</button></div>');
                }

            });

            $('#kaist5-groups').on('click', '#confirm_memo', function (e) {

                let text = $('#memo_content').val().trim();

                let group_id = $(this).data('group-id'),
                    item_id = $(this).data('item-id'),
                    target_group = {},
                    target_item = {};

                for (let i = 0; i < cw.kaist5_groups.length; i++) {
                    if ( cw.kaist5_groups[i].group.group_id === group_id ) {
                        target_group = cw.kaist5_groups[i];

                        for ( let j = 0; j < target_group.items.length; j++ ) {
                            if ( target_group.items[j].item_id === item_id ) {
                                target_item = target_group.items[j];
                                target_item.cw_comment = text;
                            }
                        }
                    }
                }

                $('#comment').remove();

                cw.event.loadGroupList();

            });

            // 추가 요구 사항
            // 작업 1
            // 작업 1 에서 미리보기버튼 클릭했을 경우
            $('#kaist5-group-list-1').on('click', '.preview_group_button', function (e) {

                if ( $(this).hasClass('preview_group_active_1') ) {
                    $(this).removeClass('preview_group_active_1');
                    $('.preview_item_button_1[data-group-id="' + $(this).data('group-id') + '"]').removeClass('preview_item_active_1');

                    let group_id = $(this).data('group-id'),
                        target_group;

                    for (let i = 0; i < cw.result_groups1.length; i++) {
                        if ( cw.result_groups1[i].group.group_id === group_id ) {
                            target_group = cw.result_groups1[i];
                        }
                    }

                    if ( target_group === undefined ) {
                        for (let i = 0; i < cw.result_groups2.length; i++) {
                            if ( cw.result_groups2[i].group.group_id === group_id ) {
                                target_group = cw.result_groups2[i];
                            }
                        }
                    }

                    for (let i = 0; i < target_group.group.widxs.length; i++) {
                        $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').removeClass('preview_1');
                    }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                                $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').removeClass('preview-item_1');
                            }

                        }
                    }
                } else {
                    $('.preview_group_active_1').removeClass('preview_group_active_1');
                    $('.preview_item_active_1').removeClass('preview_item_active_1');
                    $('.preview_1').removeClass('preview_1');
                    $('.preview-item_1').removeClass('preview-item_1');

                    $(this).addClass('preview_group_active_1');
                    $('.preview_item_button_1[data-group-id="' + $(this).data('group-id') + '"]').addClass('preview_item_active_1');

                    let group_id = $(this).data('group-id'),
                        target_group;

                    for (let i = 0; i < cw.result_groups1.length; i++) {
                        if ( cw.result_groups1[i].group.group_id === group_id ) {
                            target_group = cw.result_groups1[i];
                        }
                    }

                    if ( target_group === undefined ) {
                        for (let i = 0; i < cw.result_groups2.length; i++) {
                            if ( cw.result_groups2[i].group.group_id === group_id ) {
                                target_group = cw.result_groups2[i];
                            }
                        }
                    }

                    for (let i = 0; i < target_group.group.widxs.length; i++) {
                        $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview_1');
                    }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                                $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').addClass('preview-item_1');
                            }

                        }
                    }
                }

            });

            // 작업 1에서 제목이나 미리보기 버튼에 마우스 오버시
            $('#kaist5-group-list-1').on('mouseover', '.preview_group_button, .title', function(e) {
                // console.log($(this).data('group-id'));
                // console.log("들어왔다.");

                let group_id = $(this).data('group-id'),
                    target_group;

                for (let i = 0; i < cw.result_groups1.length; i++) {
                    if ( cw.result_groups1[i].group.group_id === group_id ) {
                        target_group = cw.result_groups1[i];
                    }
                }

                if ( target_group === undefined ) {
                    for (let i = 0; i < cw.result_groups2.length; i++) {
                        if ( cw.result_groups2[i].group.group_id === group_id ) {
                            target_group = cw.result_groups2[i];
                        }
                    }
                }

                for (let i = 0; i < target_group.group.widxs.length; i++) {
                    $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview_1');
                }

                if ( target_group.items.length !== 0 ) {
                    for (let i = 0; i < target_group.items.length; i++) {

                        for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                            $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').addClass('preview-item_1');
                        }

                    }
                }

            });

            // 작업 1에서 제목이나 미리보기 버튼에 마우스 벗어났을 때
            $('#kaist5-group-list-1').on('mouseleave', '.preview_group_button, .title', function(e) {

                if ( $('.preview_group_button[data-group-id="' + $(this).data('group-id') + '"]').hasClass('preview_group_active_1') ) {
                    return false;
                } else {
                    let group_id = $(this).data('group-id'),
                        target_group;

                    for (let i = 0; i < cw.result_groups1.length; i++) {
                        if ( cw.result_groups1[i].group.group_id === group_id ) {
                            target_group = cw.result_groups1[i];
                        }
                    }

                    if ( target_group === undefined ) {
                        for (let i = 0; i < cw.result_groups2.length; i++) {
                            if ( cw.result_groups2[i].group.group_id === group_id ) {
                                target_group = cw.result_groups2[i];
                            }
                        }
                    }

                    for (let i = 0; i < target_group.group.widxs.length; i++) {
                        $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').removeClass('preview_1');
                    }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++) {
                                $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').removeClass('preview-item_1');
                            }

                        }
                    }
                }
            });

            // 작업 1에서 개체에서 마우스 오버시
            $('#kaist5-group-list-1').on('mouseover', 'p.item', function(e) {
                // console.log($(this).data('group-id'));
                // console.log("들어왔다.");

                let group_id = $(this).parent().parent().parent().prev().data('group-id'),
                    item_id = $(this).data('item-id'),
                    target_group;

                for (let i = 0; i < cw.result_groups1.length; i++) {
                    if ( cw.result_groups1[i].group.group_id === group_id ) {
                        target_group = cw.result_groups1[i];
                    }
                }

                // for (let i = 0; i < target_group.group.widxs.length; i++) {
                //     $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview');
                // }

                if ( target_group.items.length !== 0 ) {
                    for (let i = 0; i < target_group.items.length; i++) {

                        for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                            if ( target_group.items[i].item_id === item_id) {
                                $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').addClass('preview-item_1');
                            }
                        }

                    }
                }

            });

            // 작업 1에서 개체에서 마우스 벗어났을 때
            $('#kaist5-group-list-1').on('mouseleave', 'p.item', function(e) {

                if ( $('.preview_item_button_1[data-item-id="' + $(this).data('item-id') + '"]').hasClass("preview_item_active_1") ) {
                    return false;
                } else {
                    let group_id = $(this).parent().parent().parent().prev().data('group-id'),
                        item_id = $(this).data('item-id'),
                        target_group;

                    for (let i = 0; i < cw.result_groups1.length; i++) {
                        if ( cw.result_groups1[i].group.group_id === group_id ) {
                            target_group = cw.result_groups1[i];
                        }
                    }

                    // for (let i = 0; i < target_group.group.widxs.length; i++) {
                    //     $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview');
                    // }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                                if ( target_group.items[i].item_id === item_id) {
                                    $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').removeClass('preview-item_1');
                                }
                            }

                        }
                    }

                    $('.preview_item_button_1[data-item-id="' + item_id + '"]').removeClass('preview_item_active_1');
                }

                // $('.preview-item').removeClass('preview-item');
            });

            // 작업 1에서 개체 미리보기 버튼 클릭했을 경우
            $('#kaist5-group-list-1').on('click', '.preview_item_button_1, p.item', function(e) {

                if ( $('.preview_item_button_1[data-item-id="' + $(this).data('item-id') + '"]').hasClass('preview_item_active_1') ) {
                    let group_id = $(this).data('group-id'),
                        item_id = $(this).data('item-id'),
                        target_group;

                    for (let i = 0; i < cw.result_groups1.length; i++) {
                        if ( cw.result_groups1[i].group.group_id === group_id ) {
                            target_group = cw.result_groups1[i];
                        }
                    }

                    // for (let i = 0; i < target_group.group.widxs.length; i++) {
                    //     $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview');
                    // }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                                if ( target_group.items[i].item_id === item_id) {
                                    $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').removeClass('preview-item_1');
                                }
                            }

                        }
                    }

                    $('.preview_item_button_1[data-item-id="' + item_id + '"]').removeClass('preview_item_active_1');
                } else {
                    let group_id = $(this).data('group-id'),
                        item_id = $(this).data('item-id'),
                        target_group;

                    for (let i = 0; i < cw.result_groups1.length; i++) {
                        if ( cw.result_groups1[i].group.group_id === group_id ) {
                            target_group = cw.result_groups1[i];
                        }
                    }

                    // for (let i = 0; i < target_group.group.widxs.length; i++) {
                    //     $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview');
                    // }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                                if ( target_group.items[i].item_id === item_id) {
                                    $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').addClass('preview-item_1');
                                }
                            }

                        }
                    }

                    $('.preview_item_button_1[data-item-id="' + item_id + '"]').addClass('preview_item_active_1');
                }
            });
            // 작업 1

            // check_group_button

            $('#kaist5-group-list-1').on('click', '.check_group_button', function(e) {

                if ( $(this).hasClass("checked") ) {
                    $(this).removeClass("checked")
                } else {
                    $(this).addClass("checked")
                }

            });

            $('#kaist5-group-list-2').on('click', '.check_group_button', function(e) {

                if ( $(this).hasClass("checked") ) {
                    $(this).removeClass("checked")
                } else {
                    $(this).addClass("checked")
                }

            });

            // 작업 2
            // 작업 2 에서 미리보기버튼 클릭했을 경우
            $('#kaist5-group-list-2').on('click', '.preview_group_button', function (e) {

                if ( $(this).hasClass('preview_group_active_2') ) {
                    $(this).removeClass('preview_group_active_2');
                    $('.preview_item_button_2[data-group-id="' + $(this).data('group-id') + '"]').removeClass('preview_item_active_2');

                    let group_id = $(this).data('group-id'),
                        target_group;

                    for (let i = 0; i < cw.result_groups2.length; i++) {
                        if ( cw.result_groups2[i].group.group_id === group_id ) {
                            target_group = cw.result_groups2[i];
                        }
                    }

                    if ( target_group === undefined ) {
                        for (let i = 0; i < cw.result_groups2.length; i++) {
                            if ( cw.result_groups2[i].group.group_id === group_id ) {
                                target_group = cw.result_groups2[i];
                            }
                        }
                    }

                    for (let i = 0; i < target_group.group.widxs.length; i++) {
                        $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').removeClass('preview_2');
                    }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                                $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').removeClass('preview-item_2');
                            }

                        }
                    }
                } else {
                    $('.preview_group_active_2').removeClass('preview_group_active_2');
                    $('.preview_item_active_2').removeClass('preview_item_active_2');
                    $('.preview_2').removeClass('preview_2');
                    $('.preview-item_2').removeClass('preview-item_2');

                    $(this).addClass('preview_group_active_2');
                    $('.preview_item_button_2[data-group-id="' + $(this).data('group-id') + '"]').addClass('preview_item_active_2');

                    let group_id = $(this).data('group-id'),
                        target_group;

                    for (let i = 0; i < cw.result_groups2.length; i++) {
                        if ( cw.result_groups2[i].group.group_id === group_id ) {
                            target_group = cw.result_groups2[i];
                        }
                    }

                    if ( target_group === undefined ) {
                        for (let i = 0; i < cw.result_groups2.length; i++) {
                            if ( cw.result_groups2[i].group.group_id === group_id ) {
                                target_group = cw.result_groups2[i];
                            }
                        }
                    }

                    for (let i = 0; i < target_group.group.widxs.length; i++) {
                        $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview_2');
                    }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                                $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').addClass('preview-item_2');
                            }

                        }
                    }
                }

            });

            // 작업 2에서 제목이나 미리보기 버튼에 마우스 오버시
            $('#kaist5-group-list-2').on('mouseover', '.preview_group_button, .title', function(e) {
                // console.log($(this).data('group-id'));
                // console.log("들어왔다.");

                let group_id = $(this).data('group-id'),
                    target_group;

                for (let i = 0; i < cw.result_groups2.length; i++) {
                    if ( cw.result_groups2[i].group.group_id === group_id ) {
                        target_group = cw.result_groups2[i];
                    }
                }

                if ( target_group === undefined ) {
                    for (let i = 0; i < cw.result_groups2.length; i++) {
                        if ( cw.result_groups2[i].group.group_id === group_id ) {
                            target_group = cw.result_groups2[i];
                        }
                    }
                }

                for (let i = 0; i < target_group.group.widxs.length; i++) {
                    $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview_2');
                }

                if ( target_group.items.length !== 0 ) {
                    for (let i = 0; i < target_group.items.length; i++) {

                        for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                            $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').addClass('preview-item_2');
                        }

                    }
                }

            });

            // 작업 2에서 제목이나 미리보기 버튼에 마우스 벗어났을 때
            $('#kaist5-group-list-2').on('mouseleave', '.preview_group_button, .title', function(e) {

                if ( $('.preview_group_button[data-group-id="' + $(this).data('group-id') + '"]').hasClass('preview_group_active_2') ) {
                    return false;
                } else {
                    let group_id = $(this).data('group-id'),
                        target_group;

                    for (let i = 0; i < cw.result_groups2.length; i++) {
                        if ( cw.result_groups2[i].group.group_id === group_id ) {
                            target_group = cw.result_groups2[i];
                        }
                    }

                    if ( target_group === undefined ) {
                        for (let i = 0; i < cw.result_groups2.length; i++) {
                            if ( cw.result_groups2[i].group.group_id === group_id ) {
                                target_group = cw.result_groups2[i];
                            }
                        }
                    }

                    for (let i = 0; i < target_group.group.widxs.length; i++) {
                        $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').removeClass('preview_2');
                    }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++) {
                                $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').removeClass('preview-item_2');
                            }

                        }
                    }
                }
            });

            // 작업 2에서 개체에서 마우스 오버시
            $('#kaist5-group-list-2').on('mouseover', 'p.item', function(e) {
                // console.log($(this).data('group-id'));
                // console.log("들어왔다.");

                let group_id = $(this).parent().parent().parent().prev().data('group-id'),
                    item_id = $(this).data('item-id'),
                    target_group;

                for (let i = 0; i < cw.result_groups2.length; i++) {
                    if ( cw.result_groups2[i].group.group_id === group_id ) {
                        target_group = cw.result_groups2[i];
                    }
                }

                // for (let i = 0; i < target_group.group.widxs.length; i++) {
                //     $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview');
                // }

                if ( target_group.items.length !== 0 ) {
                    for (let i = 0; i < target_group.items.length; i++) {

                        for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                            if ( target_group.items[i].item_id === item_id) {
                                $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').addClass('preview-item_2');
                            }
                        }

                    }
                }

            });

            // 작업 2에서 개체에서 마우스 벗어났을 때
            $('#kaist5-group-list-2').on('mouseleave', 'p.item', function(e) {

                if ( $('.preview_item_button_2[data-item-id="' + $(this).data('item-id') + '"]').hasClass("preview_item_active_2") ) {
                    return false;
                } else {
                    let group_id = $(this).parent().parent().parent().prev().data('group-id'),
                        item_id = $(this).data('item-id'),
                        target_group;

                    for (let i = 0; i < cw.result_groups2.length; i++) {
                        if ( cw.result_groups2[i].group.group_id === group_id ) {
                            target_group = cw.result_groups2[i];
                        }
                    }

                    // for (let i = 0; i < target_group.group.widxs.length; i++) {
                    //     $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview');
                    // }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                                if ( target_group.items[i].item_id === item_id) {
                                    $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').removeClass('preview-item_2');
                                }
                            }

                        }
                    }

                    $('.preview_item_button_2[data-item-id="' + item_id + '"]').removeClass('preview_item_active_2');
                }

                // $('.preview-item').removeClass('preview-item');
            });

            // 작업 2에서 개체 미리보기 버튼 클릭했을 경우
            $('#kaist5-group-list-2').on('click', '.preview_item_button_2, p.item', function(e) {

                if ( $('.preview_item_button_2[data-item-id="' + $(this).data('item-id') + '"]').hasClass('preview_item_active_2') ) {
                    let group_id = $(this).data('group-id'),
                        item_id = $(this).data('item-id'),
                        target_group;

                    for (let i = 0; i < cw.result_groups2.length; i++) {
                        if ( cw.result_groups2[i].group.group_id === group_id ) {
                            target_group = cw.result_groups2[i];
                        }
                    }

                    // for (let i = 0; i < target_group.group.widxs.length; i++) {
                    //     $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview');
                    // }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                                if ( target_group.items[i].item_id === item_id) {
                                    $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').removeClass('preview-item_2');
                                }
                            }

                        }
                    }

                    $('.preview_item_button_2[data-item-id="' + item_id + '"]').removeClass('preview_item_active_2');
                } else {
                    let group_id = $(this).data('group-id'),
                        item_id = $(this).data('item-id'),
                        target_group;

                    for (let i = 0; i < cw.result_groups2.length; i++) {
                        if ( cw.result_groups2[i].group.group_id === group_id ) {
                            target_group = cw.result_groups2[i];
                        }
                    }

                    // for (let i = 0; i < target_group.group.widxs.length; i++) {
                    //     $('.kaist-sentence-word[data-widx="' + target_group.group.widxs[i] + '"]').addClass('preview');
                    // }

                    if ( target_group.items.length !== 0 ) {
                        for (let i = 0; i < target_group.items.length; i++) {

                            for (let j = 0; j < target_group.items[i].widxs.length; j++ ) {
                                if ( target_group.items[i].item_id === item_id) {
                                    $('.kaist-sentence-word[data-widx="' + target_group.items[i].widxs[j] + '"]').addClass('preview-item_2');
                                }
                            }

                        }
                    }

                    $('.preview_item_button_2[data-item-id="' + item_id + '"]').addClass('preview_item_active_2');
                }
            });
            // 작업 2



        };

        cw.event = {
            loadSentence: function (cont) {

                const corefs = cont.corefs;

                if ( !cw.corefs ) {
                    cw.corefs = {};
                }

                // 띄어쓰기를 위해 work_id 별로 그룹 저장
                for (let i = 0; i < corefs.length; i++) {

                    let sentence_id;

                    if ( ("" + corefs[i].sentence_id).length === 1 ) {
                        sentence_id = "000" + corefs[i].sentence_id;
                    } else if ( ("" + corefs[i].sentence_id).length === 2 ) {
                        sentence_id = "00" + corefs[i].sentence_id;
                    } else if ( ("" + corefs[i].sentence_id).length === 3 ) {
                        sentence_id = "0" + corefs[i].sentence_id;
                    } else if ( ("" + corefs[i].sentence_id).length === 4 ) {
                        sentence_id = "" + corefs[i].sentence_id;
                    }

                    cw.corefs["c-" + (corefs[i].paragraph_id + "-" + sentence_id)] = corefs[i];

                }

            },
            writeSentence: function () {
                $('#kaist-sentence').html('');

                const corefsKeys = Object.keys(cw.corefs);
                let html = "",
                    widx = 0;

                corefsKeys.sort();

                for (let i = 0; i < corefsKeys.length; i++) {

                    const speaker_color_p1 = "#43425D",
                        speaker_color_p2 = "#FFBB3B";

                    // 본문 출력
                    let word = "",
                        sentenceArr = cw.corefs[corefsKeys[i]].text.split(' '),
                        paragraph_id = corefsKeys[i].split('-')[1],
                        sentence_id = corefsKeys[i].split('-')[2],
                        speaker = cw.corefs[corefsKeys[i]].speaker;

                    html += "<span style='font-weight:700;'>" +  speaker + ": " + "</span>";

                    for (let j = 0; j < sentenceArr.length; j++) {
                        if ( j !== 0 ) {
                            // 띄어쓰기
                            html += "<span class='kaist-sentence-space'> </span>";
                        }
                        word = "";
                        word += sentenceArr[j];
                        widx += 1;

                        html += "<span class='kaist-sentence-word' data-paragraph-id='" + paragraph_id + "' data-sentence-id='" + sentence_id + "'data-word_id='" + j + "' data-widx='" + widx + "'>" + word + "</span>";
                        // html += "<span class='kaist-sentence-word' data-paragraph-id='" + paragraph_id + "' data-sentence-id='" + sentence_id + "'data-word_id='" + j + "'data-lemma_id="' +  +  data-widx='" + widx + "'>" + word + "</span>";

                    }
                    html += "<span class='kaist-sentence-space'> </span><br>";
                }

                $('#kaist-sentence').html(html);
            },
            rangeSelection: function (a, b) {

                let preview_text = "";
                let b_changed = false;

                const range = [...Array((b - a) + 1).keys()].map(i => i + a);

                $('.selected').removeClass('selected');
                for (let i = a; i < (a + range.length); i++) {
                    let idx = i - 1;
                    document.querySelectorAll("#kaist-sentence .kaist-sentence-word").item(idx).classList.add('selected');
                }

                let selectedWord = preview_text;

                // for ( let i = 0; i < $('.kaist-sentence-word.selected').length; i++ ) {
                //     preview_text += $($('.kaist-sentence-word.selected')[i]).text() + " ";
                // };

                $("#select-text").html(preview_text);

                $('#kaist5-morp-table').html('');
                let selWord = $('#kaist-sentence .kaist-sentence-word.selected');

                cw.selectedNEs = [];

                for (let i = 0; i < selWord.length; i++) {

                    let paragraph_id = $(selWord[i]).data('paragraph-id');
                    let sentence_id = $(selWord[i]).data('sentence-id');

                    if ( ("" + sentence_id).length === 1 ) {
                        sentence_id = "000" + sentence_id;
                    } else if ( ("" + sentence_id).length === 2 ) {
                        sentence_id = "00" + sentence_id;
                    } else if ( ("" + sentence_id).length === 3 ) {
                        sentence_id = "0" + sentence_id;
                    } else if ( ("" + sentence_id).length === 4 ) {
                        sentence_id = "" + sentence_id;
                    }

                    let a = cw.corefs["c-" + (paragraph_id + "-" + sentence_id)],
                        word_id = $(selWord[i]).data('word_id'),
                        widx = $(selWord[i]).data('widx'),
                        resultArr = [];

                    // console.log('##########################', widx);

                    for (let i = 0; i < a.NEs.length; i++) {
                        if ( a.NEs[i].word_id === word_id ) {
                            resultArr.push({
                                "NEs": a.NEs[i],
                                "ids": {
                                    "paragraph-id": a.paragraph_id,
                                    "sentence-id": a.sentence_id,
                                    "widx": widx
                                }
                            });
                        }
                    }
                    cw.event.createMorpTable(resultArr);

                    for (let i = 0; i < resultArr.length; i++) {
                        cw.selectedNEs.push(resultArr[i].NEs);
                    }
                }

            },
            createMorpTable: function (word, onlyView) {

                let html = "";

                if ( word ) {
                    for (let i = 0; i < word.length; i++) {
                        console.log(word[i].NEs.text);
                        html += "<tr data-paragraph-id=" + word[i].ids["paragraph-id"] + " data-sentence-id=" + word[i].ids["sentence-id"] + " data-lemma_id=" + word[i].NEs.lemma_id + " data-word_id=" + word[i].NEs.word_id + " data-widx=" + word[i].ids["widx"] + ">" +
                            "<td class='morp-result'><span class='morp-result-input'>" + word[i].NEs.text + "</span></td>" +
                            "<td><input id='check" + i + "' type='checkbox' checked=true " + (onlyView == true ? 'disabled=true' : '') + " > <label for='check" + i + "'>" + (onlyView == true ? '포함불가' : '포함') + "</label>" +
                            "</td>" +
                            "</tr>";
                    }
                }

                $('#kaist5-morp-table').append(html);

            },
            showResultData: function (type) {
                $('#group-data-list').html('');

                for (let i = 0; i < cw.morpDatas.length; i++) {
                    let text = "";
                    let lemmaId = [];
                    let wordIds = [];
                    let html = "<div class='group-data' style='position:relative;'>";
                    let keys = Object.keys(cw.morpDatas[i].data);
                    for (let y = 0; y < keys.length; y++) {
                        text += " " + cw.morpDatas[i].data["" + keys[y] + ""].text;
                        lemmaId = lemmaId.concat(cw.morpDatas[i].data["" + keys[y] + ""].lemma_id);
                        lemmaId.sort();
                        if ( wordIds.indexOf(cw.morpDatas[i].data["" + keys[y] + ""].word_id) < 0 ) {
                            wordIds.push(cw.morpDatas[i].data["" + keys[y] + ""].word_id);
                        }
                    }

                    text = text.trim();

                    html += '<div class="ui small input"><input type="text" value="' + text + '" style="width: 240px;"></div>';

                    if ( type === "group" ) {
                        let group_id = new Date().getTime();
                        html += '<div><button class="tiny ui button positive" id="add_group_button" data-type="group" data-group-id="' + group_id + '">확인</button><button id="cancle_add_group_button" class="mini ui red button">취소</button></div>';
                    } else if ( type === "item" ) {
                        html += '<div><button class="tiny ui button positive" id="add_group_button" data-type="item" data-group-id="' + cw.selected_group_id + '">확인</button><button id="cancle_add_group_button"  class="mini ui red button">취소</button></div>';
                    } else if ( type === "edit" ) {
                        html += '<div><button class="tiny ui button positive" id="edit_group_button" data-type="group" data-group-id="' + cw.selected_group_id + '">확인</button><button id="cancle_add_group_button"  class="mini ui red button">취소</button></div>';
                    } else if ( type === "edit_item" ) {
                        html += '<div><button class="tiny ui button positive" id="edit_group_button" data-type="item" data-group-id="' + cw.selected_group_id + '" data-item-id="' + cw.selected_item_id + '">확인</button><button id="cancle_add_group_button"  class="mini ui red button">취소</button></div>';
                    }

                    html += "</div>";

                    $(html).find('select').val(cw.morpDatas[i].tag);
                    $('#group-data-list').append(html);
                }
            },
            loadGroupList: function () {

                $('#kaist5-group-list').empty();

                let html = "";
                let groupData = $('.group-data input').val();

                if ( cw.kaist5_groups ) {
                    for (let i = 0; i < cw.kaist5_groups.length; i++) {
                        console.log(cw.kaist5_groups[i]);

                        html += '<div>';
                        html += '<div style="position: relative;">';
                        html += '<button class="ui horizontal label text_edit_button" data-type="item" data-group-id="' + cw.kaist5_groups[i].group.group_id + '">+</button>';
                        html += '<button class="ui horizontal label remove_group_button" data-type="item" data-group-id="' + cw.kaist5_groups[i].group.group_id + '">−</button>';
                        html += '<button class="ui horizontal label edit_group_button" data-type="item" data-group-id="' + cw.kaist5_groups[i].group.group_id + '">그룹수정</button>';
                        html += '<button class="ui horizontal label preview_group_button" data-type="group" data-group-id="' + cw.kaist5_groups[i].group.group_id + '"><i class="eye icon" style="margin: 0 !important;"></i></button>';
                        html += '</div>';

                        if ( cw.kaist5_groups[i].group.active ) {
                            html += '<div class="title active" style="height: 82px;" data-group-id="' + cw.kaist5_groups[i].group.group_id + '">';
                        } else {
                            html += '<div class="title" style="height: 82px;" data-group-id="' + cw.kaist5_groups[i].group.group_id + '">';
                        }

                        html += '<i class="dropdown icon"></i>';
                        html += '<div style="display: inline-block;width: 297px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap; height: 16px;">' + cw.kaist5_groups[i].group.text + '</div>';

                        html += '</div>';

                        if ( cw.kaist5_groups[i].group.active ) {
                            html += '<div class="content active">';
                        } else {
                            html += '<div class="content">';
                        }
                        for (let j = 0; j < cw.kaist5_groups[i].items.length; j++) {
                            html += '<div>';
                            html += '<div class="content-item-wrapper">';
                            html += '<p class="item" data-group-id="' + cw.kaist5_groups[i].group.group_id + '" data-item-id="' + cw.kaist5_groups[i].items[j].item_id + '">' + cw.kaist5_groups[i].items[j].text +'</p>';
                            html += '<div style="color:#cacbcd; text-align: right; width: 170px; min-width: 170px;">';
                            html += '<span class="preview_item_button" data-group-id="' + cw.kaist5_groups[i].group.group_id + '" data-item-id="' + cw.kaist5_groups[i].items[j].item_id + '"><i class="eye icon" style="margin: 0 !important;"></i></span> | ';
                            html += '<span class="add_memo" data-isedit="true" data-group-id="' + cw.kaist5_groups[i].group.group_id + '" data-item-id="' + cw.kaist5_groups[i].items[j].item_id + '">메모</span> | ';
                            html += '<span class="edit_item_button" data-isedit="true" data-group-id="' + cw.kaist5_groups[i].group.group_id + '" data-item-id="' + cw.kaist5_groups[i].items[j].item_id + '">수정</span> | ';
                            html += '<span class="remove_item_button" data-group-id="' + cw.kaist5_groups[i].group.group_id + '" data-item-id="' + cw.kaist5_groups[i].items[j].item_id + '" style="margin:0px;">삭제</span>';
                            html += '</div>';
                            html += '</div>';

                            if ( cw.kaist5_groups[i].items[j].cw_comment !== undefined ) {
                                html += '<div class="cw_comment">' + cw.kaist5_groups[i].items[j].cw_comment + '</div>';
                            }

                            html += '</div>';
                        }
                        html += '</div>';
                        html += '</div>';
                    }
                    $('#kaist5-group-list').append(html);
                }

            },
            loadGroupList_12: function () {

                // cw.result_groups1

                $('#kaist5-group-list-1').empty();
                $('#kaist5-group-list-2').empty();

                let html = "";
                let groupData = $('.group-data input').val();

                if ( cw.result_groups1 ) {
                    for (let i = 0; i < cw.result_groups1.length; i++) {

                        html += '<div>';
                        html += '<div style="position: relative;">';
                        html += '<button class="ui horizontal label check_group_button" data-type="group" data-group-id="' + cw.result_groups1[i].group.group_id + '" style="position: absolute; top: 12px; right: 50px !important"><i class="check icon" style="margin: 0 !important;"></i></button>';
                        html += '<button class="ui horizontal label preview_group_button" data-type="group" data-group-id="' + cw.result_groups1[i].group.group_id + '"><i class="eye icon" style="margin: 0 !important;"></i></button>';
                        html += '</div>';

                        html += '<div class="title" data-group-id="' + cw.result_groups1[i].group.group_id + '">';

                        html += '<i class="dropdown icon"></i>';
                        html += '<div style="display: inline-block;width: 282px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap; height: 16px;">' + cw.result_groups1[i].group.text + '</div>';

                        html += '</div>';

                        html += '<div class="content">';

                        for (let j = 0; j < cw.result_groups1[i].items.length; j++) {
                            html += '<div>';
                            html += '<div class="content-item-wrapper">';
                            html += '<p class="item" data-group-id="' + cw.result_groups1[i].group.group_id + '" data-item-id="' + cw.result_groups1[i].items[j].item_id + '">(' + (j+1) + ") " + cw.result_groups1[i].items[j].text +'</p>';
                            html += '<div style="color:#cacbcd; text-align: right; width: 145px; min-width: 145px;">';
                            html += '<span class="preview_item_button_1" data-group-id="' + cw.result_groups1[i].group.group_id + '" data-item-id="' + cw.result_groups1[i].items[j].item_id + '"><i class="eye icon" style="margin: 0px 11px 0px 0px !important"></i></span>';
                            html += '</div>';
                            html += '</div>';

                            if ( cw.result_groups1[i].items[j].cw_comment !== undefined ) {
                                html += '<div class="cw_comment">' + cw.result_groups1[i].items[j].cw_comment + '</div>';
                            }

                            html += '</div>';
                        }
                        html += '</div>';
                        html += '</div>';
                    }
                    $('#kaist5-group-list-1').append(html);
                } else {
                    const text = cw.result_groups1_problem_reason ? cw.result_groups1_problem_reason : "작업불가";
                    $('#kaist5-group-list-1').text(text);
                }

                html = "";

                if ( cw.result_groups2 ) {

                    for (let i = 0; i < cw.result_groups2.length; i++) {

                        html += '<div>';
                        html += '<div style="position: relative;">';
                        html += '<button class="ui horizontal label check_group_button" data-type="group" data-group-id="' + cw.result_groups2[i].group.group_id + '" style="position: absolute; top: 12px; right: 50px !important"><i class="check icon" style="margin: 0 !important;"></i></button>';
                        html += '<button class="ui horizontal label preview_group_button" data-type="group" data-group-id="' + cw.result_groups2[i].group.group_id + '"><i class="eye icon" style="margin: 0 !important;"></i></button>';
                        html += '</div>';

                        html += '<div class="title" data-group-id="' + cw.result_groups2[i].group.group_id + '">';

                        html += '<i class="dropdown icon"></i>';
                        html += '<div style="display: inline-block;width: 282px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap; height: 16px;">' + cw.result_groups2[i].group.text + '</div>';

                        html += '</div>';

                        html += '<div class="content">';

                        for (let j = 0; j < cw.result_groups2[i].items.length; j++) {
                            html += '<div>';
                            html += '<div class="content-item-wrapper">';
                            html += '<p class="item" data-group-id="' + cw.result_groups2[i].group.group_id + '" data-item-id="' + cw.result_groups2[i].items[j].item_id + '">(' + (j+1) + ") " + cw.result_groups2[i].items[j].text +'</p>';
                            html += '<div style="color:#cacbcd; text-align: right; width: 145px; min-width: 145px;">';
                            html += '<span class="preview_item_button_2" data-group-id="' + cw.result_groups2[i].group.group_id + '" data-item-id="' + cw.result_groups2[i].items[j].item_id + '"><i class="eye icon" style="margin: 0px 11px 0px 0px !important"></i></span>';
                            html += '</div>';
                            html += '</div>';

                            if ( cw.result_groups2[i].items[j].cw_comment !== undefined ) {
                                html += '<div class="cw_comment">' + cw.result_groups2[i].items[j].cw_comment + '</div>';
                            }

                            html += '</div>';
                        }
                        html += '</div>';
                        html += '</div>';
                    }
                    $('#kaist5-group-list-2').append(html);

                } else {
                    const text = cw.result_groups2_problem_reason ? cw.result_groups2_problem_reason : "작업불가";
                    $('#kaist5-group-list-2').text(text);
                }


            },
            getUsedInfo: function () {
                let usedWordIds = [];
                let usedTR = [];
                let widx;
                let trs = $('#kaist5-morp-table tr');
                let minWordIdx = null;
                let maxWordIdx = null;
                let checkText = "";
                let checkWordText = "";

                let flagWordId = null;

                for (let i = 0; i < trs.length; i++) {

                    let isChecked = $(trs[i]).find('input[type="checkbox"]').prop('checked');
                    if ( isChecked ) {

                        let pid = $(trs[i]).data('paragraph-id');
                        let sid = $(trs[i]).data('sentence-id');
                        let wid = $(trs[i]).data('word_id');

                        if ( minWordIdx == null || minWordIdx > Number($(trs[i]).data('word_id')) ) {
                            minWordIdx = Number($(trs[i]).data('word_id'));
                        }
                        if ( maxWordIdx == null || maxWordIdx < Number($(trs[i]).data('word_id')) ) {
                            maxWordIdx = Number($(trs[i]).data('word_id'));
                        }

                        if ( ("" + sid).length === 1 ) {
                            sid = "000" + sid;
                        } else if ( ("" + sid).length === 2 ) {
                            sid = "00" + sid;
                        } else if ( ("" + sid).length === 3 ) {
                            sid = "0" + sid;
                        } else if ( ("" + sid).length === 4 ) {
                            sid = "" + sid;
                        }

                        if ( usedWordIds.indexOf(Number($(trs[i]).data('word_id'))) < 0 && !isNaN(Number($(trs[i]).data('word_id'))) ) {
                            usedWordIds.push(Number(wid));
                            let widx = Number($('.kaist-sentence-word[data-paragraph-id="' + pid + '"].kaist-sentence-word[data-sentence-id="' + sid + '"].kaist-sentence-word[data-word_id="' + wid + '"]').data('widx'));
                            if ( isNaN(widx) ) {
                                alert('에러발생');
                                return false;
                            }

                            checkWordText += $('.kaist-sentence-word[data-widx="' + widx + '"]').text() + " ";

                            usedTR.push($(trs[i]));
                        } else if ( usedWordIds.indexOf(Number($(trs[i]).data('word_id'))) > -1 ) {
                            usedTR.push($(trs[i]));
                        }

                        if ( flagWordId != null && flagWordId != wid ) {
                            flagWordId = wid;
                            checkText += " ";
                        }
                        if ( flagWordId == null ) {
                            flagWordId = wid;
                        }
                        checkText += $(trs[i]).find('.morp-result-input').text();

                    }
                }
                if ( checkText ) {
                    checkText = checkText.trim();
                }
                if ( checkWordText ) {
                    checkWordText = checkWordText.trim();
                }

                return {
                    tr: usedTR,
                    usedWordIdxes: usedWordIds,
                    minWordId: minWordIdx,
                    maxWordId: maxWordIdx,
                    checkText: checkText,
                    checkWordText: checkWordText
                };
            },
            getPositions: function (pid, sid) {
                // test code
                // pid = 0,sid = 0;
                //

                let usedInfo = cw.event.getUsedInfo(); // 체크박스된 애들
                let startPosition = 0;  // idx들의 글자 길이 합산
                let endPosition = null;

                // wordIdx 의 최소전까지의 글자 길이 파악

                startPosition = cw.event.getPreLength(pid,sid);

                for (let i = 0; i < usedInfo.minWordId; i++) {
                    startPosition += ($('.kaist-sentence-word[data-word_id="' + i + '"].kaist-sentence-word[data-paragraph-id="' + pid + '"].kaist-sentence-word[data-sentence-id="' + sid + '"]').text() + " ").length;

                }

                startPosition = startPosition + usedInfo.checkWordText.indexOf(usedInfo.checkText);
                endPosition = startPosition + usedInfo.checkText.length;

                if ( startPosition == null || startPosition == undefined || endPosition == null || endPosition == undefined ) {
                    usedInfo.msg = "정상적으로 문장 위치정보가 조회되지 않았습니다.";
                    usedInfo.result = "FAIL";
                    usedInfo.startPosition = -1;
                    usedInfo.endPosition = -1;
                } else {
                    usedInfo.msg = "정상조회.";
                    usedInfo.result = "SUCCESS";
                    usedInfo.startPosition = startPosition;
                    usedInfo.endPosition = endPosition;
                }

                return usedInfo;
            },
            getPreLength: function (currentPID, currentSID) {
                console.log("#################-------------###################");
                let words = $('.kaist-sentence-word');
                let minParagraph = $($('.kaist-sentence-word').eq(0)).data('paragraph-id');
                let minSentence = 0;
                let paragraphWords = null, sentence = null;
                let sumLength = null;
                for (let i = minParagraph; i < currentPID; i++) {
                    let paragraphWords = $('.kaist-sentence-word[data-paragraph-id="' + i + '"]');
                    for (let y = 0; y < paragraphWords.length; y++) {
                        sumLength += ($(paragraphWords[y]).text() + " ").length;
                        console.log($(paragraphWords[y]).text() + " ");
                    }
                }
                console.log("#################-------------###################");
                for (let i = minSentence; i < currentSID; i++) {
                    let sentence = $('.kaist-sentence-word[data-paragraph-id="' + currentPID + '"].kaist-sentence-word[data-sentence-id="' + i + '"]');
                    for (let y = 0; y < sentence.length; y++) {
                        sumLength += ($(sentence[y]).text() + " ").length;
                        console.log($(sentence[y]).text() + " ");
                    }
                }
                console.log("#################-------------###################");
                return sumLength;
            }
        };

        // 페이지 초기화
        cw.reset = function () {
            $(':focus').blur(); // 모든 포커스 해제
            $('#question').html('');
            $('#answer').html('');
            $('.selected').removeClass('selected');
            return false;
        };

        // 데이터 추출
        cw.getWorkData = function () {

            // 저장할 데이터
            let resultJson = {};
            resultJson = cw.jsonCont;
            resultJson.groups = cw.kaist5_groups;
            resultJson.text = $('#kaist-sentence').text();


            // 리턴데이터
            let result = {};
            if ( !resultJson ) {
                result.success = false;
                result.msg = "선택된 값이 없습니다.";
            } else {
                result.success = true;
            }
            result.jsonData = JSON.stringify(resultJson);		// 필수
            result.workObjectNumber = 1;	 	// 오브젝트 단위에서는 1, 안줄경우 기본이 1로 저장된다.


            return result;

            // 검수에서 jsonData overWrite시에는 workObjectNumber까지 변경하진 않는다.
        };

        // 작업 시작
        cw.run();

    }

</script>
