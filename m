Return-Path: <cygwin-patches-return-9848-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11332 invoked by alias); 13 Nov 2019 18:30:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11322 invoked by uid 89); 13 Nov 2019 18:30:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=H*MI:gov, H*m:gov, vista, Interactive
X-HELO: nihsmtpxwayst01.hub.nih.gov
Received: from nihsmtpxwayst01.hub.nih.gov (HELO nihsmtpxwayst01.hub.nih.gov) (165.112.13.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 13 Nov 2019 18:30:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;  d=nih.gov; i=@nih.gov; q=dns/txt; s=NIH; t=1573669850;  x=1605205850;  h=from:to:cc:subject:date:message-id;  bh=mouOMLN6vBDJWJmFbcqRA4VLnG4fdCxJRAaNu0qW8Nc=;  b=pSkMSBkw6HyWbtgRsSncylK3ZggzLCkgHTOrI7oLx2LxRxNLqXEHfK5b   rNZ9MWpQlmE3lrTajGQ6VDA+1O59Yv8mJWRepOqMSugZzys9SQmllCgKJ   k6yjujsQxt5VA37WrPoGjdNyhUC88FsXcf53p7aWUnXibeouYIzlIX0bu   joQeLyvK5AXAQtmpPHFMfr0pc31vci5tyQDZnrxVzTGvUDzb9MX6WcP63   A9rUTF0Yv387GM9pAyx/ri+L2/6KSvLxhFqjBK7Nau6ubEQTCqO5Q2EdC   CYaeSKl6ZcCPOyd5SFgTcvq7wxGWs6a6sF9p3XQU05gFAsBxDwBiihkkn   w==;
IronPort-SDR: gU0rUX3xED8NW3gzOn19Trfwql6SnBujtl/J93+YoTxTE2XXZSFpDE1aaaz6DqLlYRiu+JeGaM fmI05qYX4Zrk66DYYS0khSB2wzR5h/8BKHa35wS1tp9hnH47Y+SP+FqJu1wO2MEi4BiEg3ptHW vWIGFqdImLEMy8o0KNW9+1QY1okPROMj+IpIuwPPpExeSwDvPnWVb2Lw2KduVcIlTgq3cwtqCC /UGP68JjOonUYOBitErGYwW5fxAynMXeMeYLVHekN5mRBrm0rfjNAoEyy/3OtYAzi/quFaZkPK C+E=
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail1.ncbi.nlm.nih.gov) ([128.231.90.73])  by nihsmtpxwayst01.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 13:30:24 -0500
Received: from coredev2.be-md.ncbi.nlm.nih.gov (coredev2.be-md.ncbi.nlm.nih.gov [130.14.24.61])	by mail1.ncbi.nlm.nih.gov (Postfix) with ESMTP id 19B77340002;	Wed, 13 Nov 2019 13:30:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ncbi.nlm.nih.gov;	s=ncbi-nlm; t=1573669824;	bh=IDocCA1L6G8isJZLWL5MYuDK2bYLjJ2hv4jSwCSC4gE=;	h=From:To:Cc:Subject:Date;	b=bt0G+4rTFbx7NDVht4eWRbLKdS7YJANBLBauQHOEVzoglKvJ103KFD6ptUKZ1yOQ1	 2O/TWKWmMwpkmyY4ZR3O6GK5D3YU6qqbH1YkzPMh86XZGbMTqGWRhZ6i5G9nGqRurR	 vwY/YXigSmmagyqja7pS3wkpuSbLqkzwV0YtLFls=
Received: from coredev2.be-md.ncbi.nlm.nih.gov (localhost [127.0.0.1])	by coredev2.be-md.ncbi.nlm.nih.gov (Postfix) with ESMTP id 0424C1DBD5;	Wed, 13 Nov 2019 13:30:23 -0500 (EST)
From: "Anton Lavrentiev via cygwin-patches" <cygwin-patches@cygwin.com>
Reply-To: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Cc: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
Subject: [PATCH] cygrunsrv: Added options -T and -X; fixed a couple minor issues
Date: Wed, 13 Nov 2019 18:30:00 -0000
Message-Id: <20191113182814.379-1-lavr@ncbi.nlm.nih.gov>
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00119.txt.bz2

