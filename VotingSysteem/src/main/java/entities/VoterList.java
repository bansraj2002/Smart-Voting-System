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

/**
 *
 * @author bansraj
 */
@Entity
@Table(name = "VoterList")
@NamedQueries({
    @NamedQuery(name = "VoterList.findAll", query = "SELECT v FROM VoterList v"),
    @NamedQuery(name = "VoterList.findByListID", query = "SELECT v FROM VoterList v WHERE v.listID = :listID")})
public class VoterList implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ListID")
    private Integer listID;
    @JoinColumn(name = "CitizenID", referencedColumnName = "CitizenID")
    @ManyToOne
    private Citizen citizenID;
    @JoinColumn(name = "CenterID", referencedColumnName = "CenterID")
    @ManyToOne
    private VoteCenter centerID;

    public VoterList() {
    }

    public VoterList(Integer listID) {
        this.listID = listID;
    }

    public Integer getListID() {
        return listID;
    }

    public void setListID(Integer listID) {
        this.listID = listID;
    }

    public Citizen getCitizenID() {
        return citizenID;
    }

    public void setCitizenID(Citizen citizenID) {
        this.citizenID = citizenID;
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
        hash += (listID != null ? listID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VoterList)) {
            return false;
        }
        VoterList other = (VoterList) object;
        if ((this.listID == null && other.listID != null) || (this.listID != null && !this.listID.equals(other.listID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.VoterList[ listID=" + listID + " ]";
    }
    
}
