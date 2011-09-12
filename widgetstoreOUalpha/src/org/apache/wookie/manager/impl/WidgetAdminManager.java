/*
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.apache.wookie.manager.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.sql.*;

import org.apache.log4j.Logger;
import org.apache.wookie.Messages;
import org.apache.wookie.beans.IWidget;
import org.apache.wookie.beans.IWidgetDefault;
import org.apache.wookie.beans.IWidgetType;
import org.apache.wookie.beans.util.IPersistenceManager;
import org.apache.wookie.beans.util.PersistenceManagerFactory;
import org.apache.wookie.manager.IWidgetAdminManager;

/**
 * WidgetAdminManager
 * 
 * This class is responsible for administrative functions such as adding new
 * widget types and setting which widget is to be the default
 * 
 * @author Paul Sharples
 * @version $Id: WidgetAdminManager.java,v 1.2 2009-07-28 16:05:23 scottwilson
 *          Exp $
 */
public class WidgetAdminManager implements IWidgetAdminManager {

	static Logger _logger = Logger
			.getLogger(WidgetAdminManager.class.getName());
	protected Messages localizedMessages;

	public WidgetAdminManager(Messages localizedMessages) {
		this.localizedMessages = localizedMessages;
	}

	private void deleteWidgetDefaultByIdAndServiceType(Object widgetKey,
			String serviceType) {
		IPersistenceManager persistenceManager = PersistenceManagerFactory
				.getPersistenceManager();
		IWidget widget = persistenceManager.findById(IWidget.class, widgetKey);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("widget", widget);
		map.put("widgetContext", serviceType);
		IWidgetDefault[] widgetDefaults = persistenceManager.findByValues(
				IWidgetDefault.class, map);
		persistenceManager.delete(widgetDefaults);
	}

