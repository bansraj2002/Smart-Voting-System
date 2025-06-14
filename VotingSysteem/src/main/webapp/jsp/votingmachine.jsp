<%-- 
    Document   : votingmachine
    Author     : bansraj
--%>

<%@include file="header.jsp" %>
<%@page import="ejb.VotingBeanLocal"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="entities.VotingMachine"%>
<%@page import="entities.VoteCenter"%>
<%@page import="java.util.ArrayList"%>

<%! VotingBeanLocal votingBean; %>

<%
    votingBean = (VotingBeanLocal) new InitialContext().lookup("java:global/VotingSysteem/VotingBean!ejb.VotingBeanLocal");
    String action = request.getParameter("action");
    
    if ("delete".equals(action)) {
        int machineID = Integer.parseInt(request.getParameter("machineID"));
        votingBean.deleteVotingMachine(machineID);
    } else if ("edit".equals(action)) {
        int machineID = Integer.parseInt(request.getParameter("machineID"));
        VotingMachine machine = votingBean.readVotingMachine(machineID);
        request.setAttribute("machineToEdit", machine);
    } else if ("save".equals(action)) {
        VotingMachine machine;
        if (request.getParameter("machineID").isEmpty()) {
            machine = new VotingMachine();
        } else {
            machine = votingBean.readVotingMachine(Integer.parseInt(request.getParameter("machineID")));
        }
        machine.setStatus(request.getParameter("status"));
        
        if (!request.getParameter("centerID").isEmpty()) {
            VoteCenter center = votingBean.readVoteCenter(Integer.parseInt(request.getParameter("centerID")));
            machine.setCenterID(center);
        }
        
        if (request.getParameter("machineID").isEmpty()) {
            votingBean.createVotingMachine(machine);
        } else {
            votingBean.updateVotingMachine(machine);
        }
    }
%>

<h2>Voting Machine Management</h2>

<div class="card form-container">
    <div class="card-header">
        <%= request.getAttribute("machineToEdit") != null ? "Edit Voting Machine" : "Add New Voting Machine" %>
    </div>
    <div class="card-body">
        <form method="post">
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="machineID" value="${machineToEdit.machineID}">
            
            <div class="mb-3">
                <label class="form-label">Status</label>
                <select class="form-select" name="status" required>
                    <option value="Active" ${machineToEdit.status eq 'Active' ? 'selected' : ''}>Active</option>
                    <option value="Inactive" ${machineToEdit.status eq 'Inactive' ? 'selected' : ''}>Inactive</option>
                    <option value="Maintenance" ${machineToEdit.status eq 'Maintenance' ? 'selected' : ''}>Maintenance</option>
                </select>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Vote Center</label>
                <select class="form-select" name="centerID" required>
                    <option value="">-- Select Vote Center --</option>
                    <% for (VoteCenter center : votingBean.getAllVoteCenters()) { %>
                    <option value="<%= center.getCenterID() %>" 
                            <%= request.getAttribute("machineToEdit") != null && 
                               ((VotingMachine)request.getAttribute("machineToEdit")).getCenterID() != null && 
                               ((VotingMachine)request.getAttribute("machineToEdit")).getCenterID().getCenterID() == center.getCenterID() ? "selected" : "" %>>
                        <%= center.getLocation() %> (Capacity: <%= center.getCapacity() %>)
                    </option>
                    <% } %>
                </select>
            </div>
            
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="votingmachine.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</div>

<div class="table-container">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Status</th>
                <th>Vote Center</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (VotingMachine machine : votingBean.getAllVotingMachines()) { %>
            <tr>
                <td><%= machine.getMachineID() %></td>
                <td><%= machine.getStatus() %></td>
                <td><%= machine.getCenterID() != null ? machine.getCenterID().getLocation() : "N/A" %></td>
                <td>
                    <a href="votingmachine.jsp?action=edit&machineID=<%= machine.getMachineID() %>" 
                       class="btn btn-sm btn-warning">Edit</a>
                    <a href="votingmachine.jsp?action=delete&machineID=<%= machine.getMachineID() %>" 
                       class="btn btn-sm btn-danger" 
                       onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

<%@include file="footer.jsp" %>