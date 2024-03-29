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
 *  limitations under the License.
 */

package org.apache.wookie.beans;

import org.apache.wookie.w3c.ILocalizedElement;

/**
 * IWidgetIcon - an object representing an icon for a widget.
 * 
 * @author Scott Wilson
 * @author <a href="mailto:rwatler@apache.org">Randy Watler</a>
 * @version $Id$
 */
public interface IWidgetIcon extends ILocalizedElement
{
    /**
     * Get widget icon source URL.
     * 
     * @return icon source URL
     */
    String getSrc();
    
    /**
     * Set widget icon source URL.
     * 
     * @param src icon source URL
     */
    void setSrc(String src);    

    /**
     * Get widget icon height.
     * 
     * @return icon height
     */
    Integer getHeight();
    
    /**
     * Set widget icon height.
     * 
     * @param height icon height
     */
    void setHeight(Integer height);

    /**
     * Get widget icon width.
     * 
     * @return icon width
     */
    Integer getWidth();
    
    /**
     * Set widget icon width.
     * 
     * @param width icon width
     */
    void setWidth(Integer width);

    /**
     * Set widget icon language.
     * 
     * @param lang icon language
     */
    void setLang(String lang);    
}
