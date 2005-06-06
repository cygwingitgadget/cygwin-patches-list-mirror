Return-Path: <cygwin-patches-return-5527-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17997 invoked by alias); 6 Jun 2005 22:54:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17965 invoked by uid 22791); 6 Jun 2005 22:54:11 -0000
Received: from nat.electric-cloud.com (HELO main.electric-cloud.com) (63.82.0.114)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 06 Jun 2005 22:54:11 +0000
Received: from fulgurite.electric-cloud.com (fulgurite.electric-cloud.com [192.168.1.58])
	(authenticated bits=0)
	by main.electric-cloud.com (8.12.9/8.12.9) with ESMTP id j56Ms9M2024208
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <cygwin-patches@cygwin.com>; Mon, 6 Jun 2005 15:54:09 -0700
Subject: Re: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take
	3
From: Max Kaehn <slothman@electric-cloud.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20050606213339.GC16960@trixie.casa.cgf.cx>
References: <1118084587.5031.128.camel@fulgurite>
	 <20050606200639.GC13442@trixie.casa.cgf.cx>
	 <1118091704.5031.144.camel@fulgurite>
	 <20050606213339.GC16960@trixie.casa.cgf.cx>
Content-Type: text/plain
Message-Id: <1118098448.5031.157.camel@fulgurite>
Mime-Version: 1.0
Date: Mon, 06 Jun 2005 22:54:00 -0000
Content-Transfer-Encoding: 7bit
X-Spam-Not-Checked:  Messages over 100K or from internal Electric Cloud machines are not checked
X-SW-Source: 2005-q2/txt/msg00123.txt.bz2

On Mon, 2005-06-06 at 14:33, Christopher Faylor wrote:
> There were still some braces at the end of the line in cygload.h so I
> changed those.  I also changed the ChangeLog entry "now tests cygload"
> to "Test cygload".  See http://cygwin.com/contrib.html for some common
> mistakes in ChangeLog entries.

Got it.  (Still wrapping my brain around using the present tense. :-) )

> So, I checked in the above and, after changing cygload.exp so that it
> compiles cygload.cc rather than cygload.cpp, I found a more serious
> error.  I've attached the cygload.log file.  It doesn't look pretty,
> unfortunately.  You might notice the same thing if you configure your
> Cygwin DLL with --enable-debugging, like I do.

Aha!  I'll rebuild and investigate.  Thanks.

> Another problem is that since you have separated out the Makefile into
> two separate invocations of $(RUNTEST) the error return from the Makefile
> will not be set correctly.  To preserve previous operation, the makefile
> should do all of the tests and then return with a status of zero if things
> completed correctly or nonzero otherwise.

My goof.  Like this?

Index: winsup/testsuite/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/Makefile.in,v
retrieving revision 1.20
diff -u -p -r1.20 Makefile.in
--- winsup/testsuite/Makefile.in        6 Jun 2005 21:13:31 -0000      
1.20
+++ winsup/testsuite/Makefile.in        6 Jun 2005 22:49:40 -0000
@@ -186,7 +186,7 @@ check: $(TESTSUP_LIB_NAME) $(RUNTIME) cy
           TCL_LIBRARY=`cd .. ; cd ${srcdir}/../../tcl/library ; pwd` ;
\
            export TCL_LIBRARY ; fi ; \
        PATH=$(bupdir)/cygwin:$${PATH} ;\
-       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) ;\
+       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) ||\
        $(RUNTEST) --tool cygload $(RUNTESTFLAGS)

