Return-Path: <cygwin-patches-return-3304-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18656 invoked by alias); 11 Dec 2002 16:35:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18646 invoked from network); 11 Dec 2002 16:35:29 -0000
Message-ID: <3DF76981.86674258@ieee.org>
Date: Wed, 11 Dec 2002 08:35:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Small security patches
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00255.txt.bz2

Corinna,

here is an internationalization bug fix, and some preliminary
definitions for a future well_known_creator approach.

Pierre

2002/12/11  Pierre Humblet  <pierre.humblet@ieee.org>

	* security.h: Declare well_known_creator_group_sid.
	* sec_helper.cc: Declare and initialize well_known_creator_group_sid.
	* security.cc (get_user_local_groups): Use LookupAccountSid to find the
	local equivalent of BUILTIN.


Index: security.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.h,v
retrieving revision 1.35
diff -u -p -r1.35 security.h
--- security.h  10 Dec 2002 12:43:49 -0000      1.35
+++ security.h  11 Dec 2002 02:32:39 -0000
@@ -184,6 +184,7 @@ extern cygsid well_known_null_sid;
 extern cygsid well_known_world_sid;
 extern cygsid well_known_local_sid;
 extern cygsid well_known_creator_owner_sid;
+extern cygsid well_known_creator_group_sid;
 extern cygsid well_known_dialup_sid;
 extern cygsid well_known_network_sid;
 extern cygsid well_known_batch_sid;
Index: sec_helper.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.30
diff -u -p -r1.30 sec_helper.cc
--- sec_helper.cc       10 Dec 2002 12:43:49 -0000      1.30
+++ sec_helper.cc       11 Dec 2002 02:33:35 -0000
@@ -52,6 +52,7 @@ cygsid well_known_null_sid ("S-1-0-0");
 cygsid well_known_world_sid ("S-1-1-0");
 cygsid well_known_local_sid ("S-1-2-0");
 cygsid well_known_creator_owner_sid ("S-1-3-0");
+cygsid well_known_creator_group_sid ("S-1-3-1");
 cygsid well_known_dialup_sid ("S-1-5-1");
 cygsid well_known_network_sid ("S-1-5-2");
 cygsid well_known_batch_sid ("S-1-5-3");
Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.128
diff -u -p -r1.128 security.cc
--- security.cc 10 Dec 2002 12:43:49 -0000      1.128
+++ security.cc 11 Dec 2002 02:35:00 -0000
@@ -389,15 +389,18 @@ get_user_local_groups (cygsidlist &grp_l
       return FALSE;
     }
 
-  char bgroup[sizeof ("BUILTIN\\") + GNLEN] = "BUILTIN\\";
+  char bgroup[INTERNET_MAX_HOST_NAME_LENGTH + GNLEN + 2];
   char lgroup[INTERNET_MAX_HOST_NAME_LENGTH + GNLEN + 2];
-  const DWORD blen = sizeof ("BUILTIN\\") - 1;
-  DWORD llen = INTERNET_MAX_HOST_NAME_LENGTH + 1;
-  if (!GetComputerNameA (lgroup, &llen))
+  DWORD blen = sizeof (bgroup), llen = sizeof (lgroup);
+  SID_NAME_USE use;
+
+  if (!LookupAccountSid (NULL, well_known_admins_sid, lgroup, &llen, bgroup, &blen, &use)
+      || !GetComputerNameA (lgroup, &(llen = sizeof (lgroup))))
     {
       __seterrno ();
       return FALSE;
     }
+  bgroup[blen++] = '\\';
   lgroup[llen++] = '\\';
 
   for (DWORD i = 0; i < cnt; ++i)
@@ -407,8 +410,8 @@ get_user_local_groups (cygsidlist &grp_l
        DWORD glen = sizeof (gsid);
        char domain[INTERNET_MAX_HOST_NAME_LENGTH + 1];
        DWORD dlen = sizeof (domain);
-       SID_NAME_USE use = SidTypeInvalid;
 
+       use = SidTypeInvalid;
        sys_wcstombs (bgroup + blen, buf[i].lgrpi0_name, GNLEN + 1);
        if (!LookupAccountName (NULL, bgroup, gsid, &glen, domain, &dlen, &use))
          {
