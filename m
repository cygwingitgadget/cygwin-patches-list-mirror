Return-Path: <cygwin-patches-return-1500-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 19528 invoked by alias); 15 Nov 2001 13:24:14 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 19514 invoked from network); 15 Nov 2001 13:24:13 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: [PATCH] Mask mnemonics and expressions, help, version, getopts_long() for strace
Date: Sat, 13 Oct 2001 00:24:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKMEFPCHAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0004_01C16DA6.85F9BDA0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-SW-Source: 2001-q4/txt/msg00032.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0004_01C16DA6.85F9BDA0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 759

12th time's the charm;-)!:

2001-11-15  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>

	* strace.cc (main): Change getopt() to getopt_long().
	Add support for help and version info.
	Use new parse_mask() function for -m/--mask option.
	(longopts): Add long options structure.
	(opts): Move options string from getopts call to static var.
	(usage): Print usage information.
	(SCCSid): Version info.
	(version): New function for displaying version info.
	(parse_mask): New function supporting parsing of mnemonics,
	hex, and basic expressions in masks.
	(mnemonic2ul): New mnemonic parsing function.
	(tag_mask_mnemonic): New type.
	(mnemonic_table): New table of mnemonics for mnemonic2ul() to
	search through.

-- 
Gary R. Van Sickle
Brewer.  Patriot. 
------=_NextPart_000_0004_01C16DA6.85F9BDA0
Content-Type: application/octet-stream;
	name="strace.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="strace.cc-patch"
Content-length: 9536

Index: strace.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/utils/strace.cc,v=0A=
retrieving revision 1.12=0A=
diff -p -u -b -r1.12 strace.cc=0A=
--- strace.cc	2001/11/04 12:57:55	1.12=0A=
+++ strace.cc	2001/11/15 13:17:25=0A=
@@ -30,6 +30,9 @@ int _impure_ptr;=0A=
 /* we *know* we're being built with GCC */=0A=
 #define alloca __builtin_alloca=0A=
=20=0A=
+// Version string.=0A=
+static char *SCCSid =3D "@(#)strace V1.0, Copyright (C) 2001 Red Hat Inc.,=
 " __DATE__ "\n";=0A=
+=0A=
 static const char *pgm;=0A=
 static int forkdebug =3D 0;=0A=
 static int numerror =3D 1;=0A=
@@ -602,6 +605,196 @@ dostrace (unsigned mask, FILE *ofile, ch=0A=
   return;=0A=
 }=0A=
