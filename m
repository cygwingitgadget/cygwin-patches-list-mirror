Return-Path: <cygwin-patches-return-2352-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1592 invoked by alias); 7 Jun 2002 01:07:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1578 invoked from network); 7 Jun 2002 01:07:46 -0000
Message-ID: <032201c20dbf$f27da3b0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: Add new -T|--toggle option to strace
Date: Thu, 06 Jun 2002 18:07:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_031F_01C20DC8.53E03CA0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00335.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_031F_01C20DC8.53E03CA0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1275

As per a discussion yesterday with Chris, I've added a new option to
strace, -T or --toggle, to toggle tracing in a process already being
straced.

One other change I made was to replace a use of ExitProcess() with
exit() --- otherwise some error messages didn't appear since the stdio
buffers weren't being flushed.

I've also updated the section for strace in utils.sgml. I know that Joshua
has been holding off on changing utils.sgml (see
http://sources.redhat.com/ml/cygwin-patches/2002-q2/msg00276.html) so I
don't know whether you want this update or not. It's not much more than a
cut and paste from the usage message in strace.cc.

ChangeLog appended here and attached (to keep its format out of Outlook's
clutches).

// Conrad

2002-06-07  Conrad Scott  <conrad.scott@dsl.pipex.com>

 * strace.cc (toggle): New global variable.
 (error): Use exit instead of ExitProcess so that stdio buffers get
 flushed.
 (create_child): Remove command line error checking.
 (dostrace): Ditto.
 (dotoggle): New function.
 (usage): Add entry for new option -T|--toggle. Alphabetize.
 (longopts): Add new option -T|--toggle.
 (opts): Ditto.
 (main): Handle new -T|--toggle option. Move all command line checking
 here from other functions.
 * utils.sgml: Update section for strace.


------=_NextPart_000_031F_01C20DC8.53E03CA0
Content-Type: application/octet-stream;
	name="strace.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="strace.patch"
Content-length: 6119

Index: strace.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/utils/strace.cc,v=0A=
retrieving revision 1.22=0A=
diff -u -r1.22 strace.cc=0A=
--- strace.cc	6 Jun 2002 02:55:10 -0000	1.22=0A=
+++ strace.cc	7 Jun 2002 00:50:44 -0000=0A=
@@ -43,6 +43,7 @@=0A=
 static int usecs =3D 1;=0A=
 static int delta =3D 1;=0A=
 static int hhmmss =3D 0;=0A=
+static int toggle =3D 0;=0A=
 static int bufsize =3D 0;=0A=
 static int new_window =3D 0;=0A=
 static long flush_period =3D 0;=0A=
@@ -102,7 +103,7 @@=0A=
       fputs (buf, stderr);=0A=
       fputs ("\n", stderr);=0A=
     }=0A=
-  ExitProcess (1);=0A=
+  exit (1);=0A=
 }=0A=
=20=0A=
 DWORD lastid =3D 0;=0A=
@@ -309,9 +310,6 @@=0A=
   BOOL ret;=0A=
   DWORD flags;=0A=
=20=0A=
-  if (!*argv)=0A=
-    error (0, "no program argument specified");=0A=
-=0A=
   memset (&si, 0, sizeof (si));=0A=
   si.cb =3D sizeof (si);=0A=
=20=0A=
@@ -650,10 +648,24 @@=0A=
 }=0A=
=20=0A=
 static void=0A=
