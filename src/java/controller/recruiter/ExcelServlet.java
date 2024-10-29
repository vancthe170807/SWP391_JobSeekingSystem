package controller.recruiter;

import constant.CommonConst;
import dao.JobPostingsDAO;
import dao.RecruitersDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.JobPostings;
import model.Recruiters;

@WebServlet(name = "ExcelServlet", urlPatterns = {"/exportExcel"})
public class ExcelServlet extends HttpServlet {

    JobPostingsDAO dao = new JobPostingsDAO();
    RecruitersDAO recruitersDAO = new RecruitersDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set the content type to Excel format
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=tuan_job_postings.xlsx");

        // Create the workbook and sheet
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Job Postings");

        // Create header row
        Row headerRow = sheet.createRow(0);
        //headerRow.createCell(0).setCellValue("JobPostingID");
        //headerRow.createCell(1).setCellValue("RecruiterID");
        headerRow.createCell(0).setCellValue("Title");
        headerRow.createCell(1).setCellValue("Description");
        headerRow.createCell(2).setCellValue("Requirements");
        headerRow.createCell(3).setCellValue("MinSalary");
        headerRow.createCell(4).setCellValue("MaxSalary");
        headerRow.createCell(5).setCellValue("Location");
        headerRow.createCell(6).setCellValue("PostedDate");
        headerRow.createCell(7).setCellValue("ClosingDate");
        headerRow.createCell(8).setCellValue("JobPostingCategoryID");
        headerRow.createCell(9).setCellValue("Status");

        // Create a date format for the date cells
        CreationHelper createHelper = workbook.getCreationHelper();
        CellStyle dateCellStyle = workbook.createCellStyle();
        dateCellStyle.setDataFormat(createHelper.createDataFormat().getFormat("dd-MM-yyyy"));

        // Fill the data (Retrieve actual job postings data from DAO)
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        Recruiters recruiters = recruitersDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));
        List<JobPostings> jobPostings = dao.findAllByRecruiterID(recruiters.getRecruiterID());
        int rowNum = 1;
        for (JobPostings job : jobPostings) {
            Row row = sheet.createRow(rowNum++);

            //row.createCell(0).setCellValue(job.getJobPostingID());
            //row.createCell(1).setCellValue(job.getRecruiterID());
            row.createCell(0).setCellValue(job.getTitle());
            row.createCell(1).setCellValue(job.getDescription());
            row.createCell(2).setCellValue(job.getRequirements());
            row.createCell(3).setCellValue(job.getMinSalary());
            row.createCell(4).setCellValue(job.getMaxSalary());
            row.createCell(5).setCellValue(job.getLocation());

            // Handle PostedDate (java.util.Date)
            if (job.getPostedDate() != null) {
                Cell postedDateCell = row.createCell(5);
                postedDateCell.setCellValue(job.getPostedDate());
                postedDateCell.setCellStyle(dateCellStyle); // Apply date format
            } else {
                row.createCell(6).setCellValue("N/A");
            }

            // Handle ClosingDate (java.util.Date)
            if (job.getClosingDate() != null) {
                Cell closingDateCell = row.createCell(6);
                closingDateCell.setCellValue(job.getClosingDate());
                closingDateCell.setCellStyle(dateCellStyle); // Apply date format
            } else {
                row.createCell(7).setCellValue("N/A");
            }
            row.createCell(8).setCellValue(job.getJob_Posting_CategoryID());
            row.createCell(9).setCellValue(job.getStatus());
        }

        // Write the workbook to the response
        try (ServletOutputStream out = response.getOutputStream()) {
            workbook.write(out);
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            workbook.close(); // Close workbook in the finally block
        }
    }
}
