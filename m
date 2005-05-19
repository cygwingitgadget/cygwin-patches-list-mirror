Return-Path: <cygwin-patches-return-5477-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13411 invoked by alias); 19 May 2005 19:40:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21835 invoked from network); 19 May 2005 19:25:44 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 19 May 2005 19:25:44 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.44)
	id 1DYqeI-0000TF-Mu
	for cygwin-patches@cygwin.com; Thu, 19 May 2005 19:25:39 +0000
Message-ID: <428CE837.C00E288B@dessent.net>
Date: Thu, 19 May 2005 19:40:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] several new features for cygrunsrv
Content-Type: multipart/mixed;
 boundary="------------DC433C7F0EE7215671D3E4E0"
X-SW-Source: 2005-q2/txt/msg00073.txt.bz2

This is a multi-part message in MIME format.
--------------DC433C7F0EE7215671D3E4E0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 6992


(I realize this list is technically only for patches on cygwin, but cygrunsrv is
close enough...)

I've implemented some new features for cygrunsrv that I think might be useful to
people.  Examples follow.

A new command "-L" / "--list" can be specified that will list all installed
cygrunsrv services:

$ cygrunsrv --list
apache cron cygserver mailtun sshd 

This is meant to facilitate scripting, e.g. if you wanted to disable all running
Cygwin services you can now do something like:

for S in `cygrunsrv -L`; do cygrunsrv -E $S; done

If a service name contains spaces it will be double-quoted.

The other major change is a new flag "-V" / "--verbose" which adds a lot more
output to both the --list and the --query commands.  The output of --query is
also made more sensible, for example the "Own Process" attribute is pretty much
a given so I moved it into the --verbose mode.

I had in mind a goal to add complete dumping of all information about services
to cygcheck to aid in troubleshooting, and this makes it so that cygcheck can
simply system("cygrunsrv --list --verbose").  Some examples:

$ cygrunsrv -Q sshd
Service             : sshd
Display name        : ssh daemon
Description         : Cygwin: Accepts remote ssh sessions
Current State       : Stopped
Command             : /usr/sbin/sshd -D

$ cygrunsrv -Q sshd --verbose
Service             : sshd
Display name        : ssh daemon
Description         : Cygwin: Accepts remote ssh sessions
Current State       : Stopped
Command             : /usr/sbin/sshd -D
stdin path          : /dev/null
stdout path         : /var/log/sshd.log
stderr path         : /var/log/sshd.log
Environment         : CYGWIN="ntsec" 
Process Type        : Own Process
Startup             : Manual
Account             : LocalSystem

Most every aspect of the service will be listed in verbose mode.  Below you can
see that with both new options you get a wealth of information:

$ cygrunsrv --list --verbose
Service             : apache
Description         : Cygwin: Apache httpd server
Current State       : Stopped
Command             : /usr/sbin/httpd -F
stdin path          : /dev/null
stdout path         : /var/log/apache.log
stderr path         : /var/log/apache.log
Process Type        : Own Process
Startup             : Manual
Account             : LocalSystem

Service             : cron
Display name        : cron daemon
Description         : Cygwin: Provides scheduled execution of commands
Current State       : Running
Controls Accepted   : Stop
Command             : /usr/sbin/cron -D
stdin path          : /dev/null
stdout path         : /var/log/cron.log
stderr path         : /var/log/cron.log
Process Type        : Own Process
Startup             : Automatic
Account             : LocalSystem

Service             : cygserver
Description         : Cygwin: helper service for security, semaphores, ipc, etc
Current State       : Running
Controls Accepted   : Stop
Command             : /usr/sbin/cygserver
stdin path          : /dev/null
stdout path         : /var/log/cygserver.log
stderr path         : /var/log/cygserver.log
Process Type        : Own Process
Startup             : Automatic
Account             : LocalSystem

Service             : mailtun
Description         : Cygwin: SSH tunnel for dessent.net POP3 and SMTP services
Current State       : Running
Controls Accepted   : Stop, Shutdown
Command             : /bin/autossh.exe -M 29038 -N -L 25:localhost:25 -L
110:localhost:110 -l tunnel dessent.net
stdin path          : /dev/null
stdout path         : /var/log/mailtun.log
stderr path         : /var/log/mailtun.log
Special flags       : --shutdown 
Process Type        : Own Process
Startup             : Automatic
Dependencies        : Tcpip, cygserver, named
Account             : .\brian

