Return-Path: <cygwin-patches-return-4557-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16917 invoked by alias); 5 Feb 2004 10:39:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16863 invoked from network); 5 Feb 2004 10:38:59 -0000
Date: Thu, 05 Feb 2004 10:39:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: well_known_sids
Message-ID: <20040205103858.GB9090@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040204221719.007ce3f0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040204221719.007ce3f0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00047.txt.bz2

On Feb  4 22:17, Pierre A. Humblet wrote:
> 2004-02-04  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* security.h (SID): New macro.
> 	(well_known_*_sid): Change type to cygpsid.
> 	(cygsid::init): Delete declaration.
> 	* sec_helper.cc (well_known_*_sid): Define as cygpsid and initialize.
> 	(cygsid::init): Delete.
> 	* dcrt0.cc (dll_crt0_0): Do not call cygsid::init.
> 	* security.cc (get_user_local_groups): Change the second argument type to
> cygpsid.

What about this definition of SID instead:

Index: security.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.h,v
retrieving revision 1.50
diff -u -p -r1.50 security.h
--- security.h	7 Dec 2003 22:37:12 -0000	1.50
+++ security.h	5 Feb 2004 10:33:47 -0000
@@ -23,6 +23,16 @@ details. */
 #define ACL_DEFAULT_SIZE 3072
 #define NO_SID ((PSID)NULL)
 
+/* Macro to define variable length SID structures */
+#define SID(name, comment, authority, count, rid...) \
+static NO_COPY struct  { \
+  BYTE  Revision; \
+  BYTE  SubAuthorityCount; \
+  SID_IDENTIFIER_AUTHORITY IdentifierAuthority; \
+  DWORD SubAuthority[count]; \
+} name##_struct = { SID_REVISION, count, {authority}, {rid}}; \
+cygpsid NO_COPY name = (PSID) &name##_struct;
+
 #define FILE_READ_BITS   (FILE_READ_DATA | GENERIC_READ | GENERIC_ALL)
 #define FILE_WRITE_BITS  (FILE_WRITE_DATA | GENERIC_WRITE | GENERIC_ALL)
 #define FILE_EXEC_BITS   (FILE_EXECUTE | GENERIC_EXECUTE | GENERIC_ALL)
Index: sec_helper.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.48
diff -u -p -r1.48 sec_helper.cc
--- sec_helper.cc	7 Dec 2003 22:37:12 -0000	1.48
+++ sec_helper.cc	5 Feb 2004 10:33:47 -0000
@@ -47,19 +47,33 @@ SID_IDENTIFIER_AUTHORITY NO_COPY sid_aut
 	{SECURITY_NT_AUTHORITY}
 };
 
-cygsid well_known_null_sid;
-cygsid well_known_world_sid;
-cygsid well_known_local_sid;
-cygsid well_known_creator_owner_sid;
-cygsid well_known_creator_group_sid;
-cygsid well_known_dialup_sid;
-cygsid well_known_network_sid;
-cygsid well_known_batch_sid;
-cygsid well_known_interactive_sid;
-cygsid well_known_service_sid;
-cygsid well_known_authenticated_users_sid;
-cygsid well_known_system_sid;
-cygsid well_known_admins_sid;
+SID (well_known_null_sid, "S-1-0-0",
+     SECURITY_NULL_SID_AUTHORITY, 1, SECURITY_NULL_RID);
+SID (well_known_world_sid, "S-1-1-0",
+     SECURITY_WORLD_SID_AUTHORITY, 1, SECURITY_WORLD_RID);
+SID (well_known_local_sid, "S-1-2-0",
+     SECURITY_LOCAL_SID_AUTHORITY, 1, SECURITY_LOCAL_RID);
+SID (well_known_creator_owner_sid, "S-1-3-0",
+     SECURITY_CREATOR_SID_AUTHORITY, 1, SECURITY_CREATOR_OWNER_RID);
+SID (well_known_creator_group_sid, "S-1-3-1",
+     SECURITY_CREATOR_SID_AUTHORITY, 1, SECURITY_CREATOR_GROUP_RID);
+SID (well_known_dialup_sid, "S-1-5-1",
+     SECURITY_NT_AUTHORITY, 1, SECURITY_DIALUP_RID);
+SID (well_known_network_sid, "S-1-5-2",
+     SECURITY_NT_AUTHORITY, 1, SECURITY_NETWORK_RID);
+SID (well_known_batch_sid, "S-1-5-3",
+     SECURITY_NT_AUTHORITY, 1, SECURITY_BATCH_RID);
+SID (well_known_interactive_sid, "S-1-5-4",
+     SECURITY_NT_AUTHORITY, 1, SECURITY_INTERACTIVE_RID);
+SID (well_known_service_sid, "S-1-5-6",
+     SECURITY_NT_AUTHORITY, 1, SECURITY_SERVICE_RID);
+SID (well_known_authenticated_users_sid, "S-1-5-11",
+     SECURITY_NT_AUTHORITY, 1, SECURITY_AUTHENTICATED_USER_RID);
+SID (well_known_system_sid, "S-1-5-18",
+     SECURITY_NT_AUTHORITY, 1, SECURITY_LOCAL_SYSTEM_RID);
+SID (well_known_admins_sid, "S-1-5-32-544",
+     SECURITY_NT_AUTHORITY, 2, SECURITY_BUILTIN_DOMAIN_RID,
+			       DOMAIN_ALIAS_RID_ADMINS);
 
 bool
 cygpsid::operator== (const char *nsidstr) const

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
