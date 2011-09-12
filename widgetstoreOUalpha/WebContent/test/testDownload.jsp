<%@page import="org.apache.wookie.beans.IWidget"%>
<%@page import="org.apache.wookie.beans.jpa.impl.RatingImpl"%>
<%@page import="org.apache.wookie.beans.jpa.impl.CommentsImpl"%>
<%@page import="org.apache.wookie.beans.IComments"%>
<%@page import="org.apache.wookie.beans.IStoreUser"%>
<%@page import="org.apache.wookie.beans.ITagsWidgets"%>
<%@page import="org.apache.wookie.beans.ITags"%>
<%@page import="org.apache.wookie.beans.jpa.impl.ApikeyWidgetImpl"%>
<%@page import="org.apache.wookie.beans.IApikeyWidget"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.zip.*"%>
<%@page import="java.sql.*"%>
<%@page import="org.apache.wookie.beans.util.IPersistenceManager"%>
<%@page import="org.apache.wookie.beans.ITags"%>
<%@page import="org.apache.wookie.beans.IStoreUser"%>
<%@page import="org.apache.wookie.beans.jpa.impl.TagsImpl"%>
<%@page import="org.apache.wookie.beans.jpa.impl.TagsFreqImpl"%>
<%@page import="org.apache.wookie.beans.util.PersistenceManagerFactory"%>
<%@page import="org.apache.wookie.w3c.util.WidgetPackageUtils"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%


	IPersistenceManager persistenceManager = PersistenceManagerFactory
			.getPersistenceManager();

	String widid = request.getParameter("wid");//widget id
	int wid = Integer.parseInt(widid);

	IWidget w = persistenceManager.findById(IWidget.class, wid);

	String widgetGUID = w.getGuid();

	String widgetFolderString = WidgetPackageUtils
			.convertIdToFolderName(widgetGUID);

	String basePath = getServletContext().getRealPath("/wservices");//properties.widgetfolder

	widgetFolderString = basePath + "\\" + widgetFolderString;	
	
	File outFile = new File("out.zip",widgetFolderString);
	//String outFileFullPath = widgetFolder +"\\out.zip";
	String outFileFullPath = outFile.getPath();
	
	try {
		ZipOutputStream zipout = new ZipOutputStream(new FileOutputStream(outFileFullPath));
		File widgetFolder = new File(widgetFolderString);
		
		int len = widgetFolder.getAbsolutePath().lastIndexOf(File.separator);
		String baseName = widgetFolder.getAbsolutePath().substring(0,len+1);

		addFolderToZip(widgetFolder, zipout, baseName);

		zipout.close();
		
	}catch (FileNotFoundException e) {
		e.printStackTrace();
	} catch (IOException e) {
		e.printStackTrace();
	}
	
	static void addFolderToZip(File folder, ZipOutputStream zip, String baseName) throws IOException {
		File[] files = folder.listFiles();
		for (File file : files) {
			if (file.isDirectory()) {
				addFolderToZip(file, zip, baseName);
			} else {
				String name = file.getAbsolutePath().substring(baseName.length());
				ZipEntry zipEntry = new ZipEntry(name);
				zip.putNextEntry(zipEntry);
				IOUtils.copy(new FileInputStream(file), zip);
				zip.closeEntry();
			}
		}
	}
	
	/*
	 try {
	 File inFolder = new File(fullPath);
	 File outFolder = new File(fullPath+"/out.zip");
	 //out.print(outFolder.getAbsolutePath());
	
	 ZipOutputStream zipout = new ZipOutputStream(
	 new BufferedOutputStream(
	 new FileOutputStream(outFolder)));
	 BufferedInputStream in = null;
	 byte[] data = new byte[1000];
	 String files[] = inFolder.list();
	 for (int i = 0; i < files.length; i++) {
	 in = new BufferedInputStream(new FileInputStream(
	 inFolder.getPath() + "/" + files[i]), 1000);
	 zipout.putNextEntry(new ZipEntry(files[i]));
	 int count;
	 while ((count = in.read(data, 0, 1000)) != -1) {
	 zipout.write(data, 0, count);
	 }
	 zipout.closeEntry();
	 }
	 zipout.close();
	 out.flush();
	 out.close();
	
	 } catch (Exception e) {
	 e.printStackTrace();
	 }
	 */
%>