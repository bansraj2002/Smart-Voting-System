<%--<%@page import="entities.Role"%>
<%@include file="header.jsp" %>
<%@page import="ejb.VotingBeanLocal"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="entities.Admin"%>
<%@page import="java.util.ArrayList"%>

<%! VotingBeanLocal votingBean; %>

<%
    votingBean = (VotingBeanLocal) new InitialContext().lookup("java:global/VotingSysteem/VotingBean!ejb.VotingBeanLocal");
    String action = request.getParameter("action");
    
    if ("delete".equals(action)) {
        int adminID = Integer.parseInt(request.getParameter("adminID"));
        votingBean.deleteAdmin(adminID);
    } else if ("edit".equals(action)) {
        int adminID = Integer.parseInt(request.getParameter("adminID"));
        Admin admin = votingBean.readAdmin(adminID);
        request.setAttribute("adminToEdit", admin);
    } 
    else if ("save".equals(action)) {
        Admin admin;
        if (request.getParameter("adminID").isEmpty()) {
            admin = new Admin();
        } else {
            admin = votingBean.readAdmin(Integer.parseInt(request.getParameter("adminID")));
        }
        admin.setUsername(request.getParameter("username"));
        admin.setPassword(request.getParameter("password"));
       
        if (!request.getParameter("roleID").isEmpty()) {
           Role role = votingBean.readRole(Integer.parseInt(request.getParameter("roleID")));
            admin.setRoleID(role);
//            Role role = em.find(Role.class, Integer.parseInt(request.getParameter("roleID")));
//            admin.setRoleID(role);

        }

if (request.getParameter("adminID").isEmpty()) {
            votingBean.createAdmin(admin);
        } else {
            votingBean.updateAdmin(admin);
        }
    }
%>

<h2>Admin Management</h2>

<div class="card form-container">
    <div class="card-header">
        <%= request.getAttribute("adminToEdit") != null ? "Edit Admin" : "Add New Admin" %>
    </div>
    <div class="card-body">
        <form method="post">
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="adminID" value="${adminToEdit.adminID}">
            
            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" class="form-control" name="username" 
                       value="${adminToEdit.username}" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" class="form-control" name="password" 
                       value="${adminToEdit.password}" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Role</label>
                <select class="form-select" name="roleID">
                    <option value="">-- Select Role --</option>
                    <% for (Role role : votingBean.getAllRoles()) { %>
                    <option value="<%= role.getRoleID()%>" 
                            <%= request.getAttribute("candidateToEdit") != null && 
                               ((Admin)request.getAttribute("candidateToEdit")).getRoleID()!= null && 
                               ((Admin)request.getAttribute("candidateToEdit")).getRoleID().getRoleID()== role.getRoleID()? "selected" : "" %>>
                        <%= role.getRoleName()%>
                    </option>
                    <% } %>
                </select>
            </div>
            <%
                        Admin admin1;
                        admin1 = new Admin();
                        System.out.println("Admin ID: " + admin1.getAdminID());
System.out.println("Username: " + admin1.getUsername());
System.out.println("Password: " + admin1.getPassword());
System.out.println("Role: " + admin1.getRoleID());


            %>
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="admin.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</div>