Service             : sshd
Display name        : ssh daemon
Description         : Cygwin: Accepts remote ssh sessions
Current State       : Stopped
Command             : /usr/sbin/sshd -D
stdin path          : /dev/null
stdout path         : /var/log/sshd.log
stderr path         : /var/log/sshd.log
Environment         : CYGWIN="ntsec" 
Process Type        : Own Process
Startup             : Manual
Account             : LocalSystem


As you can see, if we simply add this to cygcheck we can now diagnose problems
with services much quicker since nearly every bit of information is displayed. 
It also makes it easier if you want to modify some aspect of a service that is
currently installed, because --verbose mode essentially gives you a blueprint of
all the options that were used installing the service.  In fact that was one of
the additional things I had planned on doing but didn't make it into this patch:
A command that says "tell me what command I would use to install service X." 
That way if you wanted to modify any aspect of the service the pain of
uninstalling and reinstalling is gone, especially if you no longer remember the
options you used when creating the service.

I apologise if the patch is a little large, but I also took the liberty of doing
some minor code cleanups here and there while implementing this.

Brian

2005-05-19  Brian Dessent  <brian@dessent.net>

	* cygrunsrv.cc (longopts): Add '--list' and '--verbose' options.
	(opts): Add '-L' and '-V' options; keep order consistent with above.
	(action_t): Add 'List'.
	(err_out_set_error): Define version of 'err_out' macro that allows for
	convenient setting the error code.
	(get_description): New function.
	(install_service): Use 'err_out_set_error' instead throughout.
	(start_service): Ditto.
	(stop_service): Ditto.	
	(ServiceType_desc): Add.  Use structs to map DWORD fields onto strings.
	(StartType_desc): Ditto.
	(CurrentState_desc): Ditto.
	(ErrorControl_desc): Ditto.
	(ControlsAccepted_desc): Ditto.
	(make_desc): Add new function that generalizes the task of creating
	a textual field from a binary DWORD.
	(serviceTypeToString): Remove.
	(serviceStateToString): Ditto.
	(controlsToString): Ditto.
	(parsedoublenull): Add new helper function for parsing lists of
	strings, which is used below when printing the 'lpDependencies' value.
	(print_service): Add new function that is responsible for generating
	the formatted output for --list and --query commands.
	(QSC_BUF_SIZE): Add.
	(query_service): Add verbosity parameter.  Remove printf output from
	here, call 'print_service' instead.  Call QueryServiceConfig to
	retrieve more detail on the service.
	(list_services): Add new function that implements -L,--list command.
	Call EnumServicesStatus to get names of all services, and then
	determine which ones are cygrunsrv services.  List their names, or 
	call print_service() if verbosity was requested.
	(main): Declare new variable 'verbosity'.  Support new command line
	switches.  Pass on verbosity information to query_service and
	list_services.
	* utils.cc (reason_list): Update error text.
	(usage): Document new switches in the help text.
	* utils.h (reason_t): Add new symbolic name for error text.
--------------DC433C7F0EE7215671D3E4E0
Content-Type: text/plain; charset=us-ascii;
 name="cygrunsrv-newfeatures.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygrunsrv-newfeatures.patch"
Content-length: 21520

