###############################################################################
#
# Project:  FWTools
# Purpose:  FWTools Pre-installer actions.
# Author:   Frank Warmerdam, warmerdam@pobox.com
#
###############################################################################
# Copyright (c) 2005, Frank Warmerdam, warmerdam@pobox.com
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Library General Public
# License as published by the Free Software Foundation; either
# version 2 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Library General Public License for more details.
#
# You should have received a copy of the GNU Library General Public
# License along with this library; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place - Suite 330,
# Boston, MA 02111-1307, USA.
###############################################################################
#
#  $Log: fwpreinstall.py,v $
#  Revision 1.1  2011-02-09 21:06:57  fwarmerdam
#  New
#
#

import sys
import string
import time

# ============================================================================
# FileSubstitute()
# ============================================================================
def FileSubstitute( filename, src_pattern, dst_pattern ):
	fulltext = open( filename ).read()
	fulltext = string.replace( fulltext, src_pattern, dst_pattern )
	open( filename, 'w').write( fulltext )


# ============================================================================
# Line Replace
# ============================================================================
def FileLineSubstitute( filename, src_substring, dst_line ):
	fulltext = open( filename ).readlines()
	count = len(fulltext)
	for i in range(count):
	    if string.find( fulltext[i], src_substring ) != -1:
		fulltext[i] = dst_line

	open( filename, 'w' ).write( string.join(fulltext,'') )

# ============================================================================
# Mainline 
# ============================================================================

FWTOOLS_DIR = r'/home/sritchie/fwtools'

VERSION = string.strip(open('FW_VERSION','r').read())
SVERSION = string.replace(VERSION,'.','' )

lt = time.localtime()
DATE = '%04d%02d%02d' % (lt[0],lt[1],lt[2])
LDATE = time.strftime('%b') + (' %d, %d' % (lt[2], lt[0]))

# ----------------------------------------------------------------------------
# Update gdal_version.h
# ----------------------------------------------------------------------------
fulltext = open( 'gdal/gcore/gdal_version.h' ).readlines()
count = len(fulltext)
for i in range(count):
    if string.find( fulltext[i], 'define GDAL_RELEASE_DATE' ) != -1:
	fulltext[i] = '#  define GDAL_RELEASE_DATE ' + DATE + '\n'

    if string.find( fulltext[i], 'define GDAL_RELEASE_NAME' ) != -1:
	x = string.find(fulltext[i],',')
	if x == -1:
	    x = string.rfind(fulltext[i],'"')
	if x == -1:
	    print 'Something went badly wrong update gdal_version.h'
	    print fulltext[i]
	else:
	    fulltext[i] = fulltext[i][:x] + ', FWTools '+VERSION+'"\n'

open( 'gdal/gcore/gdal_version.h', 'w' ).write( string.join(fulltext,'') )
