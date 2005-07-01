Return-Path: <cygwin-patches-return-5545-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4821 invoked by alias); 1 Jul 2005 05:04:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4304 invoked by uid 22791); 1 Jul 2005 05:04:10 -0000
Received: from pool-68-163-243-49.bos.east.verizon.net (HELO phumblet.no-ip.org) (68.163.243.49)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 01 Jul 2005 05:04:10 +0000
Received: from [192.168.1.10] (helo=Compaq)
	by phumblet.no-ip.org with smtp (Exim 4.51)
	id IIXMWL-0001E8-E7
	for cygwin-patches@cygwin.com; Fri, 01 Jul 2005 00:53:09 -0400
Message-Id: <3.0.5.32.20050701005237.00b69b68@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 01 Jul 2005 05:04:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [PATCH]: cygwin_internal
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2005-q3/txt/msg00000.txt.bz2


The patch below uses cygpsid::get_id to implement CW_GET_UID_FROM_SID
and CW_GET_GID_FROM_SID in cygwin_internal. Thus the sid is first
compared to the user (or primary group) sid, before looking up
the passwd (or group) file.

This can make a difference when a sid appears multiple times in the
passwd or group file, e.g. when one has both 544 and 0.
This difference can cause exim (and perhaps others) to fail (it did
happen to me).

The patch also removes an obsolete member of the cygheap. 

Pierre



2005-07-01  Pierre Humblet <pierre.humblet@ieee.org>

	* cygheap.h (struct init_cygheap): Delete cygwin_regname member.
	* external.cc (cygwin_internal): Use cygpsid::get_id for 
	CW_GET_UID_FROM_SID and CW_GET_GID_FROM_SID.
	Turn CW_SET_CYGWIN_REGISTRY_NAME and CW_GET_CYGWIN_REGISTRY_NAME
	into noops.
	


Index: cygheap.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygheap.h,v
retrieving revision 1.105
diff -u -p -r1.105 cygheap.h
--- cygheap.h   1 Jun 2005 03:46:55 -0000       1.105
+++ cygheap.h   1 Jul 2005 04:38:56 -0000
@@ -278,7 +278,6 @@ struct init_cygheap
   HANDLE shared_h;
   HANDLE console_h;
   HANDLE mt_h;
-  char *cygwin_regname;
   cwdstuff cwd;
   dtable fdtab;
   LUID luid[SE_NUM_PRIVS];
Index: external.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/external.cc,v
retrieving revision 1.75
diff -u -p -r1.75 external.cc
--- external.cc 19 May 2005 01:25:19 -0000      1.75
+++ external.cc 1 Jul 2005 04:40:36 -0000
@@ -197,16 +197,8 @@ cygwin_internal (cygwin_getinfo_types t,
        }
 
       case CW_SET_CYGWIN_REGISTRY_NAME:
-       {
-         const char *cr = va_arg (arg, char *);
-         if (check_null_empty_str_errno (cr))
-           return (DWORD) NULL;
-         cygheap->cygwin_regname = (char *) crealloc (cygheap->cygwin_regname,
-                                                      strlen (cr) + 1);
-         strcpy (cygheap->cygwin_regname, cr);
-       }
       case CW_GET_CYGWIN_REGISTRY_NAME:
-         return (DWORD) cygheap->cygwin_regname;
+       return 0;
 
       case CW_STRACE_TOGGLE:
        {
@@ -280,17 +272,13 @@ cygwin_internal (cygwin_getinfo_types t,
        }
       case CW_GET_UID_FROM_SID:
        {
-         PSID psid = va_arg (arg, PSID);
-         cygsid sid (psid);
-         struct passwd *pw = internal_getpwsid (sid);
-         return pw ? pw->pw_uid : (__uid32_t)-1;
+         cygpsid psid = va_arg (arg, PSID);
+         return psid.get_id (false, NULL);
        }
       case CW_GET_GID_FROM_SID:
        {
-         PSID psid = va_arg (arg, PSID);
-         cygsid sid (psid);
-         struct __group32 *gr = internal_getgrsid (sid);
-         return gr ? gr->gr_gid : (__gid32_t)-1;
+         cygpsid psid = va_arg (arg, PSID);
+         return psid.get_id (true, NULL);
        }
       case CW_GET_BINMODE:
        {
