Return-Path: <cygwin-patches-return-7306-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20064 invoked by alias); 5 May 2011 16:51:33 -0000
Received: (qmail 20050 invoked by uid 22791); 5 May 2011 16:51:31 -0000
X-SWARE-Spam-Status: No, hits=-1.3 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout07.t-online.de (HELO mailout07.t-online.de) (194.25.134.83)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 05 May 2011 16:51:16 +0000
Received: from fwd20.aul.t-online.de (fwd20.aul.t-online.de )	by mailout07.t-online.de with smtp 	id 1QI1li-00010U-86; Thu, 05 May 2011 18:51:14 +0200
Received: from [192.168.2.100] (ZqUcmBZfrhEmGUd3WjuIiil4pSM9MwlOduG0xSQ7hs4yJYbvpxI+6nZJWp69rbaggd@[79.224.116.155]) by fwd20.aul.t-online.de	with esmtp id 1QI1lc-1ijj0K0; Thu, 5 May 2011 18:51:08 +0200
Message-ID: <4DC2D57C.7020009@t-online.de>
Date: Thu, 05 May 2011 16:51:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.17) Gecko/20110123 SeaMonkey/2.0.12
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix access("/proc/registry/HKEY_PERFORMANCE_DATA", R_OK)
Content-Type: multipart/mixed; boundary="------------060201090200060208070002"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00072.txt.bz2

This is a multi-part message in MIME format.
--------------060201090200060208070002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 114

This patch fixes access("/proc/registry/HKEY_PERFORMANCE_DATA", R_OK) 
which always fails with EBADF.

Christian


--------------060201090200060208070002
Content-Type: text/x-patch;
 name="registry-perfdata-access.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="registry-perfdata-access.patch"
Content-length: 835

2011-05-05  Christian Franke  <franke@computer.org>

	* security.cc (check_registry_access): Handle missing
	security descriptor of HKEY_PERFORMANCE_DATA.

diff --git a/winsup/cygwin/security.cc b/winsup/cygwin/security.cc
index a52fc26..430a65f 100644
--- a/winsup/cygwin/security.cc
+++ b/winsup/cygwin/security.cc
@@ -1085,8 +1085,13 @@ check_registry_access (HANDLE hdl, int flags, bool effective)
     desired |= KEY_SET_VALUE;
   if (flags & X_OK)
     desired |= KEY_QUERY_VALUE;
-  if (!get_reg_sd (hdl, sd))
+
+  if ((HKEY) hdl == HKEY_PERFORMANCE_DATA)
+    /* RegGetKeySecurity() always fails with ERROR_INVALID_HANDLE.  */
+    ret = 0;
+  else if (!get_reg_sd (hdl, sd))
     ret = check_access (sd, reg_mapping, desired, flags, effective);
+
   /* As long as we can't write the registry... */
   if (flags & W_OK)
     {

--------------060201090200060208070002--