1. https://www.cygwin.com/ml/cygwin-patches/2019-q4/msg00107.html
2. Fixed an issue with "premature exit" error message printed if service is stopped from SCM by an operator
3. Fixed a potential issue with reporting 0 exit code when a service being stopped did not actually stop
---
 ChangeLog    |   6 +++
 cygrunsrv.cc | 125 +++++++++++++++++++++++++++++++++++++--------------
 cygrunsrv.h  |   5 +++
 utils.cc     |   8 ++++
 utils.h      |   5 +++
 5 files changed, 115 insertions(+), 34 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index b68ff6b..5466c69 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,9 @@
+2019-11-12  Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
+
+        * Added the -T (for timeout) and the -X (for stop timeout) options
+        * cygrunsrv.cc:  issue no "premature exit" error when stopped by SCM
+        (and daemon catches the internal signal then exits)
+
 2015-01-28  Corinna Vinschen <corinna@vinschen.de>
 
 	* cygrunsrv.README: Fix typo.
diff --git a/cygrunsrv.cc b/cygrunsrv.cc
index adb6ad3..31a5efd 100644
--- a/cygrunsrv.cc
+++ b/cygrunsrv.cc
@@ -82,6 +82,8 @@ struct option longopts[] = {
   { "shutdown", no_argument, NULL, 'o' },
   { "interactive", no_argument, NULL, 'i' },
   { "nohide", no_argument, NULL, 'j' },
+  { "timeout", required_argument, NULL, 'T'},
+  { "stop-timeout", required_argument, NULL, 'X'},
   { "verbose", no_argument, NULL, 'V' },
   { "help", no_argument, NULL, 'h' },
   { "version", no_argument, NULL, 'v' },
@@ -116,6 +118,8 @@ const char *opts = "I:"
   "n"
   "i"
   "j"
+  "T:"
+  "X:"
   "V"
   "h"
   "v";
@@ -131,6 +135,8 @@ DWORD preshutdown;
 DWORD shutdown;
 DWORD interactive;
 DWORD showcons;
+DWORD timeout = SERVICE_TMO;
+DWORD x_timeout = SERVICE_TMO;
 
 DWORD shutting_down = 0;
 static char service_main_exitval = 1;
@@ -245,7 +251,8 @@ install_registry_keys (const char *name, const char *desc, const char *path,
 		       const char *in_stdout, const char *in_stderr,
 		       const char *in_pidfile, DWORD neverexits,
 		       DWORD preshutdown, DWORD shutdown,
-		       DWORD interactive, DWORD showcons)
+		       DWORD interactive, DWORD showcons,
+		       DWORD timeout, DWORD x_timeout)
 {
   HKEY srv_key = NULL;
   HKEY env_key = NULL;
@@ -358,6 +365,17 @@ install_registry_keys (const char *name, const char *desc, const char *path,
 			      (const BYTE *) &showcons,
 			      sizeof(DWORD))) != ERROR_SUCCESS)
       err_out_set_error (RegSetValueEx, ret);
+  if (timeout)
+    if ((ret = RegSetValueEx (srv_key, PARAM_TIMEOUT, 0, REG_DWORD,
+                              (const BYTE *) &timeout,
+                              sizeof(DWORD))) != ERROR_SUCCESS)
+      err_out_set_error(RegSetValueEx, ret);
+  if (x_timeout)
+    if ((ret = RegSetValueEx (srv_key, PARAM_X_TIMEOUT, 0, REG_DWORD,
+                              (const BYTE *) &x_timeout,
+                              sizeof(DWORD))) != ERROR_SUCCESS)
+      err_out_set_error(RegSetValueEx, ret);
+
   RegFlushKey (srv_key);
 
 out:
