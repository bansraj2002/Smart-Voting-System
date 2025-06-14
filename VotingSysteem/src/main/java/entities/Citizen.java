/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entities;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author bansraj
 */
@Entity
@Table(name = "Citizen")
@NamedQueries({
    @NamedQuery(name = "Citizen.findAll", query = "SELECT c FROM Citizen c"),
    @NamedQuery(name = "Citizen.findByCitizenID", query = "SELECT c FROM Citizen c WHERE c.citizenID = :citizenID"),
    @NamedQuery(name = "Citizen.findByName", query = "SELECT c FROM Citizen c WHERE c.name = :name"),
    @NamedQuery(name = "Citizen.findByAddress", query = "SELECT c FROM Citizen c WHERE c.address = :address"),
    @NamedQuery(name = "Citizen.findByDateOfBirth", query = "SELECT c FROM Citizen c WHERE c.dateOfBirth = :dateOfBirth"),
    @NamedQuery(name = "Citizen.findByVoterID", query = "SELECT c FROM Citizen c WHERE c.voterID = :voterID")})
public class Citizen implements Serializable {

    @Size(max = 100)
    @Column(name = "Name")
    private String name;
    @Size(max = 255)
    @Column(name = "Address")
    private String address;
    @Basic(optional = false)
    @NotNull
    @Column(name = "VoterID")
    private int voterID;
    @OneToOne(mappedBy = "citizenID")
    private Vote vote;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CitizenID")
    private Integer citizenID;
    @Column(name = "DateOfBirth")
    @Temporal(TemporalType.DATE)
    private Date dateOfBirth;
    @OneToMany(mappedBy = "citizenID")
    private Collection<Candidate> candidateCollection;
    @OneToMany(mappedBy = "citizenID")
    private Collection<VoterList> voterListCollection;
    @OneToMany(mappedBy = "citizenID")
    private Collection<Vote> voteCollection;

    public Citizen() {
    }

    public Citizen(Integer citizenID) {
        this.citizenID = citizenID;
    }

    public Citizen(Integer citizenID, int voterID) {
        this.citizenID = citizenID;
        this.voterID = voterID;
    }

    public Integer getCitizenID() {
        return citizenID;
    }

    public void setCitizenID(Integer citizenID) {
        this.citizenID = citizenID;
    }


    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }


    public Collection<Candidate> getCandidateCollection() {
        return candidateCollection;
    }

    public void setCandidateCollection(Collection<Candidate> candidateCollection) {
        this.candidateCollection = candidateCollection;
    }

    public Collection<VoterList> getVoterListCollection() {
        return voterListCollection;
    }

    public void setVoterListCollection(Collection<VoterList> voterListCollection) {
        this.voterListCollection = voterListCollection;
    }

    public Collection<Vote> getVoteCollection() {
        return voteCollection;
    }

    public void setVoteCollection(Collection<Vote> voteCollection) {
        this.voteCollection = voteCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (citizenID != null ? citizenID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Citizen)) {
            return false;
        }
        Citizen other = (Citizen) object;
        if ((this.citizenID == null && other.citizenID != null) || (this.citizenID != null && !this.citizenID.equals(other.citizenID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Citizen[ citizenID=" + citizenID + " ]";
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getVoterID() {
        return voterID;
    }

    public void setVoterID(int voterID) {
        this.voterID = voterID;
    }

    public Vote getVote() {
        return vote;
    }

    public void setVote(Vote vote) {
        this.vote = vote;
    }
    
}
