package dao;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Scanner;
import model.Account;
import model.JobSeekers;

/**
 * DAO for JobSeekers
 */
public class JobSeekerDAO extends GenericDAO<JobSeekers> {

    @Override
    public List<JobSeekers> findAll() {
        return queryGenericDAO(JobSeekers.class);
    }

    // Insert a new Job Seeker
    @Override
    public int insert(JobSeekers t) {
        String sql = "INSERT INTO [dbo].[JobSeekers] ([AccountID]) VALUES (?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("AccountID", t.getAccountID());
        return insertGenericDAO(sql, parameterMap);
    }

    // Check if an AccountID exists in JobSeekers table
    public boolean checkAccountIDExist(int AccountID) {
        String sql = "SELECT * FROM [dbo].[JobSeekers] WHERE AccountID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("AccountID", AccountID);
        return !queryGenericDAO(JobSeekers.class, sql, parameterMap).isEmpty();
    }

    // Find JobSeeker by AccountID
    public JobSeekers findJobSeekerByAccountID(int accountID) {
        String sql = "SELECT * FROM [dbo].[JobSeekers] WHERE AccountID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("AccountID", accountID);

        List<JobSeekers> list = queryGenericDAO(JobSeekers.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);  // Return first result if found, else null
    }

    public static void main(String[] args) {
        // Test findJobSeekerByAccountID method
        JobSeekerDAO dao = new JobSeekerDAO();
        Scanner sc = new Scanner(System.in);
        int accountID = sc.nextInt();
        JobSeekers jobSeeker = dao.findJobSeekerByAccountID(accountID);
        if (jobSeeker != null) {
            System.out.println("Job Seeker ID: " + jobSeeker.getJobSeekerID());
        } else {
            System.out.println("No Job Seeker found with AccountID" + accountID);
        }
    }
}
