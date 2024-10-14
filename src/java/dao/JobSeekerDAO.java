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

    // Find JobSeeker by AccountID
    public JobSeekers findJobSeekerIDByAccountID(String accountID) {
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
        String accountIDStr = sc.nextLine();
        JobSeekers jobSeeker = dao.findJobSeekerIDByAccountID(accountIDStr);
        if (jobSeeker != null) {
            System.out.println("Job Seeker ID: " + jobSeeker.getJobSeekerID());
        } else {
            System.out.println("No Job Seeker found with AccountID" + accountIDStr);
        }
    }
}
