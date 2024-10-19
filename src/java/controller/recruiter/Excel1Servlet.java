package controller.recruiter;

import dao.JobPostingsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.JobPostings;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;  // Dùng cho .xls
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;  // Dùng cho .xlsx

@WebServlet(name = "Excel1Servlet", urlPatterns = {"/importExcel"})
@MultipartConfig
public class Excel1Servlet extends HttpServlet {

    JobPostingsDAO dao = new JobPostingsDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Part filePart = request.getPart("excelFile");
        String fileName = filePart.getSubmittedFileName();
        InputStream fileInputStream = filePart.getInputStream();

        Workbook workbook = null;
        if (fileName.endsWith(".xlsx")) {
            workbook = new XSSFWorkbook(fileInputStream);
        } else if (fileName.endsWith(".xls")) {
            workbook = new HSSFWorkbook(fileInputStream);
        } else {
            response.getWriter().write("Invalid file format. Please upload an Excel file.");
            return;
        }

        try {
            Sheet sheet = workbook.getSheetAt(0);
            List<JobPostings> jobPostingsList = new ArrayList<>();

            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row != null) {
                    JobPostings job = new JobPostings();

                    // Kiểm tra kiểu dữ liệu của các ô trước khi lấy giá trị
                    if (row.getCell(0).getCellType() == CellType.NUMERIC) {
                        job.setJobPostingID((int) row.getCell(0).getNumericCellValue());
                    }

                    if (row.getCell(1).getCellType() == CellType.NUMERIC) {
                        job.setRecruiterID((int) row.getCell(1).getNumericCellValue());
                    }

                    if (row.getCell(2).getCellType() == CellType.STRING) {
                        job.setTitle(row.getCell(2).getStringCellValue());
                    }

                    if (row.getCell(3).getCellType() == CellType.STRING) {
                        job.setDescription(row.getCell(3).getStringCellValue());
                    }

                    if (row.getCell(4).getCellType() == CellType.STRING) {
                        job.setRequirements(row.getCell(4).getStringCellValue());
                    }

                    if (row.getCell(5).getCellType() == CellType.NUMERIC) {
                        job.setSalary(row.getCell(5).getNumericCellValue());
                    }

                    if (row.getCell(6).getCellType() == CellType.STRING) {
                        job.setLocation(row.getCell(6).getStringCellValue());
                    }

                    if (row.getCell(7).getCellType() == CellType.NUMERIC && DateUtil.isCellDateFormatted(row.getCell(7))) {
                        job.setPostedDate(row.getCell(7).getDateCellValue());
                    }

                    if (row.getCell(8).getCellType() == CellType.NUMERIC && DateUtil.isCellDateFormatted(row.getCell(8))) {
                        job.setClosingDate(row.getCell(8).getDateCellValue());
                    }

                    if (row.getCell(9).getCellType() == CellType.STRING) {
                        job.setStatus(row.getCell(9).getStringCellValue());
                    }

                    // Thêm vào danh sách các JobPostings
                    jobPostingsList.add(job);
                }
            }

            // Lưu dữ liệu vào cơ sở dữ liệu
            for (JobPostings jobPosting : jobPostingsList) {
                dao.insert(jobPosting);
            }

            response.sendRedirect("jobPost");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error processing the file.");
        } finally {
            if (workbook != null) {
                workbook.close();
            }
        }
    }

}
