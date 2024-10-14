package controller.admin;

import dao.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Account;

@WebServlet(name = "SeekerAdminController", urlPatterns = {"/seekers"})
public class SeekerAdminController extends HttpServlet {

    AccountDAO dao = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String filter = request.getParameter("filter") != null ? request.getParameter("filter") : "";

        List<Account> listSeekers;
        switch (filter) {
            case "active":
                listSeekers = dao.filterSeekerByStatus(true);
                break;
            case "inactive":
                listSeekers = dao.filterSeekerByStatus(false);
                break;
            default:
                listSeekers = dao.findAllUserByRoleId(3);
        }

        request.setAttribute("listSeekers", listSeekers);

        String url = "view/admin/seekerManagement.jsp";
        if ("view-list-seekers".equals(action)) {
            url = "view/admin/seekerManagement.jsp";
        }

        // Forward to the appropriate page
        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String url = "seekers";

        try {
            int id = Integer.parseInt(request.getParameter("id-seeker"));
            Account account = dao.findUserById(id);

            switch (action) {
                case "deactive":
                    dao.deactiveAccount(account);
                    break;
                case "active":
                    dao.activeAccount(account);
                    break;
                case "view-detail":
                    request.setAttribute("accountView", account);
                    request.getRequestDispatcher("view/admin/viewDetailSeekers.jsp").forward(request, response);
                    return;
                default:
                    break;
            }

        } catch (NumberFormatException e) {
            // Handle invalid seeker ID format
            request.setAttribute("error", "Invalid seeker ID format.");
        } catch (Exception e) {
            // Handle any other exceptions
            request.setAttribute("error", "An error occurred: " + e.getMessage());
        }

        // Redirect after action
        response.sendRedirect(url);
    }
}
