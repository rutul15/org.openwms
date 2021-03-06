/*
 * openwms.org, the Open Warehouse Management System.
 * Copyright (C) 2014 Heiko Scherrer
 *
 * This file is part of openwms.org.
 *
 * openwms.org is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as 
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * openwms.org is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this software. If not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 * 02110-1301 USA, or see the FSF site: http://www.fsf.org.
 */
package org.openwms.core.test;

import java.net.URL;
import java.util.List;

import org.springframework.orm.jpa.persistenceunit.DefaultPersistenceUnitManager;
import org.springframework.orm.jpa.persistenceunit.MutablePersistenceUnitInfo;

/**
 * A CustomPersistenceUnitManager.
 * <p>
 * This customized {@link org.springframework.orm.jpa.persistenceunit.PersistenceUnitManager} extends Spring's default implementation to
 * scan Entity classes in multiple jar files. This class is only needed when the application is <b>not</b> an OSGi application.
 * </p>
 * 
 * @author <a href="mailto:scherrer@openwms.org">Heiko Scherrer</a>
 * @since 0.1
 * @see org.springframework.orm.jpa.persistenceunit.PersistenceUnitManager
 * @see org.springframework.orm.jpa.persistenceunit.DefaultPersistenceUnitManager
 * @version $Revision$
 */
public class CustomPersistenceUnitManager extends DefaultPersistenceUnitManager {

    /**
     * {@inheritDoc}
     * 
     * @see org.springframework.orm.jpa.persistenceunit.DefaultPersistenceUnitManager#postProcessPersistenceUnitInfo(org.springframework.orm.jpa.persistenceunit.MutablePersistenceUnitInfo)
     */
    @Override
    protected void postProcessPersistenceUnitInfo(MutablePersistenceUnitInfo pui) {
        super.postProcessPersistenceUnitInfo(pui);
        pui.addJarFileUrl(pui.getPersistenceUnitRootUrl());
        MutablePersistenceUnitInfo oldPui = getPersistenceUnitInfo(pui.getPersistenceUnitName());
        if (oldPui != null) {
            List<URL> urls = oldPui.getJarFileUrls();
            for (URL url : urls) {
                pui.addJarFileUrl(url);
            }
        }
    }
}