<%-- 
    Document   : index
    Author     : bansraj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%><%@include file="header.jsp" %>

<h1>Welcome to Voting System</h1>
<p class="lead">Manage elections, candidates, and votes with this system.</p>

<div class="row mt-4">
    <div class="col-md-4">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Admins</h5>
                <p class="card-text">Manage system administrators</p>
                <a href="admin.jsp" class="btn btn-primary">Go to Admins</a>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Candidates</h5>
                <p class="card-text">Manage election candidates</p>
                <a href="candidate.jsp" class="btn btn-primary">Go to Candidates</a>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Citizens</h5>
                <p class="card-text">Manage registered citizens/voters</p>
                <a href="citizen.jsp" class="btn btn-primary">Go to Citizens</a>
            </div>
        </div>
    </div>
</div>

<div class="row mt-4">
    <div class="col-md-4">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Votes</h5>
                <p class="card-text">View and manage votes</p>
                <a href="vote.jsp" class="btn btn-primary">Go to Votes</a>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>