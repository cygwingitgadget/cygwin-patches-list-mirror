Return-Path: <cygwin-patches-return-1491-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 6809 invoked by alias); 14 Nov 2001 09:59:20 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 6772 invoked from network); 14 Nov 2001 09:59:18 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: [PATCH] Mask mnemonics and expressions, help, getopts_long() for strace - current diff
Date: Wed, 10 Oct 2001 17:43:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKIEFCCHAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C16CC0.B8ACD660"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-SW-Source: 2001-q4/txt/msg00023.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C16CC0.B8ACD660
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 8194

Patch of 11-4 diffed against current CVS.


2001-11-14  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>

	* strace.cc (main): Change getopt() to getopt_long().
	Add support for help and version info.
	Use new parse_mask() function for -m/--mask option.
	(longopts): Add long options structure.
	(opts): Move options string from getopts call to static var.
	(usage): Print usage information.
	(version): Stub for eventually displaying version info.
	(parse_mask): New function supporting parsing of mnemonics,
	hex, and basic expressions in masks.
	(mnemonic2ul): New mnemonic parsing function.
	(tag_mask_mnemonic): New type.
	(mnemonic_table): New table of mnemonics for mnemonic2ul() to
	search through.


Index: winsup/utils/strace.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/strace.cc,v
retrieving revision 1.12
diff -p -u -b -r1.12 strace.cc
--- strace.cc	2001/11/04 12:57:55	1.12
+++ strace.cc	2001/11/14 09:42:11
@@ -602,6 +602,193 @@ dostrace (unsigned mask, FILE *ofile, ch
   return;
 }

