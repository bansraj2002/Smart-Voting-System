/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB30/SessionLocal.java to edit this template
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
import java.util.ArrayList;
import javax.ejb.Local;

/**
 *
 * @author bansraj
 */
@Local
public interface VotingBeanLocal {
    // Admin methods
    void createAdmin(Admin admin);
    Admin readAdmin(Integer adminID);
    void updateAdmin(Admin admin);
    void deleteAdmin(Integer adminID);
    ArrayList<Admin> getAllAdmins();
    
    // Candidate methods
    void createCandidate(Candidate candidate);
    Candidate readCandidate(Integer candidateID);
    void updateCandidate(Candidate candidate);
    void deleteCandidate(Integer candidateID);
    ArrayList<Candidate> getAllCandidates();
    
    // Citizen methods
    void createCitizen(Citizen citizen);
    Citizen readCitizen(Integer citizenID);
    void updateCitizen(Citizen citizen);
    void deleteCitizen(Integer citizenID);
    ArrayList<Citizen> getAllCitizens();
    
    // Role methods
    void createRole(Role role);
    Role readRole(Integer roleID);
    void updateRole(Role role);
    void deleteRole(Integer roleID);
    ArrayList<Role> getAllRoles();
    
    // UserPermission methods
    void createUserPermission(UserPermission permission);
    UserPermission readUserPermission(Integer permissionID);
    void updateUserPermission(UserPermission permission);
    void deleteUserPermission(Integer permissionID);
    ArrayList<UserPermission> getAllUserPermissions();
    
    // Vote methods
    void createVote(Vote vote);
    Vote readVote(Integer voteID);
    void updateVote(Vote vote);
    void deleteVote(Integer voteID);
    ArrayList<Vote> getAllVotes();
    
    // VoteCenter methods
    void createVoteCenter(VoteCenter center);
    VoteCenter readVoteCenter(Integer centerID);
    void updateVoteCenter(VoteCenter center);
    void deleteVoteCenter(Integer centerID);
    ArrayList<VoteCenter> getAllVoteCenters();
    
    // VoterList methods
    void createVoterList(VoterList voterList);
    VoterList readVoterList(Integer listID);
    void updateVoterList(VoterList voterList);
    void deleteVoterList(Integer listID);
    ArrayList<VoterList> getAllVoterLists();
    
    // VotingMachine methods
    void createVotingMachine(VotingMachine machine);
    VotingMachine readVotingMachine(Integer machineID);
    void updateVotingMachine(VotingMachine machine);
    void deleteVotingMachine(Integer machineID);
    ArrayList<VotingMachine> getAllVotingMachines();
    
    // Additional business methods
    ArrayList<Candidate> getCandidatesByParty(String party);
    ArrayList<Vote> getVotesByCitizen(Integer citizenID);
    long getTotalVotesForCandidate(Integer candidateID);
}
