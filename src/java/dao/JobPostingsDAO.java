package dao;

import static constant.CommonConst.RECORD_PER_PAGE;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import model.Company;
import model.JobPostings;
import model.WeeklyPostings;

public class JobPostingsDAO extends GenericDAO<JobPostings> {

    @Override
    public List<JobPostings> findAll() {
        return queryGenericDAO(JobPostings.class);
    }

    @Override
    public int insert(JobPostings t) {
        String sql = "INSERT INTO [dbo].[JobPostings]\n"
                + "           ([Title]\n"
                + "           ,[Description]\n"
                + "           ,[Requirements]\n"
                + "           ,[Salary]\n"
                + "           ,[Location]\n"
                + "           ,[PostedDate]\n"
                + "           ,[ClosingDate]\n"
                + "           ,[Status])\n"
                + "          VALUES(?,?,?,?,?,?,?,?)";
        parameterMap = new LinkedHashMap<>();
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

    public JobPostings findJobPostingById(int ID) {
        String sql = "SELECT * FROM [dbo].[JobPostings] where JobPostingID = ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("JobPostingID", ID);
        List<JobPostings> list = queryGenericDAO(JobPostings.class, sql, parameterMap);
        return list.isEmpty() ? null : list.get(0);
    }

    public void updateJobPosting(JobPostings jobPostingEdit) {
        String sql = "UPDATE [dbo].[JobPostings]\n"
                + "   SET [Title] = ?\n"
                + "      ,[Description] = ?\n"
                + "      ,[Requirements] = ?\n"
                + "      ,[Salary] = ?\n"
                + "      ,[Location] = ?\n"
                + "      ,[PostedDate] = ?\n"
                + "      ,[ClosingDate] = ?\n"
                + "      ,[Status] = ?\n"
                + " WHERE JobPostingID = ?";
        parameterMap = new LinkedHashMap<>();
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

    public List<JobPostings> searchJobPostingByTitle(String title) {
        String sql = "SELECT *\n"
                + "FROM [dbo].[JobPostings]\n"
                + "WHERE Title LIKE '%' + ? + '%'";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", title);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> getListBookByPage(List<JobPostings> list, int start, int end) {
        List<JobPostings> arr = new ArrayList<>();
        for (int i = start; i < end; ++i) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public List<JobPostings> findByTitle(String keyword) {
        String sql = "SELECT *\n"
                + "FROM [dbo].[JobPostings]\n"
                + "WHERE Title LIKE ?";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", "%" + keyword + "%");
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int findTotalRecordByTitle(String searchQuery) {
        String sql = "SELECT count(*)\n"
                + "FROM [dbo].[JobPostings]\n"
                + "WHERE Title LIKE '%' + ? + '%'";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", searchQuery);
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> searchJobPostingByTitle1(String searchJP, int page) {
        String sql = "SELECT *\n"
                + "FROM [dbo].[JobPostings]\n"
                + "WHERE Title LIKE '%' + ? + '%'"
                + "order by id\n"
                + "offset ? rows\n"
                + "fetch next ? rows only";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", searchJP);
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int findAllTotalRecord() {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings]\n";
        parameterMap = new LinkedHashMap<>();
        return findTotalRecordGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> sortJobPostingsByTitle(int page) {
        String sql = "SELECT *\n"
                + "FROM [dbo].[JobPostings]\n"
                + "ORDER BY Title ASC\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> sortJobPostingsByPostedDate(int page) {
        String sql = "SELECT *\n"
                + "FROM [dbo].[JobPostings]\n"
                + "ORDER BY PostedDate DESC\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> sortJobPostingsByStatus(int page) {
        String sql = "SELECT *\n"
                + "FROM [dbo].[JobPostings]\n"
                + "ORDER BY Status ASC\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> searchJobPostingByTitle(String searchJP, int page) {
        String sql = "SELECT * FROM [dbo].[JobPostings] WHERE Title LIKE '%' + ? + '%' ORDER BY JobPostingID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("Title", searchJP);
        parameterMap.put("offset", (page - 1) * RECORD_PER_PAGE);
        parameterMap.put("fetch", RECORD_PER_PAGE);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public int countTotalJobPostings() {
        String sql = "SELECT count(*) FROM [dbo].[JobPostings]";
        return findTotalRecordGenericDAO(JobPostings.class, sql, new LinkedHashMap<>());
    }

    public List<JobPostings> findJobPostingsWithFilter(String sortField, int page, int pageSize) {
        String sql = "SELECT * FROM [dbo].[JobPostings] ORDER BY " + sortField + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        parameterMap = new LinkedHashMap<>();
        parameterMap.put("offset", (page - 1) * pageSize);
        parameterMap.put("fetch", pageSize);
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    public List<JobPostings> getTop5RecentJobPostings() {
        String sql = "SELECT TOP 5 *\n"
                + "FROM [dbo].[JobPostings]\n"
                + "ORDER BY PostedDate DESC";
        parameterMap = new LinkedHashMap<>();
        return queryGenericDAO(JobPostings.class, sql, parameterMap);
    }

    

}