@@ -432,7 +450,8 @@ get_reg_entries (const char *name, HKEY hklm, char *&path, char *&args,
 		 char *&stdin_path, char *&stdout_path, char *&stderr_path,
 		 char *&pidfile_path, DWORD *neverexits_p,
 		 DWORD *preshutdown_p, DWORD *shutdown_p,
-		 DWORD *interactive_p, DWORD *showcons_p)
+		 DWORD *interactive_p, DWORD *showcons_p,
+		 DWORD *timeout_p, DWORD *x_timeout_p)
 {
   HKEY srv_key = NULL;
   HKEY env_key = NULL;
@@ -500,6 +519,16 @@ get_reg_entries (const char *name, HKEY hklm, char *&path, char *&args,
 		       (BYTE *) showcons_p,
 		       (size = sizeof(*showcons_p), &size)) != ERROR_SUCCESS)
     *showcons_p = 0;  // the default
+  /* Get (optional) timeout. */
+  if (RegQueryValueEx (srv_key, PARAM_TIMEOUT, 0, &type,
+	               (BYTE *) timeout_p,
+	               (size = sizeof(*timeout_p), &size)) != ERROR_SUCCESS)
+    *timeout_p = SERVICE_TMO;  // the default
+  /* Get (optional) stop timeout. */
+  if (RegQueryValueEx (srv_key, PARAM_X_TIMEOUT, 0, &type,
+	               (BYTE *) x_timeout_p,
+	               (size = sizeof(*x_timeout_p), &size)) != ERROR_SUCCESS)
+    *x_timeout_p = *timeout_p;  // the default is same as timeout
   /* Get (optional) stdin/stdout/stderr redirection files. */
   if ((ret = get_opt_string_entry (srv_key, PARAM_STDIN, stdin_path)))
     goto out;
@@ -511,7 +540,7 @@ get_reg_entries (const char *name, HKEY hklm, char *&path, char *&args,
     goto out;
   if ((ret = get_opt_string_entry (srv_key, PARAM_STDERR, stderr_path)))
     goto out;
-  else if (reeval_io_path (STDERR_FILENO, stderr_path, name))
+  else if ((ret = reeval_io_path(STDERR_FILENO, stderr_path, name)))
     goto out;
   /* Get (optional) environment strings. */
   strcat (strcat (param_key, "\\"), PARAM_ENVIRON);
@@ -611,8 +640,6 @@ out:
   return ret;
 }
 
-
-
 int
 add_env_var (char *envstr, env_t *&env)
 {
@@ -634,8 +661,7 @@ add_env_var (char *envstr, env_t *&env)
       }
     else if (!strcmp (env[i].name, name))
       return 0;
-  return error (InstallErr, "Only " MAX_ENV_STR
-  			    " environment variables allowed");
+  return error (InstallErr, "Only " MAX_ENV_STR " environment variables allowed");
 }
 
 int
@@ -906,7 +932,7 @@ install_service (const char *name, const char *crspath, const char *disp,
 	  sprintf (pwdbuf, "Enter password of user `%s': ", username);
 	  p = getpass (pwdbuf);
 	  strcpy (pwdbuf, p);
-	  p = getpass ("Reenter, please: ");
+	  p = getpass ("Re-enter, please: ");
 	  if (!strcmp (pwdbuf, p))
 	    pass = pwdbuf;
 	  else
@@ -965,7 +991,7 @@ remove_service (const char *name)
      If CANNOT_ACCEPT_CTRL wait and try again up to 30secs. */
   while (!ControlService (sh, SERVICE_CONTROL_STOP, &ss) &&
          (err = GetLastError ()) == ERROR_SERVICE_CANNOT_ACCEPT_CTRL &&
-	 ++cnt < 30)
+	 ++cnt < SERVICE_TMO)
     sleep (1);
   /* Any error besides ERROR_SERVICE_NOT_ACTIVE is treated as an error. */
   if (err && err != ERROR_SERVICE_NOT_ACTIVE)
