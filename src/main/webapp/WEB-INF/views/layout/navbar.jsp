<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--<% session.setAttribute("id", "id"); %>--%>
<link href="/resources/css/searchmodal.css" rel="stylesheet"/>

<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
    <a class="navbar-brand" href="#"><img
            src="/resources/images/logo_transparent.png" alt="Logo"
            style="width: 100px;"></a>
    <!-- Sidebar Toggle (Topbar) -->
    <button id="sidebarToggleTop"
            class="btn btn-link d-md-none rounded-circle mr-3">
        <i class="fa fa-bars"></i>
    </button>

    <!-- Topbar Search -->
    <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search justify-content-center ">
        <div class="input-group ">
            <input type="text" class="form-control bg-light border-0 small "
                   placeholder="Search for..." aria-label="Search"
                   aria-describedby="basic-addon2" data-toggle="modal" data-target="#searchModal" onclick="search_click();">
            <div class="input-group-append">
                <button class="btn btn-primary" type="button">
                    <i class="fas fa-search fa-sm"></i>
                </button>
            </div>
        </div>
    </form>
    
    <div class="modal fade" id="searchModal" role="dialog">
    <div class="modal-dialog searchModal">    
      <div class="modal-content searchModal">
        <div class="modal-header ">
        
			<a class="navbar-brand" href="#"><img
            src="/resources/images/logo_transparent.png" alt="Logo"
            style="width: 100px;" id="modallogo"></a>
            
		     <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search justify-content-center ">
		        <div class="input-group" id="modalsearch">
		            <input type="text" class="form-control bg-light border-0 small "
		                   placeholder="Search for..." aria-label="Search"
		                   aria-describedby="basic-addon2">
		            <div class="input-group-append">
		                <button class="btn btn-primary" type="button">
		                    <i class="fas fa-search fa-sm"></i>
		                </button>
		            </div>
		        </div>
		     </form>
		            

        </div>
        <div class="modal-body">
				<div>
					<h4>최근 검색어</h4>
				</div>
        </div>
        <div class="modal-footer">
        		<div>
        			<h4>실시간 인기</h4>
        		</div>
          <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
	</div>

    <!-- Topbar Navbar -->
    <ul class="navbar-nav ml-md-5">

        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
        <li class="nav-item dropdown no-arrow d-sm-none"><a
                class="nav-link dropdown-toggle" href="#" id="searchDropdown"
                role="button" data-toggle="dropdown" aria-haspopup="true"
                aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
        </a> <!-- Dropdown - Messages -->
            <div
                    class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                    aria-labelledby="searchDropdown">
                <form class="form-inline mr-auto w-100 navbar-search">
                    <div class="input-group">
                        <input type="text" class="form-control bg-light border-0 small"
                               placeholder="Search for..." aria-label="Search"
                               aria-describedby="basic-addon2">
                        <div class="input-group-append">
                            <button class="btn btn-primary" type="button">
                                <i class="fas fa-search fa-sm"></i>
                            </button>
                        </div>
                    </div>
                </form>
            </div></li>

        <c:choose>
            <c:when test="${ sessionScope.id eq null || sessionScope.id eq 'null'}">
                <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#loginModal">로그인</button>&nbsp; &nbsp;
                <a class="btn btn-primary" href="/member/register">회원가입</a>
            </c:when>
            <c:otherwise>
                <!-- Nav Item - Alerts -->
                <li class="nav-item dropdown no-arrow mx-1"><a
                        class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
                        role="button" data-toggle="dropdown" aria-haspopup="true"
                        aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts -->
                    <span class="badge badge-danger badge-counter">3+</span>
                </a> <!-- Dropdown - Alerts -->
                    <div
                            class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                            aria-labelledby="alertsDropdown">
                        <h6 class="dropdown-header">Alerts Center</h6>
                        <a class="dropdown-item d-flex align-items-center" href="#">
                            <div class="mr-3">
                                <div class="icon-circle bg-primary">
                                    <i class="fas fa-file-alt text-white"></i>
                                </div>
                            </div>
                            <div>
                                <div class="small text-gray-500">December 12, 2019</div>
                                <span class="font-weight-bold">A new monthly report is
									ready to download!</span>
                            </div>
                        </a> <a class="dropdown-item d-flex align-items-center" href="#">
                        <div class="mr-3">
                            <div class="icon-circle bg-success">
                                <i class="fas fa-donate text-white"></i>
                            </div>
                        </div>
                        <div>
                            <div class="small text-gray-500">December 7, 2019</div>
                            $290.29 has been deposited into your account!
                        </div>
                    </a> <a class="dropdown-item d-flex align-items-center" href="#">
                        <div class="mr-3">
                            <div class="icon-circle bg-warning">
                                <i class="fas fa-exclamation-triangle text-white"></i>
                            </div>
                        </div>
                        <div>
                            <div class="small text-gray-500">December 2, 2019</div>
                            Spending Alert: We've noticed unusually high spending for your
                            account.
                        </div>
                    </a> <a class="dropdown-item text-center small text-gray-500" href="#">Show
                        All Alerts</a>
                    </div></li>

                <!-- Nav Item - Messages -->
                <li class="nav-item dropdown no-arrow mx-1"><a
                        class="nav-link dropdown-toggle" href="#" id="messagesDropdown"
                        role="button" data-toggle="dropdown" aria-haspopup="true"
                        aria-expanded="false"> <i class="fas fa-envelope fa-fw"></i> <!-- Counter - Messages -->
                    <span class="badge badge-danger badge-counter">7</span>
                </a> <!-- Dropdown - Messages -->
                    <div
                            class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                            aria-labelledby="messagesDropdown">
                        <h6 class="dropdown-header">Message Center</h6>
                        <a class="dropdown-item d-flex align-items-center" href="#">
                            <div class="dropdown-list-image mr-3">
                                <img class="rounded-circle" src="img/undraw_profile_1.svg"
                                     alt="...">
                                <div class="status-indicator bg-success"></div>
                            </div>
                            <div class="font-weight-bold">
                                <div class="text-truncate">Hi there! I am wondering if you
                                    can help me with a problem I've been having.</div>
                                <div class="small text-gray-500">Emily Fowler · 58m</div>
                            </div>
                        </a> <a class="dropdown-item d-flex align-items-center" href="#">
                        <div class="dropdown-list-image mr-3">
                            <img class="rounded-circle" src="img/undraw_profile_2.svg"
                                 alt="...">
                            <div class="status-indicator"></div>
                        </div>
                        <div>
                            <div class="text-truncate">I have the photos that you
                                ordered last month, how would you like them sent to you?</div>
                            <div class="small text-gray-500">Jae Chun · 1d</div>
                        </div>
                    </a> <a class="dropdown-item d-flex align-items-center" href="#">
                        <div class="dropdown-list-image mr-3">
                            <img class="rounded-circle" src="img/undraw_profile_3.svg"
                                 alt="...">
                            <div class="status-indicator bg-warning"></div>
                        </div>
                        <div>
                            <div class="text-truncate">Last month's report looks
                                great, I am very happy with the progress so far, keep up the
                                good work!</div>
                            <div class="small text-gray-500">Morgan Alvarez · 2d</div>
                        </div>
                    </a> <a class="dropdown-item d-flex align-items-center" href="#">
                        <div class="dropdown-list-image mr-3">
                            <img class="rounded-circle"
                                 src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="...">
                            <div class="status-indicator bg-success"></div>
                        </div>
                        <div>
                            <div class="text-truncate">Am I a good boy? The reason I
                                ask is because someone told me that people say this to all
                                dogs, even if they aren't good...</div>
                            <div class="small text-gray-500">Chicken the Dog · 2w</div>
                        </div>
                    </a> <a class="dropdown-item text-center small text-gray-500" href="#">Read
                        More Messages</a>
                    </div></li>

                <div class="topbar-divider d-none d-sm-block"></div>

                <!-- Nav Item - User Information -->
                <li class="nav-item dropdown no-arrow"><a
                        class="nav-link dropdown-toggle" href="#" id="userDropdown"
                        role="button" data-toggle="dropdown" aria-haspopup="true"
                        aria-expanded="false"> <img class="img-profile rounded-circle" src="img/undraw_profile.svg">
                        <span class="mr-2 d-none d-lg-inline text-gray-600 small">Douglas McGee</span>
                </a> <!-- Dropdown - User Information -->
                    <div
                            class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                            aria-labelledby="userDropdown">
                        <a class="dropdown-item" href="#"> <i
                                class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> Profile
                        </a> <a class="dropdown-item" href="#"> <i
                            class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> Settings
                    </a> <a class="dropdown-item" href="#"> <i
                            class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i> Activity
                        Log
                    </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#" data-toggle="modal"
                           data-target="#logoutModal"> <i
                                class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                            Logout
                        </a>
                    </div></li>
            </c:otherwise>
        </c:choose>
    </ul>
</nav>


<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="../resources/js/searchmodal.js"></script>