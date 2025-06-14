/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entities;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author bansraj
 */
@Entity
@Table(name = "VotingMachine")
@NamedQueries({
    @NamedQuery(name = "VotingMachine.findAll", query = "SELECT v FROM VotingMachine v"),
    @NamedQuery(name = "VotingMachine.findByMachineID", query = "SELECT v FROM VotingMachine v WHERE v.machineID = :machineID"),
    @NamedQuery(name = "VotingMachine.findByStatus", query = "SELECT v FROM VotingMachine v WHERE v.status = :status")})
public class VotingMachine implements Serializable {

    @Size(max = 50)
    @Column(name = "Status")
    private String status;

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "MachineID")
    private Integer machineID;
    @OneToMany(mappedBy = "machineID")
    private Collection<Vote> voteCollection;
    @JoinColumn(name = "CenterID", referencedColumnName = "CenterID")
    @ManyToOne
    private VoteCenter centerID;

    public VotingMachine() {
    }

    public VotingMachine(Integer machineID) {
        this.machineID = machineID;
    }

    public Integer getMachineID() {
        return machineID;
    }

    public void setMachineID(Integer machineID) {
        this.machineID = machineID;
    }


    public Collection<Vote> getVoteCollection() {
        return voteCollection;
    }

    public void setVoteCollection(Collection<Vote> voteCollection) {
        this.voteCollection = voteCollection;
    }

    public VoteCenter getCenterID() {
        return centerID;
    }

    public void setCenterID(VoteCenter centerID) {
        this.centerID = centerID;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (machineID != null ? machineID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VotingMachine)) {
            return false;
        }
        VotingMachine other = (VotingMachine) object;
        if ((this.machineID == null && other.machineID != null) || (this.machineID != null && !this.machineID.equals(other.machineID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.VotingMachine[ machineID=" + machineID + " ]";
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
}
