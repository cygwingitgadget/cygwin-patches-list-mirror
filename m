Return-Path: <cygwin-patches-return-7775-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22959 invoked by alias); 13 Nov 2012 17:39:10 -0000
Received: (qmail 22947 invoked by uid 22791); 13 Nov 2012 17:39:09 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 13 Nov 2012 17:39:02 +0000
Received: from pool-98-110-183-145.bstnma.fios.verizon.net ([98.110.183.145] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TYKRx-000Dhq-S9	for cygwin-patches@cygwin.com; Tue, 13 Nov 2012 17:39:01 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 95ABB13C0C7	for <cygwin-patches@cygwin.com>; Tue, 13 Nov 2012 12:39:00 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/h9QdLyPNPezoFRAo2rIav
Date: Tue, 13 Nov 2012 17:39:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [WIP] mingw64 related changes to Cygwin configure and other assorted files with departed w32api/mingw
Message-ID: <20121113173900.GA13846@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121112200223.GA16672@ednor.casa.cgf.cx> <20121112215023.GA1436@calimero.vinschen.de> <20121113000257.GA13261@ednor.casa.cgf.cx> <20121113033105.GA24866@ednor.casa.cgf.cx> <20121113093301.GA23491@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121113093301.GA23491@calimero.vinschen.de>
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
X-SW-Source: 2012-q4/txt/msg00052.txt.bz2

On Tue, Nov 13, 2012 at 10:33:01AM +0100, Corinna Vinschen wrote:
>On Nov 12 22:31, Christopher Faylor wrote:
>> On Mon, Nov 12, 2012 at 07:02:57PM -0500, Christopher Faylor wrote:
>> >On Mon, Nov 12, 2012 at 10:50:23PM +0100, Corinna Vinschen wrote:
>> >>I'm a bit puzzled about the necessity of some of the changes to source
>> >>files.  Yaakov's Fedora 17 version of the headers is supposedly cut from
>> >>the mingw64 trunk on 2012-10-16, while JonY's official headers have an
>> >>upload date of 2012-10-18.  They should be practically identical.  Why
>> >>do I not see any problems to build CVS HEAD?!?
>> >
>> >You can keep asking me this question but I don't really have an answer.
>> >Since I don't run Fedora, I'm not going to install it to figure it out.
>
>I just checked and there's no difference in the header files at all.
>Yaakov's version == JonY's version.
>
>> Actually, an idea came to me in the thinking room that this might be due
>> to the fact that my windows headers may not be considered to be system
>> headers since they aren't in a preinstalled location.  I know that gcc
>> can be more lax about redefine symbols in some situations when dealing
>> with system headers.  Maybe that's it.
>
>Looks like it.  The w32api headers are system headers so -isystem rather
>than -idirafter should show a better result without requiring any of the
>source file changes.

Maybe I can use -isystem with ccwraper.  I'd previously gotten things
working without the wrapper, using idirafter so that's what I stuck
with.  However, the wrapper may now allow just always including the
windows headers last.

>Especially having to define _WIN32 in winlean.h and winsup.h looks
>pretty wrong.  I would also like to keep the ifndef/define brackets in
>the headers since
>
>  #ifndef _CYGWIN_IF_H_
>  #define _CYGWIN_IF_H_
>
>can be tested for in other headers while #pragma once can not.

I think that testing for "BLAH_DECLARED" for individual definitions is a
much better way to see if something is defined than relying on an
implementation detail like "_CYGWIN_IF_H".  Those are not supposed to be
a published interface.  In theory anyone could change those to something
like:

#ifndef _CYGWIN_IF_INCLUDED
#define _CYGWIN_IF_INCLUDED

and they would have been within their rights to do that.  I always felt
that it was wrong to be testing for those guards, even when I was doing
it.

However, I won't check those changes in.

cgf
