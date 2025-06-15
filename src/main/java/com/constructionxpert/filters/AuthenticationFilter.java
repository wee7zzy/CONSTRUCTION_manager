package com.constructionxpert.filters;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation du filtre
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String loginURI = httpRequest.getContextPath() + "/login";
        boolean isLoginRequest = httpRequest.getRequestURI().equals(loginURI);
        boolean isLoginPage = httpRequest.getRequestURI().endsWith("login.jsp");
        boolean isResourceRequest = httpRequest.getRequestURI().startsWith(httpRequest.getContextPath() + "/resources/");

        boolean isLoggedIn = session != null && session.getAttribute("admin") != null;

        if (isLoggedIn || isLoginRequest || isLoginPage || isResourceRequest) {
            // L'utilisateur est connecté ou demande la page de connexion ou une ressource statique
            chain.doFilter(request, response);
        } else {
            // L'utilisateur n'est pas connecté et tente d'accéder à une page protégée
            httpResponse.sendRedirect(loginURI);
        }
    }

    @Override
    public void destroy() {
        // Nettoyage des ressources
    }

    private boolean isPublicResource(String uri) {
        return uri.endsWith(".css") || 
               uri.endsWith(".js") || 
               uri.endsWith(".png") || 
               uri.endsWith(".jpg") || 
               uri.endsWith(".gif") || 
               uri.endsWith(".svg") || 
               uri.contains("/resources/") || 
               uri.contains("/assets/");
    }
}