=20=0A=
+typedef struct tag_mask_mnemonic=0A=
+{=0A=
+  unsigned long val;=0A=
+  const char *text;=0A=
+}=0A=
+mask_mnemonic;=0A=
+=0A=
+static const mask_mnemonic mnemonic_table[] =3D {=0A=
+  {_STRACE_ALL, "all"},=0A=
+  {_STRACE_FLUSH, "flush"},=0A=
+  {_STRACE_INHERIT, "inherit"},=0A=
+  {_STRACE_UHOH, "uhoh"},=0A=
+  {_STRACE_SYSCALL, "syscall"},=0A=
+  {_STRACE_STARTUP, "startup"},=0A=
+  {_STRACE_DEBUG, "debug"},=0A=
+  {_STRACE_PARANOID, "paranoid"},=0A=
+  {_STRACE_TERMIOS, "termios"},=0A=
+  {_STRACE_SELECT, "select"},=0A=
+  {_STRACE_WM, "wm"},=0A=
+  {_STRACE_SIGP, "sigp"},=0A=
+  {_STRACE_MINIMAL, "minimal"},=0A=
+  {_STRACE_EXITDUMP, "exitdump"},=0A=
+  {_STRACE_SYSTEM, "system"},=0A=
+  {_STRACE_NOMUTEX, "nomutex"},=0A=
+  {_STRACE_MALLOC, "malloc"},=0A=
+  {_STRACE_THREAD, "thread"},=0A=
+  {0, NULL}=0A=
+};=0A=
+=0A=
+static unsigned long=0A=
+mnemonic2ul (const char *nptr, char **endptr)=0A=
+{=0A=
+  // Look up mnemonic in table, return value.=0A=
+  // *endptr =3D ptr to char that breaks match.=0A=
+  const mask_mnemonic *mnp =3D mnemonic_table;=0A=
+=0A=
+  while (mnp->text !=3D NULL)=0A=
+    {=0A=
+      if (strcmp (mnp->text, nptr) =3D=3D 0)=0A=
+	{=0A=
+	  // Found a match.=0A=
+	  if (endptr !=3D NULL)=0A=
+	    {=0A=
+	      *endptr =3D ((char *) nptr) + strlen (mnp->text);=0A=
+	    }=0A=
+	  return mnp->val;=0A=
+	}=0A=
+      mnp++;=0A=
+    }=0A=
+=0A=
+  // Didn't find it.=0A=
+  if (endptr !=3D NULL)=0A=
+    {=0A=
+      *endptr =3D (char *) nptr;=0A=
+    }=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+static unsigned long=0A=
+parse_mask (const char *ms, char **endptr)=0A=
+{=0A=
+  const char *p =3D ms;=0A=
+  char *newp;=0A=
+  unsigned long retval =3D 0, thisval;=0A=
+  const size_t bufsize =3D 16;=0A=
+  char buffer[bufsize];=0A=
+  size_t len;=0A=
+=0A=
+  while (*p !=3D '\0')=0A=
+    {=0A=
+      // First extract the term, terminate it, and lowercase it.=0A=
+      strncpy (buffer, p, bufsize);=0A=
+      buffer[bufsize - 1] =3D '\0';=0A=
+      len =3D strcspn (buffer, "+,\0");=0A=
+      buffer[len] =3D '\0';=0A=
+      strlwr (buffer);=0A=
+=0A=
+      // Check if this is a mnemonic.  We have to do this first or strtoul=
()=0A=
+      // will false-trigger on anything starting with "a" through "f".=0A=
+      thisval =3D mnemonic2ul (buffer, &newp);=0A=
+      if (buffer =3D=3D newp)=0A=
+	{=0A=
+	  // This term isn't mnemonic, check if it's hex.=0A=
+	  thisval =3D strtoul (buffer, &newp, 16);=0A=
+	  if (newp !=3D buffer + len)=0A=
+	    {=0A=
+	      // Not hex either, syntax error.=0A=
+	      *endptr =3D (char *) p;=0A=
+	      return 0;=0A=
+	    }=0A=
+	}=0A=
+=0A=
+      p +=3D len;=0A=
+      retval +=3D thisval;=0A=
+=0A=
+      // Handle operators=0A=
+      if (*p =3D=3D '\0')=0A=
+	break;=0A=
+      if ((*p =3D=3D '+') || (*p =3D=3D ','))=0A=
+	{=0A=
+	  // For now these both equate to addition/ORing.  Until we get=0A=
+	  // fancy and add things like "all-<something>", all we need do is=0A=
+	  // continue the looping.=0A=
+	  p++;=0A=
+	  continue;=0A=
+	}=0A=
+      else=0A=
+	{=0A=
+	  // Syntax error=0A=
+	  *endptr =3D (char *) p;=0A=
+	  return 0;=0A=
+	}=0A=
+    }=0A=
+=0A=
+  *endptr =3D (char *) p;=0A=
+  return retval;=0A=
+}=0A=
+=0A=
+static void=0A=
+usage ()=0A=
+{=0A=
+  fprintf (stderr, "\=0A=
+Usage: strace [OPTIONS] <command-line>\n\=0A=
+  -b, --buffer-size=3DSIZE       Set size of output file buffer.\n\=0A=
+  -m, --mask=3DMASK              Set message filter mask.\n\=0A=
+\n\=0A=
+    MASK can be any combination of the following mnemonics and/or hex valu=
es\n\=0A=
+    (0x is optional).  Combine masks with '+' or ',' like so:\n\=0A=
+\n\=0A=
+                      --mask=3Dwm+system,malloc+0x00800\n\=0A=
+\n\=0A=
+    Mnemonic Hex     Corresponding Def  Description\n\=0A=
+    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
\n\=0A=
+    all      0x00001 (_STRACE_ALL)      All strace messages.\n\=0A=
+    flush    0x00002 (_STRACE_FLUSH)    Flush output buffer after each mes=
sage.\n\=0A=
+    inherit  0x00004 (_STRACE_INHERIT)  Children inherit mask from parent.=
\n\=0A=
+    uhoh     0x00008 (_STRACE_UHOH)     Unusual or weird phenomenon.\n\=0A=
+    syscall  0x00010 (_STRACE_SYSCALL)  System calls.\n\=0A=
+    startup  0x00020 (_STRACE_STARTUP)  argc/envp printout at startup.\n\=
=0A=
+    debug    0x00040 (_STRACE_DEBUG)    Info to help debugging. \n\=0A=
+    paranoid 0x00080 (_STRACE_PARANOID) Paranoid info.\n\=0A=
+    termios  0x00100 (_STRACE_TERMIOS)  Info for debugging termios stuff.\=
n\=0A=
+    select   0x00200 (_STRACE_SELECT)   Info on ugly select internals.\n\=
=0A=
+    wm       0x00400 (_STRACE_WM)       Trace Windows msgs (enable _strace=
_wm).\n\=0A=
+    sigp     0x00800 (_STRACE_SIGP)     Trace signal and process handling.=
\n\=0A=
+    minimal  0x01000 (_STRACE_MINIMAL)  Very minimal strace output.\n\=0A=
+    exitdump 0x04000 (_STRACE_EXITDUMP) Dump strace cache on exit.\n\=0A=
+    system   0x08000 (_STRACE_SYSTEM)   Cache strace messages.\n\=0A=
+    nomutex  0x10000 (_STRACE_NOMUTEX)  Don't use mutex for synchronizatio=
n.\n\=0A=
+    malloc   0x20000 (_STRACE_MALLOC)   Trace malloc calls.\n\=0A=
+    thread   0x40000 (_STRACE_THREAD)   Thread-locking calls.\n\=0A=
+\n\=0A=
+  -o, --output=3DFILENAME        Set output file to FILENAME.\n\=0A=
+  -f, --trace-children         Also trace forked child processes.\n\=0A=
+  -n, --crack-error-numbers    Output descriptive text instead of error\n\=
=0A=
+                                 numbers for Windows errors.\n\=0A=
+  -d, --no-delta               Don't display the delta-t microsecond times=
tamp.\n\=0A=
+  -t, --timestamp              Use an absolute hh:mm:ss timestamp insted o=
f the\n\=0A=
+                                 default microsecond timestamp.  Implies -=
d.\n\=0A=
+  -w, --new-window             Spawn program under test in a new window.\n=
\=0A=
+  -S, --flush-period=3DPERIOD    Flush buffered strace output every PERIOD=
 secs.\n\=0A=
+  -v, --version                Display version info.\n\=0A=
+  -h, --help                   Display this help info.\n\=0A=
+");=0A=
+}=0A=
+=0A=
+static void=0A=
+version ()=0A=
+{=0A=
+  fprintf (stderr, SCCSid+4);=0A=
+}=0A=
+=0A=
+struct option longopts[] =3D {=0A=
+  {"help", no_argument, NULL, 'h'},=0A=
+  {"version", no_argument, NULL, 'v'},=0A=
+  {"buffer-size", required_argument, NULL, 'b'},=0A=
+  {"mask", required_argument, NULL, 'm'},=0A=
+  {"output", required_argument, NULL, 'o'},=0A=
+  {"trace-children", no_argument, NULL, 'f'},=0A=
+  {"crack-error-numbers", no_argument, NULL, 'n'},=0A=
+  {"no-delta", no_argument, NULL, 'd'},=0A=
+  {"usecs", no_argument, NULL, 'u'},=0A=
+  {"timestamp", no_argument, NULL, 't'},=0A=
+  {"new-window", no_argument, NULL, 'w'},=0A=
+  {"flush-period", required_argument, NULL, 'S'},=0A=
+  {NULL, 0, NULL, 0}=0A=
+};=0A=
+=0A=
+static const char *const opts =3D "hvb:m:o:fndutwS:";=0A=
+=0A=
 int=0A=
 main (int argc, char **argv)=0A=
 {=0A=
@@ -614,9 +807,19 @@ main (int argc, char **argv)=0A=
   else=0A=
     pgm++;=0A=
=20=0A=
-  while ((opt =3D getopt (argc, argv, "b:m:o:fndutwS:")) !=3D EOF)=0A=
+  while ((opt =3D getopt_long (argc, argv, opts, longopts, NULL)) !=3D EOF=
)=0A=
     switch (opt)=0A=
       {=0A=
+      case 'h':=0A=
+	// Print help and exit=0A=
+	usage ();=0A=
+	return 1;=0A=
+	break;=0A=
+      case 'v':=0A=
+	// Print version info and exit=0A=
+	version ();=0A=
+	return 1;=0A=
+	break;=0A=
       case 'f':=0A=
 	forkdebug ^=3D 1;=0A=
 	break;=0A=
@@ -624,8 +827,17 @@ main (int argc, char **argv)=0A=
 	bufsize =3D atoi (optarg);=0A=
 	break;=0A=
       case 'm':=0A=
-	mask =3D strtoul (optarg, NULL, 16);=0A=
+	{=0A=
+	  char *endptr;=0A=
+	  mask =3D parse_mask (optarg, &endptr);=0A=
+	  if (*endptr !=3D '\0')=0A=
+	    {=0A=
+	      // Bad mask expression.=0A=
+	      error (0, "syntax error in mask expression \"%s\" near \=0A=
+character #%d.\n", optarg, (int) (endptr - optarg), endptr);=0A=
+	    }=0A=
 	break;=0A=
+	}=0A=
       case 'o':=0A=
 	if ((ofile =3D fopen (optarg, "w")) =3D=3D NULL)=0A=
 	  error (1, "can't open %s", optarg);=0A=
@@ -643,6 +855,9 @@ main (int argc, char **argv)=0A=
 	delta ^=3D 1;=0A=
 	break;=0A=
       case 'u':=0A=
+    // FIXME: This option isn't handled properly/at all by the=0A=
+    // program's logic.  It seems to be the default, does it=0A=
+    // need to just be removed?=0A=
 	usecs ^=3D 1;=0A=
 	break;=0A=
       case 'w':=0A=

------=_NextPart_000_0004_01C16DA6.85F9BDA0
Content-Type: application/octet-stream;
	name="strace.cc-changelog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="strace.cc-changelog"
Content-length: 689

2001-11-15  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>

	* strace.cc (main): Change getopt() to getopt_long().
	Add support for help and version info.
	Use new parse_mask() function for -m/--mask option.
	(longopts): Add long options structure.
	(opts): Move options string from getopts call to static var.
	(usage): Print usage information.
	(SCCSid): Version info.
	(version): New function for displaying version info.
	(parse_mask): New function supporting parsing of mnemonics,
	hex, and basic expressions in masks.
	(mnemonic2ul): New mnemonic parsing function.
	(tag_mask_mnemonic): New type.
	(mnemonic_table): New table of mnemonics for mnemonic2ul() to
	search through.

------=_NextPart_000_0004_01C16DA6.85F9BDA0--