--- /tmp/cygrunsrv-1.02-1/cygrunsrv.cc	2005-05-16 07:55:41.000000000 -0700
+++ ./cygrunsrv.cc	2005-05-19 11:27:42.609375000 -0700
@@ -51,6 +51,7 @@ struct option longopts[] = {
   { "start", required_argument, NULL, 'S' },
   { "stop", required_argument, NULL, 'E' },
   { "query", required_argument, NULL, 'Q' },
+  { "list", no_argument, NULL, 'L' },
   { "path", required_argument, NULL, 'p' },
   { "args", required_argument, NULL, 'a' },
   { "chdir", required_argument, NULL, 'c' },
@@ -69,6 +70,7 @@ struct option longopts[] = {
   { "shutdown", no_argument, NULL, 'o' },
   { "interactive", no_argument, NULL, 'i' },
   { "nohide", no_argument, NULL, 'j' },
+  { "verbose", no_argument, NULL, 'V' },
   { "help", no_argument, NULL, 'h' },
   { "version", no_argument, NULL, 'v' },
   { 0, no_argument, NULL, 0 }
@@ -77,8 +79,9 @@ struct option longopts[] = {
 char *opts = "I:"
   "R:"
   "S:"
-  "Q:"
   "E:"
+  "Q:"
+  "L"
   "p:"
   "a:"
   "c:"
@@ -97,6 +100,7 @@ char *opts = "I:"
   "n"
   "i"
   "j"
+  "V"
   "h"
   "v";
 
@@ -118,7 +122,8 @@ enum action_t {
   Remove,
   Start,
   Stop,
-  Query
+  Query,
+  List
 };
 
 enum type_t {
@@ -156,6 +161,8 @@ eval_wait_time (register DWORD wait)
 }
 
 #define err_out(name)	{err_func = #name; err = GetLastError (); goto out;}
+#define err_out_set_error(name, error) \
+            {err_func = #name; err = error; SetLastError (error); goto out;}
 
 /* Installs the subkeys of the service registry entry so that cygrunsrv
    can determine what application to start on service startup. */
@@ -463,6 +470,36 @@ out:
   return ret;
 }
 
+/* Retrieves the description of the service.  Note: it would be so much
+   cleaner to do this by a simple call to QueryServiceConfig2(), but alas this
+   does not exist in NT4.  *sigh*  */
+int
+get_description (const char *name, char *&descr)
+{
+  HKEY desc_key = NULL;
+  char desc_key_path[MAX_PATH];
+  int ret;
+
+  strcat (strcpy (desc_key_path, SRV_KEY), name);
+  if ((ret = RegOpenKeyEx (HKEY_LOCAL_MACHINE, desc_key_path, 0,
+  			   KEY_READ, &desc_key)) != ERROR_SUCCESS)
+    goto out;
+  
+  if ((ret = get_opt_string_entry (desc_key, DESC, descr)))
+    goto out;
+
+  ret = 0;
+
+out:
+  if (ret)
+    descr = NULL;
+  if (desc_key)
+    RegCloseKey (desc_key);
+  return ret;
+}
+
+
+
 int
 add_env_var (char *envstr, env_t *&env)
 {
@@ -575,10 +612,7 @@ install_service (const char *name, const
       GetLastError() != ERROR_SERVICE_DOES_NOT_EXIST)
     err_out (OpenService);
   if (sh)
-    {
-      SetLastError (ERROR_SERVICE_EXISTS);
-      err_out (OpenService);
-    }
+    err_out_set_error (OpenService, ERROR_SERVICE_EXISTS);
   /* Set optional dependencies. */
   if (deps)
     {
@@ -587,10 +621,7 @@ install_service (const char *name, const
 	concat_length += (strlen(deps[i]) + 1);
       concat_length++;
       if (! (dependencies = (char *) malloc(concat_length)))
-	{
-	  SetLastError(ERROR_OUTOFMEMORY);
-	  err_out(malloc);
-	}
+	err_out_set_error (malloc, ERROR_OUTOFMEMORY);
       char *p = dependencies;
       for (int i = 0; i < MAX_DEPS && deps[i]; i++)
 	{
@@ -626,10 +657,7 @@ install_service (const char *name, const
 	    }
 	}
       if (!(username = (char *) malloc (strlen (user) + 3)))
-        {
-	  SetLastError (ERROR_OUTOFMEMORY);
-	  err_out (malloc);
-	}
+        err_out_set_error (malloc, ERROR_OUTOFMEMORY);
       /* If no "\" is part of the name, prepend ".\" */
       if (!strchr (user, '\\'))
         strcat (strcpy (username, ".\\"), user);
@@ -789,18 +817,12 @@ start_service (const char *name)
 	      last_tick = GetTickCount ();
 	    }
 	  else if (GetTickCount() - last_tick > ss.dwWaitHint)
-	    {
-	      SetLastError (ERROR_SERVICE_REQUEST_TIMEOUT);
-	      err_out (QueryServiceStatus);
-	    }
+	    err_out_set_error (QueryServiceStatus, ERROR_SERVICE_REQUEST_TIMEOUT);
 	}
     }
 
   if (ss.dwCurrentState != SERVICE_RUNNING)
-    {
-      SetLastError (ERROR_SERVICE_NOT_ACTIVE);
-      err_out (QueryServiceStatus);
-    }
+    err_out_set_error (QueryServiceStatus, ERROR_SERVICE_NOT_ACTIVE);
 
 out:
   if (sh)
@@ -858,10 +880,7 @@ stop_service (const char *name)
 		  last_tick = GetTickCount ();
 		}
 	      else if (GetTickCount() - last_tick > ss.dwWaitHint)
-		{
-		  SetLastError (ERROR_SERVICE_REQUEST_TIMEOUT);
-		  err_out (QueryServiceStatus);
-		}
+	        err_out_set_error (QueryServiceStatus, ERROR_SERVICE_REQUEST_TIMEOUT);
 	    }
         }
     }