+typedef struct tag_mask_mnemonic
+{
+	unsigned long val;
+	const char *text;
+} mask_mnemonic;
+
+static const mask_mnemonic mnemonic_table[] =
+{
+  { _STRACE_ALL,      "all" },
+  { _STRACE_FLUSH,    "flush" },
+  { _STRACE_INHERIT,  "inherit" },
+  { _STRACE_UHOH,     "uhoh" },
+  { _STRACE_SYSCALL,  "syscall" },
+  { _STRACE_STARTUP,  "startup" },
+  { _STRACE_DEBUG,    "debug" },
+  { _STRACE_PARANOID, "paranoid" },
+  { _STRACE_TERMIOS,  "termios" },
+  { _STRACE_SELECT,   "select" },
+  { _STRACE_WM,       "wm" },
+  { _STRACE_SIGP,     "sigp" },
+  { _STRACE_MINIMAL,  "minimal" },
+  { _STRACE_EXITDUMP, "exitdump" },
+  { _STRACE_SYSTEM,   "system" },
+  { _STRACE_NOMUTEX,  "nomutex" },
+  { _STRACE_MALLOC,   "malloc" },
+  { _STRACE_THREAD,   "thread" },
+  { 0, NULL }
+};
+
+static unsigned long mnemonic2ul (const char *nptr, char **endptr)
+{
+  // Look up mnemonic in table, return value.
+  // *endptr = ptr to char that breaks match.
+  const mask_mnemonic *mnp = mnemonic_table;
+
+  while(mnp->text != NULL)
+  {
+	if(strcmp(mnp->text, nptr) == 0)
+	{
+	  // Found a match.
+	  if(endptr != NULL)
+	  {
+	    *endptr = ((char*)nptr) + strlen(mnp->text);
+	  }
+	  return mnp->val;
+    }
+    mnp++;
+  }
+
+  // Didn't find it.
+  if(endptr != NULL)
+  {
+    *endptr = (char*)nptr;
+  }
+  return 0;
+}
+
+static unsigned long parse_mask (const char *ms, char **endptr)
+{
+  const char *p = ms;
+  char *newp;
+  unsigned long retval = 0, thisval;
+  const size_t bufsize = 16;
+  char buffer[bufsize];
+  size_t len;
+
+  while(*p != '\0')
+  {
+    // First extract the term, terminate it, and lowercase it.
+    strncpy(buffer, p, bufsize);
+    buffer[bufsize-1] = '\0';
+    len = strcspn(buffer, "+,\0");
+    buffer[len] = '\0';
+    strlwr(buffer);
+
+	// Check if this is a mnemonic.  We have to do this first or strtoul()
+	// will false-trigger on anything starting with "a" through "f".
+    thisval = mnemonic2ul(buffer, &newp);
+    if(buffer == newp)
+    {
+      // This term isn't mnemonic, check if it's hex.
+	  thisval = strtoul(buffer, &newp, 16);
+      if(newp != buffer+len)
+      {
+        // Not hex either, syntax error.
+        *endptr = (char*)p;
+        return 0;
+      }
+    }
+
+    p += len;
+    retval += thisval;
+
+    // Handle operators
+    if(*p == '\0') break;
+	if((*p == '+') || (*p == ','))
+	{
+	  // For now these both equate to addition/ORing.  Until we get
+	  // fancy and add things like "all-<something>", all we need do is
+	  // continue the looping.
+	  p++;
+	  continue;
+	}
+	else
+	{
+		// Syntax error
+        *endptr = (char*)p;
+        return 0;
+	}
+  }
+
+  *endptr = (char*)p;
+  return retval;
+}
+
+static void usage ()
+{
+  fprintf (stderr,
+"\
+Usage: strace [OPTIONS] <command-line>\n\
+  -b, --buffer-size=SIZE        Set size of output file buffer.\n\
+  -m, --mask=MASK               Set message filter mask.\n\
+\n\
+    MASK can be any combination of the following mnemonics and/or hex values\n\
+    (0x is optional).  Combine masks with '+' or ',' like so:\n\
+\n\
+                      --mask=wm+system,malloc+0x00800\n\
+\n\
+    Mnemonic Hex     Corresponding Def  Description\n\
+
=========================================================================\n\
+    all      0x00001 (_STRACE_ALL)      All strace messages.\n\
+    flush    0x00002 (_STRACE_FLUSH)    Flush output buffer after each
message.\n\
+    inherit  0x00004 (_STRACE_INHERIT)  Children inherit mask from parent.\n\
+    uhoh     0x00008 (_STRACE_UHOH)     Unusual or weird phenomenon.\n\
+    syscall  0x00010 (_STRACE_SYSCALL)  System calls.\n\
+    startup  0x00020 (_STRACE_STARTUP)  argc/envp printout at startup.\n\
+    debug    0x00040 (_STRACE_DEBUG)    Info to help debugging. \n\
+    paranoid 0x00080 (_STRACE_PARANOID) Paranoid info.\n\
+    termios  0x00100 (_STRACE_TERMIOS)  Info for debugging termios stuff.\n\
+    select   0x00200 (_STRACE_SELECT)   Info on ugly select internals.\n\
+    wm       0x00400 (_STRACE_WM)       Trace Windows msgs (enable
_strace_wm).\n\
+    sigp     0x00800 (_STRACE_SIGP)     Trace signal and process handling.\n\
+    minimal  0x01000 (_STRACE_MINIMAL)  Very minimal strace output.\n\
+    exitdump 0x04000 (_STRACE_EXITDUMP) Dump strace cache on exit.\n\
+    system   0x08000 (_STRACE_SYSTEM)   Cache strace messages.\n\
+    nomutex  0x10000 (_STRACE_NOMUTEX)  Don't use mutex for synchronization.\n\
+    malloc   0x20000 (_STRACE_MALLOC)   Trace malloc calls.\n\
+    thread   0x40000 (_STRACE_THREAD)   Thread-locking calls.\n\
+\n\
+  -o, --output=FILENAME         Set output file to FILENAME.\n\
+  -f, --fork-debug              ???\n\
+  -n, --error-number            Also output associated Windows error number.\n\
+  -d, --delta                   Add a delta-t timestamp to each output line.\n\
+  -u, --usecs                   Add a microsecond-resolution timestamp to each
+                                output line.\n\
+  -t, --timestamp               Add an hhmmss timestamp to each output line.\n\
+  -w, --new-window              Spawn program under test in a new window.\n\
+  -S, --flush-period=PERIOD     Flush buffered strace output every PERIOD
secs.\n\
+  -v, --version                 Display version info.\n\
+  -h, --help                    Display this help info.\n\
+");
+}
+
+static void version ()
+{
+	fprintf (stderr, "Not yet implemented.");
+}
+
+struct option longopts[] =
+{
+  {"help", no_argument, NULL, 'h' },
+  {"version", no_argument, NULL, 'v' },
+  {"buffer-size", required_argument, NULL, 'b'},
+  {"mask", required_argument, NULL, 'm'},
+  {"output", required_argument, NULL, 'o'},
+  {"fork-debug", no_argument, NULL, 'f'},
+  {"error-number", no_argument, NULL, 'n'},
+  {"delta", no_argument, NULL, 'd'},
+  {"usecs", no_argument, NULL, 'u'},
+  {"timestamp", no_argument, NULL, 't'},
+  {"new-window", no_argument, NULL, 'w'},
+  {"flush-period", required_argument, NULL, 'S'},
+  {NULL, 0, NULL, 0}
+};
+
+static const char *const opts = "hvb:m:o:fndutwS:";
+
 int
 main (int argc, char **argv)
 {
@@ -614,9 +801,19 @@ main (int argc, char **argv)
   else
     pgm++;

-  while ((opt = getopt (argc, argv, "b:m:o:fndutwS:")) != EOF)
+  while ((opt = getopt_long (argc, argv, opts, longopts, NULL)) != EOF)
     switch (opt)
       {
+      case 'h':
+    // Print help and exit
+    usage ();
+    return 1;
+    break;
+      case 'v':
+    // Print version info and exit
+    version ();
+    return 1;
+    break;
       case 'f':
 	forkdebug ^= 1;
 	break;
@@ -624,8 +821,17 @@ main (int argc, char **argv)
 	bufsize = atoi (optarg);
 	break;
       case 'm':
-	mask = strtoul (optarg, NULL, 16);
+      {
+	    char *endptr;
+	    mask = parse_mask (optarg, &endptr);
+	    if(*endptr != '\0')
+	    {
+	      // Bad mask expression.
+	      error(0, "syntax error in mask expression \"%s\" near \
+character #%d.\n", optarg, (int)(endptr-optarg), endptr);
+	    }
 	break;
+	  }
       case 'o':
 	if ((ofile = fopen (optarg, "w")) == NULL)
 	  error (1, "can't open %s", optarg);

--
Gary R. Van Sickle
Brewer.  Patriot.

------=_NextPart_000_0000_01C16CC0.B8ACD660
Content-Type: application/octet-stream;
	name="strace.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="strace.cc-patch"
Content-length: 8893

Index: winsup/utils/strace.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/utils/strace.cc,v=0A=
retrieving revision 1.12=0A=
diff -p -u -b -r1.12 strace.cc=0A=
--- strace.cc	2001/11/04 12:57:55	1.12=0A=
+++ strace.cc	2001/11/14 09:42:11=0A=
@@ -602,6 +602,193 @@ dostrace (unsigned mask, FILE *ofile, ch=0A=
   return;=0A=
 }=0A=
=20=0A=
+typedef struct tag_mask_mnemonic=0A=
+{=0A=
+	unsigned long val;=0A=
+	const char *text;=0A=
+} mask_mnemonic;=0A=
+=0A=
+static const mask_mnemonic mnemonic_table[] =3D=0A=
+{=0A=
+  { _STRACE_ALL,      "all" },=0A=
+  { _STRACE_FLUSH,    "flush" },=0A=
+  { _STRACE_INHERIT,  "inherit" },=0A=
+  { _STRACE_UHOH,     "uhoh" },=0A=
+  { _STRACE_SYSCALL,  "syscall" },=0A=
+  { _STRACE_STARTUP,  "startup" },=0A=
+  { _STRACE_DEBUG,    "debug" },=0A=
+  { _STRACE_PARANOID, "paranoid" },=0A=
+  { _STRACE_TERMIOS,  "termios" },=0A=
+  { _STRACE_SELECT,   "select" },=0A=
+  { _STRACE_WM,       "wm" },=0A=
+  { _STRACE_SIGP,     "sigp" },=0A=
+  { _STRACE_MINIMAL,  "minimal" },=0A=
+  { _STRACE_EXITDUMP, "exitdump" },=0A=
+  { _STRACE_SYSTEM,   "system" },=0A=
+  { _STRACE_NOMUTEX,  "nomutex" },=0A=
+  { _STRACE_MALLOC,   "malloc" },=0A=
+  { _STRACE_THREAD,   "thread" },=0A=
+  { 0, NULL }=0A=
+};=0A=
+=0A=
+static unsigned long mnemonic2ul (const char *nptr, char **endptr)=0A=
+{=0A=
+  // Look up mnemonic in table, return value.=0A=
+  // *endptr =3D ptr to char that breaks match.=0A=
+  const mask_mnemonic *mnp =3D mnemonic_table;=0A=
+=20=20=0A=
+  while(mnp->text !=3D NULL)=0A=
+  {=0A=
+	if(strcmp(mnp->text, nptr) =3D=3D 0)=0A=
+	{=0A=
+	  // Found a match.=0A=
+	  if(endptr !=3D NULL)=0A=
+	  {=0A=
+	    *endptr =3D ((char*)nptr) + strlen(mnp->text);=0A=
+	  }=0A=
+	  return mnp->val;=0A=
+    }=0A=
+    mnp++;=0A=
+  }=0A=
+=20=20=0A=
+  // Didn't find it.=0A=
+  if(endptr !=3D NULL)=0A=
+  {=0A=
+    *endptr =3D (char*)nptr;=0A=
+  }=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+static unsigned long parse_mask (const char *ms, char **endptr)=0A=
+{=0A=
+  const char *p =3D ms;=0A=
+  char *newp;=0A=
+  unsigned long retval =3D 0, thisval;=0A=
+  const size_t bufsize =3D 16;=0A=
+  char buffer[bufsize];=0A=
+  size_t len;=0A=
+=20=20=0A=
+  while(*p !=3D '\0')=0A=
+  {=0A=
+    // First extract the term, terminate it, and lowercase it.=0A=
+    strncpy(buffer, p, bufsize);=0A=
+    buffer[bufsize-1] =3D '\0';=0A=
+    len =3D strcspn(buffer, "+,\0");=0A=
+    buffer[len] =3D '\0';=0A=
+    strlwr(buffer);=0A=
+=20=20=0A=
+	// Check if this is a mnemonic.  We have to do this first or strtoul()=0A=
+	// will false-trigger on anything starting with "a" through "f".=0A=
+    thisval =3D mnemonic2ul(buffer, &newp);=0A=
+    if(buffer =3D=3D newp)=0A=
+    {=0A=
+      // This term isn't mnemonic, check if it's hex.=0A=
+	  thisval =3D strtoul(buffer, &newp, 16);=0A=
+      if(newp !=3D buffer+len)=0A=
+      {=0A=
+        // Not hex either, syntax error.=0A=
+        *endptr =3D (char*)p;=0A=
+        return 0;=0A=
+      }=0A=
+    }=0A=
+=20=20=20=20=0A=
+    p +=3D len;=0A=
+    retval +=3D thisval;=0A=
+=20=20=20=20=0A=
+    // Handle operators=0A=
+    if(*p =3D=3D '\0') break;=0A=
+	if((*p =3D=3D '+') || (*p =3D=3D ','))=0A=
+	{=0A=
+	  // For now these both equate to addition/ORing.  Until we get=0A=
+	  // fancy and add things like "all-<something>", all we need do is=0A=
+	  // continue the looping.=0A=
+	  p++;=0A=
+	  continue;=0A=
+	}=0A=
+	else=0A=
+	{=0A=
+		// Syntax error=0A=
+        *endptr =3D (char*)p;=0A=
+        return 0;=0A=
+	}=0A=
+  }=0A=
+=20=20=0A=
+  *endptr =3D (char*)p;=0A=
+  return retval;=0A=
+}=0A=
+=0A=
+static void usage ()=0A=
+{=0A=
+  fprintf (stderr,=0A=
+"\=0A=
+Usage: strace [OPTIONS] <command-line>\n\=0A=
+  -b, --buffer-size=3DSIZE        Set size of output file buffer.\n\=0A=
+  -m, --mask=3DMASK               Set message filter mask.\n\=0A=
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
+  -o, --output=3DFILENAME         Set output file to FILENAME.\n\=0A=
+  -f, --fork-debug              ???\n\=0A=
+  -n, --error-number            Also output associated Windows error numbe=
r.\n\=0A=
+  -d, --delta                   Add a delta-t timestamp to each output lin=
e.\n\=0A=
+  -u, --usecs                   Add a microsecond-resolution timestamp to =
each=0A=
+                                output line.\n\=0A=
+  -t, --timestamp               Add an hhmmss timestamp to each output lin=
e.\n\=0A=
+  -w, --new-window              Spawn program under test in a new window.\=
n\=0A=
+  -S, --flush-period=3DPERIOD     Flush buffered strace output every PERIO=
D secs.\n\=0A=
+  -v, --version                 Display version info.\n\=0A=
+  -h, --help                    Display this help info.\n\=0A=
+");=0A=
+}=0A=
+=0A=
+static void version ()=0A=
+{=0A=
+	fprintf (stderr, "Not yet implemented.");=0A=
+}=0A=
+=0A=
+struct option longopts[] =3D=0A=
+{=0A=
+  {"help", no_argument, NULL, 'h' },=0A=
+  {"version", no_argument, NULL, 'v' },=0A=
+  {"buffer-size", required_argument, NULL, 'b'},=0A=
+  {"mask", required_argument, NULL, 'm'},=0A=
+  {"output", required_argument, NULL, 'o'},=0A=
+  {"fork-debug", no_argument, NULL, 'f'},=0A=
+  {"error-number", no_argument, NULL, 'n'},=0A=
+  {"delta", no_argument, NULL, 'd'},=0A=
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
@@ -614,9 +801,19 @@ main (int argc, char **argv)=0A=
   else=0A=
     pgm++;=0A=
=20=0A=
-  while ((opt =3D getopt (argc, argv, "b:m:o:fndutwS:")) !=3D EOF)=0A=
+  while ((opt =3D getopt_long (argc, argv, opts, longopts, NULL)) !=3D EOF=
)=0A=
     switch (opt)=0A=
       {=0A=
+      case 'h':=0A=
+    // Print help and exit=0A=
+    usage ();=0A=
+    return 1;=0A=
+    break;=0A=
+      case 'v':=0A=
+    // Print version info and exit=0A=
+    version ();=0A=
+    return 1;=0A=
+    break;=0A=
       case 'f':=0A=
 	forkdebug ^=3D 1;=0A=
 	break;=0A=
@@ -624,8 +821,17 @@ main (int argc, char **argv)=0A=
 	bufsize =3D atoi (optarg);=0A=
 	break;=0A=
       case 'm':=0A=
-	mask =3D strtoul (optarg, NULL, 16);=0A=
+      {=0A=
+	    char *endptr;=0A=
+	    mask =3D parse_mask (optarg, &endptr);=0A=
+	    if(*endptr !=3D '\0')=0A=
+	    {=0A=
+	      // Bad mask expression.=0A=
+	      error(0, "syntax error in mask expression \"%s\" near \=0A=
+character #%d.\n", optarg, (int)(endptr-optarg), endptr);=0A=
+	    }=0A=
 	break;=0A=
+	  }=0A=
       case 'o':=0A=
 	if ((ofile =3D fopen (optarg, "w")) =3D=3D NULL)=0A=
 	  error (1, "can't open %s", optarg);=0A=

------=_NextPart_000_0000_01C16CC0.B8ACD660
Content-Type: application/octet-stream;
	name="strace.cc-changelog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="strace.cc-changelog"
Content-length: 667

2001-11-14  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>

	* strace.cc (main): Change getopt() to getopt_long().
	Add support for help and version info.
	Use new parse_mask() function for -m/--mask option.
	(longopts): Add long options structure.
	(opts): Move options string from getopts call to static var.
	(usage): Print usage information.
	(version): Stub for eventually displaying version info.
	(parse_mask): New function supporting parsing of mnemonics,
	hex, and basic expressions in masks.
	(mnemonic2ul): New mnemonic parsing function.
	(tag_mask_mnemonic): New type.
	(mnemonic_table): New table of mnemonics for mnemonic2ul() to
	search through.

------=_NextPart_000_0000_01C16CC0.B8ACD660--
