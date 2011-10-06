Return-Path: <cygwin-patches-return-7514-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12184 invoked by alias); 6 Oct 2011 02:37:49 -0000
Received: (qmail 11579 invoked by uid 22791); 6 Oct 2011 02:37:47 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,TW_XF,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm18.access.bullet.mail.mud.yahoo.com (HELO nm18.access.bullet.mail.mud.yahoo.com) (66.94.237.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 06 Oct 2011 02:37:31 +0000
Received: from [66.94.237.195] by nm18.access.bullet.mail.mud.yahoo.com with NNFMP; 06 Oct 2011 02:37:31 -0000
Received: from [66.94.237.98] by tm6.access.bullet.mail.mud.yahoo.com with NNFMP; 06 Oct 2011 02:37:31 -0000
Received: from [127.0.0.1] by omp1003.access.mail.mud.yahoo.com with NNFMP; 06 Oct 2011 02:37:31 -0000
Received: (qmail 80987 invoked from network); 6 Oct 2011 02:37:30 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@173.76.45.30 with login)        by smtp101.vzn.mail.bf1.yahoo.com with SMTP; 05 Oct 2011 19:37:30 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id E667B13C0D3	for <cygwin-patches@cygwin.com>; Wed,  5 Oct 2011 22:37:29 -0400 (EDT)
Date: Thu, 06 Oct 2011 02:37:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Allow usage of union wait for wait() functions and macros
Message-ID: <20111006023729.GM1955@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E8C3828.4010009@t-online.de> <20111005132620.GA8422@ednor.casa.cgf.cx> <4E8CC986.3080001@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E8CC986.3080001@t-online.de>
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
X-SW-Source: 2011-q4/txt/msg00004.txt.bz2

On Wed, Oct 05, 2011 at 11:17:58PM +0200, Christian Franke wrote:
>Christopher Faylor wrote:
>> On Wed, Oct 05, 2011 at 12:57:44PM +0200, Christian Franke wrote:
>>> ...
>>> diff --git a/winsup/cygwin/include/cygwin/wait.h b/winsup/cygwin/include/cygwin/wait.h
>>> index bed81b7..e4edba2 100644
>>> --- a/winsup/cygwin/include/cygwin/wait.h
>>> +++ b/winsup/cygwin/include/cygwin/wait.h
>>> @@ -1,6 +1,6 @@
>>> /* cygwin/wait.h
>>>
>>> -   Copyright 2006, 2009 Red Hat, Inc.
>>> +   Copyright 2006, 2009, 2011 Red Hat, Inc.
>>>
>>> This file is part of Cygwin.
>>>
>>> @@ -16,6 +16,9 @@ details. */
>>> #define WCONTINUED 8
>>> #define __W_CONTINUED	0xffff
>>>
>>> +/* Will be redefined in sys/wait.h.  */
>>> +#define __wait_status_to_int(w)  (w)
>>> +
>> Why is this necessary?  It doesn't look like it is ever expanded in cygwin/wait.h.
>
>This would be needed if cygwin/wait.h is included separately without 
>sys/wait.h
>(e.g. stdlib.h -> cygwin/stdlib.h -> cygwin/wait.h)
>and some W*() macro is actually used.
>
>
>> If a redefinition is necessary why not put it all in one place?
>
>The W*() macros and union wait are closely related. So a probably better 
>approach would be to move union wait to cygwin/wait.h and define 
>__wait_status_to_int() only there.
>
>But then C++ compile may fail because cygwin/wait.h is sometimes 
>included indirectly inside an extern "C" block:
>w32api/shlobj.h -> extern "C" { w32api/ole2.h ...-> stdlib.h ...-> 
>cygwin/wait.h }

Ok.  I see that Linux's use of similar macros is convoluted too.
I really would rather keep this all together but I guess it isn't
possible without redesigning stdlib.h and */wait.h.

>> And why is redefinition needed inside Cygwin?
>
>It is not redefined in the __INSIDE_CYGWIN__ case.
>
>
>>> ...
>>> +
>>> +#endif
>> Could you add a comment here and at the #else indicating what they refer to
>> like #else /* !(defined(__cplusplus) || defined(__INSIDE_CYGWIN__)) and
>> #endif (defined(__cplusplus) || defined(__INSIDE_CYGWIN__) ?
>
>OK.
>
>
>> Also since Cygwin is C++ why do you need the __INSIDE_CYGWIN__ here?
>
>There are still ten *.c files in winsup/cygwin :-)

% cd winsup/cygwin
% grep wait.h **/*.c
%

cgf
