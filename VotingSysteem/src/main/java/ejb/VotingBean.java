/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB30/StatelessEjbClass.java to edit this template
 */
package ejb;

import entities.Admin;
import entities.Candidate;
import entities.Citizen;
import entities.Role;
import entities.UserPermission;
import entities.Vote;
import entities.VoteCenter;
import entities.VoterList;
import entities.VotingMachine;
import javax.ejb.Stateless;
import java.util.ArrayList;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author bansraj
 */
@Stateless
public class VotingBean implements VotingBeanLocal {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    
    @PersistenceContext(unitName = "votingpu") 
    private EntityManager em;

    // Admin CRUD operations
    public void createAdmin(Admin admin) {
        em.persist(admin);
    }

    public Admin readAdmin(Integer adminID) {
        return em.find(Admin.class, adminID);
    }

    public void updateAdmin(Admin admin) {
        em.merge(admin);
    }

    public void deleteAdmin(Integer adminID) {
        Admin admin = em.find(Admin.class, adminID);
        if (admin != null) {
            em.remove(admin);
        }
    }

    public ArrayList<Admin> getAllAdmins() {
        return new ArrayList<>(em.createNamedQuery("Admin.findAll").getResultList());
    }

    // Candidate CRUD operations
    public void createCandidate(Candidate candidate) {
        em.persist(candidate);
    }

    public Candidate readCandidate(Integer candidateID) {
        return em.find(Candidate.class, candidateID);
    }

    public void updateCandidate(Candidate candidate) {
        em.merge(candidate);
    }

    public void deleteCandidate(Integer candidateID) {
        Candidate candidate = em.find(Candidate.class, candidateID);
        if (candidate != null) {
            em.remove(candidate);
        }
    }

    public ArrayList<Candidate> getAllCandidates() {
        return new ArrayList<>(em.createNamedQuery("Candidate.findAll").getResultList());
    }

    // Citizen CRUD operations
    public void createCitizen(Citizen citizen) {
        em.persist(citizen);
    }

    public Citizen readCitizen(Integer citizenID) {
        return em.find(Citizen.class, citizenID);
    }

    public void updateCitizen(Citizen citizen) {
        em.merge(citizen);
    }

    public void deleteCitizen(Integer citizenID) {
        Citizen citizen = em.find(Citizen.class, citizenID);
        if (citizen != null) {
            em.remove(citizen);
        }
    }

    public ArrayList<Citizen> getAllCitizens() {
        return new ArrayList<>(em.createNamedQuery("Citizen.findAll").getResultList());
    }

    // Role CRUD operations
    public void createRole(Role role) {
        em.persist(role);
    }

    public Role readRole(Integer roleID) {
        return em.find(Role.class, roleID);
    }

    public void updateRole(Role role) {
        em.merge(role);
    }

    public void deleteRole(Integer roleID) {
        Role role = em.find(Role.class, roleID);
        if (role != null) {
            em.remove(role);
        }
    }

    public ArrayList<Role> getAllRoles() {
        return new ArrayList<>(em.createNamedQuery("Role.findAll").getResultList());
    }

    // UserPermission CRUD operations
    public void createUserPermission(UserPermission permission) {
        em.persist(permission);
    }

    public UserPermission readUserPermission(Integer permissionID) {
        return em.find(UserPermission.class, permissionID);
    }

    public void updateUserPermission(UserPermission permission) {
        em.merge(permission);
    }

    public void deleteUserPermission(Integer permissionID) {
        UserPermission permission = em.find(UserPermission.class, permissionID);
        if (permission != null) {
            em.remove(permission);
        }
    }

    public ArrayList<UserPermission> getAllUserPermissions() {
        return new ArrayList<>(em.createNamedQuery("UserPermission.findAll").getResultList());
    }

    // Vote CRUD operations
    public void createVote(Vote vote) {
        em.persist(vote);
    }

    public Vote readVote(Integer voteID) {
        return em.find(Vote.class, voteID);
    }

    public void updateVote(Vote vote) {
        em.merge(vote);
    }

    public void deleteVote(Integer voteID) {
        Vote vote = em.find(Vote.class, voteID);
        if (vote != null) {
            em.remove(vote);
        }
    }

    public ArrayList<Vote> getAllVotes() {
        return new ArrayList<>(em.createNamedQuery("Vote.findAll").getResultList());
    }

    // VoteCenter CRUD operations
    public void createVoteCenter(VoteCenter center) {
        em.persist(center);
    }

    public VoteCenter readVoteCenter(Integer centerID) {
        return em.find(VoteCenter.class, centerID);
    }

    public void updateVoteCenter(VoteCenter center) {
        em.merge(center);
    }

    public void deleteVoteCenter(Integer centerID) {
        VoteCenter center = em.find(VoteCenter.class, centerID);
        if (center != null) {
            em.remove(center);
        }
    }

    public ArrayList<VoteCenter> getAllVoteCenters() {
        return new ArrayList<>(em.createNamedQuery("VoteCenter.findAll").getResultList());
    }

    // VoterList CRUD operations
    public void createVoterList(VoterList voterList) {
        em.persist(voterList);
    }

    public VoterList readVoterList(Integer listID) {
        return em.find(VoterList.class, listID);
    }

    public void updateVoterList(VoterList voterList) {
        em.merge(voterList);
    }

    public void deleteVoterList(Integer listID) {
        VoterList voterList = em.find(VoterList.class, listID);
        if (voterList != null) {
            em.remove(voterList);
        }
    }

    public ArrayList<VoterList> getAllVoterLists() {
        return new ArrayList<>(em.createNamedQuery("VoterList.findAll").getResultList());
    }

    // VotingMachine CRUD operations
    public void createVotingMachine(VotingMachine machine) {
        em.persist(machine);
    }

    public VotingMachine readVotingMachine(Integer machineID) {
        return em.find(VotingMachine.class, machineID);
    }

    public void updateVotingMachine(VotingMachine machine) {
        em.merge(machine);
    }

    public void deleteVotingMachine(Integer machineID) {
        VotingMachine machine = em.find(VotingMachine.class, machineID);
        if (machine != null) {
            em.remove(machine);
        }
    }

    public ArrayList<VotingMachine> getAllVotingMachines() {
        return new ArrayList<>(em.createNamedQuery("VotingMachine.findAll").getResultList());
    }
    
    // Additional business methods
    public ArrayList<Candidate> getCandidatesByParty(String party) {
        return new ArrayList<>(em.createNamedQuery("Candidate.findByParty")
                .setParameter("party", party)
                .getResultList());
    }
    
    public ArrayList<Vote> getVotesByCitizen(Integer citizenID) {
        Citizen citizen = em.find(Citizen.class, citizenID);
        return new ArrayList<>(em.createQuery("SELECT v FROM Vote v WHERE v.citizenID = :citizen")
                .setParameter("citizen", citizen)
                .getResultList());
    }
    
    public long getTotalVotesForCandidate(Integer candidateID) {
        return (long) em.createQuery("SELECT COUNT(v) FROM Vote v WHERE v.candidateID.candidateID = :candidateID")
                .setParameter("candidateID", candidateID)
                .getSingleResult();
    }


}