	private boolean doesServiceExistForWidget(Object dbkey, String serviceType) {
		IPersistenceManager persistenceManager = PersistenceManagerFactory
				.getPersistenceManager();
		IWidget widget = persistenceManager.findById(IWidget.class, dbkey);
		Iterator<IWidgetType> typesIter = widget.getWidgetTypes().iterator();
		while (typesIter.hasNext()) {
			IWidgetType type = typesIter.next();
			if (type.getWidgetContext().equalsIgnoreCase(serviceType)) {
				return true;
			}
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.apache.wookie.manager.IWidgetAdminManager#removeSingleWidgetType(
	 * java.lang.String, java.lang.String)
	 */
	public boolean removeSingleWidgetType(String widgetId, String widgetType) {
		boolean response = false;
		IPersistenceManager persistenceManager = PersistenceManagerFactory
				.getPersistenceManager();
		IWidget widget = persistenceManager.findById(IWidget.class, widgetId);
		// remove any widget types for this widget
		Iterator<IWidgetType> typesIter = widget.getWidgetTypes().iterator();
		while (typesIter.hasNext()) {
			IWidgetType type = typesIter.next();
			if (type.getWidgetContext().equalsIgnoreCase(widgetType)) {
				typesIter.remove();
				response = true;
			}
		}
		if (response) {
			persistenceManager.save(widget);
		}
		// if it exists as a service default, then remove it
		deleteWidgetDefaultByIdAndServiceType(widgetId, widgetType);
		return response;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.apache.wookie.manager.IWidgetAdminManager#setDefaultWidget(java.lang
	 * .String, java.lang.String)
	 */
	public void setDefaultWidget(String key, String widgetType) {
		boolean found = false;
		IPersistenceManager persistenceManager = PersistenceManagerFactory
				.getPersistenceManager();
		IWidget widget = persistenceManager.findById(IWidget.class, key);
		// does it already exist in the widgetdefault table?
		IWidgetDefault[] currentDefaults = persistenceManager
				.findAll(IWidgetDefault.class);
		for (int i = 0; i < currentDefaults.length; i++) {
			if (currentDefaults[i].getWidgetContext().equalsIgnoreCase(
					widgetType)) {
				// found it so update to new widget id
				currentDefaults[i].setWidget(widget);
				persistenceManager.save(currentDefaults[i]);
				found = true;
			}
		}
		// didnt find it already set, so add new one
		if (!found) {
			IWidgetDefault wd = persistenceManager
					.newInstance(IWidgetDefault.class);
			wd.setWidgetContext(widgetType);
			wd.setWidget(widget);
			persistenceManager.save(wd);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.apache.wookie.manager.IWidgetAdminManager#setWidgetTypesForWidget
	 * (java.lang.String, java.lang.String[], boolean)
	 */
	public void setWidgetTypesForWidget(String dbKey, String[] widgetTypes,
			boolean maximize) {
		IPersistenceManager persistenceManager = PersistenceManagerFactory
				.getPersistenceManager();
		IWidget widget = persistenceManager.findById(IWidget.class, dbKey);

		boolean widgetTypesSet = false;
		if (widgetTypes != null) {
			for (int i = 0; i < widgetTypes.length; i++) {
				if (!doesServiceExistForWidget(widget.getId(), widgetTypes[i])) {
					IWidgetType widgetType = persistenceManager
							.newInstance(IWidgetType.class);
					widgetType.setWidgetContext(widgetTypes[i]);
					widget.getWidgetTypes().add(widgetType);
					widgetTypesSet = true;
				}
			}
		}
		if (widgetTypesSet) {
			persistenceManager.save(widget);
		}
	}

	public void setWidgetTags(String dbKey, String[] tags) {
		// TO-DO 
		// handle all database logic through the java persistance manager 
		// instead of what I did here(rough and ugly but yet is quick...)  
		
		// IPersistenceManager persistenceManager =
		// PersistenceManagerFactory.getPersistenceManager();
		// IWidget widget = persistenceManager.findById(IWidget.class, dbKey);
		
		

		int widgetid=Integer.parseInt(dbKey);
		
		Connection conn = null;

		try {
			String userName = "java";
			String password = "java";
			String url = "jdbc:mysql://localhost:3306/widgetdb";
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection(url, userName, password);

			for (int i = 0; i < tags.length; i++) {

				//insert into TAGS table
				
				//first check if already exists
				String psSql="SELECT * FROM TAGS WHERE TAGTEXT=?";
				PreparedStatement ps = conn.prepareStatement(psSql);
				ps.setString(1,tags[i]);
				ps.execute();
				ResultSet rs = ps.getResultSet();
				int tagid=0;
				if (rs.next()){
					//if it exists get the id
					tagid=rs.getInt(1);
					rs.close();
				}else {
					//insert a new entry and also get the id
					String psSql2="INSERT INTO TAGS VALUES(NULL,?)";
					PreparedStatement ps2 = conn.prepareStatement(psSql2,Statement.RETURN_GENERATED_KEYS);
					ps2.setString(1,tags[i]);
					ps2.executeUpdate();
					//get the auto-generated id
					ResultSet rs2 = ps2.getGeneratedKeys();
					if (rs2.next()){
						tagid = rs2.getInt(1);
					}
					ps2.close();
					rs2.close();
				}
				ps.close();
				
				//insert into TAGSWIDGETS table
				
				//first check if tag-widget pair exists
				String psSql3="SELECT * FROM TAGSWIDGETS WHERE tagid=? AND widid=?";
				PreparedStatement ps3 = conn.prepareStatement(psSql3);
				ps3.setInt(1, tagid);
				ps3.setInt(2, widgetid);
				ps3.execute();
				ResultSet rs3 = ps3.getResultSet();
				if (rs3.next()){
					//do not insert anything - already there
					rs3.close();
				}else {
					String psSql4="INSERT INTO TAGSWIDGETS(tagid,widid) VALUES (?,?)";
					PreparedStatement ps4 = conn.prepareStatement(psSql4);
					ps4.setInt(1, tagid);
					ps4.setInt(2, widgetid);
					ps4.executeUpdate();
					ps4.close();
				}
				ps3.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) { /* ignore close errors */
				}
			}
		}

	}

}
