/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author bansraj
 */
@Entity
@Table(name = "UserPermission")
@NamedQueries({
    @NamedQuery(name = "UserPermission.findAll", query = "SELECT u FROM UserPermission u"),
    @NamedQuery(name = "UserPermission.findByPermissionID", query = "SELECT u FROM UserPermission u WHERE u.permissionID = :permissionID"),
    @NamedQuery(name = "UserPermission.findByPermissionName", query = "SELECT u FROM UserPermission u WHERE u.permissionName = :permissionName")})
public class UserPermission implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "PermissionID")
    private Integer permissionID;
    @Size(max = 100)
    @Column(name = "PermissionName")
    private String permissionName;
    @JoinColumn(name = "RoleID", referencedColumnName = "RoleID")
    @ManyToOne
    private Role roleID;

    public UserPermission() {
    }

    public UserPermission(Integer permissionID) {
        this.permissionID = permissionID;
    }

    public Integer getPermissionID() {
        return permissionID;
    }

    public void setPermissionID(Integer permissionID) {
        this.permissionID = permissionID;
    }

    public String getPermissionName() {
        return permissionName;
    }

    public void setPermissionName(String permissionName) {
        this.permissionName = permissionName;
    }

    public Role getRoleID() {
        return roleID;
    }

    public void setRoleID(Role roleID) {
        this.roleID = roleID;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (permissionID != null ? permissionID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof UserPermission)) {
            return false;
        }
        UserPermission other = (UserPermission) object;
        if ((this.permissionID == null && other.permissionID != null) || (this.permissionID != null && !this.permissionID.equals(other.permissionID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.UserPermission[ permissionID=" + permissionID + " ]";
    }
    
}
