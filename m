Return-Path: <cygwin-patches-return-7835-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14291 invoked by alias); 22 Feb 2013 14:32:19 -0000
Received: (qmail 14274 invoked by uid 22791); 22 Feb 2013 14:32:17 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,TW_SF
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 22 Feb 2013 14:32:08 +0000
Received: from pool-173-76-49-193.bstnma.fios.verizon.net ([173.76.49.193] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1U8tfT-000DWy-Li	for cygwin-patches@cygwin.com; Fri, 22 Feb 2013 14:32:07 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id EFF58880493	for <cygwin-patches@cygwin.com>; Fri, 22 Feb 2013 09:32:06 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19qQ41Q8i0Xv5taUPeAaSKk
Date: Fri, 22 Feb 2013 14:32:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Export <io.h> symbols with underscore
Message-ID: <20130222143206.GC8104@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130221011432.GA2786@ednor.casa.cgf.cx> <20130221111545.GA24054@calimero.vinschen.de> <20130221194236.GA1163@ednor.casa.cgf.cx> <20130222001848.7049805a@YAAKOV04> <20130222065110.GA7834@ednor.casa.cgf.cx> <20130222080025.GI28458@calimero.vinschen.de> <20130222084951.GJ28458@calimero.vinschen.de> <20130222034047.778e1e12@YAAKOV04> <20130222095128.GF21700@calimero.vinschen.de> <20130222100255.GA32597@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130222100255.GA32597@calimero.vinschen.de>
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
X-SW-Source: 2013-q1/txt/msg00046.txt.bz2

On Fri, Feb 22, 2013 at 11:02:55AM +0100, Corinna Vinschen wrote:
>On Feb 22 10:51, Corinna Vinschen wrote:
>> On Feb 22 03:40, Yaakov wrote:
>> > On Fri, 22 Feb 2013 09:49:51 +0100, Corinna Vinschen wrote:
>> > > > access should go, no doubt about it.
>> > > > 
>> > > > For get_osfhandle and setmode I would prefer maintaining backward
>> > > > compatibility with existing applications.  Both variations, with and
>> > > > without underscore are definitely in use.
>> > > > 
>> > > > What about exporting the underscored variants only, but define the
>> > > > non-underscored ones:
>> > > > 
>> > > >   extern long _get_osfhandle(int);
>> > > >   #define get_osfhandle(i) _get_osfhandle(i)
>> > > > 
>> > > >   extern int _setmode (int __fd, int __mode);
>> > > >   #define setmode(f,m) _setmode((f),(m))
>> > > 
>> > > Just to be clear:  On 32 bit we should keep the exported symbols, too.
>> > > On 64 bit we can drop the non-underscored ones (which just requires
>> > > to rebuild gawk for me) and only keep the defines for backward
>> > > compatibility.
>> > 
>> > Like this?
>> 
>> Almost.  The _setmode needs a tweak, too.  I also think it makes
>> sense to rename the functions inside of syscalls.cc:
>> [...]
>
>I applied this patch to the 64 bit branch for now.

I was actually expecting that we'd break the compilation of existing
applications which incorrectly referenced get_osfhandle and setmode (I
have a couple of those).  It's a simple fix if someone recompiles and
it wouldn't be the first time that you'd have to make a source code
change when upreving to a new "OS".  For 32-bit we would need to keep
both in cygwin.din though, of course.

But, if you're going to use defines, why not just simplify them as:

#define get_osfhandle _get_osfhandle
#define setmode _setmode

?

cgf
