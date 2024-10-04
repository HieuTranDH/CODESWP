<%@ page import="model.DAO.Ticket_DB" %>
<%@ page import="util.DateUtils" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="model.DAO.Movie_DB" %>
<%@ page import="model.DAO.Cinema_DB" %>
<%@ page import="model.Cinema" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!doctype html>
<html lang="en">

    <!-- Mirrored from demo.dashboardpack.com/architectui-html-pro/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 23 Sep 2024 02:38:30 GMT -->
    <%@include file="head.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <body>
        <div class="app-container app-theme-white body-tabs-shadow fixed-header fixed-sidebar">
            <%@include file="header.jsp"%>
            <div class="ui-theme-settings">
                <button type="button" id="TooltipDemo" class="btn-open-options btn btn-warning">
                    <i class="fa fa-cog fa-w-16 fa-spin fa-2x"></i>
                </button>
                <div class="theme-settings__inner">
                    <div class="scrollbar-container">
                        <div class="theme-settings__options-wrapper">
                            <h3 class="themeoptions-heading">Layout Options</h3>
                            <div class="p-3">
                                <ul class="list-group">
                                    <li class="list-group-item">
                                        <div class="widget-content p-0">
                                            <div class="widget-content-wrapper">
                                                <div class="widget-content-left mr-3">
                                                    <div class="switch has-switch switch-container-class" data-class="fixed-header">
                                                        <div class="switch-animate switch-on">
                                                            <input type="checkbox" checked data-toggle="toggle" data-onstyle="success">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="widget-content-left">
                                                    <div class="widget-heading">Fixed Header</div>
                                                    <div class="widget-subheading">Makes the header top fixed, always visible!</div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="widget-content p-0">
                                            <div class="widget-content-wrapper">
                                                <div class="widget-content-left mr-3">
                                                    <div class="switch has-switch switch-container-class" data-class="fixed-sidebar">
                                                        <div class="switch-animate switch-on">
                                                            <input type="checkbox" checked data-toggle="toggle" data-onstyle="success">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="widget-content-left">
                                                    <div class="widget-heading">Fixed Sidebar</div>
                                                    <div class="widget-subheading">Makes the sidebar left fixed, always visible!</div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="widget-content p-0">
                                            <div class="widget-content-wrapper">
                                                <div class="widget-content-left mr-3">
                                                    <div class="switch has-switch switch-container-class" data-class="fixed-footer">
                                                        <div class="switch-animate switch-off">
                                                            <input type="checkbox" data-toggle="toggle" data-onstyle="success">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="widget-content-left">
                                                    <div class="widget-heading">Fixed Footer</div>
                                                    <div class="widget-subheading">Makes the app footer bottom fixed, always visible!</div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <h3 class="themeoptions-heading">
                                <div> Header Options </div>
                                <button type="button" class="btn-pill btn-shadow btn-wide ml-auto btn btn-focus btn-sm switch-header-cs-class" data-class>
                                    Restore Default
                                </button>
                            </h3>
                            <div class="p-3">
                                <ul class="list-group">
                                    <li class="list-group-item">
                                        <h5 class="pb-2">Choose Color Scheme</h5>
                                        <div class="theme-settings-swatches">
                                            <div class="swatch-holder bg-primary switch-header-cs-class" data-class="bg-primary header-text-light"></div>
                                            <div class="swatch-holder bg-secondary switch-header-cs-class" data-class="bg-secondary header-text-light"></div>
                                            <div class="swatch-holder bg-success switch-header-cs-class" data-class="bg-success header-text-light"></div>
                                            <div class="swatch-holder bg-info switch-header-cs-class" data-class="bg-info header-text-light"></div>
                                            <div class="swatch-holder bg-warning switch-header-cs-class" data-class="bg-warning header-text-dark"></div>
                                            <div class="swatch-holder bg-danger switch-header-cs-class" data-class="bg-danger header-text-light"></div>
                                            <div class="swatch-holder bg-light switch-header-cs-class" data-class="bg-light header-text-dark"></div>
                                            <div class="swatch-holder bg-dark switch-header-cs-class" data-class="bg-dark header-text-light"></div>
                                            <div class="swatch-holder bg-focus switch-header-cs-class" data-class="bg-focus header-text-light"></div>
                                            <div class="swatch-holder bg-alternate switch-header-cs-class" data-class="bg-alternate header-text-light"></div>
                                            <div class="divider"></div>
                                            <div class="swatch-holder bg-vicious-stance switch-header-cs-class" data-class="bg-vicious-stance header-text-light"></div>
                                            <div class="swatch-holder bg-midnight-bloom switch-header-cs-class" data-class="bg-midnight-bloom header-text-light"></div>
                                            <div class="swatch-holder bg-night-sky switch-header-cs-class" data-class="bg-night-sky header-text-light"></div>
                                            <div class="swatch-holder bg-slick-carbon switch-header-cs-class" data-class="bg-slick-carbon header-text-light"></div>
                                            <div class="swatch-holder bg-asteroid switch-header-cs-class" data-class="bg-asteroid header-text-light"></div>
                                            <div class="swatch-holder bg-royal switch-header-cs-class" data-class="bg-royal header-text-light"></div>
                                            <div class="swatch-holder bg-warm-flame switch-header-cs-class" data-class="bg-warm-flame header-text-dark"></div>
                                            <div class="swatch-holder bg-night-fade switch-header-cs-class" data-class="bg-night-fade header-text-dark"></div>
                                            <div class="swatch-holder bg-sunny-morning switch-header-cs-class" data-class="bg-sunny-morning header-text-dark"></div>
                                            <div class="swatch-holder bg-tempting-azure switch-header-cs-class" data-class="bg-tempting-azure header-text-dark"></div>
                                            <div class="swatch-holder bg-amy-crisp switch-header-cs-class" data-class="bg-amy-crisp header-text-dark"></div>
                                            <div class="swatch-holder bg-heavy-rain switch-header-cs-class" data-class="bg-heavy-rain header-text-dark"></div>
                                            <div class="swatch-holder bg-mean-fruit switch-header-cs-class" data-class="bg-mean-fruit header-text-dark"></div>
                                            <div class="swatch-holder bg-malibu-beach switch-header-cs-class" data-class="bg-malibu-beach header-text-light"></div>
                                            <div class="swatch-holder bg-deep-blue switch-header-cs-class" data-class="bg-deep-blue header-text-dark"></div>
                                            <div class="swatch-holder bg-ripe-malin switch-header-cs-class" data-class="bg-ripe-malin header-text-light"></div>
                                            <div class="swatch-holder bg-arielle-smile switch-header-cs-class" data-class="bg-arielle-smile header-text-light"></div>
                                            <div class="swatch-holder bg-plum-plate switch-header-cs-class" data-class="bg-plum-plate header-text-light"></div>
                                            <div class="swatch-holder bg-happy-fisher switch-header-cs-class" data-class="bg-happy-fisher header-text-dark"></div>
                                            <div class="swatch-holder bg-happy-itmeo switch-header-cs-class" data-class="bg-happy-itmeo header-text-light"></div>
                                            <div class="swatch-holder bg-mixed-hopes switch-header-cs-class" data-class="bg-mixed-hopes header-text-light"></div>
                                            <div class="swatch-holder bg-strong-bliss switch-header-cs-class" data-class="bg-strong-bliss header-text-light"></div>
                                            <div class="swatch-holder bg-grow-early switch-header-cs-class" data-class="bg-grow-early header-text-light"></div>
                                            <div class="swatch-holder bg-love-kiss switch-header-cs-class" data-class="bg-love-kiss header-text-light"></div>
                                            <div class="swatch-holder bg-premium-dark switch-header-cs-class" data-class="bg-premium-dark header-text-light"></div>
                                            <div class="swatch-holder bg-happy-green switch-header-cs-class" data-class="bg-happy-green header-text-light"></div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <h3 class="themeoptions-heading">
                                <div>Sidebar Options</div>
                                <button type="button" class="btn-pill btn-shadow btn-wide ml-auto btn btn-focus btn-sm switch-sidebar-cs-class" data-class>
                                    Restore Default
                                </button>
                            </h3>
                            <div class="p-3">
                                <ul class="list-group">

                                    <li class="list-group-item">
                                        <h5 class="pb-2">Choose Color Scheme</h5>
                                        <div class="theme-settings-swatches">
                                            <div class="swatch-holder bg-primary switch-sidebar-cs-class" data-class="bg-primary sidebar-text-light"></div>
                                            <div class="swatch-holder bg-secondary switch-sidebar-cs-class" data-class="bg-secondary sidebar-text-light"></div>
                                            <div class="swatch-holder bg-success switch-sidebar-cs-class" data-class="bg-success sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-info switch-sidebar-cs-class" data-class="bg-info sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-warning switch-sidebar-cs-class" data-class="bg-warning sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-danger switch-sidebar-cs-class" data-class="bg-danger sidebar-text-light"></div>
                                            <div class="swatch-holder bg-light switch-sidebar-cs-class" data-class="bg-light sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-dark switch-sidebar-cs-class" data-class="bg-dark sidebar-text-light"></div>
                                            <div class="swatch-holder bg-focus switch-sidebar-cs-class" data-class="bg-focus sidebar-text-light"></div>
                                            <div class="swatch-holder bg-alternate switch-sidebar-cs-class" data-class="bg-alternate sidebar-text-light"></div>
                                            <div class="divider"></div>
                                            <div class="swatch-holder bg-vicious-stance switch-sidebar-cs-class" data-class="bg-vicious-stance sidebar-text-light"></div>
                                            <div class="swatch-holder bg-midnight-bloom switch-sidebar-cs-class" data-class="bg-midnight-bloom sidebar-text-light"></div>
                                            <div class="swatch-holder bg-night-sky switch-sidebar-cs-class" data-class="bg-night-sky sidebar-text-light"></div>
                                            <div class="swatch-holder bg-slick-carbon switch-sidebar-cs-class" data-class="bg-slick-carbon sidebar-text-light"></div>
                                            <div class="swatch-holder bg-asteroid switch-sidebar-cs-class" data-class="bg-asteroid sidebar-text-light"></div>
                                            <div class="swatch-holder bg-royal switch-sidebar-cs-class" data-class="bg-royal sidebar-text-light"></div>
                                            <div class="swatch-holder bg-warm-flame switch-sidebar-cs-class" data-class="bg-warm-flame sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-night-fade switch-sidebar-cs-class" data-class="bg-night-fade sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-sunny-morning switch-sidebar-cs-class" data-class="bg-sunny-morning sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-tempting-azure switch-sidebar-cs-class" data-class="bg-tempting-azure sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-amy-crisp switch-sidebar-cs-class" data-class="bg-amy-crisp sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-heavy-rain switch-sidebar-cs-class" data-class="bg-heavy-rain sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-mean-fruit switch-sidebar-cs-class" data-class="bg-mean-fruit sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-malibu-beach switch-sidebar-cs-class" data-class="bg-malibu-beach sidebar-text-light"></div>
                                            <div class="swatch-holder bg-deep-blue switch-sidebar-cs-class" data-class="bg-deep-blue sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-ripe-malin switch-sidebar-cs-class" data-class="bg-ripe-malin sidebar-text-light"></div>
                                            <div class="swatch-holder bg-arielle-smile switch-sidebar-cs-class" data-class="bg-arielle-smile sidebar-text-light"></div>
                                            <div class="swatch-holder bg-plum-plate switch-sidebar-cs-class" data-class="bg-plum-plate sidebar-text-light"></div>
                                            <div class="swatch-holder bg-happy-fisher switch-sidebar-cs-class" data-class="bg-happy-fisher sidebar-text-dark"></div>
                                            <div class="swatch-holder bg-happy-itmeo switch-sidebar-cs-class" data-class="bg-happy-itmeo sidebar-text-light"></div>
                                            <div class="swatch-holder bg-mixed-hopes switch-sidebar-cs-class" data-class="bg-mixed-hopes sidebar-text-light"></div>
                                            <div class="swatch-holder bg-strong-bliss switch-sidebar-cs-class" data-class="bg-strong-bliss sidebar-text-light"></div>
                                            <div class="swatch-holder bg-grow-early switch-sidebar-cs-class" data-class="bg-grow-early sidebar-text-light"></div>
                                            <div class="swatch-holder bg-love-kiss switch-sidebar-cs-class" data-class="bg-love-kiss sidebar-text-light"></div>
                                            <div class="swatch-holder bg-premium-dark switch-sidebar-cs-class" data-class="bg-premium-dark sidebar-text-light"></div>
                                            <div class="swatch-holder bg-happy-green switch-sidebar-cs-class" data-class="bg-happy-green sidebar-text-light"></div>
                                        </div>
                                    </li>


                                </ul>
                            </div>
                            <h3 class="themeoptions-heading">
                                <div>Main Content Options</div>
                                <button type="button" class="btn-pill btn-shadow btn-wide ml-auto active btn btn-focus btn-sm">Restore Default</button>
                            </h3>
                            <div class="p-3">
                                <ul class="list-group">

                                    <li class="list-group-item">
                                        <h5 class="pb-2">Page Section Tabs</h5>
                                        <div class="theme-settings-swatches">
                                            <div role="group" class="mt-2 btn-group">
                                                <button type="button" class="btn-wide btn-shadow btn-primary btn btn-secondary switch-theme-class" data-class="body-tabs-line"> Line</button>
                                                <button type="button" class="btn-wide btn-shadow btn-primary active btn btn-secondary switch-theme-class" data-class="body-tabs-shadow"> Shadow </button>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <h5 class="pb-2">Light Color Schemes
                                        </h5>
                                        <div class="theme-settings-swatches">
                                            <div role="group" class="mt-2 btn-group">
                                                <button type="button" class="btn-wide btn-shadow btn-primary active btn btn-secondary switch-theme-class" data-class="app-theme-white"> White Theme</button>
                                                <button type="button" class="btn-wide btn-shadow btn-primary btn btn-secondary switch-theme-class" data-class="app-theme-gray"> Gray Theme</button>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <div class="app-main">
                <div class="app-sidebar sidebar-shadow">
                    <div class="app-header__logo">
                        <div class="logo-src"></div>
                        <div class="header__pane ml-auto">
                            <div>
                                <button type="button" class="hamburger close-sidebar-btn hamburger--elastic" data-class="closed-sidebar">
                                    <span class="hamburger-box">
                                        <span class="hamburger-inner"></span>
                                    </span>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="app-header__mobile-menu">
                        <div>
                            <button type="button" class="hamburger hamburger--elastic mobile-toggle-nav">
                                <span class="hamburger-box">
                                    <span class="hamburger-inner"></span>
                                </span>
                            </button>
                        </div>
                    </div>
                    <div class="app-header__menu">
                        <span>
                            <button type="button" class="btn-icon btn-icon-only btn btn-primary btn-sm mobile-toggle-header-nav">
                                <span class="btn-icon-wrapper">
                                    <i class="fa fa-ellipsis-v fa-w-6"></i>
                                </span>
                            </button>
                        </span>
                    </div> 
                    <div class="scrollbar-sidebar">
                        <%@include file="menu_slide.jsp" %>
                    </div>
                </div><div class="app-main__outer">
                    <div class="app-main__inner">
                        <div class="app-page-title">
                            <div class="page-title-wrapper">
                                <div class="page-title-heading">
                                    <div class="page-title-icon">
                                        <i class="fas fa-car icon-gradient bg-mean-fruit"></i>
                                    </div>
                                    <div>Analytics Dashboard
                                        <div class="page-title-subheading">Take a look at the statistics and data carefully!</div>
                                    </div>
                                </div>
                            </div>

                            <c:choose>
                                <c:when test="${not empty Staff}">
                                    <c:set var="StaffAdmin" value="${Staff}" />
                                </c:when>
                                <c:otherwise>
                                    <c:set var="StaffAdmin" value="${Staff2}" />
                                </c:otherwise>
                            </c:choose>

                            <div class="tabs-animation">
                                <c:set var="date" value="${DateUtils.getCurrentMonthYear()}" />
                                <div class="mb-3 card">
                                    <div class="card-header-tab card-header">
                                        <div class="card-header-title font-size-lg text-capitalize font-weight-normal">
                                            <i style="margin-left:450px" class="header-icon lnr-charts icon-gradient bg-happy-green"> </i>
                                            <c:set var="cinema" value="${Cinema_DB.getCinemaByStaffId(StaffAdmin.getStaffId())}" />
                                            <span style="font-size: 1.5em; text-decoration: underline; font-weight: bold;">
                                                ${cinema.getName()}
                                            </span>
                                        </div>

                                        <div class="btn-actions-pane-right text-capitalize">
                                            <div class="btn-wide btn-outline-2x mr-md-2 btn btn-outline-focus btn-sm">${StaffAdmin.name}</div>
                                        </div>
                                    </div>
                                    <div class="card-header-tab card-header">
                                        <div class="card-header-title font-size-lg text-capitalize font-weight-normal">
                                            <i class="header-icon fa fa-chart-line icon-gradient bg-happy-green"></i>
                                            Monthly Statistics - ${date}
                                        </div>
                                    </div>
                                    <div class="no-gutters row d-flex justify-content-center align-items-center">
                                        <!-- Number of tickets sold -->
                                        <div class="col-sm-6 col-md-4 col-xl-4 d-flex justify-content-center align-items-center">
                                            <div class="card no-shadow rm-border bg-transparent widget-chart text-left">
                                                <div class="icon-wrapper rounded-circle">
                                                    <div class="icon-wrapper-bg opacity-10 bg-warning"></div>
                                                    <i class="fa fa-ticket-alt text-dark opacity-8"></i>
                                                </div>
                                                <div class="widget-chart-content text-center">
                                                    <div class="widget-subheading">Number of tickets sold</div>
                                                    <c:set var="monthnow" value="${DateUtils.getCurrentMonth()}" />
                                                    <c:set var="yearnow" value="${DateUtils.getCurrentYear()}" />
                                                    <c:set var="idstaff" value="${StaffAdmin.getStaffId()}" />
                                                    <!--Nho Thay Doi Gia Tri Trong Ham Duoi -->
                                                    <c:set var="ticket" value="${Ticket_DB.getAllTickets(idstaff,monthnow,yearnow)}" />
                                                    <div class="widget-numbers"><c:out value="${fn:length(ticket)}" /> Ticket</div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Total income -->
                                        <div class="col-sm-6 col-md-4 col-xl-4 d-flex justify-content-center align-items-center">
                                            <div class="card no-shadow rm-border bg-transparent widget-chart text-left">
                                                <div class="icon-wrapper rounded-circle">
                                                    <div class="icon-wrapper-bg opacity-9 bg-danger"></div>
                                                    <i class="fa fa-dollar-sign text-white"></i>
                                                </div>
                                                <div class="widget-chart-content text-center">
                                                    <c:set var="totalPrice" value="0.0" />
                                                    <c:forEach var="t" items="${ticket}">
                                                        <c:set var="totalPrice" value="${totalPrice + t.price}" />
                                                    </c:forEach>
                                                    <div class="widget-subheading">Total income</div>
                                                    <div class="widget-numbers"><span>${totalPrice}D</span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!--Nho Thay Doi Gia Tri Cua StaffId và year-->
                                <%
 int staffId = (int) pageContext.getAttribute("idstaff"); // Example staff ID
 int year = (int) pageContext.getAttribute("yearnow"); // Example year
