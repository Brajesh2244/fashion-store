package com.fashionstore.controller;

import java.io.IOException;

import com.fashionstore.dao.UserDAO;
import com.fashionstore.dao.impl.UserDAOImpl;
import com.fashionstore.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {

        userDAO = new UserDAOImpl();

    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/views/register.jsp")
               .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");

        // Email Validation
        if (userDAO.emailExists(email)) {

            request.setAttribute("error",
                    "Email already registered.");

            request.getRequestDispatcher("/WEB-INF/views/register.jsp")
                   .forward(request, response);

            return;

        }

        // Phone Validation
        if (userDAO.phoneExists(phone)) {

            request.setAttribute("error",
                    "Phone number already registered.");

            request.getRequestDispatcher("/WEB-INF/views/register.jsp")
                   .forward(request, response);

            return;

        }

        User user = new User();

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(password);
        user.setAddress(address);
        user.setCity(city);
        user.setState(state);
        user.setPincode(pincode);

        boolean status = userDAO.registerUser(user);

        if (status) {

            response.sendRedirect(
                    request.getContextPath() + "/login");

        } else {

            request.setAttribute("error",
                    "Registration Failed.");

            request.getRequestDispatcher("/WEB-INF/views/register.jsp")
                   .forward(request, response);

        }

    }

}