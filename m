Return-Path: <cygwin-patches-return-1965-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28062 invoked by alias); 11 Mar 2002 02:04:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28008 invoked from network); 11 Mar 2002 02:04:19 -0000
Message-ID: <20020311020418.6676.qmail@web20002.mail.yahoo.com>
Date: Sun, 10 Mar 2002 18:54:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: big kill patch (adds list/help/version)
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-964740161-1015812258=:5905"
X-SW-Source: 2002-q1/txt/msg00322.txt.bz2

--0-964740161-1015812258=:5905
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 1777

As a result of the 'kill -sigN' functionality, kill does not use
GNU getopt to process options, so this patch required quite a few
changes. While ./kill.exe works the same as /bin/kill for me, as
usual I'm not saying it has any MERCHANTABILITY or FITNESS FOR A 
PARTICULAR PURPOSE. Send me test cases and I will test if you desire.

I also made two "unecessary" changes, which I like to think of as
improvements. First, I removed the goto statement and moved the 
code into a new function called sig0 (the label from the goto). This
and all the other functions now appear above main (). I thought a 
goto was absolutely necessary (even though I haven't needed one since 
VAX assembly), until I read:

Edsger W. Dijkstra "Go To Statement Considered Harmful"
http://www.acm.org/classics/oct95/

No code was harmed in this move. In fact, being lazy I left all the
variable names the same.
Second, there is now a -l, --list option that will list signal numbers
and a *description* of the signal such as:

24: CPU time limit exceeded

I would like to add the symbolic names like XCPU, HUP, etc. to the list 
option, but I don't know of a dynamic way to do so. Is there something like
strsignal for this, or would it have to be hard-coded?

2002-03-10  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
* kill.cc (sig0) New function. Process signals given on command line.
          (usage) Generalize to allow use for help. Describe options.
          (list_signals) New fucntion.
          (print_version) New function. 
          (main) Accomodate new options. Add long options for each. 
           Move goto functionality to sig0.


__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
--0-964740161-1015812258=:5905
Content-Type: text/plain; name="kill.cc-patch"
Content-Description: kill.cc-patch
Content-Disposition: inline; filename="kill.cc-patch"
Content-length: 5578

--- kill.cc-orig	Sun Feb 24 13:28:27 2002
+++ kill.cc	Sun Mar 10 19:55:13 2002
@@ -1,6 +1,6 @@
 /* kill.cc
 
-   Copyright 1996, 1997, 1998, 1999, 2000, 2001 Red Hat, Inc.
+   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -17,52 +17,52 @@ details. */
 #include <windows.h>
 #include <sys/cygwin.h>
 
-static void usage (void);
-static int __stdcall getsig (char *);
-static void __stdcall forcekill (int, int, int);
+static const char version[] = "$Revision: 1.10 $";
+static char *prog_name;
 
-int
-main (int argc, char **argv)
+static void __stdcall
+forcekill (int pid, int sig, int wait)
 {
-  int sig = SIGTERM;
-  int force = 0;
-  int gotsig = 0;
-  int ret = 0;
-
-  if (argc == 1)
-    usage ();
+  external_pinfo *p =
+    (external_pinfo *) cygwin_internal (CW_GETPINFO_FULL, pid);
+  if (!p)
+    return;
+  HANDLE h = OpenProcess (PROCESS_TERMINATE, FALSE, (DWORD) p->dwProcessId);
+  if (!h)
+    return;
+  if (!wait || WaitForSingleObject (h, 200) != WAIT_OBJECT_0)
+    TerminateProcess (h, sig << 8);
+  CloseHandle (h);
+}
 
