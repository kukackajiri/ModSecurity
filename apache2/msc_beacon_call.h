/*
* ModSecurity for Apache 2.x, http://www.modsecurity.org/
* Copyright (c) 2004-2013 Trustwave Holdings, Inc. (http://www.trustwave.com/)
*
* You may not use this file except in compliance with
* the License.  You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* If any of the files related to licensing are missing or if you have any
* other questions related to licensing please contact Trustwave Holdings, Inc.
* directly using the email address security@modsecurity.org.
*/

#ifndef MSC_BEACON_CALL_H
#define MSC_BEACON_CALL_H

#include "apr.h"
#include "apr_pools.h"
#include "apr_version.h"
#include "apr_optional.h"
#include "msc_pcre.h"

#if WIN32
#define snprintf _snprintf
#endif

#define BEACON_CALL_IN_BETWEEN_DOTS 20

#define MODSECURITY_DNS_BEACON_POSTFIX "modsec.zimmerle.org"

static const char msc_beacon_basis_32[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";

int msc_beacon_call (void);

#endif
