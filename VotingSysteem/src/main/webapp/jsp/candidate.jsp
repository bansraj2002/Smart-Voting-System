<%-- 
    Document   : candidate
    Author     : bansraj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<%@page import="ejb.VotingBeanLocal"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="entities.Candidate"%>
<%@page import="entities.Citizen"%>
<%@page import="java.util.ArrayList"%>

<%! VotingBeanLocal votingBean; %>

<%
    votingBean = (VotingBeanLocal) new InitialContext().lookup("java:global/VotingSysteem/VotingBean!ejb.VotingBeanLocal");
    String action = request.getParameter("action");
    
    if ("delete".equals(action)) {
        int candidateID = Integer.parseInt(request.getParameter("candidateID"));
        votingBean.deleteCandidate(candidateID);
    } else if ("edit".equals(action)) {
        int candidateID = Integer.parseInt(request.getParameter("candidateID"));
        Candidate candidate = votingBean.readCandidate(candidateID);
        request.setAttribute("candidateToEdit", candidate);
    } else if ("save".equals(action)) {
        Candidate candidate;
        if (request.getParameter("candidateID").isEmpty()) {
            candidate = new Candidate();
        } else {
            candidate = votingBean.readCandidate(Integer.parseInt(request.getParameter("candidateID")));
        }
        candidate.setName(request.getParameter("name"));
        candidate.setParty(request.getParameter("party"));
        candidate.setBio(request.getParameter("bio"));
        
        if (!request.getParameter("citizenID").isEmpty()) {
            Citizen citizen = votingBean.readCitizen(Integer.parseInt(request.getParameter("citizenID")));
            candidate.setCitizenID(citizen);
        }
        
        if (request.getParameter("candidateID").isEmpty()) {
            votingBean.createCandidate(candidate);
        } else {
            votingBean.updateCandidate(candidate);
        }
    }
%>

<h2>Candidate Management</h2>

<div class="card form-container">
    <div class="card-header">
        <%= request.getAttribute("candidateToEdit") != null ? "Edit Candidate" : "Add New Candidate" %>
    </div>
    <div class="card-body">
        <form method="post">
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="candidateID" value="${candidateToEdit.candidateID}">
            
            <div class="mb-3">
                <label class="form-label">Name</label>
                <input type="text" class="form-control" name="name" 
                       value="${candidateToEdit.name}" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Party</label>
                <input type="text" class="form-control" name="party" 
                       value="${candidateToEdit.party}" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Bio</label>
                <textarea class="form-control" name="bio" rows="3">${candidateToEdit.bio}</textarea>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Citizen</label>
                <select class="form-select" name="citizenID">
                    <option value="">-- Select Citizen --</option>
                    <% for (Citizen citizen : votingBean.getAllCitizens()) { %>
                    <option value="<%= citizen.getCitizenID() %>" 
                            <%= request.getAttribute("candidateToEdit") != null && 
                               ((Candidate)request.getAttribute("candidateToEdit")).getCitizenID() != null && 
                               ((Candidate)request.getAttribute("candidateToEdit")).getCitizenID().getCitizenID() == citizen.getCitizenID() ? "selected" : "" %>>
                        <%= citizen.getName() %>
                    </option>
                    <% } %>
                </select>
            </div>
            
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="candidate.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</div>

<div class="table-container">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Party</th>
                <th>Citizen</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (Candidate candidate : votingBean.getAllCandidates()) { %>
            <tr>
                <td><%= candidate.getCandidateID() %></td>
                <td><%= candidate.getName() %></td>
                <td><%= candidate.getParty() %></td>
                <td><%= candidate.getCitizenID() != null ? candidate.getCitizenID().getName() : "N/A" %></td>
                <td>
                    <a href="candidate.jsp?action=edit&candidateID=<%= candidate.getCandidateID() %>" 
                       class="btn btn-sm btn-warning">Edit</a>
                    <a href="candidate.jsp?action=delete&candidateID=<%= candidate.getCandidateID() %>" 
                       class="btn btn-sm btn-danger" 
                       onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

<%@include file="footer.jsp" %>