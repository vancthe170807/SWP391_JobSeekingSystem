package dao;

import static constant.CommonConst.RECORD_PER_PAGE;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.sql.*;
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
    
    public int findTotalRecordByTitle(String searchQuery, double minSalary, double maxSalary) {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings] WHERE Title LIKE '%' + ? + '%' AND MinSalary >= ? AND MaxSalary <= ? AND Status = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", searchQuery);
        parameterMap.put("Status", "Opened");  // Thêm RecruiterID vào truy vấn
        parameterMap.put("MinSalary", minSalary);
        parameterMap.put("MaxSalary", maxSalary);
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
    
    public int countJobsBySalaryRange(double minSalary, double maxSalary) {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings] WHERE MinSalary >= ? AND MaxSalary <= ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("MinSalary", minSalary);
        parameterMap.put("MaxSalary", maxSalary);
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }
    
    public int countJobPostingsByCategory(int categoryId) {
        String sql = "SELECT COUNT(*) FROM JobPostings WHERE Status = ? and Job_Posting_CategoryID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Open");
        parameterMap.put("Job_Posting_CategoryID", categoryId);

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

    public List<JobPostings> getTop6JobPostingsByCategory(int categoryId) {
        String sql = "select top 6 * from JobPostings where Status = ? and Job_Posting_CategoryID = ? order by PostedDate desc";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Open");
        parameterMap.put("Job_Posting_CategoryID", categoryId);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> getJobPostingsByCategory(int categoryId) {
        String sql = "select * from JobPostings where Status = ? and Job_Posting_CategoryID = ? order by PostedDate desc";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Open");
        parameterMap.put("Job_Posting_CategoryID", categoryId);

        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> findTop5Recruiter() {
        String sql = "SELECT *\n"
                + "FROM JobPostings\n"
                + "WHERE RecruiterID IN (\n"
                + "    SELECT TOP 5 RecruiterID\n"
                + "    FROM JobPostings\n"
                + "    GROUP BY RecruiterID\n"
                + "    ORDER BY COUNT(*) DESC\n"
                + ")\n"
                + "ORDER BY RecruiterID, PostedDate;";
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> filterJobPostingStatusForChart() {
        String sql = "SELECT *\n"
                + "FROM JobPostings\n"
                + "ORDER BY Status;";
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    // Tim Job theo khoang luong
    public List<JobPostings> getJobsBySalaryRange(double MinSalary, double MaxSalary, int page, int pageSize, String sortField) {
        String sql = "SELECT * FROM JobPostings WHERE MinSalary >= ? AND MaxSalary <= ? AND Status = ? ORDER BY " + sortField + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("MinSalary", MinSalary);
        parameterMap.put("MaxSalary", MaxSalary);
        parameterMap.put("Status", "Open");
        parameterMap.put("offset", (page - 1) * pageSize);
        parameterMap.put("fetch", pageSize);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }
    public List<JobPostings> findAndfilterJobPostings(String status, String salaryRange, String postDate, String search, int page) {
        String sql = """
                     SELECT jb.* FROM JobPostings as jb, Recruiters as re, Account as acc
                     where jb.RecruiterID = re.RecruiterID AND re.AccountID = acc.id """;

        // Thêm điều kiện lọc nếu các giá trị không null hoặc không rỗng
        if (status != null && !status.isEmpty() && !status.equals("all")) {
            sql += " AND jb.Status = ?";
        }
        if (salaryRange != null && !salaryRange.isEmpty() && !salaryRange.equals("all")) {
            switch (salaryRange) {
                case "0-1000":
                    sql += " AND jb.MinSalary >= 0 AND jb.MaxSalary <=1000";
                    break;
                case "1000+":
                    sql += " AND jb.MinSalary >= 1000";
                    break;
                case "2000+":
                    sql += " AND jb.MinSalary >= 2000";
                    break;
            }
        }
        if (postDate != null && !postDate.isEmpty()) {
            sql += " AND jb.PostedDate = ?";
        }
        if (search != null && !search.isEmpty()) {
            sql += " AND acc.lastName + ' ' + acc.firstName like ?";
        }
        sql += """
                order by JobPostingID
               OFFSET ? rows
               FETCH NEXT ? rows only""";
        parameterMap = new LinkedHashMap<>();
        if (status != null && !status.isEmpty() && !status.equals("all")) {
            parameterMap.put("Status", status);
        }
        if (postDate != null && !postDate.isEmpty()) {
            parameterMap.put("PostedDate", postDate);
        }
        if (search != null && !search.isEmpty()) {
            parameterMap.put("FullName", "%" + search + "%");
        }
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public void violateJobPost(int jobPostId) {
        String sql = """
                     UPDATE [dbo].[JobPostings]
                        SET 
                           [Status] = ?
                      WHERE JobPostingID = ?""";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", "Violate");
        parameterMap.put("JobPostingID", jobPostId);
        updateGenericDAO(sql, parameterMap);
    }

    public int findAndfilterAllRecord(String status, String salaryRange, String postDate, String search) {
        String sql = """
                     SELECT count(*) FROM JobPostings as jb, Recruiters as re, Account as acc
                     where jb.RecruiterID = re.RecruiterID AND re.AccountID = acc.id """;

        // Thêm điều kiện lọc nếu các giá trị không null hoặc không rỗng
        if (status != null && !status.isEmpty() && !status.equals("all")) {
            sql += " AND jb.Status = ?";
        }
        if (salaryRange != null && !salaryRange.isEmpty() && !salaryRange.equals("all")) {
            switch (salaryRange) {
                case "0-1000":
                    sql += " AND jb.MinSalary >= 0 AND jb.MaxSalary <=1000";
                    break;
                case "1000+":
                    sql += " AND jb.MinSalary >= 1000";
                    break;
                case "2000+":
                    sql += " AND jb.MinSalary >= 2000";
                    break;
            }
        }
        if (postDate != null && !postDate.isEmpty()) {
            sql += " AND jb.PostedDate = ?";
        }
        if (search != null && !search.isEmpty()) {
            sql += " AND acc.lastName + ' ' + acc.firstName like ?";
        }
        
        parameterMap = new LinkedHashMap<>();
        if (status != null && !status.isEmpty() && !status.equals("all")) {
            parameterMap.put("Status", status);
        }
        if (postDate != null && !postDate.isEmpty()) {
            parameterMap.put("PostedDate", postDate);
        }
        if (search != null && !search.isEmpty()) {
            parameterMap.put("FullName", "%" + search + "%");
        }
        
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

}
