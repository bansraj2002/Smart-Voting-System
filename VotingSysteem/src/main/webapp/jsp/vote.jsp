<%-- 
    Document   : vote
    Author     : bansraj
--%>
<%-- 
    Document   : vote
    Author     : bansraj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<%@page import="ejb.VotingBeanLocal"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="entities.Vote"%>
<%@page import="entities.Candidate"%>
<%@page import="entities.Citizen"%>
<%@page import="entities.VotingMachine"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%! 
    VotingBeanLocal votingBean;
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
%>

<%
    votingBean = (VotingBeanLocal) new InitialContext().lookup("java:global/VotingSysteem/VotingBean!ejb.VotingBeanLocal");
    String action = request.getParameter("action");

    if ("delete".equals(action)) {
        int voteID = Integer.parseInt(request.getParameter("voteID"));
        votingBean.deleteVote(voteID);
    } else if ("edit".equals(action)) {
        int voteID = Integer.parseInt(request.getParameter("voteID"));
        Vote vote = votingBean.readVote(voteID);
        request.setAttribute("voteToEdit", vote);
    } else if ("save".equals(action)) {
        Vote vote;
        boolean isNew = request.getParameter("voteID").isEmpty();

        if (isNew) {
            vote = new Vote();
        } else {
            vote = votingBean.readVote(Integer.parseInt(request.getParameter("voteID")));
        }

        // Set timestamp: use current time for new, use form value for edit
        if (isNew) {
            vote.setTimestamp(new Date());
        } else if (!request.getParameter("timestamp").isEmpty()) {
            vote.setTimestamp(dateFormat.parse(request.getParameter("timestamp")));
        }

        if (!request.getParameter("candidateID").isEmpty()) {
            Candidate candidate = votingBean.readCandidate(Integer.parseInt(request.getParameter("candidateID")));
            vote.setCandidateID(candidate);
        }

        if (!request.getParameter("citizenID").isEmpty()) {
            Citizen citizen = votingBean.readCitizen(Integer.parseInt(request.getParameter("citizenID")));
            vote.setCitizenID(citizen);
        }

        if (!request.getParameter("machineID").isEmpty()) {
            VotingMachine machine = votingBean.readVotingMachine(Integer.parseInt(request.getParameter("machineID")));
            vote.setMachineID(machine);
        }

        if (isNew) {
            votingBean.createVote(vote);
        } else {
            votingBean.updateVote(vote);
        }
    }

    // Prepare timestamp value for hidden field
    String timestampValue;
    if (request.getAttribute("voteToEdit") != null) {
        timestampValue = dateFormat.format(((Vote) request.getAttribute("voteToEdit")).getTimestamp());
    } else {
        timestampValue = dateFormat.format(new Date());
    }
%>

<h2>Vote Management</h2>

<div class="card form-container">
    <div class="card-header">
        <%= request.getAttribute("voteToEdit") != null ? "Edit Vote" : "Add New Vote" %>
    </div>
    <div class="card-body">
        <form method="post">
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="voteID" value="${voteToEdit.voteID}">
            <input type="hidden" name="timestamp" value="<%= timestampValue %>">

            <div class="mb-3">
                <label class="form-label">Candidate</label>
                <select class="form-select" name="candidateID" required>
                    <option value="">-- Select Candidate --</option>
                    <% for (Candidate candidate : votingBean.getAllCandidates()) { %>
                    <option value="<%= candidate.getCandidateID() %>" 
                            <%= request.getAttribute("voteToEdit") != null &&
                                 ((Vote)request.getAttribute("voteToEdit")).getCandidateID() != null &&
                                 ((Vote)request.getAttribute("voteToEdit")).getCandidateID().getCandidateID() == candidate.getCandidateID() ? "selected" : "" %>>
                        <%= candidate.getName() %> (<%= candidate.getParty() %>)
                    </option>
                    <% } %>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Citizen</label>
                <select class="form-select" name="citizenID" required>
                    <option value="">-- Select Citizen --</option>
                    <% for (Citizen citizen : votingBean.getAllCitizens()) { %>
                    <option value="<%= citizen.getCitizenID() %>" 
                            <%= request.getAttribute("voteToEdit") != null &&
                                 ((Vote)request.getAttribute("voteToEdit")).getCitizenID() != null &&
                                 ((Vote)request.getAttribute("voteToEdit")).getCitizenID().getCitizenID() == citizen.getCitizenID() ? "selected" : "" %>>
                        <%= citizen.getName() %>
                    </option>
                    <% } %>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Voting Machine</label>
                <select class="form-select" name="machineID" required>
                    <option value="">-- Select Voting Machine --</option>
                    <% for (VotingMachine machine : votingBean.getAllVotingMachines()) { %>
                    <option value="<%= machine.getMachineID() %>" 
                            <%= request.getAttribute("voteToEdit") != null &&
                                 ((Vote)request.getAttribute("voteToEdit")).getMachineID() != null &&
                                 ((Vote)request.getAttribute("voteToEdit")).getMachineID().getMachineID() == machine.getMachineID() ? "selected" : "" %>>
                        <%= machine.getMachineID() %> (<%= machine.getStatus() %>)
                    </option>
                    <% } %>
                </select>
            </div>

            <button type="submit" class="btn btn-primary">Save</button>
            <a href="vote.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</div>

<div class="table-container">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Timestamp</th>
                <th>Candidate</th>
                <th>Citizen</th>
                <th>Machine</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (Vote vote : votingBean.getAllVotes()) { %>
            <tr>
                <td><%= vote.getVoteID() %></td>
                <td><%= dateFormat.format(vote.getTimestamp()) %></td>
                <td><%= vote.getCandidateID().getName() %></td>
                <td><%= vote.getCitizenID().getName() %></td>
                <td><%= vote.getMachineID().getMachineID() %></td>
                <td>
                    <a href="vote.jsp?action=edit&voteID=<%= vote.getVoteID() %>" class="btn btn-sm btn-warning">Edit</a>
                    <a href="vote.jsp?action=delete&voteID=<%= vote.getVoteID() %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

<%@include file="footer.jsp" %>
