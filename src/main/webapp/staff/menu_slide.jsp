<div class="scrollbar-sidebar"> 
    <div class="app-sidebar__inner">
        <ul class="vertical-nav-menu">
            <li class="app-sidebar__heading">Menu</li>
            <li class="mm-active">
                <a href="#">
                    <i class="metismenu-icon pe-7s-rocket"></i>Dashboards
                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                    <c:choose>
                        <c:when test="${not empty Staff}">
                            <li>
                                <a href="${pageContext.request.contextPath}/staff/dashboard" >
                                    <i class="metismenu-icon"></i>Analytics
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/staff/showTimeManagement">
                                    <i class="metismenu-icon"></i>Show Time Management 
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/staff/ticketManagement">
                                    <i class="metismenu-icon"></i>Ticket Management 
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/staff/screenroom" >
                                    <i class="metismenu-icon"></i>Screen Room
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a href="${pageContext.request.contextPath}/staff/listcinema">
                                    <i class="metismenu-icon"></i>List Cinema
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/staff/promotion">
                                    <i class="metismenu-icon"></i>Promotion
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/staff/registerStaffAcount">
                                    <i class="metismenu-icon"></i>Staff
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/staff/movieManagement">
                                    <i class="metismenu-icon"></i>Movie Management 
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/staff/combo" >
                                    <i class="metismenu-icon"></i>Combo
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>


                </ul>
            </li>
        </ul>
    </div>
</div>
