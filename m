Return-Path: <cygwin-patches-return-4556-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24661 invoked by alias); 5 Feb 2004 03:18:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24647 invoked from network); 5 Feb 2004 03:18:17 -0000
Message-Id: <3.0.5.32.20040204221719.007ce3f0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 05 Feb 2004 03:18:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: well_known_sids
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1075969039==_"
X-SW-Source: 2004-q1/txt/msg00046.txt.bz2

--=====================_1075969039==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1200

When cygwin starts a process, it sets its security to allow
access by the Administrators. However this is not necessarily the
case when Windows starts a cygwin process. This results in various
anomalies, e.g. an admin user cannot signal/kill the top Cygwin process
started by a non-privileged user with fast user switching.
Similarly administrators may not have access to some file mappings.

Fixing that would be very easy if the well_known_sids were available
early at startup time. However they are recomputed late in the startup
sequence on exec, and copied from the parent in case of fork.

This patch simply stores the well_known_sids as NO_COPY variables,
eliminating all run time overhead and making them available during
the init sequence. That will be used in a subsequent patch.

Pierre

2004-02-04  Pierre Humblet <pierre.humblet@ieee.org>

	* security.h (SID): New macro.
	(well_known_*_sid): Change type to cygpsid.
	(cygsid::init): Delete declaration.
	* sec_helper.cc (well_known_*_sid): Define as cygpsid and initialize.
	(cygsid::init): Delete.
	* dcrt0.cc (dll_crt0_0): Do not call cygsid::init.
	* security.cc (get_user_local_groups): Change the second argument type to
cygpsid.


--=====================_1075969039==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="sid.diff"
Content-length: 7683

Index: security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.h,v
retrieving revision 1.50
diff -u -p -r1.50 security.h
--- security.h	7 Dec 2003 22:37:12 -0000	1.50
+++ security.h	5 Feb 2004 02:45:04 -0000
@@ -23,6 +23,15 @@ details. */
 #define ACL_DEFAULT_SIZE 3072
 #define NO_SID ((PSID)NULL)

+/* Macro to define variable length SID structures */
+#define SID(name, authority, count, rid...) \
+struct  { \
+  BYTE  Revision; \
+  BYTE  SubAuthorityCount; \
+  SID_IDENTIFIER_AUTHORITY IdentifierAuthority; \
+  DWORD SubAuthority[count]; \
+} name =3D { SID_REVISION, count, {authority}, {rid}}
+
 #define FILE_READ_BITS   (FILE_READ_DATA | GENERIC_READ | GENERIC_ALL)
 #define FILE_WRITE_BITS  (FILE_WRITE_DATA | GENERIC_WRITE | GENERIC_ALL)
 #define FILE_EXEC_BITS   (FILE_EXECUTE | GENERIC_EXECUTE | GENERIC_ALL)
@@ -79,7 +88,6 @@ class cygsid : public cygpsid {
     }

 public:
-  static void init();
   inline operator const PSID () { return psid; }

   inline const PSID operator=3D (cygsid &nsid)
@@ -213,19 +221,19 @@ public:
     }
 };

-extern cygsid well_known_null_sid;
-extern cygsid well_known_world_sid;
-extern cygsid well_known_local_sid;
-extern cygsid well_known_creator_owner_sid;
-extern cygsid well_known_creator_group_sid;
-extern cygsid well_known_dialup_sid;
-extern cygsid well_known_network_sid;
-extern cygsid well_known_batch_sid;
-extern cygsid well_known_interactive_sid;
-extern cygsid well_known_service_sid;
-extern cygsid well_known_authenticated_users_sid;
-extern cygsid well_known_system_sid;
-extern cygsid well_known_admins_sid;
+extern cygpsid well_known_null_sid;
+extern cygpsid well_known_world_sid;
+extern cygpsid well_known_local_sid;
+extern cygpsid well_known_creator_owner_sid;
+extern cygpsid well_known_creator_group_sid;
+extern cygpsid well_known_dialup_sid;
+extern cygpsid well_known_network_sid;
+extern cygpsid well_known_batch_sid;
+extern cygpsid well_known_interactive_sid;
+extern cygpsid well_known_service_sid;
+extern cygpsid well_known_authenticated_users_sid;
+extern cygpsid well_known_system_sid;
+extern cygpsid well_known_admins_sid;

 inline BOOL
 legal_sid_type (SID_NAME_USE type)
