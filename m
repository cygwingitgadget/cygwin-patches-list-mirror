From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: [PATCH] Mask mnemonics and expressions, help, getopts_long() for strace - current diff
Date: Wed, 14 Nov 2001 01:59:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKIEFCCHAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00219.html
Content-type: multipart/mixed; boundary="----------=_1583532850-65438-115"
Message-ID: <20011114015900.ymMKTcfqevx9Hc9MLN1phlJpD36KD2U78OkX3GquzoI@z>

This is a multi-part message in MIME format...

------------=_1583532850-65438-115
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

------------=_1583532850-65438-115
Content-Type: text/plain; charset=us-ascii; name="strace.cc-changelog"
Content-Disposition: inline; filename="strace.cc-changelog"
Content-Transfer-Encoding: base64
Content-Length: 907

MjAwMS0xMS0xNCAgR2FyeSBSLiBWYW4gU2lja2xlICA8Zy5yLnZhbnNpY2ts
ZUB3b3JsZG5ldC5hdHQubmV0PgoKCSogc3RyYWNlLmNjIChtYWluKTogQ2hh
bmdlIGdldG9wdCgpIHRvIGdldG9wdF9sb25nKCkuCglBZGQgc3VwcG9ydCBm
b3IgaGVscCBhbmQgdmVyc2lvbiBpbmZvLgoJVXNlIG5ldyBwYXJzZV9tYXNr
KCkgZnVuY3Rpb24gZm9yIC1tLy0tbWFzayBvcHRpb24uCgkobG9uZ29wdHMp
OiBBZGQgbG9uZyBvcHRpb25zIHN0cnVjdHVyZS4KCShvcHRzKTogTW92ZSBv
cHRpb25zIHN0cmluZyBmcm9tIGdldG9wdHMgY2FsbCB0byBzdGF0aWMgdmFy
LgoJKHVzYWdlKTogUHJpbnQgdXNhZ2UgaW5mb3JtYXRpb24uCgkodmVyc2lv
bik6IFN0dWIgZm9yIGV2ZW50dWFsbHkgZGlzcGxheWluZyB2ZXJzaW9uIGlu
Zm8uCgkocGFyc2VfbWFzayk6IE5ldyBmdW5jdGlvbiBzdXBwb3J0aW5nIHBh
cnNpbmcgb2YgbW5lbW9uaWNzLAoJaGV4LCBhbmQgYmFzaWMgZXhwcmVzc2lv
bnMgaW4gbWFza3MuCgkobW5lbW9uaWMydWwpOiBOZXcgbW5lbW9uaWMgcGFy
c2luZyBmdW5jdGlvbi4KCSh0YWdfbWFza19tbmVtb25pYyk6IE5ldyB0eXBl
LgoJKG1uZW1vbmljX3RhYmxlKTogTmV3IHRhYmxlIG9mIG1uZW1vbmljcyBm
b3IgbW5lbW9uaWMydWwoKSB0bwoJc2VhcmNoIHRocm91Z2guCg==

------------=_1583532850-65438-115
Content-Type: text/x-diff; charset=us-ascii; name="strace.cc-patch"
Content-Disposition: inline; filename="strace.cc-patch"
Content-Transfer-Encoding: base64
Content-Length: 10118

