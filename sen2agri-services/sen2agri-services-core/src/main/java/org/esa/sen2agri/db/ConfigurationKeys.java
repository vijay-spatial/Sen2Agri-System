/*
 * Copyright (C) 2018 CS ROMANIA
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 3 of the License, or (at your option)
 * any later version.
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, see http://www.gnu.org/licenses/
 */
package org.esa.sen2agri.db;

/**
 * @author Cosmin Cara
 */
public final class ConfigurationKeys {
    public static final String DOWNLOADER_STATE_ENABLED = "downloader.enabled";
    public static final String DOWNLOADER_SITE_STATE_ENABLED = "downloader.%s.enabled";
    public static final String DOWNLOADER_SITE_FORCE_START_ENABLED = "downloader.%s.forcestart";
    public static final String SENSOR_STATE = "%s.enabled";
    public static final String DOWNLOAD_DIR = "downloader.%s.write-dir";
    public static final String DOWNLOADER_START_OFFSET = "downloader.start.offset";
    public static final String SKIP_EXISTING_PRODUCTS = "downloader.skip.existing";
}