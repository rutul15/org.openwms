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
package org.openwms.web.flex.client.module {

    import flash.events.Event;
    import mx.events.FlexEvent;
    import mx.modules.ModuleBase;

    /**
     * A CommonModule is the superclass of all Flex Modules that can be loaded
     * into the CORE Flex Application.
     *
     * @author <a href="mailto:scherrer@openwms.org">Heiko Scherrer</a>
     * @version $Revision$
     * @since 0.1
     */
    public class CommonModule extends ModuleBase {

        /**
         * Constructor registers the CREATION_COMPLETE event.
         */
        public function CommonModule() {
            super();
            this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
        }

        /**
         * Callback, is called when the FlexEvent.CREATION_COMPLETE is fired.
         * Override initApp() to hook in.
         */
        public function onCreationComplete(e : Event) : void {
            trace("Creation of Module completed");
            initApp();
        }

        /**
         * Override to do initial work when FlexEvent.CREATION_COMPLETE is fired.
         */
        protected function initApp() : void {
        }
    }
}

