Return-Path: <cygwin-patches-return-3312-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5126 invoked by alias); 13 Dec 2002 12:38:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5114 invoked from network); 13 Dec 2002 12:38:03 -0000
Date: Fri, 13 Dec 2002 04:38:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Small security patches
Message-ID: <20021213133801.A17831@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DF76981.86674258@ieee.org> <20021211192211.GD29798@redhat.com> <3DF7A670.E7BA1862@ieee.org> <20021211210349.GB31049@redhat.com> <3DF8BA7A.37C82FE5@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF8BA7A.37C82FE5@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00263.txt.bz2

On Thu, Dec 12, 2002 at 11:34:02AM -0500, Pierre A. Humblet wrote:
> Christopher Faylor wrote:
> > 
> > Actually, if you can get away without using a
> > constructor that would be best.  Constructors are a noticeable part of
> > cygwin's startup cost.
> 
> - Is there a C++ way to initialize a constant class and have it in the .text 
>   section, as "const int i = 1;" would be?
> - If not, I can get the desired effect by using gcc "Asm Labels", like
>   int foo asm ("myfoo") = 2;
>   Would that be acceptable in Cygwin?

What about this idea:

Add a static method init() called from .  Init() checks if it has been
called already before and returns immendiately if so.  Otherwise it
initializes the external objects.  

Shouldn't that be sufficient?

I created a patch (ignoring your patch so far) and it seem to work fine:

	* dcrt0.cc (dll_crt0_1): Call well known SID initializer function.
	* sec_helper.cc: Don't use constructor for well known SIDs.
	(cygsid::init): New static method initializing well known SIDs.
	* security.cc (class cygsid): Add static members for initializing
	well known SIDs.

Index: dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.165
diff -u -p -r1.165 dcrt0.cc
--- dcrt0.cc	29 Nov 2002 07:05:25 -0000	1.165
+++ dcrt0.cc	13 Dec 2002 11:48:05 -0000
@@ -549,6 +549,9 @@ dll_crt0_1 ()
   /* Initialize SIGSEGV handling, etc. */
   init_exceptions (&cygwin_except_entry);
 
+  /* Init global well known SID objects */
+  cygsid::init ();
+
   /* Set the os_being_run global. */
   wincap.init ();
   check_sanity_and_sync (user_data);
Index: sec_helper.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.30
diff -u -p -r1.30 sec_helper.cc
--- sec_helper.cc	10 Dec 2002 12:43:49 -0000	1.30
+++ sec_helper.cc	13 Dec 2002 11:48:05 -0000
@@ -48,18 +48,40 @@ SID_IDENTIFIER_AUTHORITY sid_auth[] = {
 	{SECURITY_NT_AUTHORITY}
 };
 
-cygsid well_known_null_sid ("S-1-0-0");
-cygsid well_known_world_sid ("S-1-1-0");
-cygsid well_known_local_sid ("S-1-2-0");
-cygsid well_known_creator_owner_sid ("S-1-3-0");
-cygsid well_known_dialup_sid ("S-1-5-1");
-cygsid well_known_network_sid ("S-1-5-2");
-cygsid well_known_batch_sid ("S-1-5-3");
-cygsid well_known_interactive_sid ("S-1-5-4");
-cygsid well_known_service_sid ("S-1-5-6");
-cygsid well_known_authenticated_users_sid ("S-1-5-11");
-cygsid well_known_system_sid ("S-1-5-18");
-cygsid well_known_admins_sid ("S-1-5-32-544");
+cygsid well_known_null_sid;
+cygsid well_known_world_sid;
+cygsid well_known_local_sid;
+cygsid well_known_creator_owner_sid;
+cygsid well_known_dialup_sid;
+cygsid well_known_network_sid;
+cygsid well_known_batch_sid;
+cygsid well_known_interactive_sid;
+cygsid well_known_service_sid;
+cygsid well_known_authenticated_users_sid;
+cygsid well_known_system_sid;
+cygsid well_known_admins_sid;
+
+int cygsid::initialized = 0;
+
+void
+cygsid::init ()
+{
+  if (initialized)
+    return;
+  well_known_null_sid = "S-1-0-0";
+  well_known_world_sid = "S-1-1-0";
+  well_known_local_sid = "S-1-2-0";
+  well_known_creator_owner_sid = "S-1-3-0";
+  well_known_dialup_sid = "S-1-5-1";
+  well_known_network_sid = "S-1-5-2";
+  well_known_batch_sid = "S-1-5-3";
+  well_known_interactive_sid = "S-1-5-4";
+  well_known_service_sid = "S-1-5-6";
+  well_known_authenticated_users_sid = "S-1-5-11";
+  well_known_system_sid = "S-1-5-18";
+  well_known_admins_sid = "S-1-5-32-544";
+  initialized = 1;
+}
 
 char *
 cygsid::string (char *nsidstr) const
Index: security.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.h,v
retrieving revision 1.35
diff -u -p -r1.35 security.h
--- security.h	10 Dec 2002 12:43:49 -0000	1.35
+++ security.h	13 Dec 2002 11:48:05 -0000
@@ -23,6 +23,7 @@ details. */
 class cygsid {
   PSID psid;
   char sbuf[MAX_SID_LEN];
+  static int initialized;
 
   const PSID getfromstr (const char *nsidstr);
   PSID get_sid (DWORD s, DWORD cnt, DWORD *r);
@@ -40,6 +41,7 @@ class cygsid {
     }
 
 public:
+  static void init();
   inline operator const PSID () { return psid; }
 
   inline const PSID operator= (cygsid &nsid)


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