@@ -875,104 +894,242 @@ out:
   return err == 0 ? 0 : error (StopErr, err_func, err);
 }
 
-char *
-serviceTypeToString(DWORD stype)
+/* these are used to turn DWORDs into desciptive text */
+static struct desc_type { bool bitwise; DWORD flag; const char *meaning; } 
+
+ServiceType_desc[] =
 {
-  switch (stype) {
-    case SERVICE_WIN32_OWN_PROCESS:
-      return "Own Process";
-      break;
-    case SERVICE_WIN32_SHARE_PROCESS:
-      return "Share Process";
-      break;
-    case SERVICE_KERNEL_DRIVER:
-      return "Kernel Driver";
-    case SERVICE_FILE_SYSTEM_DRIVER:
-      return "File System Driver";
-    case SERVICE_INTERACTIVE_PROCESS:
-      return "Interactive Process";
-    default:
-      return "Undefined type";
-  }
+  {false, 0,                                   "(Unknown)"},
+  {false, SERVICE_WIN32_OWN_PROCESS,           "Own Process"},
+  {false, SERVICE_WIN32_SHARE_PROCESS,         "Shared Process"},
+  {false, SERVICE_KERNEL_DRIVER,               "Kernel Driver"},
+  {false, SERVICE_FILE_SYSTEM_DRIVER,          "Filesystem Driver"},
+  {false, SERVICE_INTERACTIVE_PROCESS,         "Interactive Process"},
+  {false, 0, NULL}
+},
+
+StartType_desc[] =
+{
+  {false, 0,                                   "(Unknown)"},
+  {false, SERVICE_BOOT_START,                  "Boot"},
+  {false, SERVICE_SYSTEM_START,                "System"},
+  {false, SERVICE_AUTO_START,                  "Automatic"},
+  {false, SERVICE_DISABLED,                    "Disabled"},
+  {false, SERVICE_DEMAND_START,                "Manual"},
+  {false, 0, NULL}
+},
+
+CurrentState_desc[] =
+{
+  {false, 0,                                   "(Unknown)"},
+  {false, SERVICE_STOPPED,                     "Stopped"},
+  {false, SERVICE_START_PENDING,               "Start Pending"},
+  {false, SERVICE_STOP_PENDING,                "Stop Pending"}, 
+  {false, SERVICE_RUNNING,                     "Running"},  
+  {false, SERVICE_CONTINUE_PENDING,            "Continue Pending"},
+  {false, SERVICE_PAUSE_PENDING,               "Pause Pending"},
+  {false, SERVICE_PAUSED,                      "Paused"}, 
+  {false, 0, NULL}
+},
+
+ErrorControl_desc[] =
+{
+  {false, 0,                                   "(Unknown)"},
+  {false, SERVICE_ERROR_IGNORE,                "Ignore"},
+  {false, SERVICE_ERROR_NORMAL,                "Normal"},
+  {false, SERVICE_ERROR_SEVERE,                "Severe"},
+  {false, SERVICE_ERROR_CRITICAL,              "Critical"},
+  {false, 0, NULL}
+},
+    
+ControlsAccepted_desc[] = 
+{
+  {true, 0,                                    "(none)"},
+  {true, SERVICE_ACCEPT_STOP,                  "Stop, "},
+  {true, SERVICE_ACCEPT_SHUTDOWN,              "Shutdown, "},
+  {true, SERVICE_ACCEPT_PAUSE_CONTINUE,        "Pause, Continue, "},
+  {true, SERVICE_ACCEPT_PARAMCHANGE,           "Change Parameters, "},
+  {true, SERVICE_ACCEPT_NETBINDCHANGE,         "Change Network Binding, "},
+  {true, SERVICE_ACCEPT_HARDWAREPROFILECHANGE, "Hardware Profile Change Notify, "},
+  {true, SERVICE_ACCEPT_POWEREVENT,            "Power Status Change Notify, "},
+  {true, SERVICE_ACCEPT_SESSIONCHANGE,         "Session Status Change Notify, "},
+  {true, 0, NULL }
+};
+
+
+/* Passed one of the above static arrays and a DWORD, this returns a 
+   pointer to a descriptive string: either a concatenation of matching
+   items (if bitwise is true) otherwise just the matching item.  */
+const char *
+make_desc(struct desc_type *desc, DWORD thing)
+{
+  static char buf[256];
+
+  if (desc[0].bitwise)
+    {
+      buf[0] = '\0';
+      for (int i = 1; desc[i].meaning; i++)
+        if (thing & desc[i].flag)
+          strcat (buf, desc[i].meaning);
+  
+      char *ptr = strchr (buf, '\0');
+      if (ptr - buf > 2 && ptr[-1] == ' ' && ptr[-2] == ',')
+        {
+          ptr[-2] = '\0';               /* remove tailing ", " */
+          return (buf);
+        }
+    }
+  else
+    for (int i = 1; desc[i].meaning; i++)
+      if (thing == desc[i].flag)
+        return (desc[i].meaning);
+
+  return desc[0].meaning;               /* default value */        
 }
 
