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
package org.openwms.web.flex.client.common.business {

    import mx.collections.ArrayCollection;
    import mx.controls.Alert;

    import org.granite.tide.events.TideFaultEvent;
    import org.granite.tide.events.TideResultEvent;
    import org.granite.tide.spring.Context;
    import org.openwms.common.domain.Rule;
    import org.openwms.common.domain.TransportUnitType;
    import org.openwms.common.domain.TypePlacingRule;
    import org.openwms.common.domain.TypeStackingRule;
    import org.openwms.web.flex.client.common.event.TransportUnitTypeEvent;
    import org.openwms.web.flex.client.common.model.CommonModelLocator;

    [Name("transportUnitTypeDelegate")]
    [ManagedEvent(name="LOAD_ALL_TRANSPORT_UNIT_TYPES")]
    /**
     * A TransportUnitTypeDelegate.
     *
     * @author <a href="mailto:scherrer@openwms.org">Heiko Scherrer</a>
     * @version $Revision$
     * @since 0.1
     */
    public class TransportUnitTypeDelegate {

        [In]
        [Bindable]
        /**
         * Injected Context object.
         */
        public var tideContext:Context;

        [Inject]
        [Bindable]
        /**
         * Injected Model.
         */
        public var commonModelLocator:CommonModelLocator;
        private var transportUnitType:TransportUnitType;

        public function TransportUnitTypeDelegate():void { }

        [Observer("LOAD_ALL_TRANSPORT_UNIT_TYPES")]
        /**
         * Call to load all TransportUnitTypes from the service.
         */
        public function getTransportUnitTypes(event : TransportUnitTypeEvent) : void {
            tideContext.transportUnitTypeService.findAll(onTransportUnitTypesLoaded, onFault);
        }
        private function onTransportUnitTypesLoaded(event : TideResultEvent) : void {
            commonModelLocator.allTransportUnitTypes = event.result as ArrayCollection;        	
        }

        [Observer("CREATE_TRANSPORT_UNIT_TYPE")]
        /**
         * Call to create a new TransportUnitType.
         */
        public function createTransportUnitType(event : TransportUnitTypeEvent) : void {
            if (event.data != null) {
                tideContext.transportUnitTypeService.create(event.data as TransportUnitType, onTransportUnitTypeCreated, onFault);
            }
        }
        private function onTransportUnitTypeCreated(event : TideResultEvent) : void {
            dispatchEvent(new TransportUnitTypeEvent(TransportUnitTypeEvent.LOAD_ALL_TRANSPORT_UNIT_TYPES));
        }

        [Observer("DELETE_TRANSPORT_UNIT_TYPE")]
        /**
         * Call to delete a TransportUnitType.
         */
        public function deleteTransportUnitTypes(event : TransportUnitTypeEvent) : void {
            if (event.data != null) {
                tideContext.transportUnitTypeService.deleteType(event.data as ArrayCollection, onTransportUnitTypeDeleted, onFault);
            }
        }
        private function onTransportUnitTypeDeleted(event : TideResultEvent) : void {
            dispatchEvent(new TransportUnitTypeEvent(TransportUnitTypeEvent.LOAD_ALL_TRANSPORT_UNIT_TYPES));
        }

        [Observer("SAVE_TRANSPORT_UNIT_TYPE")]
        /**
         * Call to save an already existing TransportUnitType.
         */
        public function saveTransportUnitType(event : TransportUnitTypeEvent) : void {
            if (event.data != null) {
                tideContext.transportUnitTypeService.save(event.data as TransportUnitType, onTransportUnitTypeSaved, onFault);
            }
        }
        private function onTransportUnitTypeSaved(event : TideResultEvent) : void {
            dispatchEvent(new TransportUnitTypeEvent(TransportUnitTypeEvent.LOAD_ALL_TRANSPORT_UNIT_TYPES));
        }

        [Observer("LOAD_TUT_RULES")]
        /**
         * Lazy load all Rules belonging to a TransportUnitType.
         */
        public function loadRules(event : TransportUnitTypeEvent) : void {
            if (event.data != null) {
                transportUnitType = event.data as TransportUnitType;
                tideContext.transportUnitTypeService.loadRules(transportUnitType.type, onRulesLoaded, onFault);
            }
        }
        private function onRulesLoaded(event : TideResultEvent) : void {
            var rules:ArrayCollection = event.result as ArrayCollection;
            for each (var rule:Rule in rules) {
                if (rule is TypePlacingRule) {
                    transportUnitType.typePlacingRules.addItem(rule);
                }
                if (rule is TypeStackingRule) {
                    transportUnitType.typeStackingRules.addItem(rule);
                }
            }
        }

        private function onFault(event : TideFaultEvent) : void {
            trace("Error executing operation on Transport Unit service:" + event.fault);
            Alert.show("Error executing operation on Transport Unit service:"+ event.fault);
        }
    }
}