Index: sec_helper.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.48
diff -u -p -r1.48 sec_helper.cc
--- sec_helper.cc	7 Dec 2003 22:37:12 -0000	1.48
+++ sec_helper.cc	5 Feb 2004 02:45:05 -0000
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
+static NO_COPY SID(NullSid, SECURITY_NULL_SID_AUTHORITY, 1, SECURITY_NULL_=
RID);
+static NO_COPY SID(WorldSid, SECURITY_WORLD_SID_AUTHORITY, 1, SECURITY_WOR=
LD_RID);
+static NO_COPY SID(LocalSid, SECURITY_LOCAL_SID_AUTHORITY, 1, SECURITY_LOC=
AL_RID);
+static NO_COPY SID(CreatorOwnerSid, SECURITY_CREATOR_SID_AUTHORITY, 1, SEC=
URITY_CREATOR_OWNER_RID);
+static NO_COPY SID(CreatorGroupSid, SECURITY_CREATOR_SID_AUTHORITY, 1, SEC=
URITY_CREATOR_GROUP_RID);
+static NO_COPY SID(DialupSid, SECURITY_NT_AUTHORITY, 1, SECURITY_DIALUP_RI=
D);
+static NO_COPY SID(NetworkSid, SECURITY_NT_AUTHORITY, 1, SECURITY_NETWORK_=
RID);
+static NO_COPY SID(BatchSid, SECURITY_NT_AUTHORITY, 1, SECURITY_BATCH_RID);
+static NO_COPY SID(InteractiveSid, SECURITY_NT_AUTHORITY, 1, SECURITY_INTE=
RACTIVE_RID);
+static NO_COPY SID(ServiceSid, SECURITY_NT_AUTHORITY, 1, SECURITY_SERVICE_=
RID);
+static NO_COPY SID(AuthenticatedUserSid, SECURITY_NT_AUTHORITY, 1, SECURIT=
Y_AUTHENTICATED_USER_RID);
+static NO_COPY SID(SystemSid, SECURITY_NT_AUTHORITY, 1, SECURITY_LOCAL_SYS=
TEM_RID);
+static NO_COPY SID(AdminsSid, SECURITY_NT_AUTHORITY, 2, SECURITY_BUILTIN_D=
OMAIN_RID, DOMAIN_ALIAS_RID_ADMINS);
+
+cygpsid NO_COPY well_known_null_sid =3D (PSID) &NullSid;    /* S-1-0-0" */
+cygpsid NO_COPY well_known_world_sid =3D (PSID) &WorldSid;  /* S-1-1-0" */
+cygpsid NO_COPY well_known_local_sid =3D (PSID) &LocalSid;  /* S-1-2-0 */
+cygpsid NO_COPY well_known_creator_owner_sid =3D (PSID) &CreatorOwnerSid; =
/* S-1-3-0 */
+cygpsid NO_COPY well_known_creator_group_sid =3D (PSID) &CreatorGroupSid; =
/* S-1-3-1 */
+cygpsid NO_COPY well_known_dialup_sid =3D (PSID) &DialupSid;   /* S-1-5-1 =
*/
+cygpsid NO_COPY well_known_network_sid =3D (PSID) &NetworkSid; /* S-1-5-2 =
*/
+cygpsid NO_COPY well_known_batch_sid =3D (PSID) &BatchSid;     /* S-1-5-3 =
*/
+cygpsid NO_COPY well_known_interactive_sid =3D (PSID) &InteractiveSid; /* =
S-1-5-4 */
+cygpsid NO_COPY well_known_service_sid =3D (PSID) &ServiceSid; /* S-1-5-6 =
*/
+cygpsid NO_COPY well_known_authenticated_users_sid =3D (PSID) &Authenticat=
edUserSid; /* S-1-5-11 */
+cygpsid NO_COPY well_known_system_sid =3D (PSID) &SystemSid; /* S-1-5-18 */
+cygpsid NO_COPY well_known_admins_sid =3D (PSID) &AdminsSid; /* S-1-5-32-5=
44 */

 bool
 cygpsid::operator=3D=3D (const char *nsidstr) const
@@ -116,24 +130,6 @@ cygpsid::string (char *nsidstr) const
   for (i =3D 0; i < *GetSidSubAuthorityCount (psid); ++i)
     t +=3D __small_sprintf (t, "-%lu", *GetSidSubAuthority (psid, i));
   return nsidstr;
-}
-
-void
-cygsid::init ()
-{
-  well_known_null_sid =3D "S-1-0-0";
-  well_known_world_sid =3D "S-1-1-0";
-  well_known_local_sid =3D "S-1-2-0";
-  well_known_creator_owner_sid =3D "S-1-3-0";
-  well_known_creator_group_sid =3D "S-1-3-1";
-  well_known_dialup_sid =3D "S-1-5-1";
-  well_known_network_sid =3D "S-1-5-2";
-  well_known_batch_sid =3D "S-1-5-3";
-  well_known_interactive_sid =3D "S-1-5-4";
-  well_known_service_sid =3D "S-1-5-6";
-  well_known_authenticated_users_sid =3D "S-1-5-11";
-  well_known_system_sid =3D "S-1-5-18";
-  well_known_admins_sid =3D "S-1-5-32-544";
 }

 PSID
Index: dcrt0.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.209
diff -u -p -r1.209 dcrt0.cc
--- dcrt0.cc	2 Feb 2004 21:00:07 -0000	1.209
+++ dcrt0.cc	5 Feb 2004 02:45:07 -0000
@@ -723,8 +723,6 @@ dll_crt0_0 ()
   /* Initialize events */
   events_init ();

-  /* Init global well known SID objects */
-  cygsid::init ();
   cygheap->cwd.init ();
 }

Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.158
diff -u -p -r1.158 security.cc
--- security.cc	7 Dec 2003 22:37:12 -0000	1.158
+++ security.cc	5 Feb 2004 02:45:10 -0000
@@ -425,7 +425,7 @@ get_user_local_groups (cygsidlist &grp_l
 }

 static bool
-sid_in_token_groups (PTOKEN_GROUPS grps, cygsid &sid)
+sid_in_token_groups (PTOKEN_GROUPS grps, cygpsid sid)
 {
   if (!grps)
     return false;

--=====================_1075969039==_--
