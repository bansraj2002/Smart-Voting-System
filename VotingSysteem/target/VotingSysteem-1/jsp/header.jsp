<%-- 
    Document   : header
    Author     : bansraj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Voting System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { padding: 20px; }
        .form-container { max-width: 600px; margin: 0 auto; }
        .table-container { margin-top: 20px; }
    </style>
    </head>
    <body>
         <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.jsp">Voting System</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="admin.jsp">Admins</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="candidate.jsp">Candidates</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="citizen.jsp">Citizens</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="vote.jsp">Votes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="votecenter.jsp">Vote Centers</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="votingmachine.jsp">Voting Machines</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>    <div class="container">

    </body>
</html>
