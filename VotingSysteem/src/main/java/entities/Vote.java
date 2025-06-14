///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package entities;
//
//import java.io.Serializable;
//import java.util.Date;
//import javax.persistence.Basic;
//import javax.persistence.Column;
//import javax.persistence.Entity;
//import javax.persistence.GeneratedValue;
//import javax.persistence.GenerationType;
//import javax.persistence.Id;
//import javax.persistence.JoinColumn;
//import javax.persistence.ManyToOne;
//import javax.persistence.NamedQueries;
//import javax.persistence.NamedQuery;
//import javax.persistence.OneToOne;
//import javax.persistence.Table;
//import javax.persistence.Temporal;
//import javax.persistence.TemporalType;
//
///**
// *
// * @author bansraj
// */
//@Entity
//@Table(name = "Vote")
//@NamedQueries({
//    @NamedQuery(name = "Vote.findAll", query = "SELECT v FROM Vote v"),
//    @NamedQuery(name = "Vote.findByVoteID", query = "SELECT v FROM Vote v WHERE v.voteID = :voteID"),
//    @NamedQuery(name = "Vote.findByTimestamp", query = "SELECT v FROM Vote v WHERE v.timestamp = :timestamp")})
//public class Vote implements Serializable {
//
//    private static final long serialVersionUID = 1L;
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    @Basic(optional = false)
//    @Column(name = "VoteID")
//    private Integer voteID;
//    @Column(name = "Timestamp")
//    @Temporal(TemporalType.TIMESTAMP)
//    private Date timestamp;
//    @JoinColumn(name = "CandidateID", referencedColumnName = "CandidateID")
//    @ManyToOne
//    private Candidate candidateID;
//    @JoinColumn(name = "CitizenID", referencedColumnName = "CitizenID")
//    @OneToOne
//    private Citizen citizenID;
//    @JoinColumn(name = "MachineID", referencedColumnName = "MachineID")
//    @ManyToOne
//    private VotingMachine machineID;
//
//    public Vote() {
//    }
//
//    public Vote(Integer voteID) {
//        this.voteID = voteID;
//    }
//
//    public Integer getVoteID() {
//        return voteID;
//    }
//
//    public void setVoteID(Integer voteID) {
//        this.voteID = voteID;
//    }
//
//    public Date getTimestamp() {
//        return timestamp;
//    }
//
//    public void setTimestamp(Date timestamp) {
//        this.timestamp = timestamp;
//    }
//
//    public Candidate getCandidateID() {
//        return candidateID;
//    }
//
//    public void setCandidateID(Candidate candidateID) {
//        this.candidateID = candidateID;
//    }
//
//    public Citizen getCitizenID() {
//        return citizenID;
//    }
//
//    public void setCitizenID(Citizen citizenID) {
//        this.citizenID = citizenID;
//    }
//
//    public VotingMachine getMachineID() {
//        return machineID;
//    }
//
//    public void setMachineID(VotingMachine machineID) {
//        this.machineID = machineID;
//    }
//
//    @Override
//    public int hashCode() {
//        int hash = 0;
//        hash += (voteID != null ? voteID.hashCode() : 0);
//        return hash;
//    }
//
//    @Override
//    public boolean equals(Object object) {
//        // TODO: Warning - this method won't work in the case the id fields are not set
//        if (!(object instanceof Vote)) {
//            return false;
//        }
//        Vote other = (Vote) object;
//        if ((this.voteID == null && other.voteID != null) || (this.voteID != null && !this.voteID.equals(other.voteID))) {
//            return false;
//        }
//        return true;
//    }
//
//    @Override
//    public String toString() {
//        return "entities.Vote[ voteID=" + voteID + " ]";
//    }
//    
//}


package entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

/**
 *
 * @author bansraj
 */
@Entity
@Table(name = "Vote")
@NamedQueries({
    @NamedQuery(name = "Vote.findAll", query = "SELECT v FROM Vote v"),
    @NamedQuery(name = "Vote.findByVoteID", query = "SELECT v FROM Vote v WHERE v.voteID = :voteID"),
    @NamedQuery(name = "Vote.findByTimestamp", query = "SELECT v FROM Vote v WHERE v.timestamp = :timestamp")})
public class Vote implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "VoteID")
    private Integer voteID;
    
    @NotNull(message = "Timestamp is required")
    @Column(name = "Timestamp")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timestamp;
    
    @NotNull(message = "Candidate is required")
    @JoinColumn(name = "CandidateID", referencedColumnName = "CandidateID")
    @ManyToOne(optional = false)
    private Candidate candidateID;
    
    @NotNull(message = "Citizen is required")
    @JoinColumn(name = "CitizenID", referencedColumnName = "CitizenID")
    @OneToOne(optional = false)
    private Citizen citizenID;
    
    @NotNull(message = "Voting Machine is required")
    @JoinColumn(name = "MachineID", referencedColumnName = "MachineID")
    @ManyToOne(optional = false)
    private VotingMachine machineID;

    public Vote() {
    }

    public Vote(Integer voteID) {
        this.voteID = voteID;
    }

    public Integer getVoteID() {
        return voteID;
    }

    public void setVoteID(Integer voteID) {
        this.voteID = voteID;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public Candidate getCandidateID() {
        return candidateID;
    }

    public void setCandidateID(Candidate candidateID) {
        this.candidateID = candidateID;
    }

    public Citizen getCitizenID() {
        return citizenID;
    }

    public void setCitizenID(Citizen citizenID) {
        this.citizenID = citizenID;
    }

    public VotingMachine getMachineID() {
        return machineID;
    }

    public void setMachineID(VotingMachine machineID) {
        this.machineID = machineID;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (voteID != null ? voteID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Vote)) {
            return false;
        }
        Vote other = (Vote) object;
        if ((this.voteID == null && other.voteID != null) || (this.voteID != null && !this.voteID.equals(other.voteID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Vote[ voteID=" + voteID + " ]";
    }
}