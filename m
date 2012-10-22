Return-Path: <cygwin-patches-return-7742-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29496 invoked by alias); 22 Oct 2012 04:09:51 -0000
Received: (qmail 29480 invoked by uid 22791); 22 Oct 2012 04:09:50 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 22 Oct 2012 04:09:44 +0000
Received: from pool-72-74-71-200.bstnma.fios.verizon.net ([72.74.71.200] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TQ9Kh-00019e-ML; Mon, 22 Oct 2012 04:09:43 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id C099E13C005;	Mon, 22 Oct 2012 00:09:42 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18gCDNcJe0wwrrDj/HCPKIr
Date: Mon, 22 Oct 2012 04:09:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: earnie@users.sourceforge.net
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121022040942.GA9515@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, earnie@users.sourceforge.net
References: <20121017193258.GA15271@ednor.casa.cgf.cx> <1350545597.3492.59.camel@YAAKOV04> <20121018083419.GC6221@calimero.vinschen.de> <1350580828.3492.73.camel@YAAKOV04> <20121019092135.GA22432@calimero.vinschen.de> <1350664438.3492.114.camel@YAAKOV04> <20121019184636.GZ25877@calimero.vinschen.de> <20121021113320.GA2469@calimero.vinschen.de> <20121021171053.GA24725@ednor.casa.cgf.cx> <1350844361.1244.54.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1350844361.1244.54.camel@YAAKOV04>
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
X-SW-Source: 2012-q4/txt/msg00019.txt.bz2

On Sun, Oct 21, 2012 at 01:32:41PM -0500, Yaakov (Cygwin/X) wrote:
>On Sun, 2012-10-21 at 13:10 -0400, Christopher Faylor wrote:
>>That said, is it time to ask the mingw.org stuff to relocate their CVS
>>repo?  I could tar up the affected CVS directories for them if so.
>
>What about some CVSROOT/modules magic to exclude winsup/mingw and
>winsup/w32api from a Cygwin checkout?
>
>1) change the existing cygwin module to naked-cygwin; 2) add a new
>cygwin module with "-a src-support naked-cygwin naked-newlib
>naked-include"; 3) change the directions on cvs.html to "cvs co cygwin"
>instead of "cvs co winsup" for new checkouts; 4) devs with existing
>checkouts could just rm -fr winsup/mingw winsup/w32api if they so
>choose (but with the patch, they won't be used anymore even if
>present).
>
>As mingw.org already treats winsup/mingw and winsup/w32api as separate
>repos[1], that should do the trick for us without forcing them to move.
>Given our long-standing cooperation until now, I think it's the least
>we could do.

I wasn't trying to punish anyone.  I actually thought that they probably
hadn't moved already mainly out of courtesy to us.  I vaguely recall some
rumbling about this in the past.

I've cc'ed Earnie to see how he feels about it.

Earnie, we seem to be transitioning from the need to have a mingw/w32api
in the source tree.  What do you think about removing these directories
from the depot and moving repo to sourceforge, or some other place?

You've got a home for as long as you like on sourceware.org but I was
thinking that it might be advantageous for mingw to move anyway.

If it helps, I can provide tar copies of the directories from
sourceware.

Alternately, I can also provide you with a top-level directory at
sourceware.org if that is preferable.

cgf
