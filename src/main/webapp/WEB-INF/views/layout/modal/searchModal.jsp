<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="modal" id="searchModal" tabindex="-1" aria-labelledby="searchModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">

                <div style="display: flex; width: 100%">
                    <div class="col-2 offset-1 logo">
                        <img src="/resources/images/tempLogo2.png" alt="로고">
                        <span>myStreaming</span>
                    </div>

                    <div class="offset-1 col-4 search-bar">
                        <div class="input-icon">
                            <input type="text" class="form-control" id="searchModalInput" placeholder="어떤 방송을 찾고계신가요?" name="search">
                            <a class="append-icon" id="search-button"><i class="bi bi-search"></i></a>
                        </div>
                        <div>
                            <span class="modal-close-span" data-dismiss="modal">취소</span>
                        </div>
                    </div>
                </div>


            </div>
            <div class="modal-body col-4 m-auto">
                <div class="search-result-container">
                    <div style="display: flex;justify-content: space-between">
                        <span class="search-result-class">최근 검색어</span>
                        <span class="delete-span">전체 삭제</span>
                    </div>
                    <div class="search-results">

                    </div>
                </div>

                <div class="search-result-container">
                    <div style="display: flex;padding-top: 17px">
                        <span class="search-result-class">추천 스트리머</span>
                    </div>
                    <div style="margin: 15px 0">
                        <button class="btn custom-button">풍월량</button>
                    </div>

                </div>
                <div class="search-result-container">
                    <div style="display: flex;padding-top: 17px">
                        <span class="search-result-class">인기 검색어</span>
                        <span class="search-timer">
                            <i class="bi bi-clock"></i>
                            <span class="search-time">

                            </span>
                            기준
                        </span>
                    </div>
                    <div class="search-rank-container" style="display: flex">
                        <div class="search-rank-left" style="display: flex;flex-direction: column;flex: 1">
                            <div class="search-rank-one">
                                <span class="search-rank-num">1</span><span class="search-rank-word">풍월량</span>
                            </div>
                            <div class="search-rank-one">
                                <span class="search-rank-num">2</span><span class="search-rank-word">풍월량</span>
                            </div>
                            <div class="search-rank-one">
                                <span class="search-rank-num">3</span><span class="search-rank-word">풍월량</span>
                            </div>
                            <div class="search-rank-one">
                                <span class="search-rank-num">4</span><span class="search-rank-word">풍월량</span>
                            </div>
                            <div class="search-rank-one">
                                <span class="search-rank-num">5</span><span class="search-rank-word">풍월량</span>
                            </div>
                        </div>
                        <div class="search-rank-right" style="display: flex;flex-direction: column;flex: 1">
                            <div class="search-rank-one">
                                <span class="search-rank-num">6</span><span class="search-rank-word">풍월량</span>
                            </div>
                            <div class="search-rank-one">
                                <span class="search-rank-num">7</span><span class="search-rank-word">풍월량</span>
                            </div>
                            <div class="search-rank-one">
                                <span class="search-rank-num">8</span><span class="search-rank-word">풍월량</span>
                            </div>
                            <div class="search-rank-one">
                                <span class="search-rank-num">9</span><span class="search-rank-word">풍월량</span>
                            </div>
                            <div class="search-rank-one">
                                <span class="search-rank-num">10</span><span class="search-rank-word">풍월량</span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>