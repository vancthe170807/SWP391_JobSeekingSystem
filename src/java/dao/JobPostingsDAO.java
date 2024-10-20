package dao;

import static constant.CommonConst.RECORD_PER_PAGE;
import java.util.ArrayList;
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

    public List<JobPostings> findJobPostingbyRecruitersID(int recruiterID) {
        String sql = "select * from [dbo].[JobPostings] where RecruiterID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterID);
        List<JobPostings> list = queryGenericDAO(JobPostings.class, sql, parameterMap);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);

    }

    public void updateJobPosting(JobPostings jobPostingEdit) {
        String sql = "UPDATE [dbo].[JobPostings]\n"
                + "   SET [RecruiterID] = ?\n"
                + "      ,[Title] = ?\n"
                + "      ,[Description] = ?\n"
                + "      ,[Requirements] = ?\n"
                + "      ,[Salary] = ?\n"
                + "      ,[Location] = ?\n"
                + "      ,[PostedDate] = ?\n"
                + "      ,[ClosingDate] = ?\n"
                + "      ,[Status] = ?\n"
                + " WHERE JobPostingID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", jobPostingEdit.getRecruiterID());
        parameterMap.put("Title", jobPostingEdit.getTitle());
        parameterMap.put("Description", jobPostingEdit.getDescription());
        parameterMap.put("Requirements", jobPostingEdit.getRequirements());
        parameterMap.put("Salary", jobPostingEdit.getSalary());
        parameterMap.put("Location", jobPostingEdit.getLocation());
        parameterMap.put("PostedDate", jobPostingEdit.getPostedDate());
        parameterMap.put("ClosingDate", jobPostingEdit.getClosingDate());
        parameterMap.put("Status", jobPostingEdit.getStatus());
        parameterMap.put("JobPostingID", jobPostingEdit.getJobPostingID());
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
                + "           ,[Salary]\n"
                + "           ,[Location]\n"
                + "           ,[PostedDate]\n"
                + "           ,[ClosingDate]\n"
                + "           ,[Status])\n"
                + "     VALUES(?,?,?,?,?,?,?,?,?)";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", t.getRecruiterID());
        parameterMap.put("Title", t.getTitle());
        parameterMap.put("Description", t.getDescription());
        parameterMap.put("Requirements", t.getRequirements());
        parameterMap.put("Salary", t.getSalary());
        parameterMap.put("Location", t.getLocation());
        parameterMap.put("PostedDate", t.getPostedDate());
        parameterMap.put("ClosingDate", t.getClosingDate());
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

    public int findTotalRecordByTitleAndRecruiterID(String searchQuery, int recruiterID) {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings] WHERE Title LIKE '%' + ? + '%' AND RecruiterID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", searchQuery);
        parameterMap.put("RecruiterID", recruiterID);  // Thêm RecruiterID vào truy vấn
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

    public int countTotalJobPostingsByRecruiterID(int recruiterID) {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings] WHERE RecruiterID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("RecruiterID", recruiterID);  // Thêm RecruiterID vào truy vấn
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    //cho trang home page
    public List<JobPostings> findJobPostingsByStatus(String status) {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE Status = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", status);
        List<JobPostings> list = queryGenericDAO(JobPostings.class, sql, parameterMap);
        return list;
    }

    public List<JobPostings> findJobPostingsByStatusWithPagination(String status, int page, int pageSize) {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE Status = ? ORDER BY PostedDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", status);
        parameterMap.put("Offset", (page - 1) * pageSize);  // Tính toán offset cho phân trang
        parameterMap.put("PageSize", pageSize);  // Số lượng bản ghi trên mỗi trang

        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int countJobPostingsByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM [dbo].[JobPostings] WHERE Status = ?";

        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", status);

        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }
    
    public List<JobPostings> findJobPostingsByStatusAndTitleWithPagination(String status, String title, int page, int pageSize) {
    String sql = "SELECT * FROM [dbo].[JobPostings] WHERE Status = ? AND Title LIKE ? ORDER BY PostedDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    
    parameterMap = new LinkedHashMap<>();
    parameterMap.put("Status", status);
    parameterMap.put("Title", "%" + title + "%");
    parameterMap.put("Offset", (page - 1) * pageSize);  // Tính toán offset cho phân trang
    parameterMap.put("PageSize", pageSize);  // Số lượng bản ghi trên mỗi trang

    return queryGenericDAO(JobPostings.class, sql, parameterMap);
}

