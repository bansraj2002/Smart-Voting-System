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
import javax.persistence.Lob;
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
@Table(name = "Candidate")
@NamedQueries({
    @NamedQuery(name = "Candidate.findAll", query = "SELECT c FROM Candidate c"),
    @NamedQuery(name = "Candidate.findByCandidateID", query = "SELECT c FROM Candidate c WHERE c.candidateID = :candidateID"),
    @NamedQuery(name = "Candidate.findByName", query = "SELECT c FROM Candidate c WHERE c.name = :name"),
    @NamedQuery(name = "Candidate.findByParty", query = "SELECT c FROM Candidate c WHERE c.party = :party")})
public class Candidate implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "CandidateID")
    private Integer candidateID;
    @Size(max = 100)
    @Column(name = "Name")
    private String name;
    @Size(max = 100)
    @Column(name = "Party")
    private String party;
    @Lob
    @Size(max = 65535)
    @Column(name = "Bio")
    private String bio;
    @JoinColumn(name = "CitizenID", referencedColumnName = "CitizenID")
    @ManyToOne
    private Citizen citizenID;
    @OneToMany(mappedBy = "candidateID")
    private Collection<Vote> voteCollection;

    public Candidate() {
    }

    public Candidate(Integer candidateID) {
        this.candidateID = candidateID;
    }

    public Integer getCandidateID() {
        return candidateID;
    }

    public void setCandidateID(Integer candidateID) {
        this.candidateID = candidateID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getParty() {
        return party;
    }

    public void setParty(String party) {
        this.party = party;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public Citizen getCitizenID() {
        return citizenID;
    }

    public void setCitizenID(Citizen citizenID) {
        this.citizenID = citizenID;
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
        hash += (candidateID != null ? candidateID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Candidate)) {
            return false;
        }
        Candidate other = (Candidate) object;
        if ((this.candidateID == null && other.candidateID != null) || (this.candidateID != null && !this.candidateID.equals(other.candidateID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Candidate[ candidateID=" + candidateID + " ]";
    }
    
}