+/* Passed a pointer to a double-NULL terminated list of strings, this 
+   returns a formatted list of those items, each delimited by `delim'.  */
 char *
-serviceStateToString(DWORD state)
+parsedoublenull (const char *input, const char *delim)
 {
-  switch (state) {
-    case SERVICE_STOPPED:
-      return "Stopped";
-    case SERVICE_START_PENDING:
-      return "Start Pending";
-    case SERVICE_STOP_PENDING:
-      return "Stop Pending";
-    case SERVICE_RUNNING:
-      return "Running";
-    case SERVICE_CONTINUE_PENDING:
-      return "Continue Pending";
-    case SERVICE_PAUSE_PENDING:
-      return "Pause Pending";
-    case SERVICE_PAUSED:
-      return "Paused";
-    default:
-      return "Undefined state";
-  }
-}
-
-#define ACCEPT_STOP_MSG           "Accept Stop"
-#define ACCEPT_PAUSE_CONTINUE_MSG "Accept Pause Continue"
-#define ACCEPT_SHUTDOWN_MSG       "Accept Shutdown"
-char *
-controlsToString(DWORD controls)
+  char *base, *end;
+  static char buf[34];
+  int used = 0, dsiz = strlen (delim);
+  
+#define parsedoublenull_done (*end == 0 && *base == 0)
+
+  for (buf[0] = 0, base = end = (char *) input; !parsedoublenull_done; end++)
+    if (*end == 0)
+      {
+        if ((used += ((end - base) + dsiz)) >= sizeof(buf))
+          break;     /* don't overflow */
+        strcat (buf, base);
+        base = end + 1;
+        if (!parsedoublenull_done)
+          strcat (buf, delim);
+      }
+  return buf;
+}
+
+/* Passed the name, opened handle, and status information about a service, 
+   this formats all the information and outputs it to stdout.  */
+void
+print_service (const char *name, SC_HANDLE &sh, SERVICE_STATUS &ss, 
+               QUERY_SERVICE_CONFIG *qsc, bool verbose)
 {
-  static char buf[sizeof(ACCEPT_STOP_MSG) + sizeof(ACCEPT_PAUSE_CONTINUE_MSG) 
-    + sizeof(ACCEPT_SHUTDOWN_MSG) + 5];
-  buf[0] = '\0';
-
-  if ( controls & SERVICE_ACCEPT_STOP ) {
-    strcat(buf, ACCEPT_STOP_MSG);
-  }
-  if ( controls & SERVICE_ACCEPT_PAUSE_CONTINUE ) {
-    if ( buf[0] != '\0' ) 
-      strcat(buf, ", ");
-    strcat(buf, ACCEPT_STOP_MSG);
-  }
-  if ( controls & SERVICE_ACCEPT_SHUTDOWN ) {
-    if ( buf[0] != '\0' ) 
-      strcat(buf, ", ");
-    strcat(buf, ACCEPT_SHUTDOWN_MSG);
-  }
-  return(buf);
+  char *descrip = NULL, *path = NULL, *args = NULL, *dir = NULL, 
+       *stdin_path = NULL, *stdout_path = NULL, *stderr_path = NULL;
+  DWORD termsignal, neverex, shutd, interact, showc;
+  env_t *env = NULL;
+
+#define P(x, y) printf ("%-20s: %s\n", x, y)
+
+  P("Service",            name);
+  if (strcmp (name, qsc->lpDisplayName))
+    P("Display name",     qsc->lpDisplayName);
+  if (!get_description (name, descrip) && descrip && strlen (descrip))
+    P("Description", descrip);
+    
+  P("Current State",      make_desc(CurrentState_desc, ss.dwCurrentState));
+  if (ss.dwControlsAccepted)
+    P("Controls Accepted",  make_desc(ControlsAccepted_desc, ss.dwControlsAccepted));
+
+  /* Get the cygrunsrv-specific things from the registry. */
+  if (get_reg_entries (name, path, args, dir, env, &termsignal,
+		            stdin_path, stdout_path, stderr_path,
+			    &neverex, &shutd, &interact, &showc))
+    return;  /* bail on error */
+
+  printf ("%-20s: %s", "Command", path);
+  if (args)
+    printf (" %s\n", args);
+  else
+    fputc ('\n', stdout);
+
+  if (verbose)
+    {      
+      if (dir)
+        P("Working Dir", dir);
+      if (stdin_path)
+        P("stdin path", stdin_path);
+      if (stdout_path)
+        P("stdout path", stdout_path);
+      if (stderr_path)
+        P("stderr path", stderr_path);
+        
+      char tmp[128] = {0};
+      if (neverex)
+        strcat (tmp, "--neverexits ");
+      if (shutd)
+        strcat (tmp, "--shutdown ");
+      if (interact)
+        strcat (tmp, "--interactive ");
+      if (interact)
+        strcat (tmp, "--nohide ");
+      if (strlen(tmp))
+        P("Special flags", tmp);
+      
+      if (termsignal != SIGTERM)
+        P("Termination Signal", strsignal (termsignal));
+
+      if (env)
+        {
+          printf ("%-20s: ", "Environment");
+          for (int i = 0; i <= MAX_ENV && env[i].name; ++i)
+            printf ("%s=\"%s\" ", env[i].name, env[i].val);
+          fputc ('\n', stdout);
+        }
+      
+      P("Process Type", make_desc(ServiceType_desc, ss.dwServiceType));
+      P("Startup", make_desc(StartType_desc, qsc->dwStartType)); 
+      if (qsc->lpDependencies && strlen (qsc->lpDependencies))
+        P("Dependencies", parsedoublenull(qsc->lpDependencies, ", "));
+      if (qsc->lpServiceStartName)
+        P("Account", qsc->lpServiceStartName);
+    }
+
+#undef P
+  fputc ('\n', stdout);
 }
 
