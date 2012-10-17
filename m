Return-Path: <cygwin-patches-return-7725-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28273 invoked by alias); 17 Oct 2012 16:44:51 -0000
Received: (qmail 28262 invoked by uid 22791); 17 Oct 2012 16:44:48 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 17 Oct 2012 16:44:42 +0000
Received: from pool-173-76-44-35.bstnma.fios.verizon.net ([173.76.44.35] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TOWjZ-000Afq-9h	for cygwin-patches@cygwin.com; Wed, 17 Oct 2012 16:44:41 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id A9F6613C005	for <cygwin-patches@cygwin.com>; Wed, 17 Oct 2012 12:44:40 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX183r4AJPZIVkkDedhBv+Sn0
Date: Wed, 17 Oct 2012 16:44:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121017164440.GA12989@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00002.txt.bz2

On Wed, Oct 17, 2012 at 06:13:18PM +0200, Kai Tietz wrote:
>Hello everybody,

I have no objections whatsoever to these changes in principle but I
would rather wait until after the 1.7.17 release for their checkin.

Other comments below.

>Index: winsup/utils/mingw
>===================================================================
>RCS file: /cvs/src/src/winsup/utils/mingw,v
>retrieving revision 1.8
>diff -p -u -3 -r1.8 mingw
>--- winsup/utils/mingw	14 Jun 2011 15:04:04 -0000	1.8
>+++ winsup/utils/mingw	17 Oct 2012 15:21:33 -0000
>@@ -5,17 +5,82 @@
> #
> # Find the path to the compiler.
> #
>+cpu=$1; shift
> compiler=$1; shift
> dir=$(cd $(dirname $("$compiler" -print-prog-name=ld))/../..; pwd)
>
> #
>+# Find the tool's name without the target-prefix
>+#
>+case $compiler in

>+*-*-*-*)

Your formatting does not match the rest of the file here ^.

>+tool=`echo "$compiler" | sed 's/^\([^-]*\)-\([^-]*\)-\([^-]*\)-\(.*\)$/\4/'` ;;
>+*) tool=compiler ;;
>+esac
>+
>+#
> # The mingw32 directory should live somewhere close by to the
> # compiler.  Search for it.
> #
>-[ "$dir" = '/' ] && dir=''
>+[ "$dir" = '/' ] && dir='';

No need for a semicolon here.

I have other comments but I wonder if it would just be best to scrap this
script and assume that there is a mingw compiler installed.  When I first
wrote this script there was no mingw compiler in the distro.  Now there
is.  So I think we should just make that a requirement for building.

Then, no more head standing is required.

>Index: winsup/Makefile.common
>===================================================================
>RCS file: /cvs/src/src/winsup/Makefile.common,v
>retrieving revision 1.59
>diff -p -u -3 -r1.59 Makefile.common
>--- winsup/Makefile.common	30 Jul 2012 04:43:21 -0000	1.59
>+++ winsup/Makefile.common	17 Oct 2012 15:21:32 -0000

Can we just get rid of this as well?  That's what I did in my now-unneeded
revamp of the configury in the cygwin git repository.

I think I'd rather just move everything into winsup, cygserver, utils and
not bother with this "common" stuff.

>Index: winsup/utils/mingw
>===================================================================
>RCS file: /cvs/src/src/winsup/utils/mingw,v
>retrieving revision 1.8
>diff -p -u -3 -r1.8 mingw
>--- winsup/utils/mingw	14 Jun 2011 15:04:04 -0000	1.8
>+++ winsup/utils/mingw	17 Oct 2012 15:21:33 -0000

Looks like you included some stuff twice?

cgf