-  while (*++argv && **argv == '-')
-    if (strcmp (*argv + 1, "f") == 0)
-      force = 1;
-    else if (gotsig)
-      break;
-    else if (strcmp(*argv + 1, "0") != 0)
-      {
-	sig = getsig (*argv + 1);
-	gotsig = 1;
-      }
-    else
-      {
-	argv++;
-	sig = 0;
-	goto sig0;
-      }
+static int
+getsig (char *in_sig)
+{
+  char *sig;
+  char buf[80];
 
-  if (sig <= 0 || sig > NSIG)
+  if (strncmp (in_sig, "SIG", 3) == 0)
+    sig = in_sig;
+  else
     {
-      fprintf (stderr, "kill: unknown signal: %s\n", argv[-1]);
-      exit (1);
+      sprintf (buf, "SIG%s", in_sig);
+      sig = buf;
     }
+  return (strtosigno (sig) ? : atoi (in_sig));
+}
+
+int
+sig0 (char **argv, int sig, int force)
+{
+  int ret = 0;
 
-sig0:
   while (*argv != NULL)
     {
       char *p;
       int pid = strtol (*argv, &p, 10);
       if (*p != '\0')
 	{
-	  fprintf (stderr, "kill: illegal pid: %s\n", *argv);
+	  fprintf (stderr, "%s: illegal pid: %s\n", prog_name, *argv);
 	  ret = 1;
 	}
       else if (kill (pid, sig) == 0)
@@ -85,38 +85,139 @@ sig0:
 }
 
 static void
-usage (void)
+usage (FILE * stream, int status)
 {
-  fprintf (stderr, "Usage: kill [-sigN] pid1 [pid2 ...]\n");
-  exit (1);
+  fprintf (stream, "\
+Usage: %s [ [-f] -sigN] pid1 [pid2 ...]\n\
+ -f, --force     force kill, use win32 interface if necessary\n\
+ -sigN           send signal N (see sys/signal.h for names)\n\
+ -l, --list      list signal numbers, what each signifies and exit\n\
+ -h, --help      output usage information and exit\n\
+ -v, --version   output version information and exit\n\
+", prog_name);
+  exit (status);
 }
 
-static int
-getsig (char *in_sig)
+static void
+list_signals ()
 {
-  char *sig;
-  char buf[80];
+  int sig;
+  for (sig = 0; sig < NSIG; sig++)
+    printf ("%d: %s\n", sig, strsignal (sig));
+}
 
-  if (strncmp (in_sig, "SIG", 3) == 0)
-    sig = in_sig;
+static void
+print_version ()
+{
+  const char *v = strchr (version, ':');
+  int len;
+  if (!v)
+    {
+      v = "?";
+      len = 1;
+    }
   else
     {
-      sprintf (buf, "SIG%s", in_sig);
-      sig = buf;
+      v += 2;
+      len = strchr (v, ' ') - v;
     }
-  return (strtosigno (sig) ?: atoi (in_sig));
+  printf ("\
+kill (cygwin) %.*s\n\
+Process Signaler \n\
+Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.\n\
+Compiled on %s", len, v, __DATE__);
 }
 
-static void __stdcall
-forcekill (int pid, int sig, int wait)
+int
+main (int argc, char **argv)
 {
-  external_pinfo *p = (external_pinfo *) cygwin_internal (CW_GETPINFO_FULL, pid);
-  if (!p)
-    return;
-  HANDLE h = OpenProcess (PROCESS_TERMINATE, FALSE, (DWORD) p->dwProcessId);
-  if (!h)
-    return;
-  if (!wait || WaitForSingleObject (h, 200) != WAIT_OBJECT_0)
-    TerminateProcess (h, sig << 8);
-  CloseHandle (h);
+  int sig = SIGTERM;
+  int force = 0;
+  int gotsig = 0;
+  int ret = 0;
+  int opt;
+  char *longopt;
+
+  prog_name = strrchr (argv[0], '/');
+  if (prog_name == NULL)
+    prog_name = strrchr (argv[0], '\\');
+  if (prog_name == NULL)
+    prog_name = argv[0];
+  else
+    prog_name++;
+
+  if (argc == 1)
+    usage (stderr, 1);
+
+  while (*++argv && **argv == '-')
+    {
+      opt = *(*argv + 1);
+      if (!gotsig)
+	switch (opt)
+	  {
+	  case 'f':
+	    force = 1;
+	    break;
+
+	  case 'h':
+	    usage (stdout, 0);
+
+	  case 'l':
+	    list_signals ();
+	    exit (0);
+
+	  case 'v':
+	    print_version ();
+	    exit (0);
+
+	  case '0':
+	    argv++;
+	    sig = 0;
+	    ret = sig0 (argv, sig, force);
+	    return ret;
+
+          /* Handle long options */
+	  case '-':
+	    longopt = *argv + 2;
+	    if (strcmp (longopt, "force") == 0)
+	      force = 1;
+	    else if (strcmp (longopt, "help") == 0)
+	      usage (stdout, 0);
+	    else if (strcmp (longopt, "list") == 0)
+	      {
+		list_signals ();
+		exit (0);
+	      }
+	    else if (strcmp (longopt, "version") == 0)
+	      {
+		print_version ();
+		exit (0);
+	      }
+	    else
+	      {
+		fprintf (stderr, "%s: unknown long option: --%s\n\n",
+			 prog_name, longopt);
+		usage (stderr, 1);
+	      }
+	    *argv += strlen (longopt);
+	    break;
+          /* End of long options */
+
+	  default:
+	    sig = getsig (*argv + 1);
+	    gotsig = 1;
+	  }
+      else
+	break;
+    }
+
+  if (sig <= 0 || sig > NSIG)
+    {
+      fprintf (stderr, "%s: unknown signal: %s\n", prog_name, argv[-1]);
+      exit (1);
+    }
+
+  ret = sig0 (argv, sig, force);
+  return ret;
+
 }

--0-964740161-1015812258=:5905--
