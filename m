Return-Path: <cygwin-patches-return-7030-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27088 invoked by alias); 6 May 2010 13:49:10 -0000
Received: (qmail 27075 invoked by uid 22791); 6 May 2010 13:49:09 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-55-5.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.55.5)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 06 May 2010 13:49:04 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id B35C313C061	for <cygwin-patches@cygwin.com>; Thu,  6 May 2010 09:49:02 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 53BEB2B352; Thu,  6 May 2010 09:49:02 -0400 (EDT)
Date: Thu, 06 May 2010 13:49:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: CFA: pseudo-reloc v2
Message-ID: <20100506134901.GA21258@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC7910E.1010900@cwilson.fastmail.fm> <4AC82056.7060308@cwilson.fastmail.fm> <4BE1A2C5.4090604@gmail.com> <20100505175614.GA6651@ednor.casa.cgf.cx> <4BE1BFCC.6060703@gmail.com> <20100505191317.GA14692@ednor.casa.cgf.cx> <4BE23275.1030009@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BE23275.1030009@cwilson.fastmail.fm>
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
X-SW-Source: 2010-q2/txt/msg00013.txt.bz2

On Wed, May 05, 2010 at 11:07:33PM -0400, Charles Wilson wrote:
>On 5/5/2010 3:13 PM, Christopher Faylor wrote:
>
>> That's basically it and I have it more-or-less coded but I haven't
>> finished thinking about DLLs.  Maybe that's more complication than is
>> warranted.  I have to do more research there.  We could, and I think
>> should, put most of the code in pseudo_reloc.c in cygwin1.dll, though,
>> rather than duplicate it in every source file.
>
>I disagree with this statement.
>
>I spent a lot of effort trying to synchronize our version of
>pseudo_reloc.c with the mingw and mingw64 versions -- specifically so
>that we could leverage Kai's v2 efforts.
>
>If we -- meaning cygwin -- move most of the guts into the cygwin DLL,
>then ... we either
>  (1) fork our version from the mingw[32|64] version permanently, and
>lose the possibility of "easy" code sharing between the three projects, or
>  (2) this portion of the code lives in both places (pseudo_reloc.c and
>some-other-cygwin-dll-source-file), but is #ifdef'ed in pseudo_reloc.c
>when compiled on cygwin, because there's this other identical copy over
>in some-other-cygwin-dll-source-file.

I kept the ifdef __CYGWIN__ stuff.  Moving the code into the DLL
actually simplifies the Cygwin part quite a bit since you can use things
like "winsup.h" and "small_printf".  And, my changes don't permute
things as much as Dave's.  Dave's changes were not really MinGW
friendly.

>Yuck.  (I don't mind "losing" the effort I put in, because whatever
>happens we now have v2 support.  But...why make it harder if somebody
>in mingw-land invents v3?  Or make it harder on them, if WE do?)

And, why not make it so that potentially all that is required for v3
support is a DLL upgrade rather than a rebuild?

cgf