// Retrieve data from the DAO
Map<Integer, int[]> ticketStats = Ticket_DB.getTicketStatsForYear(staffId, year);

List<String> months = Arrays.asList("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
List<Integer> revenues = new ArrayList<>();
List<Integer> ticketsSold = new ArrayList<>(); // To store the number of tickets sold

// Loop through the months and gather both revenue and tickets sold data
for (int month = 1; month <= 12; month++) {
int[] stats = ticketStats.get(month);
if (stats != null) {
ticketsSold.add(stats[0]);  // Number of tickets sold
revenues.add(stats[1]);     // Revenue
} else {
ticketsSold.add(0);         // Default to 0 if no data
revenues.add(0);            // Default to 0 if no data
}
}
                                %>
                                <div style="margin-bottom: 30px" class="container mt-5">
                                    <div class="row">
                                        <!-- First Chart: Revenue -->
                                        <div class="col-md-6">
                                            <h2>Revenue by Month for 2024</h2>
                                            <canvas id="revenueChart" width="400" height="200"></canvas>
                                        </div>

                                        <!-- Second Chart: Tickets Sold -->
                                        <div class="col-md-6">
                                            <h2>Tickets Sold by Month for 2024</h2>
                                            <canvas id="ticketsSoldChart" width="400" height="200"></canvas>
                                        </div>
                                    </div>
                                </div>
                                <script>
                                    // Data from the server
                                    const months = <%= new com.google.gson.Gson().toJson(months) %>;
                                    const revenues = <%= new com.google.gson.Gson().toJson(revenues) %>;
                                    const ticketsSold = <%= new com.google.gson.Gson().toJson(ticketsSold) %>;

                                    // Create the chart for revenue
                                    const ctxRevenue = document.getElementById('revenueChart').getContext('2d');
                                    const revenueChart = new Chart(ctxRevenue, {
                                        type: 'bar',
                                        data: {
                                            labels: months, // Labels are the months
                                            datasets: [{
                                                    label: 'Revenue',
                                                    data: revenues, // Total revenue
                                                    backgroundColor: 'rgba(153, 102, 255, 0.2)',
                                                    borderColor: 'rgba(153, 102, 255, 1)',
                                                    borderWidth: 1
                                                }]
                                        },
                                        options: {
                                            scales: {
                                                y: {
                                                    beginAtZero: true
                                                }
                                            }
                                        }
                                    });

                                    // Create the chart for tickets sold
                                    const ctxTickets = document.getElementById('ticketsSoldChart').getContext('2d');
                                    const ticketsChart = new Chart(ctxTickets, {
                                        type: 'bar',
                                        data: {
                                            labels: months, // Labels are the months
                                            datasets: [{
                                                    label: 'Tickets Sold',
                                                    data: ticketsSold, // Total tickets sold
                                                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                                    borderColor: 'rgba(75, 192, 192, 1)',
                                                    borderWidth: 1
                                                }]
                                        },
                                        options: {
                                            scales: {
                                                y: {
                                                    beginAtZero: true
                                                }
                                            }
                                        }
                                    });
                                </script>

                                <style>
                                    hr{
                                        margin: 5px 0;
                                    }
                                    .rank-col img{
                                        width: 100%;
                                        max-width: 200px;
                                    }
                                    .rank-1 .rank-information{
                                        margin-top: 20px;

                                    }
                                    .rank-2{
                                        margin-top: 40px;
                                    }
                                    .rank-3{
                                        margin-top: 65px;
                                    }
                                    .ranl-col{
                                        margin-left: 20px;
                                        margin-right:20px;
                                    }
                                    .rank-information h3{
                                        color:white;
                                        font-size: 13px;
                                        font-weight: 600;
                                    }
                                    .rank-information {
                                        position: relative;
                                        color: white;
                                        top: -37%;
                                        left: 0;
                                        width: 100%;
                                        z-index: 99;
                                    }
                                    .gift{
                                        margin: 5px 0 0 0;
                                    }
                                    .gift img{
                                        width:40px;
                                    }
                                </style>

                                <div class="card mb-3">
                                    <c:set var="movielist" value="${Movie_DB.getActiveMoviesByStaff(idstaff)}" />
                                    <div class="card w-100">
                                        <div class="card-body p-4">
                                            <h2 class="text-center">Ranking</h2>
                                            <div class="rank row mx-auto w-100">
                                                <c:if test="${movielist.size() == 1}">
                                                    <div class="rank-col col-12 text-center">
                                                        <img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/top1.png">
                                                        <div class="rank-information">
                                                            <h3 class="text-center ">${movielist.get(0).getTitle()}</h3>
                                                            <hr/>
                                                            <c:set var="movieid0" value="${movielist.get(0).getMovieId()}"/>
                                                            <c:set var="count0" value="${Ticket_DB.countTicketsByMovie(movieid0)}" />
                                                            <p class="text-center">Ticket ${count0}</p>
                                                        </div>
                                                    </div>
                                                </c:if>
                                                <c:if test="${movielist.size() > 1}">
                                                    <c:if test="${movielist.size() > 1}">
                                                        <div class="rank-col col-4 rank-2">
                                                            <img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/top2.png">
                                                            <div class="rank-information">
                                                                <h3 class="text-center ">${movielist.get(1).getTitle()}</h3>
                                                                <hr/>
                                                                <c:set var="movieid1" value="${movielist.get(1).getMovieId()}"/>
                                                                <c:set var="count1" value="${Ticket_DB.countTicketsByMovie(movieid1)}" />
                                                                <p class="text-center">Ticket: ${count1}</p>
                                                            </div>
                                                        </div>
                                                    </c:if>

                                                    <div class="rank-col col-4 rank-1 ">
                                                        <img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/top1.png">
                                                        <div class="rank-information">
                                                            <h3 class="text-center ">${movielist.get(0).getTitle()}</h3>
                                                            <hr/>
                                                            <c:set var="movieid0" value="${movielist.get(0).getMovieId()}"/>
                                                            <c:set var="count0" value="${Ticket_DB.countTicketsByMovie(movieid0)}" />
                                                            <p class="text-center">Ticket ${count0}</p>
                                                        </div>
                                                    </div>

                                                    <c:if test="${movielist.size() > 2}">
                                                        <div class="rank-col col-4 rank-3">
                                                            <img class="mx-auto d-block" src="${pageContext.request.contextPath}/static/images/rank/top3.png">
                                                            <div class="rank-information">
                                                                <h3 class="text-center ">${movielist.get(2).getTitle()}</h3>
                                                                <hr/>
                                                                <c:set var="movieid2" value="${movielist.get(2).getMovieId()}"/>
                                                                <c:set var="count2" value="${Ticket_DB.countTicketsByMovie(movieid2)}" />
                                                                <p class="text-center">Ticket ${count2}</p>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="card mb-3">
                                    <div class="card w-100">
                                        <div class="card-body p-4">
                                            <div style="max-height: 400px; overflow-y: scroll;">
                                                <table class="table table-striped table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Rank</th>
                                                            <th scope="col" class="text-center">Title</th>
                                                            <th scope="col" class="text-center">Ticket</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:set var="MovieIndex" value="${4}" />
                                                        <c:forEach var="movie" items="${movielist}" begin="3" end="49">
                                                            <tr>
                                                                <c:set var="movieid2" value="${movie.getMovieId()}"/>
                                                                <c:set var="count2" value="${Ticket_DB.countTicketsByMovie(movieid2)}" />
                                                                <th scope="row">${MovieIndex}</th>
                                                                <td class="text-center">${movie.getTitle()}</td>
                                                                <td class="text-center">${count2}</td>
                                                            </tr>
                                                            <c:set var="MovieIndex" value="${MovieIndex + 1}" />
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%@include file="footer.jsp" %>
                        </div>
                    </div>
                </div>
                <%@include file="draw_wrapper.jsp"%>
                </html>