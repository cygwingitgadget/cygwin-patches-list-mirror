Return-Path: <cygwin-patches-return-2439-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29982 invoked by alias); 16 Jun 2002 04:11:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29968 invoked from network); 16 Jun 2002 04:11:11 -0000
Message-Id: <3.0.5.32.20020616000701.007f7df0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sat, 15 Jun 2002 21:11:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Reorganizing internal_getlogin() patch is in
In-Reply-To: <20020615010217.GA5699@redhat.com>
References: <20020613052709.GA17779@redhat.com>
 <20020613052709.GA17779@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00422.txt.bz2

At 09:02 PM 6/14/2002 -0400, Christopher Faylor wrote:
>Pierre's patch + my modifications + Corinna's insights into my blunders
>are now checked in.

Kudos to Chris and Corinna for the elegant way they have reimplemented
the Windows environment handling.

I noticed several nits:
spawn.cc:    line accidentally deleted, diff below.

environ.cc: (diff below)
a) There are cases where a variable that is not present should be added,
and cases where an existing variable should be removed.
That's because the SYSTEM account is missing variables (different on
NT and Win2000 !!), as can be checked by running env from cygrunsrv with
the production cygwin1.dll  I made spenv::retrieve return an empty string
when a variable should not exist.
b) Unfortunately, postponing the evaluation of variables cannot be done past 
CreateProcessAsUser. After that point LookupAccountSid returns 
incorrect values (this would happen when the child is cygwin but the 
grandchild isn't).
However if the child is cygwin, there is no need to include the variables
in the env (they are stored in "user") so "no_envblock" remains useful. 
As a side effect, if /usr/bin is mounted cygexec, "env" and "/bin/env" 
may output a different number of variables. Before this patch they were 
producing the same number, but some variables had different values...
c) adding a member "namelen" in spenv (as in win_env) seems to be helpful.

There is also a simple possible optimization (not in the patch):
AFAIK all this stuff is unnecessary in Win95/98/ME

I don't understand the logic for SYSTEMDRIVE and SYSTEMROOT. It looks
like if they are not in the cygwin env then they are looked up in the
Windows env (this would mean that the program has deleted them (?)).
However if the program was recognized as a Cygwin program, there won't
be a Windows environment and they will be lost forever. 
If these variables are essential in some cases, wouldn't  it be safer 
to recreate them from GetWindowsDirectory?


uinfo.cc:  (no diff yet, can use help)
a) cygheap_user.pname is set to the Cygwin user name. There should also 
be an entry for the Windows user name. It should be initialized from the 
same LookupAccountSid call that returns the domain. I don't provide a patch 
because I don't see how to do that elegantly... 
b) NetUserGetInfo() must always be called with the env_logsrv, otherwise
name aliasing can occur. Don't call if env_logsrv is NULL, which should
be the case only for SYSTEM.
c) get_logon_server() will fail for SYSTEM. There should be a test
"if (strcasematch (Windowname (), "SYSTEM"))" before calling it as it 
will looked up repeatedly if plogsrv remains NULL.

In env_userprofile () I don't understand why the last two conditions
are useful in:
  if (strcasematch (name (), "SYSTEM") || !env_domain () || !env_logsrv ())
The domain should never be NULL, and the logserver only NULL for SYSTEM.

Also I don't see the need to copy HOMEDRIVE and HOMEPATH to homedrive_env_buf
and homepath_env_buf when HOME already exists.

I'd be happy to eventually provide a diff for uinfo.cc

Pierre

2002-06-12  Pierre Humblet <pierre.humblet@ieee.org>

	* spawn.cc (spawn_guts): Revert removal of
	ciresrv.moreinfo->uid = ILLEGAL_UID.
	* environ.cc (spenv::retrieve): Compute the user variables even if 
	no_envblock. Return an empty string when values are NULL or if
	no_envblock. Add namelen member to spenv and avoid strlen ().
	(build_env): Compare lengths before calling spenv::retrieve.
	Discard empty strings returned by spenv::retrieve.


--- spawn.cc.orig       2002-06-15 16:09:34.000000000 -0400
+++ spawn.cc    2002-06-15 16:12:24.000000000 -0400
@@ -646,6 +646,7 @@
       char wstname[1024];
       char dskname[1024];
 
+      ciresrv.moreinfo->uid = ILLEGAL_UID;
       hwst = GetProcessWindowStation ();
       SetUserObjectSecurity (hwst, &dsi, get_null_sd ());
       GetUserObjectInformation (hwst, UOI_NAME, wstname, 1024, &n);


