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
@Table(name = "VoteCenter")
@NamedQueries({
    @NamedQuery(name = "VoteCenter.findAll", query = "SELECT v FROM VoteCenter v"),
    @NamedQuery(name = "VoteCenter.findByCenterID", query = "SELECT v FROM VoteCenter v WHERE v.centerID = :centerID"),
    @NamedQuery(name = "VoteCenter.findByLocation", query = "SELECT v FROM VoteCenter v WHERE v.location = :location"),
    @NamedQuery(name = "VoteCenter.findByCapacity", query = "SELECT v FROM VoteCenter v WHERE v.capacity = :capacity")})
public class VoteCenter implements Serializable {

    @Size(max = 255)
    @Column(name = "Location")
    private String location;

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "CenterID")
    private Integer centerID;
    @Column(name = "Capacity")
    private Integer capacity;
    @OneToMany(mappedBy = "centerID")
    private Collection<VoterList> voterListCollection;
    @OneToMany(mappedBy = "centerID")
    private Collection<VotingMachine> votingMachineCollection;

    public VoteCenter() {
    }

    public VoteCenter(Integer centerID) {
        this.centerID = centerID;
    }

    public Integer getCenterID() {
        return centerID;
    }

    public void setCenterID(Integer centerID) {
        this.centerID = centerID;
    }


    public Integer getCapacity() {
        return capacity;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }

    public Collection<VoterList> getVoterListCollection() {
        return voterListCollection;
    }

    public void setVoterListCollection(Collection<VoterList> voterListCollection) {
        this.voterListCollection = voterListCollection;
    }

    public Collection<VotingMachine> getVotingMachineCollection() {
        return votingMachineCollection;
    }

    public void setVotingMachineCollection(Collection<VotingMachine> votingMachineCollection) {
        this.votingMachineCollection = votingMachineCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (centerID != null ? centerID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VoteCenter)) {
            return false;
        }
        VoteCenter other = (VoteCenter) object;
        if ((this.centerID == null && other.centerID != null) || (this.centerID != null && !this.centerID.equals(other.centerID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.VoteCenter[ centerID=" + centerID + " ]";
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
    
}
