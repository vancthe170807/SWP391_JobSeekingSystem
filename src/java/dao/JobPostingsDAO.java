package dao;

import static constant.CommonConst.RECORD_PER_PAGE;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Company;
import model.JobPostings;

public class JobPostingsDAO extends GenericDAO<JobPostings> {

    @Override
    public List<JobPostings> findAll() {
        return queryGenericDAO(JobPostings.class);
    }

    public JobPostings findJobPostingById(int ID) {
        String sql = "SELECT * FROM [dbo].[JobPostings] where JobPostingID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobPostingID", ID);
        List<JobPostings> list = queryGenericDAO(JobPostings.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    //Tính toán thời gian cách đây 1 tháng so với ngày hiện tại
    public List<JobPostings> findJobPostingbyRecruitersIDandOneMonth(int recruiterID) {
        // Thêm điều kiện tìm kiếm các bài đăng trong 1 tháng
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE RecruiterID = ? AND PostedDate >= DATEADD(month, -1, GETDATE())";

        // Tạo map chứa các tham số cho câu truy vấn
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterID);

        // Gọi hàm queryGenericDAO để truy vấn
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> findJobPostingbyRecruitersID(int recruiterID) {
        String sql = "select * from [dbo].[JobPostings] where RecruiterID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterID);
        List<JobPostings> list = queryGenericDAO(JobPostings.class, sql, parameterMap);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);

    }

