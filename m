Return-Path: <cygwin-patches-return-1489-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 12573 invoked by alias); 14 Nov 2001 03:24:02 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 12541 invoked from network); 14 Nov 2001 03:23:58 -0000
Date: Wed, 10 Oct 2001 12:28:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Update of 11-4 strace.cc patch
Message-ID: <20011114032318.GA2385@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <NCBBIHCHBLCMLBLOBONKEECPCHAA.g.r.vansickle@worldnet.att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NCBBIHCHBLCMLBLOBONKEECPCHAA.g.r.vansickle@worldnet.att.net>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2001-q4/txt/msg00021.txt.bz2

Gary,
We got your assignment.  Can you generate a new patch against current
CVS?

Also, is there anything you can do to make the formatting of your
ChangeLog a little less sawtooth?  Is your mailer screwing up the
formatting?

Also, take a look at the date format for the ChangeLog.  There are two
formats and the one below doesn't adhere to either.

Thanks,
cgf

On Sun, Nov 04, 2001 at 11:05:51PM -0600, Gary R. Van Sickle wrote:
>This is the same as my previous patch and supercedes it, but contains usage
>info and getopts_long() support added for Egor's -w/-S patch, and is diffed
>against cvs with his patch.
>
>
>2001-11-04 23:02:00  Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>
>
>	* strace.cc (main): Change getopt() to getopt_long().
>	Add support for help and version info.
>      Use new parse_mask() function for -m/--mask option.
>	(longopts): Add long options structure.
>	(opts): Move options string from getopts call to static var.
>	(usage): Print usage information.
>	(version): Stub for eventually displaying version info.
>      (parse_mask): New function supporting parsing of mnemonics,
>      hex, and basic expressions in masks.
>      (mnemonic2ul): New mnemonic parsing function.
>      (tag_mask_mnemonic): New type.
>      (mnemonic_table): New table of mnemonics for mnemonic2ul() to
>      search through.
>
>
>Index: winsup/utils/strace.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/utils/strace.cc,v
>retrieving revision 1.12
>diff -p -u -b -r1.12 strace.cc
>--- strace.cc	2001/11/04 12:57:55	1.12
>+++ strace.cc	2001/11/05 05:02:10
>@@ -602,6 +602,193 @@ dostrace (unsigned mask, FILE *ofile, ch
>   return;
> }
>
>+typedef struct tag_mask_mnemonic
>+{
>+	unsigned long val;
>+	const char *text;
>+} mask_mnemonic;
>+
>+static const mask_mnemonic mnemonic_table[] =
>+{
>+  { _STRACE_ALL,      "all" },
>+  { _STRACE_FLUSH,    "flush" },
>+  { _STRACE_INHERIT,  "inherit" },
>+  { _STRACE_UHOH,     "uhoh" },
>+  { _STRACE_SYSCALL,  "syscall" },
>+  { _STRACE_STARTUP,  "startup" },
>+  { _STRACE_DEBUG,    "debug" },
>+  { _STRACE_PARANOID, "paranoid" },
>+  { _STRACE_TERMIOS,  "termios" },
>+  { _STRACE_SELECT,   "select" },
>+  { _STRACE_WM,       "wm" },
>+  { _STRACE_SIGP,     "sigp" },
>+  { _STRACE_MINIMAL,  "minimal" },
>+  { _STRACE_EXITDUMP, "exitdump" },
>+  { _STRACE_SYSTEM,   "system" },
>+  { _STRACE_NOMUTEX,  "nomutex" },
>+  { _STRACE_MALLOC,   "malloc" },
>+  { _STRACE_THREAD,   "thread" },
>+  { 0, NULL }
>+};
>+
>+static unsigned long mnemonic2ul (const char *nptr, char **endptr)
>+{
>+  // Look up mnemonic in table, return value.
>+  // *endptr = ptr to char that breaks match.
>+  const mask_mnemonic *mnp = mnemonic_table;
>+
>+  while(mnp->text != NULL)
>+  {
>+	if(strcmp(mnp->text, nptr) == 0)
>+	{
>+	  // Found a match.
>+	  if(endptr != NULL)
>+	  {
>+	    *endptr = ((char*)nptr) + strlen(mnp->text);
>+	  }
>+	  return mnp->val;
>+    }
>+    mnp++;
>+  }
>+
>+  // Didn't find it.
>+  if(endptr != NULL)
>+  {
>+    *endptr = (char*)nptr;
>+  }
>+  return 0;
>+}
>+
>+static unsigned long parse_mask (const char *ms, char **endptr)
>+{
>+  const char *p = ms;
>+  char *newp;
>+  unsigned long retval = 0, thisval;
>+  const size_t bufsize = 16;
>+  char buffer[bufsize];
>+  size_t len;
>+
>+  while(*p != '\0')
>+  {
>+    // First extract the term, terminate it, and lowercase it.
>+    strncpy(buffer, p, bufsize);
>+    buffer[bufsize-1] = '\0';
>+    len = strcspn(buffer, "+,\0");
>+    buffer[len] = '\0';
>+    strlwr(buffer);
>+
>+	// Check if this is a mnemonic.  We have to do this first or strtoul()
>+	// will false-trigger on anything starting with "a" through "f".
>+    thisval = mnemonic2ul(buffer, &newp);
>+    if(buffer == newp)
>+    {
>+      // This term isn't mnemonic, check if it's hex.
>+	  thisval = strtoul(buffer, &newp, 16);
>+      if(newp != buffer+len)
>+      {
>+        // Not hex either, syntax error.
>+        *endptr = (char*)p;
>+        return 0;
>+      }
>+    }
>+
>+    p += len;
>+    retval += thisval;
>+
>+    // Handle operators
>+    if(*p == '\0') break;
>+	if((*p == '+') || (*p == ','))
>+	{
>+	  // For now these both equate to addition/ORing.  Until we get
>+	  // fancy and add things like "all-<something>", all we need do is
>+	  // continue the looping.
>+	  p++;
>+	  continue;
>+	}
>+	else
>+	{
>+		// Syntax error
>+        *endptr = (char*)p;
>+        return 0;
>+	}
>+  }
>+
>+  *endptr = (char*)p;
>+  return retval;
>+}
>+
>+static void usage ()
>+{
>+  fprintf (stderr,
>+"\
>+Usage: strace [OPTIONS] <command-line>\n\
>+  -b, --buffer-size=SIZE        Set size of output file buffer.\n\
>+  -m, --mask=MASK               Set message filter mask.\n\
>+\n\
>+    MASK can be any combination of the following mnemonics and/or hex
>values\n\
>+    (0x is optional).  Combine masks with '+' or ',' like so:\n\
>+\n\
>+                      --mask=wm+system,malloc+0x00800\n\
>+\n\
>+    Mnemonic Hex     Corresponding Def  Description\n\
>+
>=========================================================================\n\
>+    all      0x00001 (_STRACE_ALL)      All strace messages.\n\
>+    flush    0x00002 (_STRACE_FLUSH)    Flush output buffer after each
>message.\n\
>+    inherit  0x00004 (_STRACE_INHERIT)  Children inherit mask from
>parent.\n\
>+    uhoh     0x00008 (_STRACE_UHOH)     Unusual or weird phenomenon.\n\
>+    syscall  0x00010 (_STRACE_SYSCALL)  System calls.\n\
>+    startup  0x00020 (_STRACE_STARTUP)  argc/envp printout at startup.\n\
>+    debug    0x00040 (_STRACE_DEBUG)    Info to help debugging. \n\
>+    paranoid 0x00080 (_STRACE_PARANOID) Paranoid info.\n\
>+    termios  0x00100 (_STRACE_TERMIOS)  Info for debugging termios
>stuff.\n\
>+    select   0x00200 (_STRACE_SELECT)   Info on ugly select internals.\n\
>+    wm       0x00400 (_STRACE_WM)       Trace Windows msgs (enable
>_strace_wm).\n\
>+    sigp     0x00800 (_STRACE_SIGP)     Trace signal and process
>handling.\n\
>+    minimal  0x01000 (_STRACE_MINIMAL)  Very minimal strace output.\n\
>+    exitdump 0x04000 (_STRACE_EXITDUMP) Dump strace cache on exit.\n\
>+    system   0x08000 (_STRACE_SYSTEM)   Cache strace messages.\n\
>+    nomutex  0x10000 (_STRACE_NOMUTEX)  Don't use mutex for
>synchronization.\n\
>+    malloc   0x20000 (_STRACE_MALLOC)   Trace malloc calls.\n\
>+    thread   0x40000 (_STRACE_THREAD)   Thread-locking calls.\n\
>+\n\
>+  -o, --output=FILENAME         Set output file to FILENAME.\n\
>+  -f, --fork-debug              ???\n\
>+  -n, --error-number            Also output associated Windows error
>number.\n\
>+  -d, --delta                   Add a delta-t timestamp to each output
>line.\n\
>+  -u, --usecs                   Add a microsecond-resolution timestamp to
>each
>+                                output line.\n\
>+  -t, --timestamp               Add an hhmmss timestamp to each output
>line.\n\
>+  -w, --new-window              Spawn program under test in a new
>window.\n\
>+  -S, --flush-period=PERIOD     Flush buffered strace output every PERIOD
>secs.\n\
>+  -v, --version                 Display version info.\n\
>+  -h, --help                    Display this help info.\n\
>+");
>+}
>+
>+static void version ()
>+{
>+	fprintf (stderr, "Not yet implemented.");
>+}
>+
>+struct option longopts[] =
>+{
>+  {"help", no_argument, NULL, 'h' },
>+  {"version", no_argument, NULL, 'v' },
>+  {"buffer-size", required_argument, NULL, 'b'},
>+  {"mask", required_argument, NULL, 'm'},
>+  {"output", required_argument, NULL, 'o'},
>+  {"fork-debug", no_argument, NULL, 'f'},
>+  {"error-number", no_argument, NULL, 'n'},
>+  {"delta", no_argument, NULL, 'd'},
>+  {"usecs", no_argument, NULL, 'u'},
>+  {"timestamp", no_argument, NULL, 't'},
>+  {"new-window", no_argument, NULL, 'w'},
>+  {"flush-period", required_argument, NULL, 'S'},
>+  {NULL, 0, NULL, 0}
>+};
>+
>+static const char *const opts = "hvb:m:o:fndutwS:";
>+
> int
> main (int argc, char **argv)
> {
>@@ -614,9 +801,19 @@ main (int argc, char **argv)
>   else
>     pgm++;
>
>-  while ((opt = getopt (argc, argv, "b:m:o:fndutwS:")) != EOF)
>+  while ((opt = getopt_long (argc, argv, opts, longopts, NULL)) != EOF)
>     switch (opt)
>       {
>+      case 'h':
>+    // Print help and exit
>+    usage ();
>+    return 1;
>+    break;
>+      case 'v':
>+    // Print version info and exit
>+    version ();
>+    return 1;
>+    break;
>       case 'f':
> 	forkdebug ^= 1;
> 	break;
>@@ -624,8 +821,17 @@ main (int argc, char **argv)
> 	bufsize = atoi (optarg);
> 	break;
>       case 'm':
>-	mask = strtoul (optarg, NULL, 16);
>+      {
>+	    char *endptr;
>+	    mask = parse_mask (optarg, &endptr);
>+	    if(*endptr != '\0')
>+	    {
>+	      // Bad mask expression.
>+	      error(0, "syntax error in mask expression \"%s\" near \
>+character #%d.\n", optarg, (int)(endptr-optarg), endptr);
>+	    }
> 	break;
>+	  }
>       case 'o':
> 	if ((ofile = fopen (optarg, "w")) == NULL)
> 	  error (1, "can't open %s", optarg);

-- 
cgf@redhat.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