+/* According to the platform SDK, the maximum size that a QUERY_SERVICE_CONFIG
+   buffer need be is 8kb.  */
+#define QSC_BUF_SIZE 8192
+
 /* Query service `name'. */
 int
-query_service (const char *name)
+query_service (const char *name, bool verbose)
 {
   SC_HANDLE sm = (SC_HANDLE) 0;
   SC_HANDLE sh = (SC_HANDLE) 0;
   SERVICE_STATUS ss;
+  QUERY_SERVICE_CONFIG *qsc_buf = NULL;
   int cnt = 0;
   char *err_func;
-  DWORD err = 0;
+  DWORD err = 0, bytes_needed;
+
+  /* Allocate qsc buffer. */
+  if ((qsc_buf = (QUERY_SERVICE_CONFIG *) malloc (QSC_BUF_SIZE)) == NULL)
+    err_out_set_error (malloc, ERROR_OUTOFMEMORY);
 
   /* Open service manager database. */
   if (!(sm = OpenSCManager (NULL, NULL, SC_MANAGER_CONNECT)))
     err_out (OpenSCManager);
+
   /* Check whether service exists. */
   if (!(sh = OpenService (sm, name,  SERVICE_QUERY_STATUS | SERVICE_QUERY_CONFIG)))
     err_out (OpenService);
-  printf("Service %s exists\n", name);
 
-  /* Get the status and print it out */
+  /* Get the current status of the service. */
   if (!QueryServiceStatus(sh, &ss))
     err_out (QueryServiceStatus);
-  printf("%-20s: %s\n", "Type", serviceTypeToString(ss.dwServiceType));
-  printf("%-20s: %s\n", "Current State", 
-      serviceStateToString(ss.dwCurrentState));
-  printf("%-20s: %s\n", "Controls Accepted", \
-      controlsToString(ss.dwControlsAccepted));
 
+  /* Get configuration info about the service. */
+  if (!QueryServiceConfig (sh, qsc_buf, QSC_BUF_SIZE, &bytes_needed))
+    err_out (QueryServiceConfig);
+
+  print_service (name, sh, ss, qsc_buf, verbose);
+   
   err = 0;
 
 out:
@@ -980,11 +1137,103 @@ out:
     CloseServiceHandle (sh);
   if (sm)
     CloseServiceHandle (sm);
+  if (qsc_buf)
+    free (qsc_buf);
   return err == 0 ? 0 : error (QueryErr, err_func, err);
 }
 
