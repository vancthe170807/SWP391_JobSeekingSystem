package controller.recruiter;

import constant.CommonConst;
import dao.CompanyDAO;
import dao.RecruitersDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Company;
import model.Recruiters;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
@WebServlet(name = "VerifyRecruiter", urlPatterns = {"/verifyRecruiter"})
public class VerifyRecruiter extends HttpServlet {

    RecruitersDAO reDAO = new RecruitersDAO();
    CompanyDAO companyDao = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);
        List<Company> companies = companyDao.findAll();
        request.setAttribute("companyList", companies);
        request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ID công ty và vị trí từ form
        int companyId;
        try {
            companyId = Integer.parseInt(request.getParameter("companyId"));
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid company ID format.");
            request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
            return;
        }
        String position = request.getParameter("position");

        // Kiểm tra nếu companyId có tồn tại trong database
        if (!companyDao.isCompanyExist(companyId)) {
            request.setAttribute("error", "Company ID does not exist.");
            request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
            return;
        }

        // Handle file uploads
        Part frontCitizenIDPart = request.getPart("frontCitizenID");
        Part backCitizenIDPart = request.getPart("backCitizenID");

        // Kiểm tra nếu người dùng chọn cùng một file cho cả hai mặt
        if (frontCitizenIDPart.getSubmittedFileName().equals(backCitizenIDPart.getSubmittedFileName())) {
            request.setAttribute("error", "You cannot upload the same file for both Front and Back Citizen ID.");
            request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
            return;
        }

        // Save the uploaded files
        String uploadDir = "uploads/citizen_ids";
        String frontCitizenIDFileName = saveFile(frontCitizenIDPart, uploadDir);
        String backCitizenIDFileName = saveFile(backCitizenIDPart, uploadDir);

        // Lấy account từ session
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute(CommonConst.SESSION_ACCOUNT);

        // Kiểm tra nếu recruiter đã xác nhận chưa
        Recruiters recruiter = reDAO.findRecruitersbyAccountID(String.valueOf(account.getId()));
        if (recruiter != null && recruiter.isIsVerify()) {
            // Nếu đã xác nhận, quay về dashboard
            response.sendRedirect("Dashboard");
        } else if (recruiter != null && !recruiter.isIsVerify()) {
            // Nếu yêu cầu đang chờ, ngăn không cho gửi lại
            request.setAttribute("error", "Your verification request is already pending approval.");
            request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
            return;
        } else {
            // Nếu chưa, tạo request mới
            Recruiters re = new Recruiters();
            re.setAccountID(account.getId());
            re.setCompanyID(companyId);
            re.setPosition(position);
            re.setIsVerify(false); // Đặt trạng thái là chưa xác minh
            re.setFrontCitizenImage(frontCitizenIDFileName);  // Save the front citizen image
            re.setBackCitizenImage(backCitizenIDFileName);    // Save the back citizen image
            reDAO.insert(re);

            // Lưu trạng thái "đã nộp đơn xác minh" vào session
            session.setAttribute("isRecruiterVerified", false);

            // Gửi thông báo xác nhận thành công
            request.setAttribute("verify", "Your verification request has been sent.");
            request.getRequestDispatcher("view/recruiter/verifyRecruiter.jsp").forward(request, response);
        }
    }
// Helper method to save the uploaded file and return the file path

    private String saveFile(Part filePart, String uploadDir) throws IOException {
        // Create directories if they don't exist
        Path uploadPath = Paths.get(getServletContext().getRealPath("/") + uploadDir);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // Lấy tên file từ filePart
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Kiểm tra nếu file đã tồn tại
        Path filePath = uploadPath.resolve(fileName);
        if (Files.exists(filePath)) {
            // Tạo tên file mới bằng cách thêm timestamp vào file
            String newFileName = System.currentTimeMillis() + "_" + fileName;
            filePath = uploadPath.resolve(newFileName);
            fileName = newFileName;
        }

        // Lưu file
        Files.copy(filePart.getInputStream(), filePath);

        // Trả về đường dẫn tương đối đến file
        return uploadDir + "/" + fileName;
    }
}