SW5kZXg6IHdpbnN1cC91dGlscy9zdHJhY2UuY2MKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC91dGlscy9z
dHJhY2UuY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTIKZGlmZiAtcCAt
dSAtYiAtcjEuMTIgc3RyYWNlLmNjCi0tLSBzdHJhY2UuY2MJMjAwMS8xMS8w
NCAxMjo1Nzo1NQkxLjEyCisrKyBzdHJhY2UuY2MJMjAwMS8xMS8xNCAwOTo0
MjoxMQpAQCAtNjAyLDYgKzYwMiwxOTMgQEAgZG9zdHJhY2UgKHVuc2lnbmVk
IG1hc2ssIEZJTEUgKm9maWxlLCBjaAogICByZXR1cm47CiB9CiAKK3R5cGVk
ZWYgc3RydWN0IHRhZ19tYXNrX21uZW1vbmljCit7CisJdW5zaWduZWQgbG9u
ZyB2YWw7CisJY29uc3QgY2hhciAqdGV4dDsKK30gbWFza19tbmVtb25pYzsK
Kworc3RhdGljIGNvbnN0IG1hc2tfbW5lbW9uaWMgbW5lbW9uaWNfdGFibGVb
XSA9Cit7CisgIHsgX1NUUkFDRV9BTEwsICAgICAgImFsbCIgfSwKKyAgeyBf
U1RSQUNFX0ZMVVNILCAgICAiZmx1c2giIH0sCisgIHsgX1NUUkFDRV9JTkhF
UklULCAgImluaGVyaXQiIH0sCisgIHsgX1NUUkFDRV9VSE9ILCAgICAgInVo
b2giIH0sCisgIHsgX1NUUkFDRV9TWVNDQUxMLCAgInN5c2NhbGwiIH0sCisg
IHsgX1NUUkFDRV9TVEFSVFVQLCAgInN0YXJ0dXAiIH0sCisgIHsgX1NUUkFD
RV9ERUJVRywgICAgImRlYnVnIiB9LAorICB7IF9TVFJBQ0VfUEFSQU5PSUQs
ICJwYXJhbm9pZCIgfSwKKyAgeyBfU1RSQUNFX1RFUk1JT1MsICAidGVybWlv
cyIgfSwKKyAgeyBfU1RSQUNFX1NFTEVDVCwgICAic2VsZWN0IiB9LAorICB7
IF9TVFJBQ0VfV00sICAgICAgICJ3bSIgfSwKKyAgeyBfU1RSQUNFX1NJR1As
ICAgICAic2lncCIgfSwKKyAgeyBfU1RSQUNFX01JTklNQUwsICAibWluaW1h
bCIgfSwKKyAgeyBfU1RSQUNFX0VYSVREVU1QLCAiZXhpdGR1bXAiIH0sCisg
IHsgX1NUUkFDRV9TWVNURU0sICAgInN5c3RlbSIgfSwKKyAgeyBfU1RSQUNF
X05PTVVURVgsICAibm9tdXRleCIgfSwKKyAgeyBfU1RSQUNFX01BTExPQywg
ICAibWFsbG9jIiB9LAorICB7IF9TVFJBQ0VfVEhSRUFELCAgICJ0aHJlYWQi
IH0sCisgIHsgMCwgTlVMTCB9Cit9OworCitzdGF0aWMgdW5zaWduZWQgbG9u
ZyBtbmVtb25pYzJ1bCAoY29uc3QgY2hhciAqbnB0ciwgY2hhciAqKmVuZHB0
cikKK3sKKyAgLy8gTG9vayB1cCBtbmVtb25pYyBpbiB0YWJsZSwgcmV0dXJu
IHZhbHVlLgorICAvLyAqZW5kcHRyID0gcHRyIHRvIGNoYXIgdGhhdCBicmVh
a3MgbWF0Y2guCisgIGNvbnN0IG1hc2tfbW5lbW9uaWMgKm1ucCA9IG1uZW1v
bmljX3RhYmxlOworICAKKyAgd2hpbGUobW5wLT50ZXh0ICE9IE5VTEwpCisg
IHsKKwlpZihzdHJjbXAobW5wLT50ZXh0LCBucHRyKSA9PSAwKQorCXsKKwkg
IC8vIEZvdW5kIGEgbWF0Y2guCisJICBpZihlbmRwdHIgIT0gTlVMTCkKKwkg
IHsKKwkgICAgKmVuZHB0ciA9ICgoY2hhciopbnB0cikgKyBzdHJsZW4obW5w
LT50ZXh0KTsKKwkgIH0KKwkgIHJldHVybiBtbnAtPnZhbDsKKyAgICB9Cisg
ICAgbW5wKys7CisgIH0KKyAgCisgIC8vIERpZG4ndCBmaW5kIGl0LgorICBp
ZihlbmRwdHIgIT0gTlVMTCkKKyAgeworICAgICplbmRwdHIgPSAoY2hhciop
bnB0cjsKKyAgfQorICByZXR1cm4gMDsKK30KKworc3RhdGljIHVuc2lnbmVk
IGxvbmcgcGFyc2VfbWFzayAoY29uc3QgY2hhciAqbXMsIGNoYXIgKiplbmRw
dHIpCit7CisgIGNvbnN0IGNoYXIgKnAgPSBtczsKKyAgY2hhciAqbmV3cDsK
KyAgdW5zaWduZWQgbG9uZyByZXR2YWwgPSAwLCB0aGlzdmFsOworICBjb25z
dCBzaXplX3QgYnVmc2l6ZSA9IDE2OworICBjaGFyIGJ1ZmZlcltidWZzaXpl
XTsKKyAgc2l6ZV90IGxlbjsKKyAgCisgIHdoaWxlKCpwICE9ICdcMCcpCisg
IHsKKyAgICAvLyBGaXJzdCBleHRyYWN0IHRoZSB0ZXJtLCB0ZXJtaW5hdGUg
aXQsIGFuZCBsb3dlcmNhc2UgaXQuCisgICAgc3RybmNweShidWZmZXIsIHAs
IGJ1ZnNpemUpOworICAgIGJ1ZmZlcltidWZzaXplLTFdID0gJ1wwJzsKKyAg
ICBsZW4gPSBzdHJjc3BuKGJ1ZmZlciwgIissXDAiKTsKKyAgICBidWZmZXJb
bGVuXSA9ICdcMCc7CisgICAgc3RybHdyKGJ1ZmZlcik7CisgIAorCS8vIENo
ZWNrIGlmIHRoaXMgaXMgYSBtbmVtb25pYy4gIFdlIGhhdmUgdG8gZG8gdGhp
cyBmaXJzdCBvciBzdHJ0b3VsKCkKKwkvLyB3aWxsIGZhbHNlLXRyaWdnZXIg
b24gYW55dGhpbmcgc3RhcnRpbmcgd2l0aCAiYSIgdGhyb3VnaCAiZiIuCisg
ICAgdGhpc3ZhbCA9IG1uZW1vbmljMnVsKGJ1ZmZlciwgJm5ld3ApOworICAg
IGlmKGJ1ZmZlciA9PSBuZXdwKQorICAgIHsKKyAgICAgIC8vIFRoaXMgdGVy
bSBpc24ndCBtbmVtb25pYywgY2hlY2sgaWYgaXQncyBoZXguCisJICB0aGlz
dmFsID0gc3RydG91bChidWZmZXIsICZuZXdwLCAxNik7CisgICAgICBpZihu
ZXdwICE9IGJ1ZmZlcitsZW4pCisgICAgICB7CisgICAgICAgIC8vIE5vdCBo
ZXggZWl0aGVyLCBzeW50YXggZXJyb3IuCisgICAgICAgICplbmRwdHIgPSAo
Y2hhciopcDsKKyAgICAgICAgcmV0dXJuIDA7CisgICAgICB9CisgICAgfQor
ICAgIAorICAgIHAgKz0gbGVuOworICAgIHJldHZhbCArPSB0aGlzdmFsOwor
ICAgIAorICAgIC8vIEhhbmRsZSBvcGVyYXRvcnMKKyAgICBpZigqcCA9PSAn
XDAnKSBicmVhazsKKwlpZigoKnAgPT0gJysnKSB8fCAoKnAgPT0gJywnKSkK
Kwl7CisJICAvLyBGb3Igbm93IHRoZXNlIGJvdGggZXF1YXRlIHRvIGFkZGl0
aW9uL09SaW5nLiAgVW50aWwgd2UgZ2V0CisJICAvLyBmYW5jeSBhbmQgYWRk
IHRoaW5ncyBsaWtlICJhbGwtPHNvbWV0aGluZz4iLCBhbGwgd2UgbmVlZCBk
byBpcworCSAgLy8gY29udGludWUgdGhlIGxvb3BpbmcuCisJICBwKys7CisJ
ICBjb250aW51ZTsKKwl9CisJZWxzZQorCXsKKwkJLy8gU3ludGF4IGVycm9y
CisgICAgICAgICplbmRwdHIgPSAoY2hhciopcDsKKyAgICAgICAgcmV0dXJu
IDA7CisJfQorICB9CisgIAorICAqZW5kcHRyID0gKGNoYXIqKXA7CisgIHJl
dHVybiByZXR2YWw7Cit9CisKK3N0YXRpYyB2b2lkIHVzYWdlICgpCit7Cisg
IGZwcmludGYgKHN0ZGVyciwKKyJcCitVc2FnZTogc3RyYWNlIFtPUFRJT05T
XSA8Y29tbWFuZC1saW5lPlxuXAorICAtYiwgLS1idWZmZXItc2l6ZT1TSVpF
ICAgICAgICBTZXQgc2l6ZSBvZiBvdXRwdXQgZmlsZSBidWZmZXIuXG5cCisg
IC1tLCAtLW1hc2s9TUFTSyAgICAgICAgICAgICAgIFNldCBtZXNzYWdlIGZp
bHRlciBtYXNrLlxuXAorXG5cCisgICAgTUFTSyBjYW4gYmUgYW55IGNvbWJp
bmF0aW9uIG9mIHRoZSBmb2xsb3dpbmcgbW5lbW9uaWNzIGFuZC9vciBoZXgg
dmFsdWVzXG5cCisgICAgKDB4IGlzIG9wdGlvbmFsKS4gIENvbWJpbmUgbWFz
a3Mgd2l0aCAnKycgb3IgJywnIGxpa2Ugc286XG5cCitcblwKKyAgICAgICAg
ICAgICAgICAgICAgICAtLW1hc2s9d20rc3lzdGVtLG1hbGxvYysweDAwODAw
XG5cCitcblwKKyAgICBNbmVtb25pYyBIZXggICAgIENvcnJlc3BvbmRpbmcg
RGVmICBEZXNjcmlwdGlvblxuXAorICAgID09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT1cblwKKyAgICBhbGwgICAgICAweDAwMDAxIChfU1RSQUNFX0FM
TCkgICAgICBBbGwgc3RyYWNlIG1lc3NhZ2VzLlxuXAorICAgIGZsdXNoICAg
IDB4MDAwMDIgKF9TVFJBQ0VfRkxVU0gpICAgIEZsdXNoIG91dHB1dCBidWZm
ZXIgYWZ0ZXIgZWFjaCBtZXNzYWdlLlxuXAorICAgIGluaGVyaXQgIDB4MDAw
MDQgKF9TVFJBQ0VfSU5IRVJJVCkgIENoaWxkcmVuIGluaGVyaXQgbWFzayBm
cm9tIHBhcmVudC5cblwKKyAgICB1aG9oICAgICAweDAwMDA4IChfU1RSQUNF
X1VIT0gpICAgICBVbnVzdWFsIG9yIHdlaXJkIHBoZW5vbWVub24uXG5cCisg
ICAgc3lzY2FsbCAgMHgwMDAxMCAoX1NUUkFDRV9TWVNDQUxMKSAgU3lzdGVt
IGNhbGxzLlxuXAorICAgIHN0YXJ0dXAgIDB4MDAwMjAgKF9TVFJBQ0VfU1RB
UlRVUCkgIGFyZ2MvZW52cCBwcmludG91dCBhdCBzdGFydHVwLlxuXAorICAg
IGRlYnVnICAgIDB4MDAwNDAgKF9TVFJBQ0VfREVCVUcpICAgIEluZm8gdG8g
aGVscCBkZWJ1Z2dpbmcuIFxuXAorICAgIHBhcmFub2lkIDB4MDAwODAgKF9T
VFJBQ0VfUEFSQU5PSUQpIFBhcmFub2lkIGluZm8uXG5cCisgICAgdGVybWlv
cyAgMHgwMDEwMCAoX1NUUkFDRV9URVJNSU9TKSAgSW5mbyBmb3IgZGVidWdn
aW5nIHRlcm1pb3Mgc3R1ZmYuXG5cCisgICAgc2VsZWN0ICAgMHgwMDIwMCAo
X1NUUkFDRV9TRUxFQ1QpICAgSW5mbyBvbiB1Z2x5IHNlbGVjdCBpbnRlcm5h
bHMuXG5cCisgICAgd20gICAgICAgMHgwMDQwMCAoX1NUUkFDRV9XTSkgICAg
ICAgVHJhY2UgV2luZG93cyBtc2dzIChlbmFibGUgX3N0cmFjZV93bSkuXG5c
CisgICAgc2lncCAgICAgMHgwMDgwMCAoX1NUUkFDRV9TSUdQKSAgICAgVHJh
Y2Ugc2lnbmFsIGFuZCBwcm9jZXNzIGhhbmRsaW5nLlxuXAorICAgIG1pbmlt
YWwgIDB4MDEwMDAgKF9TVFJBQ0VfTUlOSU1BTCkgIFZlcnkgbWluaW1hbCBz
dHJhY2Ugb3V0cHV0LlxuXAorICAgIGV4aXRkdW1wIDB4MDQwMDAgKF9TVFJB
Q0VfRVhJVERVTVApIER1bXAgc3RyYWNlIGNhY2hlIG9uIGV4aXQuXG5cCisg
ICAgc3lzdGVtICAgMHgwODAwMCAoX1NUUkFDRV9TWVNURU0pICAgQ2FjaGUg
c3RyYWNlIG1lc3NhZ2VzLlxuXAorICAgIG5vbXV0ZXggIDB4MTAwMDAgKF9T
VFJBQ0VfTk9NVVRFWCkgIERvbid0IHVzZSBtdXRleCBmb3Igc3luY2hyb25p
emF0aW9uLlxuXAorICAgIG1hbGxvYyAgIDB4MjAwMDAgKF9TVFJBQ0VfTUFM
TE9DKSAgIFRyYWNlIG1hbGxvYyBjYWxscy5cblwKKyAgICB0aHJlYWQgICAw
eDQwMDAwIChfU1RSQUNFX1RIUkVBRCkgICBUaHJlYWQtbG9ja2luZyBjYWxs
cy5cblwKK1xuXAorICAtbywgLS1vdXRwdXQ9RklMRU5BTUUgICAgICAgICBT
ZXQgb3V0cHV0IGZpbGUgdG8gRklMRU5BTUUuXG5cCisgIC1mLCAtLWZvcmst
ZGVidWcgICAgICAgICAgICAgID8/P1xuXAorICAtbiwgLS1lcnJvci1udW1i
ZXIgICAgICAgICAgICBBbHNvIG91dHB1dCBhc3NvY2lhdGVkIFdpbmRvd3Mg
ZXJyb3IgbnVtYmVyLlxuXAorICAtZCwgLS1kZWx0YSAgICAgICAgICAgICAg
ICAgICBBZGQgYSBkZWx0YS10IHRpbWVzdGFtcCB0byBlYWNoIG91dHB1dCBs
aW5lLlxuXAorICAtdSwgLS11c2VjcyAgICAgICAgICAgICAgICAgICBBZGQg
YSBtaWNyb3NlY29uZC1yZXNvbHV0aW9uIHRpbWVzdGFtcCB0byBlYWNoCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG91dHB1dCBsaW5lLlxu
XAorICAtdCwgLS10aW1lc3RhbXAgICAgICAgICAgICAgICBBZGQgYW4gaGht
bXNzIHRpbWVzdGFtcCB0byBlYWNoIG91dHB1dCBsaW5lLlxuXAorICAtdywg
LS1uZXctd2luZG93ICAgICAgICAgICAgICBTcGF3biBwcm9ncmFtIHVuZGVy
IHRlc3QgaW4gYSBuZXcgd2luZG93LlxuXAorICAtUywgLS1mbHVzaC1wZXJp
b2Q9UEVSSU9EICAgICBGbHVzaCBidWZmZXJlZCBzdHJhY2Ugb3V0cHV0IGV2
ZXJ5IFBFUklPRCBzZWNzLlxuXAorICAtdiwgLS12ZXJzaW9uICAgICAgICAg
ICAgICAgICBEaXNwbGF5IHZlcnNpb24gaW5mby5cblwKKyAgLWgsIC0taGVs
cCAgICAgICAgICAgICAgICAgICAgRGlzcGxheSB0aGlzIGhlbHAgaW5mby5c
blwKKyIpOworfQorCitzdGF0aWMgdm9pZCB2ZXJzaW9uICgpCit7CisJZnBy
aW50ZiAoc3RkZXJyLCAiTm90IHlldCBpbXBsZW1lbnRlZC4iKTsKK30KKwor
c3RydWN0IG9wdGlvbiBsb25nb3B0c1tdID0KK3sKKyAgeyJoZWxwIiwgbm9f
YXJndW1lbnQsIE5VTEwsICdoJyB9LAorICB7InZlcnNpb24iLCBub19hcmd1
bWVudCwgTlVMTCwgJ3YnIH0sCisgIHsiYnVmZmVyLXNpemUiLCByZXF1aXJl
ZF9hcmd1bWVudCwgTlVMTCwgJ2InfSwKKyAgeyJtYXNrIiwgcmVxdWlyZWRf
YXJndW1lbnQsIE5VTEwsICdtJ30sCisgIHsib3V0cHV0IiwgcmVxdWlyZWRf
YXJndW1lbnQsIE5VTEwsICdvJ30sCisgIHsiZm9yay1kZWJ1ZyIsIG5vX2Fy
Z3VtZW50LCBOVUxMLCAnZid9LAorICB7ImVycm9yLW51bWJlciIsIG5vX2Fy
Z3VtZW50LCBOVUxMLCAnbid9LAorICB7ImRlbHRhIiwgbm9fYXJndW1lbnQs
IE5VTEwsICdkJ30sCisgIHsidXNlY3MiLCBub19hcmd1bWVudCwgTlVMTCwg
J3UnfSwKKyAgeyJ0aW1lc3RhbXAiLCBub19hcmd1bWVudCwgTlVMTCwgJ3Qn
fSwKKyAgeyJuZXctd2luZG93Iiwgbm9fYXJndW1lbnQsIE5VTEwsICd3J30s
CisgIHsiZmx1c2gtcGVyaW9kIiwgcmVxdWlyZWRfYXJndW1lbnQsIE5VTEws
ICdTJ30sCisgIHtOVUxMLCAwLCBOVUxMLCAwfQorfTsKKworc3RhdGljIGNv
bnN0IGNoYXIgKmNvbnN0IG9wdHMgPSAiaHZiOm06bzpmbmR1dHdTOiI7CisK
IGludAogbWFpbiAoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogewpAQCAtNjE0
LDkgKzgwMSwxOSBAQCBtYWluIChpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAg
IGVsc2UKICAgICBwZ20rKzsKIAotICB3aGlsZSAoKG9wdCA9IGdldG9wdCAo
YXJnYywgYXJndiwgImI6bTpvOmZuZHV0d1M6IikpICE9IEVPRikKKyAgd2hp
bGUgKChvcHQgPSBnZXRvcHRfbG9uZyAoYXJnYywgYXJndiwgb3B0cywgbG9u
Z29wdHMsIE5VTEwpKSAhPSBFT0YpCiAgICAgc3dpdGNoIChvcHQpCiAgICAg
ICB7CisgICAgICBjYXNlICdoJzoKKyAgICAvLyBQcmludCBoZWxwIGFuZCBl
eGl0CisgICAgdXNhZ2UgKCk7CisgICAgcmV0dXJuIDE7CisgICAgYnJlYWs7
CisgICAgICBjYXNlICd2JzoKKyAgICAvLyBQcmludCB2ZXJzaW9uIGluZm8g
YW5kIGV4aXQKKyAgICB2ZXJzaW9uICgpOworICAgIHJldHVybiAxOworICAg
IGJyZWFrOwogICAgICAgY2FzZSAnZic6CiAJZm9ya2RlYnVnIF49IDE7CiAJ
YnJlYWs7CkBAIC02MjQsOCArODIxLDE3IEBAIG1haW4gKGludCBhcmdjLCBj
aGFyICoqYXJndikKIAlidWZzaXplID0gYXRvaSAob3B0YXJnKTsKIAlicmVh
azsKICAgICAgIGNhc2UgJ20nOgotCW1hc2sgPSBzdHJ0b3VsIChvcHRhcmcs
IE5VTEwsIDE2KTsKKyAgICAgIHsKKwkgICAgY2hhciAqZW5kcHRyOworCSAg
ICBtYXNrID0gcGFyc2VfbWFzayAob3B0YXJnLCAmZW5kcHRyKTsKKwkgICAg
aWYoKmVuZHB0ciAhPSAnXDAnKQorCSAgICB7CisJICAgICAgLy8gQmFkIG1h
c2sgZXhwcmVzc2lvbi4KKwkgICAgICBlcnJvcigwLCAic3ludGF4IGVycm9y
IGluIG1hc2sgZXhwcmVzc2lvbiBcIiVzXCIgbmVhciBcCitjaGFyYWN0ZXIg
IyVkLlxuIiwgb3B0YXJnLCAoaW50KShlbmRwdHItb3B0YXJnKSwgZW5kcHRy
KTsKKwkgICAgfQogCWJyZWFrOworCSAgfQogICAgICAgY2FzZSAnbyc6CiAJ
aWYgKChvZmlsZSA9IGZvcGVuIChvcHRhcmcsICJ3IikpID09IE5VTEwpCiAJ
ICBlcnJvciAoMSwgImNhbid0IG9wZW4gJXMiLCBvcHRhcmcpOwo=

------------=_1583532850-65438-115--