@@ -992,12 +1018,11 @@ remove_service (const char *name)
 		  last_tick = GetTickCount ();
 		}
 	      else if (GetTickCount() - last_tick > ss.dwWaitHint)
-		{
-		  SetLastError (ERROR_SERVICE_REQUEST_TIMEOUT);
-		  err_out (QueryServiceStatus);
-		}
+		err_out_set_error (QueryServiceStatus, ERROR_SERVICE_REQUEST_TIMEOUT);
 	    }
         }
+      if (ss.dwCurrentState != SERVICE_STOPPED)
+        err_out_set_error (QueryServiceStatus, ERROR_SERVICE_CANNOT_ACCEPT_CTRL);
     }
   err = 0;
   /* Now try to remove service. */
@@ -1096,7 +1121,7 @@ stop_service (const char *name)
      If CANNOT_ACCEPT_CTRL wait and try again up to 30secs. */
   while (!ControlService (sh, SERVICE_CONTROL_STOP, &ss) &&
          (err = GetLastError ()) == ERROR_SERVICE_CANNOT_ACCEPT_CTRL &&
-	 ++cnt < 30)
+        ++cnt < SERVICE_TMO)
     sleep (1);
   /* Any error besides ERROR_SERVICE_NOT_ACTIVE is treated as an error. */
   if (err && err != ERROR_SERVICE_NOT_ACTIVE)
@@ -1123,9 +1148,11 @@ stop_service (const char *name)
 		  last_tick = GetTickCount ();
 		}
 	      else if (GetTickCount() - last_tick > ss.dwWaitHint)
-	        err_out_set_error (QueryServiceStatus, ERROR_SERVICE_REQUEST_TIMEOUT);
+		err_out_set_error (QueryServiceStatus, ERROR_SERVICE_REQUEST_TIMEOUT);
 	    }
         }
+      if (ss.dwCurrentState != SERVICE_STOPPED)
+        err_out_set_error (QueryServiceStatus, ERROR_SERVICE_CANNOT_ACCEPT_CTRL);
     }
   err = 0;
 
@@ -1193,7 +1220,6 @@ ControlsAccepted_desc[] =
   {true, 0, NULL }
 };
 
-
 /* Passed one of the above static arrays and a DWORD, this returns a 
    pointer to a descriptive string: either a concatenation of matching
    items (if bitwise is true) otherwise just the matching item.  */
@@ -1281,7 +1307,7 @@ print_service (const char *name, HKEY hklm, SC_HANDLE &sh, SERVICE_STATUS &ss,
   if (get_reg_entries (name, hklm, path, args, dir, env, &termsignal,
 		       &shutsignal, stdin_path, stdout_path, stderr_path,
 		       pidfile_path, &neverex, &preshutd, &shutd, &interact,
-		       &showc))
+		       &showc, &timeout, &x_timeout))
     return;  /* bail on error */
 
   printf ("%-20s: %s", "Command", path);
