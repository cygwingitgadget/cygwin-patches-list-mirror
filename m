Return-Path: <cygwin-patches-return-6727-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23909 invoked by alias); 6 Oct 2009 21:01:59 -0000
Received: (qmail 23897 invoked by uid 22791); 6 Oct 2009 21:01:58 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS,WEIRD_PORT
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 21:01:55 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 7C2BE86EC6 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 17:01:53 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute2.internal (MEProxy); Tue, 06 Oct 2009 17:01:53 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 190A14536; 	Tue,  6 Oct 2009 17:01:53 -0400 (EDT)
Message-ID: <4ACBB03A.6030009@cwilson.fastmail.fm>
Date: Tue, 06 Oct 2009 21:01:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACA5BC7.6090908@cwilson.fastmail.fm>  <20091006034229.GA12172@ednor.casa.cgf.cx>  <4ACAC079.2020105@cwilson.fastmail.fm>  <20091006074620.GA13712@calimero.vinschen.de>  <4ACB56D5.4060606@cwilson.fastmail.fm>  <4ACB670F.2070209@cwilson.fastmail.fm>  <20091006182221.GD18135@ednor.casa.cgf.cx>  <4ACB9042.3070104@cwilson.fastmail.fm>  <20091006193502.GA18384@ednor.casa.cgf.cx>  <4ACB9FBE.5080700@cwilson.fastmail.fm> <20091006202915.GA18969@ednor.casa.cgf.cx>
In-Reply-To: <20091006202915.GA18969@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00058.txt.bz2

Christopher Faylor wrote:
> On Tue, Oct 06, 2009 at 03:51:26PM -0400, Charles Wilson wrote:
>> Having said all that, I really don't care one way or the other. We have
>> three possibilities:
>>
>> 1) current iteration (BOOL in cygwin_internal coerced to bool for static
>> function exit_process)
>> 2) use bool throughout exceptions.cc, and expect caller to use C++ bool,
>> C99 bool, or stdbool.h bool.
> 
> Since, as you say, we use DWORD in other places, I'm going to opt for
> what I originally proposed.  Change BOOL to bool since there is no reason
> to use the Windows API BOOL type.  Do that everywhere in your change that
> it makes sense.  Leave the UINT alone.

Hmm...this is interesting:

/usr/src/devel/kernel/src/winsup/cygwin/external.cc: In function 'long
unsigned int cygwin_internal(cygwin_getinfo_types, ...)':
/usr/src/devel/kernel/src/winsup/cygwin/external.cc:413: error: 'bool'
is promoted to 'int' when passed through '...'
/usr/src/devel/kernel/src/winsup/cygwin/external.cc:413: note: (so you
should pass 'int' not 'bool' to 'va_arg')
/usr/src/devel/kernel/src/winsup/cygwin/external.cc:413: note: if this
code is reached, the program will abort

This didn't happen with BOOL, because it is typedef int, anyway:

windef.h:

typedef unsigned long DWORD;
typedef int WINBOOL,*PWINBOOL,*LPWINBOOL;
/* FIXME: Is there a good solution to this? */
#ifndef XFree86Server
#ifndef __OBJC__
typedef WINBOOL BOOL;
#else
#define BOOL WINBOOL
#endif
typedef unsigned char BYTE;
#endif /* ndef XFree86Server */

So, to avoid requiring #include <windows.h>, I guess the next best thing
is option #3, right?

> 3) use bool in static function exit_process, use unsigned long in
> cygwin_internal and callers.

--
Chuck