    public void updateJobPosting(JobPostings t) {
        String sql = "UPDATE [dbo].[JobPostings]\n"
                + "   SET [RecruiterID] = ?\n"
                + "      ,[Title] = ?\n"
                + "      ,[Description] = ?\n"
                + "      ,[Requirements] = ?\n"
                + "      ,[MinSalary] = ?\n"
                + "      ,[MaxSalary] = ?\n"
                + "      ,[Location] = ?\n"
                + "      ,[PostedDate] = ?\n"
                + "      ,[ClosingDate] = ?\n"
                + "      ,[Job_Posting_CategoryID] = ?\n"
                + "      ,[Status] = ?\n"
                + " WHERE JobPostingID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", t.getRecruiterID());
        parameterMap.put("Title", t.getTitle());
        parameterMap.put("Description", t.getDescription());
        parameterMap.put("Requirements", t.getRequirements());
        parameterMap.put("MinSalary", t.getMinSalary());
        parameterMap.put("MaxSalary", t.getMaxSalary());
        parameterMap.put("Location", t.getLocation());
        parameterMap.put("PostedDate", t.getPostedDate());
        parameterMap.put("ClosingDate", t.getClosingDate());
        parameterMap.put("Job_Posting_CategoryID", t.getJob_Posting_CategoryID());
        parameterMap.put("Status", t.getStatus());
        parameterMap.put("JobPostingID", t.getJobPostingID());
        updateGenericDAO(sql, parameterMap);
    }

    public void deleteJobPosting(String jobPostingEdit) {
        String sql = "DELETE FROM [dbo].[JobPostings]\n"
                + "      WHERE JobPostingID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobPostingID", jobPostingEdit);
        deleteGenericDAO(sql, parameterMap);
    }

    public List<JobPostings> getTop5RecentJobPostings() {
        String sql = "SELECT TOP 5 *\n"
                + "FROM [dbo].[JobPostings]\n"
                + "ORDER BY PostedDate DESC";
        parameterMap = new LinkedHashMap<>();
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    @Override
    public int insert(JobPostings t) {
        String sql = "INSERT INTO [dbo].[JobPostings]\n"
                + "           ([RecruiterID]\n"
                + "           ,[Title]\n"
                + "           ,[Description]\n"
                + "           ,[Requirements]\n"
                + "           ,[MinSalary]\n"
                + "           ,[MaxSalary]\n"
                + "           ,[Location]\n"
                + "           ,[PostedDate]\n"
                + "           ,[ClosingDate]\n"
                + "           ,[Job_Posting_CategoryID]\n"
                + "           ,[Status])\n"
                + "     VALUES(?,?,?,?,?,?,?,?,?,?,?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", t.getRecruiterID());
        parameterMap.put("Title", t.getTitle());
        parameterMap.put("Description", t.getDescription());
        parameterMap.put("Requirements", t.getRequirements());
        parameterMap.put("MinSalary", t.getMinSalary());
        parameterMap.put("MaxSalary", t.getMaxSalary());
        parameterMap.put("Location", t.getLocation());
        parameterMap.put("PostedDate", t.getPostedDate());
        parameterMap.put("ClosingDate", t.getClosingDate());
        parameterMap.put("Job_Posting_CategoryID", t.getJob_Posting_CategoryID());
        parameterMap.put("Status", t.getStatus());
        return insertGenericDAO(sql, parameterMap);
    }

    public List<JobPostings> findAllByRecruiterID(int recruiterID) {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE RecruiterID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterID);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public void deleteJobPosting(int jobPostingID, int recruiterID) {
        String sql = "DELETE FROM [dbo].[JobPostings]\n"
                + "      WHERE JobPostingID = ? AND RecruiterID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobPostingID", jobPostingID);
        parameterMap.put("RecruiterID", recruiterID);  // Chỉ cho phép xóa nếu recruiterID khớp
        deleteGenericDAO(sql, parameterMap);
    }

    public List<JobPostings> getTop5RecentJobPostingsByRecruiterID(int recruiterID) {
        String sql = "SELECT TOP 5 * FROM [dbo].[JobPostings]\n"
                + "WHERE RecruiterID = ?\n"
                + "ORDER BY PostedDate desc";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterID);

        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    ////
    public List<JobPostings> searchJobPostingByTitleAndRecruiterID(String searchJP, int recruiterID, int page) {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE Title LIKE '%' + ? + '%' AND RecruiterID = ? ORDER BY JobPostingID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", searchJP);
        parameterMap.put("RecruiterID", recruiterID);  // Thêm RecruiterID vào truy vấn
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> searchJobPostingByTitle(String searchJP, int page) {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE Title LIKE '%' + ? + '%' AND Status = ? ORDER BY JobPostingID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", searchJP);
        parameterMap.put("Status", "Open");
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int findTotalRecordByTitleAndRecruiterID(String searchQuery, int recruiterID) {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings] WHERE Title LIKE '%' + ? + '%' AND RecruiterID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", searchQuery);
        parameterMap.put("RecruiterID", recruiterID);  // Thêm RecruiterID vào truy vấn
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int findTotalRecordByTitle(String searchQuery) {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings] WHERE Title LIKE '%' + ? + '%' AND Status = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", searchQuery);
        parameterMap.put("Status", "Opened");  // Thêm RecruiterID vào truy vấn
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> findJobPostingsWithFilterAndRecruiterID(String sortField, int recruiterID, int page, int pageSize) {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE RecruiterID = ? ORDER BY " + sortField + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterID);  // Thêm RecruiterID vào truy vấn
        parameterMap.put("offset", (page - 1) * pageSize);
        parameterMap.put("fetch", pageSize);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> findJobPostingsWithFilter(String sortField, int page, int pageSize) {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE Status = ? ORDER BY " + sortField + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Open");
        parameterMap.put("offset", (page - 1) * pageSize);
        parameterMap.put("fetch", pageSize);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int countTotalJobPostingsByRecruiterID(int recruiterID) {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings] WHERE RecruiterID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterID);  // Thêm RecruiterID vào truy vấn
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    //Top 6 cong viec moi nhat
    public List<JobPostings> getTop6RecentJobPostingsByOpen() {
        String sql = "SELECT TOP 6 * FROM [dbo].[JobPostings] WHERE [Status] = ? order by PostedDate desc";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Open");

        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int countTotalJobPostings() {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings] WHERE Status = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Open");
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> getJobPostingsByOpen() {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE [Status] = ? order by PostedDate desc";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Open");

        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

}