@@ -1321,6 +1347,17 @@ print_service (const char *name, HKEY hklm, SC_HANDLE &sh, SERVICE_STATUS &ss,
       if (shutsignal != termsignal)
         P("Shutdown Signal", strsignal (shutsignal));
 
+      if (timeout != SERVICE_TMO)
+        {
+          sprintf (tmp, "%u", timeout);
+          P(timeout != x_timeout ? "Start Timeout" : "Start/Stop Timeout", tmp);
+        }
+      if (x_timeout != timeout)
+        {
+          sprintf (tmp, "%u", x_timeout);
+          P("Stop Timeout", tmp);
+        }
+
       if (env)
         {
           printf ("%-20s: ", "Environment");
@@ -1483,7 +1520,7 @@ list_services (const char *server, bool verbose)
 	      else
 		printf ("%s\n", srv_buf[i].lpServiceName);
 	    }
-          else
+	  else
             {
               if (!QueryServiceStatus(sh, &ss))
                 err_out (QueryServiceStatus);
@@ -1520,8 +1557,9 @@ int server_pid;
 int
 terminate_child (DWORD sig)
 {
-  set_service_status (SERVICE_STOP_PENDING, 1, 21000L);
-  for (int i = 0; i < 20; ++i)
+  shutting_down = 1;
+  set_service_status (SERVICE_STOP_PENDING, 1, x_timeout * 1000L);
+  for (DWORD i = 1; i < x_timeout; ++i)
     if (!server_pid)
       sleep (1);
     else
@@ -1541,7 +1579,6 @@ terminate_child (DWORD sig)
 void
 sigterm_handler (int sig)
 {
-  shutting_down = 1;
   syslog (LOG_INFO, "Received signal `%d', terminate child...", sig);
   terminate_child (termsig);
 }
@@ -1737,7 +1774,8 @@ service_main (DWORD argc, LPSTR *argv)
   if ((err = get_reg_entries (svcname, HKEY_LOCAL_MACHINE, path, args, dir, env,
 			      &termsig, &shutsig, stdin_path, stdout_path,
 			      stderr_path, pidfile_path, &neverexits,
-			      &preshutdown, &shutdown, &interactive, &showcons))
+			      &preshutdown, &shutdown, &interactive, &showcons,
+			      &timeout, &x_timeout))
       != 0)
     {
       syslog_starterr ("get_reg_entries", err);
@@ -1883,24 +1921,24 @@ service_main (DWORD argc, LPSTR *argv)
   else
     {
       /* Pid file given, first wait for daemon's fork(). */
-      int i;
-      for (i = 1; i <= 30; i++) {
-       if ((ret = waitpid (child_pid, &status, WNOHANG)) != 0)
-	 break;
-       syslog (LOG_INFO, "service `%s': waiting for fork of %d (#%d)",
-	 svcname, child_pid, i);
-       sleep(1);
-       report_service_status ();
+      DWORD i;
+      for (i = 1; i <= timeout; ++i) {
+	if ((ret = waitpid (child_pid, &status, WNOHANG)) != 0)
+	  break;
+	syslog (LOG_INFO, "service `%s': waiting for fork of %d (#%u)",
+	  svcname, child_pid, (unsigned int) i);
+	sleep(1);
+	report_service_status ();
       }
       if (ret == child_pid && WIFEXITED(status) && WEXITSTATUS(status) == 0)
 	{
 	 /* Daemon has fork()ed successfully, wait for pidfile. */
 	 int read_pid;
-	 for (i = 1; i <= 30; i++) {
+         for (; i <= timeout; ++i) {
 	   if ((read_pid = read_pidfile (pidfile_path, forktime)) != -1)
 	     break;
-	   syslog (LOG_INFO, "service `%s': waiting for file %s (#%d)",
-	     svcname, pidfile_path, i);
+	   syslog (LOG_INFO, "service `%s': waiting for file %s (#%u)",
+	     svcname, pidfile_path, (unsigned int) i);
 	   sleep(1);
 	   report_service_status ();
 	 }
@@ -2048,6 +2086,8 @@ main (int argc, char **argv)
   int in_shutdown = 0;
   int in_interactive = 0;
   int in_showcons = 0;
+  int in_timeout = 0;
+  int in_x_timeout = 0;
   bool verbose = false;
 
   setlocale (LC_ALL, "");
@@ -2281,6 +2321,22 @@ main (int argc, char **argv)
 	  return error (OnlyOneIO);
 	in_pidfile = optarg;
 	break;
+      case 'T':
+        if (action != Install)
+          return error (TimeoutNotAllowed);
+        if (in_timeout)
+	  return error (OnlyOneTimeout);
+        if ((in_timeout = atoi (optarg)) <= 0)
+	  return error (InvalidTimeout);
+        break;
+      case 'X':
+        if (action != Install)
+	  return error (XTimeoutNotAllowed);
+        if (in_x_timeout)
+	  return error (OnlyOneXTimeout);
+        if ((in_x_timeout = atoi (optarg)) <= 0)
+	  return error (InvalidTimeout);
+        break;
       case 'V':
         verbose = true;
         break;
@@ -2320,7 +2376,8 @@ main (int argc, char **argv)
 					in_stdin, in_stdout, in_stderr,
 					in_pidfile, in_neverexits,
 					in_preshutdown, in_shutdown,
-					in_interactive, in_showcons)) != 0)
+					in_interactive, in_showcons,
+					in_timeout, in_x_timeout)) != 0)
         remove_service (in_name);
       return ret;
       break;
