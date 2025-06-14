<%-- 
    Document   : votecenter
    Author     : bansraj
--%>

<%@include file="header.jsp" %>
<%@page import="ejb.VotingBeanLocal"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="entities.VoteCenter"%>
<%@page import="java.util.ArrayList"%>

<%! VotingBeanLocal votingBean; %>

<%
    votingBean = (VotingBeanLocal) new InitialContext().lookup("java:global/VotingSysteem/VotingBean!ejb.VotingBeanLocal");
    String action = request.getParameter("action");
    
    if ("delete".equals(action)) {
        int centerID = Integer.parseInt(request.getParameter("centerID"));
        votingBean.deleteVoteCenter(centerID);
    } else if ("edit".equals(action)) {
        int centerID = Integer.parseInt(request.getParameter("centerID"));
        VoteCenter center = votingBean.readVoteCenter(centerID);
        request.setAttribute("centerToEdit", center);
    } else if ("save".equals(action)) {
        VoteCenter center;
        if (request.getParameter("centerID").isEmpty()) {
            center = new VoteCenter();
        } else {
            center = votingBean.readVoteCenter(Integer.parseInt(request.getParameter("centerID")));
        }
        center.setLocation(request.getParameter("location"));
        
        if (!request.getParameter("capacity").isEmpty()) {
            center.setCapacity(Integer.parseInt(request.getParameter("capacity")));
        }
        
        if (request.getParameter("centerID").isEmpty()) {
            votingBean.createVoteCenter(center);
        } else {
            votingBean.updateVoteCenter(center);
        }
    }
%>

<h2>Vote Center Management</h2>

<div class="card form-container">
    <div class="card-header">
        <%= request.getAttribute("centerToEdit") != null ? "Edit Vote Center" : "Add New Vote Center" %>
    </div>
    <div class="card-body">
        <form method="post">
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="centerID" value="${centerToEdit.centerID}">
            
            <div class="mb-3">
                <label class="form-label">Location</label>
                <input type="text" class="form-control" name="location" 
                       value="${centerToEdit.location}" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Capacity</label>
                <input type="number" class="form-control" name="capacity" 
                       value="${centerToEdit.capacity}" required>
            </div>
            
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="votecenter.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</div>

<div class="table-container">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Location</th>
                <th>Capacity</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (VoteCenter center : votingBean.getAllVoteCenters()) { %>
            <tr>
                <td><%= center.getCenterID() %></td>
                <td><%= center.getLocation() %></td>
                <td><%= center.getCapacity() != null ? center.getCapacity() : "N/A" %></td>
                <td>
                    <a href="votecenter.jsp?action=edit&centerID=<%= center.getCenterID() %>" 
                       class="btn btn-sm btn-warning">Edit</a>
                    <a href="votecenter.jsp?action=delete&centerID=<%= center.getCenterID() %>" 
                       class="btn btn-sm btn-danger" 
                       onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

<%@include file="footer.jsp" %>