+/* Iterates through all services and reports on 
+   those that are cygrunsrv-managed.  */
+int
+list_services (bool verbose)
+{
+  char mypath[MAX_PATH];
+  SC_HANDLE sm = (SC_HANDLE) 0;
+  SC_HANDLE sh = (SC_HANDLE) 0;
+  ENUM_SERVICE_STATUS *srv_buf = NULL;
+  QUERY_SERVICE_CONFIG *qsc_buf = NULL;
+  SERVICE_STATUS ss;
+  DWORD bytes_needed, num_services, resume_handle = 0;
+  char *err_func;
+  DWORD err = 0;
+
+  /* Get our own filename so that we can tell which services are ours.  */
+  if (!GetModuleFileName (NULL, mypath, MAX_PATH))
+    err_out (GetModuleFileName);
+  
+  /* This buffer will be used for querying the details of a service.  */
+  if ((qsc_buf = (QUERY_SERVICE_CONFIG *) malloc (QSC_BUF_SIZE)) == NULL)
+    err_out_set_error (malloc, ERROR_OUTOFMEMORY);
+    
+  /* Open service manager database.  */
+  if (!(sm = OpenSCManager (NULL, NULL, SC_MANAGER_CONNECT | 
+                                        SC_MANAGER_ENUMERATE_SERVICE)))
+    err_out (OpenSCManager);
+
+  /* First call with lpServices to NULL to get length of needed buffer.  */
+  if (EnumServicesStatus (sm, SERVICE_WIN32, SERVICE_STATE_ALL, NULL, 0,
+                          &bytes_needed, &num_services, &resume_handle) != 0)
+    err_out (EnumServiceStatus);
+    
+  if ((srv_buf = (ENUM_SERVICE_STATUS *) malloc (bytes_needed)) == NULL) 
+    err_out_set_error (malloc, ERROR_OUTOFMEMORY);
+
+  /* Call the function for real this time with the allocated buffer.
+     FIXME: In theory this should be a while loop that checks for ERROR_MORE_DATA
+     and continues fetching the remaining records.  However, we'll just trust
+     that the value returned above in bytes_needed was sufficient to get all
+     records in a single pass.  */
+  if (!EnumServicesStatus (sm, SERVICE_WIN32, SERVICE_STATE_ALL, srv_buf, 
+                  bytes_needed, &bytes_needed, &num_services, &resume_handle))
+    err_out (EnumServiceStatus);
+
+  for (int i = 0; i < num_services; i++)
+    {
+      /* get details of this service and see if it's one of ours.  */
+      if (!(sh = OpenService (sm, srv_buf[i].lpServiceName, GENERIC_READ)))
+        err_out (OpenService);
+      
+      if (!QueryServiceConfig (sh, qsc_buf, QSC_BUF_SIZE, &bytes_needed))
+        err_out (QueryServiceConfig);
+      
+      if (!stricmp (qsc_buf->lpBinaryPathName, mypath))  /* this us?  */
+        {          
+          if (!verbose)
+            {
+              /* add quotes if spaces present to make shell scripting easier */
+              if (strchr (srv_buf[i].lpServiceName, ' '))
+                printf ("\"%s\" ", srv_buf[i].lpServiceName);
+              else
+                printf ("%s ", srv_buf[i].lpServiceName);
+            }
+          else
+            {
+              if (!QueryServiceStatus(sh, &ss))
+                err_out (QueryServiceStatus);
+
+              print_service (srv_buf[i].lpServiceName, sh, ss, qsc_buf, verbose);
+            }
+        }
+      CloseServiceHandle (sh);
+    }
+
+  fputc ('\n', stdout);  
+  err = 0;
+
+out:
+  if (qsc_buf)
+    free (qsc_buf);
+  if (srv_buf)
+    free (srv_buf);
+  if (sh)
+    CloseServiceHandle (sh);
+  if (sm)
+    CloseServiceHandle (sm);
+  return err == 0 ? 0 : error (ListErr, err_func, err);
+}
 
 #undef err_out