+dotoggle (pid_t pid)=0A=
+{=0A=
+  load_cygwin ();=0A=
+  child_pid =3D (DWORD) cygwin_internal (CW_CYGWIN_PID_TO_WINPID, pid);=0A=
+  if (!child_pid)=0A=
+    {=0A=
+      warn (0, "no such cygwin pid - %d", pid);=0A=
+      child_pid =3D pid;=0A=
+    }=0A=
+  if (cygwin_internal (CW_STRACE_TOGGLE, child_pid))=0A=
+    error (0, "failed to toggle tracing for process %d<%d>", pid, child_pi=
d);=0A=
+=0A=
+  return;=0A=
+}=0A=
+=0A=
+static void=0A=
 dostrace (unsigned mask, FILE *ofile, pid_t pid, char **argv)=0A=
 {=0A=
-  if (*argv && pid)=0A=
-    error (0, "can't use -p with program argument");=0A=
   if (!pid)=0A=
     create_child (argv);=0A=
   else=0A=
@@ -786,21 +798,24 @@=0A=
 {=0A=
   fprintf (where, "\=0A=
 Usage: %s [OPTIONS] <command-line>\n\=0A=
+Usage: %s [OPTIONS] -p <pid>\n\=0A=
   -b, --buffer-size=3DSIZE       set size of output file buffer\n\=0A=
   -d, --no-delta               don't display the delta-t microsecond times=
tamp\n\=0A=
   -f, --trace-children         trace child processes (toggle - default tru=
e)\n\=0A=
   -h, --help                   output usage information and exit\n\=0A=
   -m, --mask=3DMASK              set message filter mask\n\=0A=
-  -o, --output=3DFILENAME        set output file to FILENAME\n\=0A=
-  -p, --pid=3Dn                  attach to executing program with cygwin p=
id n\n\=0A=
   -n, --crack-error-numbers    output descriptive text instead of error\n\=
=0A=
                                numbers for Windows errors\n\=0A=
+  -o, --output=3DFILENAME        set output file to FILENAME\n\=0A=
+  -p, --pid=3Dn                  attach to executing program with cygwin p=
id n\n\=0A=
   -S, --flush-period=3DPERIOD    flush buffered strace output every PERIOD=
 secs\n\=0A=
   -t, --timestamp              use an absolute hh:mm:ss timestamp insted o=
f \n\=0A=
                                the default microsecond timestamp.  Implies=
 -d\n\=0A=
+  -T, --toggle                 toggle tracing in a process already being\n=
\=0A=
+                               traced. Requires -p <pid>\n\=0A=
   -v, --version                output version information and exit\n\=0A=
   -w, --new-window             spawn program under test in a new window\n\=
=0A=
-\n", pgm);=0A=
+\n", pgm, pgm);=0A=
   if ( where =3D=3D stdout)=0A=
     fprintf (stdout, "\=0A=
     MASK can be any combination of the following mnemonics and/or hex valu=
es\n\=0A=
@@ -844,6 +859,7 @@=0A=
   {"no-delta", no_argument, NULL, 'd'},=0A=
   {"pid", required_argument, NULL, 'p'},=0A=
   {"timestamp", no_argument, NULL, 't'},=0A=
+  {"toggle", no_argument, NULL, 'T'},=0A=
   {"trace-children", no_argument, NULL, 'f'},=0A=
   {"translate-error-numbers", no_argument, NULL, 'n'},=0A=
   {"usecs", no_argument, NULL, 'u'},=0A=
@@ -851,7 +867,7 @@=0A=
   {NULL, 0, NULL, 0}=0A=
 };=0A=
=20=0A=
-static const char *const opts =3D "b:dhfm:no:p:S:tuvw";=0A=
+static const char *const opts =3D "b:dhfm:no:p:S:tTuvw";=0A=
=20=0A=
 static void=0A=
 print_version ()=0A=
@@ -880,7 +896,7 @@=0A=
 {=0A=
   unsigned mask =3D 0;=0A=
   FILE *ofile =3D NULL;=0A=
-  pid_t attach_pid =3D 0;=0A=
+  pid_t pid =3D 0;=0A=
   int opt;=0A=
=20=0A=
   if (!(pgm =3D strrchr (*argv, '\\')) && !(pgm =3D strrchr (*argv, '/')))=
=0A=
@@ -914,7 +930,7 @@=0A=
 	      error (0, "syntax error in mask expression \"%s\" near \=0A=
 character #%d.\n", optarg, (int) (endptr - optarg), endptr);=0A=
 	    }=0A=
-	break;=0A=
+	  break;=0A=
 	}=0A=
       case 'n':=0A=
 	numerror ^=3D 1;=0A=
@@ -927,7 +943,7 @@=0A=
 #endif=0A=
 	break;=0A=
       case 'p':=0A=
-	attach_pid =3D strtol (optarg, NULL, 10);=0A=
+	pid =3D strtol (optarg, NULL, 10);=0A=
 	break;=0A=
       case 'S':=0A=
 	flush_period =3D strtol (optarg, NULL, 10);=0A=
@@ -935,6 +951,9 @@=0A=
       case 't':=0A=
 	hhmmss ^=3D 1;=0A=
 	break;=0A=
+      case 'T':=0A=
+	toggle ^=3D 1;=0A=
+	break;=0A=
       case 'u':=0A=
 	// FIXME: currently unimplemented=0A=
 	usecs ^=3D 1;=0A=
@@ -943,14 +962,22 @@=0A=
 	// Print version info and exit=0A=
 	print_version ();=0A=
 	return 0;=0A=
-	break;=0A=
       case 'w':=0A=
 	new_window ^=3D 1;=0A=
 	break;=0A=
+      case '?':=0A=
+	fprintf (stderr, "Try '%s --help' for more information.\n", pgm);=0A=
+	exit (1);=0A=
       }=0A=
=20=0A=
-  if ( argv[optind] =3D=3D NULL)=0A=
-    usage ();=0A=
+  if (pid && argv[optind])=0A=
+    error (0, "cannot provide both a command line and a process id");=0A=
+=0A=
+  if (!pid && !argv[optind])=0A=
+    error (0, "must provide either a command line or a process id");=0A=
+=0A=
+  if (toggle && !pid)=0A=
+    error (0, "must provide a process id to toggle tracing");=0A=
=20=0A=
   if (!mask)=0A=
     mask =3D 1;=0A=
@@ -961,7 +988,10 @@=0A=
   if (!ofile)=0A=
     ofile =3D stdout;=0A=
=20=0A=
-  dostrace (mask, ofile, attach_pid, argv + optind);=0A=
+  if (toggle)=0A=
+    dotoggle (pid);=0A=
+  else=0A=
+    dostrace (mask, ofile, pid, argv + optind);=0A=
 }=0A=
=20=0A=
 #undef CloseHandle=0A=

------=_NextPart_000_031F_01C20DC8.53E03CA0
Content-Type: application/octet-stream;
	name="utils.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="utils.patch"
Content-length: 2408

Index: utils.sgml=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/utils/utils.sgml,v=0A=
retrieving revision 1.22=0A=
diff -u -r1.22 utils.sgml=0A=
--- utils.sgml	2 Jun 2002 17:46:38 -0000	1.22=0A=
+++ utils.sgml	7 Jun 2002 00:50:44 -0000=0A=
@@ -641,21 +641,23 @@=0A=
 <sect2 id=3D"strace"><title>strace</title>=0A=
=20=0A=
 <screen>=0A=
-Usage strace [options] program [args...]=0A=
-=0A=
+Usage: strace [OPTIONS] <command-line>=0A=
+Usage: strace [OPTIONS] -p <pid>=0A=
   -b, --buffer-size=3DSIZE       set size of output file buffer=0A=
   -d, --no-delta               don't display the delta-t microsecond times=
tamp=0A=
-  -f, --trace-children         trace child processes (toggle -- default is=
 "true")=0A=
-  -h, --help                   display help info=0A=
+  -f, --trace-children         trace child processes (toggle - default tru=
e)=0A=
+  -h, --help                   output usage information and exit=0A=
   -m, --mask=3DMASK              set message filter mask=0A=
   -n, --crack-error-numbers    output descriptive text instead of error=0A=
                                numbers for Windows errors=0A=
   -o, --output=3DFILENAME        set output file to FILENAME=0A=
-  -p, --pid=3Dpid                attach to a running process=0A=
+  -p, --pid=3Dn                  attach to executing program with cygwin p=
id n=0A=
   -S, --flush-period=3DPERIOD    flush buffered strace output every PERIOD=
 secs=0A=
-  -t, --timestamp              use an absolute hh:mm:ss timestamp insted o=
f the=0A=
-                               default microsecond timestamp.  Implies -d=
=0A=
-  -v, --version                display version info=0A=
+  -t, --timestamp              use an absolute hh:mm:ss timestamp insted o=
f=20=0A=
+                               the default microsecond timestamp.  Implies=
 -d=0A=
+  -T, --toggle                 toggle tracing in a process already being=
=0A=
+                               traced. Requires -p <pid>=0A=
+  -v, --version                output version information and exit=0A=
   -w, --new-window             spawn program under test in a new window=0A=
=20=0A=
     MASK can be any combination of the following mnemonics and/or hex valu=
es=0A=

------=_NextPart_000_031F_01C20DC8.53E03CA0
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 537

2002-06-07  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* strace.cc (toggle): New global variable.
	(error): Use exit instead of ExitProcess so that stdio buffers get
	flushed.
	(create_child): Remove command line error checking.
	(dostrace): Ditto.
	(dotoggle): New function.
	(usage): Add entry for new option -T|--toggle. Alphabetize.
	(longopts): Add new option -T|--toggle.
	(opts): Ditto.
	(main): Handle new -T|--toggle option. Move all command line checking
	here from other functions.
	* utils.sgml: Update section for strace.

------=_NextPart_000_031F_01C20DC8.53E03CA0--