<div class="table-container">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Password</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (Admin admin : votingBean.getAllAdmins()) { %>
            <tr>
                <td><%= admin.getAdminID() %></td>
                <td><%= admin.getUsername() %></td>
                <td><%= admin.getPassword() %></td>
                <td><%= admin.getRoleID()!= null ? admin.getRoleID().getRoleName(): "N/A" %></td>

                <td>
                    <a href="admin.jsp?action=edit&adminID=<%= admin.getAdminID() %>" 
                       class="btn btn-sm btn-warning">Edit</a>
                    <a href="admin.jsp?action=delete&adminID=<%= admin.getAdminID() %>" 
                       class="btn btn-sm btn-danger" 
                       onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

<%@include file="footer.jsp" %>--%>



<%@page import="entities.Role"%>
<%@include file="header.jsp" %>
<%@page import="ejb.VotingBeanLocal"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="entities.Admin"%>
<%@page import="java.util.ArrayList"%>

<%! VotingBeanLocal votingBean; %>

<%
    votingBean = (VotingBeanLocal) new InitialContext().lookup("java:global/VotingSysteem/VotingBean!ejb.VotingBeanLocal");
    String action = request.getParameter("action");
    
    if ("delete".equals(action)) {
        int adminID = Integer.parseInt(request.getParameter("adminID"));
        votingBean.deleteAdmin(adminID);
    } else if ("edit".equals(action)) {
        int adminID = Integer.parseInt(request.getParameter("adminID"));
        Admin admin = votingBean.readAdmin(adminID);
        request.setAttribute("adminToEdit", admin);
    } else if ("save".equals(action)) {
    try {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String roleID = request.getParameter("roleID");
        
        // Validate inputs
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty() || 
            roleID == null || roleID.trim().isEmpty()) {
            throw new Exception("All fields are required");
        }
        
        // Trim inputs
        username = username.trim();
        password = password.trim();
        
        // Create or update admin
        Admin admin;
        if (request.getParameter("adminID") == null || request.getParameter("adminID").isEmpty()) {
            admin = new Admin();
        } else {
            admin = votingBean.readAdmin(Integer.parseInt(request.getParameter("adminID")));
            if (admin == null) {
                throw new Exception("Admin not found");
            }
        }
        
        admin.setUsername(username);
        admin.setPassword(password);
        
        Role role = votingBean.readRole(Integer.parseInt(roleID));
        if (role == null) {
            throw new Exception("Invalid Role selected");
        }
        admin.setRoleID(role);
        
        if (request.getParameter("adminID") == null || request.getParameter("adminID").isEmpty()) {
            votingBean.createAdmin(admin);
            request.setAttribute("success", "Admin created successfully");
        } else {
            votingBean.updateAdmin(admin);
            request.setAttribute("success", "Admin updated successfully");
        }
        
        // Clear edit form after successful save
        request.removeAttribute("adminToEdit");
        
    } catch (NumberFormatException e) {
        request.setAttribute("error", "Invalid ID format");
    } catch (Exception e) {
        request.setAttribute("error", "Error saving admin: " + e.getMessage());
    }
}
%>

<h2>Admin Management</h2>

<%-- Display error/success messages --%>
<% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger">${error}</div>
<% } %>
<% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success">${success}</div>
<% } %>

<div class="card form-container">
    <div class="card-header">
        <%= request.getAttribute("adminToEdit") != null ? "Edit Admin" : "Add New Admin" %>
    </div>
    <div class="card-body">
        <form method="post">
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="adminID" value="${adminToEdit.adminID}">
            
            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" class="form-control" name="username" 
                       value="${adminToEdit.username}" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" class="form-control" name="password" 
                       value="${adminToEdit.password}" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Role</label>
                <select class="form-select" name="roleID" required>
                    <option value="">-- Select Role --</option>
                    <% for (Role role : votingBean.getAllRoles()) { %>
                    <option value="<%= role.getRoleID()%>" 
                            <%= request.getAttribute("adminToEdit") != null && 
                               ((Admin)request.getAttribute("adminToEdit")).getRoleID() != null && 
                               ((Admin)request.getAttribute("adminToEdit")).getRoleID().getRoleID() == role.getRoleID() ? "selected" : "" %>>
                        <%= role.getRoleName()%>
                    </option>
                    <% } %>
                </select>
            </div>
            
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="admin.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</div>

<div class="table-container">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Password</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (Admin admin : votingBean.getAllAdmins()) { %>
            <tr>
                <td><%= admin.getAdminID() %></td>
                <td><%= admin.getUsername() %></td>
                <td><%= admin.getPassword() %></td>
                <td><%= admin.getRoleID() != null ? admin.getRoleID().getRoleName() : "N/A" %></td>

                <td>
                    <a href="admin.jsp?action=edit&adminID=<%= admin.getAdminID() %>" 
                       class="btn btn-sm btn-warning">Edit</a>
                    <a href="admin.jsp?action=delete&adminID=<%= admin.getAdminID() %>" 
                       class="btn btn-sm btn-danger" 
                       onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

<%@include file="footer.jsp" %>