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
package org.openwms.core.service.exception;

/**
 * A RemovalNotAllowedException is thrown when the caller is not allowed to remove an entity.
 * 
 * @author <a href="mailto:russelltina@users.sourceforge.net">Tina Russell</a>
 * @version $Revision$
 * @since 0.1
 */
public class RemovalNotAllowedException extends ServiceException {

    private static final long serialVersionUID = -5592508830188199188L;

    /**
     * Create a new RemovalNotAllowedException.
     * 
     * @param message
     *            Detail message
     */
    public RemovalNotAllowedException(String message) {
        super(message);
    }

    /**
     * Create a new RemovalNotAllowedException.
     * 
     * @param cause
     *            Root cause
     */
    public RemovalNotAllowedException(Throwable cause) {
        super(cause);
    }

    /**
     * Create a new RemovalNotAllowedException.
     * 
     * @param message
     *            Detail message
     * @param cause
     *            Root cause
     */
    public RemovalNotAllowedException(String message, Throwable cause) {
        super(message, cause);
    }
}