+#undef err_out_set_error
 
 int server_pid;
 
@@ -1338,6 +1587,7 @@ main (int argc, char **argv)
   int in_shutdown = 0;
   int in_interactive = 0;
   int in_showcons = 0;
+  bool verbose = false;
 
   appname = argv[0];
 
@@ -1391,6 +1641,11 @@ main (int argc, char **argv)
 	action = Query;
 	in_name = optarg;
 	break;
+      case 'L':
+      	if (action != Undefined) 
+	  return error (ReqAction);
+	action = List;
+	break;
       case 'p':
 	if (action != Install)
 	  return error (PathNotAllowed);
@@ -1530,6 +1785,9 @@ main (int argc, char **argv)
 	  return error (OnlyOneIO);
 	in_stderr = optarg;
 	break;
+      case 'V':
+        verbose = true;
+        break;
       case 'h':
 	return usage ();
       case 'v':
@@ -1573,7 +1831,10 @@ main (int argc, char **argv)
       return stop_service (in_name);
       break;
     case Query:
-      return query_service (in_name);
+      return query_service (in_name, verbose);
+      break;
+    case List:
+      return list_services (verbose);
       break;
     }
   return error (ReqAction);
--- /tmp/cygrunsrv-1.02-1/utils.cc	2004-04-07 07:06:05.000000000 -0700
+++ ./utils.cc	2005-05-19 10:55:41.609375000 -0700
@@ -32,7 +32,7 @@
 
 char *reason_list[] = {
   "",
-  "Exactly one of --install, --remove, --start or --stop is required",
+  "Exactly one of --install, --remove, --start, --stop, --query, or --list is required",
   "--path is required with --install",
   "Given path doesn't point to a valid executable",
   "--path is only allowed with --install",
@@ -75,6 +75,7 @@ char *reason_list[] = {
   "Error starting a service",
   "Error stopping a service",
   "Error querying a service",
+  "Error enumerating services",
   NULL
 };
 
@@ -135,6 +136,8 @@ usage ()
   uprint ("  -S, --start <svc_name>    Starts a service named <svc_name>.");
   uprint ("  -E, --stop <svc_name>     Stops a service named <svc_name>.");
   uprint ("  -Q, --query <svc_name>    Queries a service named <svc_name>.");
+  uprint ("  -L, --list                Lists services that have been installed");
+  uprint ("                            with cygrunsrv.");
   uprint ("\nRequired install options:");
   uprint ("  -p, --path <app_path>     Application path which is run as a service.");
   uprint ("\nMiscellaneous install options:");
@@ -180,6 +183,8 @@ usage ()
   uprint ("  -j, --nohide              Don't hide console window when service interacts");
   uprint ("                            with desktop.");
   uprint ("\nInformative output:");
+  uprint ("  -V, --verbose             When used with --query or --list, causes extra");
+  uprint ("                            information to be printed.");
   uprint ("  -h, --help                print this help, then exit.");
   uprint ("  -v, --version             print cygrunsrv program version number, then exit.");
   uprint ("\nReport bugs to <cygwin@cygwin.com>.");
--- /tmp/cygrunsrv-1.02-1/utils.h	2004-04-07 07:06:05.000000000 -0700
+++ ./utils.h	2005-05-19 10:56:49.750000000 -0700
@@ -66,6 +66,7 @@ enum reason_t {
   StartErr,
   StopErr,
   QueryErr,
+  ListErr,
   MaxReason		/* Always the last element */
 };
 


--------------DC433C7F0EE7215671D3E4E0--
