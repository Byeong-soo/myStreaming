<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="l-navbar" id="navbar">
	<nav class="nav">
		<div>
			<div class="nav__brand">
				<ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle"></ion-icon>
				<a href="/" class="nav__logo">myStreaming</a>
			</div>
			<c:if test="${not empty id }">
				<div>
					<span class="nav__title"> <ion-icon name="heart-outline"
					class="nav__icon" data-toggle="tooltip" data-placement="right" title="팔로우 중인 채널"></ion-icon>
					<span class="nav_name">팔로우 중인 채널</span>
					</span>
				</div>
				<c:choose>
                	<c:when test="${ not empty bookmarkList }">
                		<div class="nav__bookmark">
                		<c:forEach var="bookmark" items="${ bookmarkList }">
                			<c:if test="${not empty bookmark.streamerLogin }">
								<a href="https://www.twitch.tv/${bookmark.streamerLogin}" class="nav__follow" id="nav__follow${bookmark.streamerId}" target="_blank">
								<img class="nav__img" alt="사진" src="${bookmark.profileImageUrl }"> <span
								class="nav_name">${ bookmark.streamerName }</span>
								<span class="twitchIs_live" id="${bookmark.streamerName}"></span>
								</a>
							</c:if>
							<c:if test="${ empty bookmark.streamerLogin }">
								<a href="https://www.youtube.com/channel/${bookmark.streamerId}" class="nav__follow" id="nav__follow${bookmark.streamerId}" target="_blank">
							 	<img class="nav__img" alt="사진" src="${bookmark.profileImageUrl }"> <span
								class="nav_name">${ bookmark.streamerName }</span>
								<span class="youtubeIs_live" id="isLive${bookmark.streamerName}"></span>
								</a>
							</c:if>
							
                		</c:forEach>
                		</div>
                	</c:when>
                	<c:otherwise>

                	</c:otherwise>
                </c:choose>
			</c:if>

			
			<div class="nav__list">
				<a href="#" class="nav__link nav_active"> <ion-icon
						name="home-outline" class="nav__icon"></ion-icon> <span
					class="nav_name">Dashboard</span>
				</a> <a href="#" class="nav__link"> <ion-icon
						name="chatbubbles-outline" class="nav__icon"></ion-icon> <span
					class="nav_name">Messenger</span>
				</a>

				<div href="#" class="nav__link" id="collapse">
					<ion-icon name="folder-outline" class="nav__icon"></ion-icon>
					<span class="nav_name">Boards</span>

					<ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>

					<ul class="collapse__menu">
						<a href="#" class="collapse__sublink">Q&A</a>
						<a href="#" class="collapse__sublink">Group</a>
						<a href="#" class="collapse__sublink">Members</a>
						<a href="/boardCategory/list" class="collapse  sublink">boardCategory</a>
					</ul>
				</div>

				<a href="#" class="nav__link"> <ion-icon
						name="pie-chart-outline" class="nav__icon"></ion-icon> <span
					class="nav_name">Analytics</span>
				</a>

				<div href="#" class="nav__link" id="collapse">
					<ion-icon name="people-outline" class="nav__icon"></ion-icon>
					<span class="nav_name">Team</span>

					<ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>

					<ul class="collapse__menu">
						<a href="#" class="collapse__sublink">Data</a>
						<a href="#" class="collapse__sublink">Group</a>
						<a href="#" class="collapse__sublink">Members</a>
					</ul>
				</div>

				<a href="#" class="nav__link"> <ion-icon name="settings-outline"
						class="nav__icon"></ion-icon> <span class="nav_name">Settings</span>
				</a>
			</div>
			<a href="#" class="nav__link"> <ion-icon name="log-out-outline"
					class="nav__icon"></ion-icon> <span class="nav_name">Log out</span>
			</a>
		</div>
	</nav>
</div>