public int countJobPostingsByStatusAndTitle(String status, String title) {
    String sql = "SELECT COUNT(*) FROM [dbo].[JobPostings] WHERE Status = ? AND Title LIKE ?";
    
    parameterMap = new LinkedHashMap<>();
    parameterMap.put("Status", status);
    parameterMap.put("Title", "%" + title + "%");

    return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
}

public List<JobPostings> findJobPostingsByTitle(String title, int offset, int noOfRecords) {
        String sql = "SELECT * FROM [JobPostings] WHERE Title LIKE ? AND Status = 'Open' ORDER BY PostedDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", "%" + title + "%");
        parameterMap.put("offset", offset);
        parameterMap.put("noOfRecords", noOfRecords);
        
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int getTotalRecords(String title) {
        String sql = "SELECT COUNT(*) FROM [JobPostings] WHERE Title LIKE ? AND Status = 'Open'";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", "%" + title + "%");

        // Implement phương thức để lấy số lượng bản ghi dựa trên query
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }
    
    // Tìm các job theo status và title (có phân trang)
    public List<JobPostings> findJobPostingsByTitleAndStatus(String status, String title, int offset, int noOfRecords) {
        String sql = "SELECT * FROM [JobPostings] WHERE Title LIKE ? AND Status = ? ORDER BY PostedDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", "%" + title + "%");
        parameterMap.put("Status", status);
        parameterMap.put("offset", offset);
        parameterMap.put("noOfRecords", noOfRecords);
        
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    // Tìm các job theo status (có phân trang)
    public List<JobPostings> findJobPostingsByStatus(String status, int offset, int noOfRecords) {
        String sql = "SELECT * FROM [JobPostings] WHERE Status = ? ORDER BY PostedDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", status);
        parameterMap.put("offset", offset);
        parameterMap.put("noOfRecords", noOfRecords);
        
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    // Lấy tổng số bản ghi dựa trên status và title
    public int getTotalRecords(String status, String title) {
        String sql = "SELECT COUNT(*) FROM [JobPostings] WHERE Status = ? AND Title LIKE ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", status);
        parameterMap.put("Title", "%" + title + "%");

        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }
    
    
    public List<JobPostings> findJobPostingsByStatusAndTitle(String status, String title, int page) {
    String sql = "SELECT * FROM [dbo].[JobPostings] WHERE Status = ? AND Title LIKE '%' + ? + '%' ORDER BY JobPostingID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    
    // Sử dụng parameterMap để truyền giá trị vào câu truy vấn
    parameterMap = new LinkedHashMap<>();
    parameterMap.put("Status", status);
    parameterMap.put("Title", title);
    parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);  // Tính toán offset cho phân trang
    parameterMap.put("fetch", RECORD_PER_PAGE);  // Số lượng bản ghi trên mỗi trang

    // Thực hiện truy vấn và trả về danh sách JobPostings
    return queryGenericDAO(JobPostings.class, sql, parameterMap);
}
    public int findTotalRecordByStatusAndTitle(String status, String title) {
    String sql = "SELECT count(*) FROM [dbo].[JobPostings] WHERE Status = ? AND Title LIKE '%' + ? + '%'";
    
    // Sử dụng parameterMap để truyền giá trị vào câu truy vấn
    parameterMap = new LinkedHashMap<>();
    parameterMap.put("Status", status);
    parameterMap.put("Title", title);

    // Thực hiện truy vấn và trả về tổng số bản ghi
    return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
}
 // Hàm lấy danh sách job postings theo trạng thái và tiêu đề với phân trang
    public List<JobPostings> findJobPostingsByStatusAndTitle(String status, String title, int page, int recordsPerPage) {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE Status = ? AND Title LIKE '%' + ? + '%' ORDER BY JobPostingID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        // Sử dụng parameterMap để truyền giá trị vào câu truy vấn
        Map<String, Object> parameterMap = new LinkedHashMap<>();
        parameterMap.put("Status", status);
        parameterMap.put("Title", title);
        parameterMap.put("offset", (page - 1) * recordsPerPage);  // Tính toán offset cho phân trang
        parameterMap.put("fetch", recordsPerPage);  // Số lượng bản ghi trên mỗi trang

        // Thực hiện truy vấn và trả về danh sách JobPostings
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }
}
