Return-Path: <cygwin-patches-return-5618-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1688 invoked by alias); 16 Aug 2005 16:38:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1566 invoked by uid 22791); 16 Aug 2005 16:38:24 -0000
Received: from slinky.cs.nyu.edu (HELO slinky.cs.nyu.edu) (128.122.20.14)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 16 Aug 2005 16:38:24 +0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id j7GGcMuA024277
	for <cygwin-patches@cygwin.com>; Tue, 16 Aug 2005 12:38:22 -0400 (EDT)
Date: Tue, 16 Aug 2005 16:38:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix cygrunsrv invocation in cygcheck
Message-ID: <Pine.GSO.4.61.0508161203480.9560@slinky.cs.nyu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-992951867-1124210302=:9560"
X-SW-Source: 2005-q3/txt/msg00073.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-992951867-1124210302=:9560
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 2056

As mentioned in <http://cygwin.com/ml/cygwin/2005-08/msg00724.html>, I
noticed something strange in the "cygcheck -s" output:

/usr/bin/cygrunsrv: Exactly one of --install, --remove, --start, --stop, --query, or --list is required
Try `/usr/bin/cygrunsrv --help' for more information.

strace shows the following arguments:

  106   11167 [main] cygrunsrv 2116 build_argv: argv[0] = 'C:\cygwin\bin\cygrunsrv.exe'
   20   11187 [main] cygrunsrv 2116 build_argv: argv[1] = '--query'
   19   11206 [main] cygrunsrv 2116 build_argv: argv[2] = 'in\cygrunsrv.exe'
   18   11224 [main] cygrunsrv 2116 build_argv: argv[3] = '--list'
   18   11242 [main] cygrunsrv 2116 build_argv: argc 4

which is obviously wrong.  The attached patch fixes it.  No copyright
assignment here, but the patch is trivial.

Besides the bug, the invocation code has a bit of an inefficiency.  The
inefficiency is in the following code (in pseudocode, for conciseness):

   f = popen("cygrunsrv --list");
   fread(buf, 1, sizeof(buf), f);
   pclose(f);
   for (char *srv = strtok(buf, "\n"); srv; srv = strtok(NULL, "\n")) {
      if (verbose)
         f = popen("cygrunsrv --list --verbose");
      else ...
      copy_output(f, stdout);
      if (verbose) break;
   }

why not simply run "cygrunsrv --list --verbose" in verbose mode, instead
of actually going through one iteration of the loop?  Simply to reuse the
"copy output" code?  Brian?
	Igor
==============================================================================
ChangeLog:
2005-08-16  Igor Pechtchanski  <pechtcha@cs.nyu.edu>

	* cygcheck.cc (dump_sysinfo_services): Terminate command output
	before running strtok().

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

If there's any real truth it's that the entire multidimensional infinity
of the Universe is almost certainly being run by a bunch of maniacs. /DA
---559023410-992951867-1124210302=:9560
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cygcheck-cygrunsrv-fix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.61.0508161238220.9560@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="cygcheck-cygrunsrv-fix.patch"
Content-length: 1286

SW5kZXg6IGN5Z2NoZWNrLmNjDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC91dGlscy9jeWdjaGVjay5j
Yyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNzYNCmRpZmYgLXUgLXAgLXIx
Ljc2IGN5Z2NoZWNrLmNjDQotLS0gY3lnY2hlY2suY2MJMTkgSnVsIDIwMDUg
MjE6MDA6MzQgLTAwMDAJMS43Ng0KKysrIGN5Z2NoZWNrLmNjCTE2IEF1ZyAy
MDA1IDE2OjM0OjI4IC0wMDAwDQpAQCAtOTI5LDcgKzkyOSw3IEBAIGR1bXBf
c3lzaW5mb19zZXJ2aWNlcyAoKQ0KICAgICAgIHByaW50ZiAoIkZhaWxlZCB0
byBleGVjdXRlICclcycsIHNraXBwaW5nIHNlcnZpY2VzIGNoZWNrLlxuIiwg
YnVmKTsNCiAgICAgICByZXR1cm47DQogICAgIH0NCi0gIHNpemVfdCBuY2hh
cnMgPSBmcmVhZCAoKHZvaWQgKikgYnVmLCAxLCBzaXplb2YgKGJ1ZiksIGYp
Ow0KKyAgc2l6ZV90IG5jaGFycyA9IGZyZWFkICgodm9pZCAqKSBidWYsIDEs
IHNpemVvZiAoYnVmKSAtIDEsIGYpOw0KICAgcGNsb3NlIChmKTsNCiANCiAg
IC8qIHdlcmUgYW55IHNlcnZpY2VzIGZvdW5kPyAgKi8NCkBAIC05MzksNiAr
OTM5LDggQEAgZHVtcF9zeXNpbmZvX3NlcnZpY2VzICgpDQogICAgICAgcmV0
dXJuOw0KICAgICB9DQogDQorICBidWZbbmNoYXJzXSA9ICdcMCc7DQorDQog
ICAvKiBJbiB2ZXJib3NlIG1vZGUsIGp1c3QgcnVuICdjeWdydW5zcnYgLS1s
aXN0IC0tdmVyYm9zZScgYW5kIGNvcHkgdGhlDQogICAgICBlbnRpcmUgb3V0
cHV0LiAgT3RoZXJ3aXNlIHJ1biAnY3lncnVuc3J2IC0tcXVlcnknIGZvciBl
YWNoIHNlcnZpY2UuICAqLw0KICAgZm9yIChjaGFyICpzcnYgPSBzdHJ0b2sg
KGJ1ZiwgIlxuIik7IHNydjsgc3J2ID0gc3RydG9rIChOVUxMLCAiXG4iKSkN
Cg==

---559023410-992951867-1124210302=:9560--
