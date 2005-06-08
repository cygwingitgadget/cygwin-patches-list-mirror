Return-Path: <cygwin-patches-return-5535-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13185 invoked by alias); 8 Jun 2005 18:44:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13152 invoked by uid 22791); 8 Jun 2005 18:44:07 -0000
Received: from nat.electric-cloud.com (HELO main.electric-cloud.com) (63.82.0.114)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 08 Jun 2005 18:44:07 +0000
Received: from fulgurite.electric-cloud.com (fulgurite.electric-cloud.com [192.168.1.58])
	(authenticated bits=0)
	by main.electric-cloud.com (8.12.9/8.12.9) with ESMTP id j58Ii5M2011623
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <cygwin-patches@cygwin.com>; Wed, 8 Jun 2005 11:44:05 -0700
Subject: Re: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take
	3
From: Max Kaehn <slothman@electric-cloud.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20050606235137.GE16960@trixie.casa.cgf.cx>
References: <1118084587.5031.128.camel@fulgurite>
	 <20050606200639.GC13442@trixie.casa.cgf.cx>
	 <1118091704.5031.144.camel@fulgurite>
	 <20050606213339.GC16960@trixie.casa.cgf.cx>
	 <1118098448.5031.157.camel@fulgurite>
	 <Pine.GSO.4.61.0506061907220.15703@slinky.cs.nyu.edu>
	 <1118099492.5031.160.camel@fulgurite>
	 <20050606235137.GE16960@trixie.casa.cgf.cx>
Content-Type: text/plain
Message-Id: <1118256244.5031.2661.camel@fulgurite>
Mime-Version: 1.0
Date: Wed, 08 Jun 2005 18:44:00 -0000
Content-Transfer-Encoding: 7bit
X-Spam-Not-Checked:  Messages over 100K or from internal Electric Cloud machines are not checked
X-SW-Source: 2005-q2/txt/msg00131.txt.bz2

On Mon, 2005-06-06 at 16:51, Christopher Faylor wrote:
> Actually neither is right.  The tests are supposed to run to
> completion, not stop on a failure.

My first cut was this, but it could have led to a tedious
accumulation of if/then/else/if/then/else:

Index: winsup/testsuite/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/Makefile.in,v
retrieving revision 1.20
diff -u -p -r1.20 Makefile.in
--- winsup/testsuite/Makefile.in        6 Jun 2005 21:13:31 -0000       1.20
+++ winsup/testsuite/Makefile.in        7 Jun 2005 01:28:25 -0000
@@ -186,8 +186,11 @@ check: $(TESTSUP_LIB_NAME) $(RUNTIME) cy
           TCL_LIBRARY=`cd .. ; cd ${srcdir}/../../tcl/library ; pwd` ; \
            export TCL_LIBRARY ; fi ; \
        PATH=$(bupdir)/cygwin:$${PATH} ;\
-       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) ;\
-       $(RUNTEST) --tool cygload $(RUNTESTFLAGS)
+       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) ; WINSUPSTATUS=$$?;\
+       $(RUNTEST) --tool cygload $(RUNTESTFLAGS) ; CYGLOADSTATUS=$$?;\
+       if [ $$WINSUPSTATUS -ne 0 ] ; then \
+           exit $$WINSUPSTATUS; \
+       else exit $$CYGLOADSTATUS; fi;

 cygrun.o: cygrun.c
        $(CC) $(MINGW_CFLAGS) -o $@ -c $<


So I wrote a more general script, discovered that cygwin uses ash
instead of bash for /bin/sh, and rewrote the more general script so
ash could handle it.  Since ash doesn't seem to support arrays,
I wound up using "eval", and was thoroughly perplexed at the way
that the first "eval" seems to get thrown away.

Index: winsup/testsuite/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/Makefile.in,v
retrieving revision 1.20
diff -u -p -r1.20 Makefile.in
--- winsup/testsuite/Makefile.in        6 Jun 2005 21:13:31 -0000       1.20
+++ winsup/testsuite/Makefile.in        8 Jun 2005 18:39:42 -0000
@@ -179,6 +179,8 @@ testsuite/site.exp: site.exp

 # Note: we set the PATH so that we can pick up cygwin0.dll

+TOOLS = winsup cygload
+
 check: $(TESTSUP_LIB_NAME) $(RUNTIME) cygrun.exe testsuite/site.exp
        cd testsuite; \
        EXPECT=${EXPECT} ; export EXPECT ; \
@@ -186,8 +188,18 @@ check: $(TESTSUP_LIB_NAME) $(RUNTIME) cy
           TCL_LIBRARY=`cd .. ; cd ${srcdir}/../../tcl/library ; pwd` ; \
            export TCL_LIBRARY ; fi ; \
        PATH=$(bupdir)/cygwin:$${PATH} ;\
-       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) ;\
-       $(RUNTEST) --tool cygload $(RUNTESTFLAGS)
+       eval ""; \
+       for tool in $(TOOLS); do \
+           $(RUNTEST) --tool $$tool $(RUNTESTFLAGS); \
+           eval "results_$$tool=$$?"; \
+       done; \
+       for tool in $(TOOLS) ; do \
+           eval "result=\$$results_$$tool"; \
+           if [ $${result:-0} -ne 0 ] ; then \
+               echo "$$tool failed: $$result"; \
+               exit $$result; \
+           fi; \
+       done;

 cygrun.o: cygrun.c
        $(CC) $(MINGW_CFLAGS) -o $@ -c $<

