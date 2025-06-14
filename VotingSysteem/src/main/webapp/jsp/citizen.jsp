<%-- 
    Document   : citizen
    Author     : bansraj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%><%@include file="header.jsp" %>
<%@page import="ejb.VotingBeanLocal"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="entities.Citizen"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>

<%!
    VotingBeanLocal votingBean;
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>

<%
    votingBean = (VotingBeanLocal) new InitialContext().lookup("java:global/VotingSysteem/VotingBean!ejb.VotingBeanLocal");
    String action = request.getParameter("action");

    if ("delete".equals(action)) {
        int citizenID = Integer.parseInt(request.getParameter("citizenID"));
        votingBean.deleteCitizen(citizenID);
    } else if ("edit".equals(action)) {
        int citizenID = Integer.parseInt(request.getParameter("citizenID"));
        Citizen citizen = votingBean.readCitizen(citizenID);
        request.setAttribute("citizenToEdit", citizen);
    } else if ("save".equals(action)) {
        Citizen citizen;
        if (request.getParameter("citizenID").isEmpty()) {
            citizen = new Citizen();
        } else {
            citizen = votingBean.readCitizen(Integer.parseInt(request.getParameter("citizenID")));
        }
        citizen.setName(request.getParameter("name"));
        citizen.setAddress(request.getParameter("address"));

        if (!request.getParameter("dateOfBirth").isEmpty()) {
            citizen.setDateOfBirth(dateFormat.parse(request.getParameter("dateOfBirth")));
        }

//        if (!request.getParameter("voterID").isEmpty()) {
//            citizen.setVoterID(Integer.parseInt(request.getParameter("voterID")));
//        }
        if (!request.getParameter("voterID").isEmpty()) {
            citizen.setVoterID(Integer.parseInt(request.getParameter("voterID")));
        } else {
            citizen.setVoterID(0); // <-- Needed!
        }

        if (request.getParameter("citizenID").isEmpty()) {
            votingBean.createCitizen(citizen);
        } else {
            votingBean.updateCitizen(citizen);
        }
    }
%>

<h2>Citizen Management</h2>

<div class="card form-container">
    <div class="card-header">
        <%= request.getAttribute("citizenToEdit") != null ? "Edit Citizen" : "Add New Citizen"%>
    </div>
    <div class="card-body">
        <form method="post">
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="citizenID" value="${citizenToEdit.citizenID}">

            <div class="mb-3">
                <label class="form-label">Name</label>
                <input type="text" class="form-control" name="name" 
                       value="${citizenToEdit.name}" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Address</label>
                <input type="text" class="form-control" name="address" 
                       value="${citizenToEdit.address}" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Date of Birth</label>
                <input type="date" class="form-control" name="dateOfBirth" 
                       value="<%= request.getAttribute("citizenToEdit") != null
                               ? dateFormat.format(((Citizen) request.getAttribute("citizenToEdit")).getDateOfBirth()) : ""%>">
            </div>

            <div class="mb-3">
                <label class="form-label">Voter ID</label>
                <input type="number" class="form-control" name="voterID" 
                       value="${citizenToEdit.voterID}">
            </div>

            <button type="submit" class="btn btn-primary">Save</button>
            <a href="citizen.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</div>

<div class="table-container">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Address</th>
                <th>Date of Birth</th>
                <th>Voter ID</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (Citizen citizen : votingBean.getAllCitizens()) {%>
            <tr>
                <td><%= citizen.getCitizenID()%></td>
                <td><%= citizen.getName()%></td>
                <td><%= citizen.getAddress()%></td>
                <td><%= citizen.getDateOfBirth() != null ? dateFormat.format(citizen.getDateOfBirth()) : "N/A"%></td>
                <td>
                    <%=  citizen.getVoterID() != 0 ? citizen.getVoterID() : "N/A" %>
                </td>
                <td>
                    <a href="citizen.jsp?action=edit&citizenID=<%= citizen.getCitizenID()%>" 
                       class="btn btn-sm btn-warning">Edit</a>
                    <a href="citizen.jsp?action=delete&citizenID=<%= citizen.getCitizenID()%>" 
                       class="btn btn-sm btn-danger" 
                       onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
            <% }%>
        </tbody>
    </table>
</div>

<%@include file="footer.jsp" %>