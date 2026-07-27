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
import jakarta.servlet.http.HttpSession;

@WebServlet("/update-profile")
public class UpdateProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {

        userDAO = new UserDAOImpl();

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login");

            return;

        }

        User loggedInUser =
                (User) session.getAttribute("loggedInUser");

        User user = new User();

        user.setUserId(loggedInUser.getUserId());

        user.setFullName(loggedInUser.getFullName());

        user.setEmail(loggedInUser.getEmail());

        user.setPassword(loggedInUser.getPassword());

        user.setPhone(request.getParameter("phone"));

        user.setAddress(request.getParameter("address"));

        user.setCity(request.getParameter("city"));

        user.setState(request.getParameter("state"));

        user.setPincode(request.getParameter("pincode"));

        boolean updated =
                userDAO.updateUser(user);

        if (updated) {

            session.setAttribute("loggedInUser", user);

        }

        response.sendRedirect(
                request.getContextPath() + "/profile");

    }

}