diff --git a/cygrunsrv.h b/cygrunsrv.h
index b21ff18..7839487 100644
--- a/cygrunsrv.h
+++ b/cygrunsrv.h
@@ -40,6 +40,8 @@
 #define PARAM_SHUTDOWN	"Shutdown"
 #define PARAM_INTERACT	"Interactive"
 #define PARAM_SHOWCONS	"ShowConsole"
+#define PARAM_TIMEOUT   "Timeout"
+#define PARAM_X_TIMEOUT "StopTimeout"
 
 #define CYG_ROOT	"SOFTWARE\\Cygnus Solutions\\Cygwin\\mounts v2\\/"
 #define CYG_ROOT_VAL	"native"
@@ -56,6 +58,9 @@
 #define MAX_DEPS	16
 #define MAX_DEPS_STR	STRINGIFY(MAX_DEPS)
 
+#define SERVICE_TMO     30
+#define SERVICE_TMO_STR STRINGIFY(SERVICE_TMO)
+
 extern char *appname;
 extern char *svcname;
 
diff --git a/utils.cc b/utils.cc
index 62e7f80..142f2c7 100644
--- a/utils.cc
+++ b/utils.cc
@@ -75,6 +75,11 @@ const char *reason_list[] = {
   "--interactive not allowed with --user",
   "--nohide is only allowed with --install",
   "Only one --nohide is allowed",
+  "--timeout is only allowed with --install",
+  "Only one --timeout allowed",
+  "Invalid timeout value",
+  "--stop-timeout is only allowed with --install",
+  "Only one --stop-timeout allowed",
   "Trailing commandline arguments not allowed",
   "You must specify one of the `-IRSE' options",
   "Error installing a service",
@@ -207,6 +212,9 @@ usage ()
 "                            (No effect since Windows Vista/Longhorn).\n"
 "  -j, --nohide              Don't hide console window when service interacts\n"
 "                            with desktop.\n"
+"  -T, --timeout <secs>      Timeout for lengthy service operations (start/stop),\n"
+"                            default is " SERVICE_TMO_STR " seconds\n"
+"  -X, --stop-timeout <secs> Timeout to stop service (defaults to the -T value).\n"
 "\n"
 "Informative output:\n"
 "  -V, --verbose             When used with --query or --list, causes extra\n"
diff --git a/utils.h b/utils.h
index 9b4b09c..f648d5c 100644
--- a/utils.h
+++ b/utils.h
@@ -66,6 +66,11 @@ enum reason_t {
   NoInteractiveWithUser,
   ShowconsNotAllowed,
   OnlyOneShowcons,
+  TimeoutNotAllowed,
+  OnlyOneTimeout,
+  InvalidTimeout,
+  XTimeoutNotAllowed,
+  OnlyOneXTimeout,
   TrailingArgs,
   StartAsSvcErr,
   InstallErr,
-- 
2.17.0
