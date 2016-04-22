<%@ page import="com.baidu.ueditor.ActionEnter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding( "utf-8" );
	response.setHeader("Content-Type" , "text/html");
	
	String rootPath = application.getRealPath( "/" );
	
	out.write( new ActionEnter( request, rootPath ).exec() ); //原生的 
	//out.write( new MyActionEnter( request, rootPath ).exec() ); //结合本项目修改后版本，改成请求/ueditor/controller.action
%>