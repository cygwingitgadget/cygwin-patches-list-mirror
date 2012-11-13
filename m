Return-Path: <cygwin-patches-return-7778-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25417 invoked by alias); 13 Nov 2012 18:44:52 -0000
Received: (qmail 25405 invoked by uid 22791); 13 Nov 2012 18:44:51 -0000
X-SWARE-Spam-Status: No, hits=-1.4 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 13 Nov 2012 18:44:44 +0000
Received: from pool-98-110-183-145.bstnma.fios.verizon.net ([98.110.183.145] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TYLTX-000HaK-Fw	for cygwin-patches@cygwin.com; Tue, 13 Nov 2012 18:44:43 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id E0E7C13C0C7	for <cygwin-patches@cygwin.com>; Tue, 13 Nov 2012 13:44:42 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19WMgC8OV5e/cR9IU6VgumJ
Date: Tue, 13 Nov 2012 18:44:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [WIP] mingw64 related changes to Cygwin configure and other assorted files with departed w32api/mingw
Message-ID: <20121113184442.GA13205@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121112200223.GA16672@ednor.casa.cgf.cx> <20121112215023.GA1436@calimero.vinschen.de> <20121113000257.GA13261@ednor.casa.cgf.cx> <20121113033105.GA24866@ednor.casa.cgf.cx> <20121113093301.GA23491@calimero.vinschen.de> <20121113173900.GA13846@ednor.casa.cgf.cx> <20121113181908.GA27964@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121113181908.GA27964@calimero.vinschen.de>
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
X-SW-Source: 2012-q4/txt/msg00055.txt.bz2

On Tue, Nov 13, 2012 at 07:19:08PM +0100, Corinna Vinschen wrote:
>On Nov 13 12:39, Christopher Faylor wrote:
>> On Tue, Nov 13, 2012 at 10:33:01AM +0100, Corinna Vinschen wrote:
>> >I would also like to keep the ifndef/define brackets in
>> >the headers since
>> >
>> >  #ifndef _CYGWIN_IF_H_
>> >  #define _CYGWIN_IF_H_
>> >
>> >can be tested for in other headers while #pragma once can not.
>> 
>> I think that testing for "BLAH_DECLARED" for individual definitions is a
>> much better way to see if something is defined than relying on an
>> implementation detail like "_CYGWIN_IF_H".
>
>Sure.
>
>This might not be of much interest for the headers in the include/cygwin
>subdir, but there are applications out there which test for such header
>defines, and there are also applications using system-specific headers
>liberally.  Out of curiosity I had a look and none of the Linux/glibc
>headers seem to use #pragma once either for some reason.

I do see some '#pragma once's in my /usr/include tree but they don't
come from glibc.  Maybe it's a conscious decision not to use this or
maybe nobody could be bothered to make the change.  I don't see any
discussion in the libc-alpha mailing list about this but I only spent 10
seconds googling.

>An alternative might be something like
>
>  #pragma once
>  #define _CYGWIN_IF_H_
>
>It would introduce the new pragma and keep the definition available.

Yeah, that would work but you're still adding a define that shouldn't
really be used to the cygnosphere.

cgf