--- environ.cc.orig	2002-06-15 16:17:34.000000000 -0400
+++ environ.cc	2002-06-15 22:31:28.000000000 -0400
@@ -753,44 +753,41 @@
 struct spenv
 {
   const char *name;
+  const int namelen;
   const char * (cygheap_user::*from_cygheap) ();
   char *retrieve (bool, const char * const = NULL, int = 0);
 };
 
 /* Keep this list in upper case and sorted */
+#define NAMELENGTH(name) #name, sizeof(#name) - 1
 static NO_COPY spenv spenvs[] =
 {
-  {"HOMEPATH=", &cygheap_user::env_homepath},
-  {"HOMEDRIVE=", &cygheap_user::env_homedrive},
-  {"LOGONSERVER=", &cygheap_user::env_logsrv},
-  {"SYSTEMDRIVE=", NULL},
-  {"SYSTEMROOT=", NULL},
-  {"USERDOMAIN=", &cygheap_user::env_domain},
-  {"USERNAME=", &cygheap_user::env_name},
-  {"USERPROFILE=", &cygheap_user::env_userprofile},
+  {NAMELENGTH(HOMEDRIVE=), &cygheap_user::env_homedrive},
+  {NAMELENGTH(HOMEPATH=), &cygheap_user::env_homepath},
+  {NAMELENGTH(LOGONSERVER=), &cygheap_user::env_logsrv},
+  {NAMELENGTH(SYSTEMDRIVE=), NULL},
+  {NAMELENGTH(SYSTEMROOT=), NULL},
+  {NAMELENGTH(USERDOMAIN=), &cygheap_user::env_domain},
+  {NAMELENGTH(USERNAME=), &cygheap_user::env_name},
+  {NAMELENGTH(USERPROFILE=), &cygheap_user::env_userprofile},
 };
+#undef NAMELENGTH
 
 char *
 spenv::retrieve (bool no_envblock, const char *const envname, int len)
 {
+  static NO_COPY char empty[] = {0};  
   if (len && !strncasematch (envname, name, len))
     return NULL;
   if (from_cygheap)
     {
       const char *p;
-      if (!len)
-	return NULL;			/* No need to force these into the
-					   environment */
-
-      if (no_envblock)
-	return cstrdup1 (envname);	/* Don't really care what it's set to
-					   if we're calling a cygwin program */
 
       /* Make a FOO=BAR entry from the value returned by the cygheap_user
-         method. */
-      if (!(p = (cygheap->user.*from_cygheap) ()))
-        return NULL;
-      int namelen = strlen (name);
+         method. If there is no value or if the value isn't needed,
+	 return "". */
+      if (!(p = (cygheap->user.*from_cygheap) ()) || no_envblock)
+        return empty;
       char *s = (char *) cmalloc (HEAP_1_STR, namelen + strlen (p) + 1);
       strcpy (s, name);
       (void) strcpy (s + namelen, p);
@@ -804,7 +801,6 @@
   int vallen = GetEnvironmentVariable (name, dum, 0);
   if (vallen > 0)
     {
-      int namelen = strlen (name);
       char *p = (char *) cmalloc (HEAP_1_STR, namelen + ++vallen);
       strcpy (p, name);
       if (GetEnvironmentVariable (name, p + namelen, vallen))
@@ -845,16 +841,18 @@
   int tl = 0;
   /* Iterate over input list, generating a new environment list and
refreshing
      "special" entries, if necessary. */
-  for (srcp = envp, dstp = newenv; *srcp; srcp++, dstp++)
+  for (srcp = envp, dstp = newenv; *srcp; srcp++)
     {
       len = strcspn (*srcp, "=") + 1;
 
       /* Look for entries that require special attention */
       for (unsigned i = 0; i < SPENVS_SIZE; i++)
-	if (!saw_spenv[i]
+	if ( len == spenvs[i].namelen && !saw_spenv[i]
 	    && (*dstp = spenvs[i].retrieve (no_envblock, *srcp, len)))
 	  {
 	    saw_spenv[i] = 1;
+	    if (**dstp == 0) 
+	      goto skip; /* Remove from env */
 	    goto next;
 	  }
 
@@ -863,6 +861,9 @@
     next:
       if (!no_envblock)
 	tl += strlen (*dstp) + 1;
+      dstp++;
+    skip:
+      continue;
     }
 
   /* Fill in any required-but-missing environment variables. */
@@ -870,7 +871,7 @@
     if (!saw_spenv[i])
       {
 	*dstp = spenvs[i].retrieve (no_envblock);
-	if (*dstp)
+	if (*dstp && **dstp)
 	  {
 	    if (!no_envblock)
 	      tl += strlen (*dstp) + 1;

