Return-Path: <cygwin-patches-return-7516-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23438 invoked by alias); 6 Oct 2011 13:04:18 -0000
Received: (qmail 23383 invoked by uid 22791); 6 Oct 2011 13:04:16 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,TW_XF,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm12.access.bullet.mail.mud.yahoo.com (HELO nm12.access.bullet.mail.mud.yahoo.com) (66.94.237.213)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 06 Oct 2011 13:03:59 +0000
Received: from [66.94.237.197] by nm12.access.bullet.mail.mud.yahoo.com with NNFMP; 06 Oct 2011 13:03:58 -0000
Received: from [66.94.237.109] by tm8.access.bullet.mail.mud.yahoo.com with NNFMP; 06 Oct 2011 13:03:58 -0000
Received: from [127.0.0.1] by omp1014.access.mail.mud.yahoo.com with NNFMP; 06 Oct 2011 13:03:58 -0000
Received: (qmail 63172 invoked from network); 6 Oct 2011 13:03:58 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@173.76.45.30 with login)        by smtp103.vzn.mail.bf1.yahoo.com with SMTP; 06 Oct 2011 06:03:58 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 8A4C913C0D3	for <cygwin-patches@cygwin.com>; Thu,  6 Oct 2011 09:03:57 -0400 (EDT)
Date: Thu, 06 Oct 2011 13:04:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Allow usage of union wait for wait() functions and macros
Message-ID: <20111006130357.GA20063@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E8C3828.4010009@t-online.de> <20111005132620.GA8422@ednor.casa.cgf.cx> <4E8CC986.3080001@t-online.de> <20111006023729.GM1955@ednor.casa.cgf.cx> <4E8D8B0D.1060805@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E8D8B0D.1060805@t-online.de>
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
X-SW-Source: 2011-q4/txt/msg00006.txt.bz2

On Thu, Oct 06, 2011 at 01:03:41PM +0200, Christian Franke wrote:
>Christopher Faylor wrote:
>> On Wed, Oct 05, 2011 at 11:17:58PM +0200, Christian Franke wrote:
>>> Christopher Faylor wrote:
>>>> On Wed, Oct 05, 2011 at 12:57:44PM +0200, Christian Franke wrote:
>>>>> ...
>>>>> diff --git a/winsup/cygwin/include/cygwin/wait.h b/winsup/cygwin/include/cygwin/wait.h
>>>>> index bed81b7..e4edba2 100644
>>>>> --- a/winsup/cygwin/include/cygwin/wait.h
>>>>> +++ b/winsup/cygwin/include/cygwin/wait.h
>>>>> @@ -1,6 +1,6 @@
>>>>> /* cygwin/wait.h
>>>>>
>>>>> -   Copyright 2006, 2009 Red Hat, Inc.
>>>>> +   Copyright 2006, 2009, 2011 Red Hat, Inc.
>>>>>
>>>>> This file is part of Cygwin.
>>>>>
>>>>> @@ -16,6 +16,9 @@ details. */
>>>>> #define WCONTINUED 8
>>>>> #define __W_CONTINUED	0xffff
>>>>>
>>>>> +/* Will be redefined in sys/wait.h.  */
>>>>> +#define __wait_status_to_int(w)  (w)
>>>>> +
>>>> Why is this necessary?  It doesn't look like it is ever expanded in cygwin/wait.h.
>>> This would be needed if cygwin/wait.h is included separately without
>>> sys/wait.h
>>> (e.g. stdlib.h ->  cygwin/stdlib.h ->  cygwin/wait.h)
>>> and some W*() macro is actually used.
>>>
>>>
>>>> If a redefinition is necessary why not put it all in one place?
>>> The W*() macros and union wait are closely related. So a probably better
>>> approach would be to move union wait to cygwin/wait.h and define
>>> __wait_status_to_int() only there.
>>>
>>> But then C++ compile may fail because cygwin/wait.h is sometimes
>>> included indirectly inside an extern "C" block:
>>> w32api/shlobj.h ->  extern "C" { w32api/ole2.h ...->  stdlib.h ...->
>>> cygwin/wait.h }
>> Ok.  I see that Linux's use of similar macros is convoluted too.
>> I really would rather keep this all together but I guess it isn't
>> possible without redesigning stdlib.h and */wait.h.
>
>Linux uses the following approach for the C++ case:
>
>typedef void *__wait_status_ptr_t;
>#define __wait_status_to_int(w)  (*(int*)&(w))
>
>This prevents the C++ inline function problem but is not typesafe at all.
>
>Meantime I found out that the inline functions can be used even if a 
>file is included in an extern "C" block. It is possible to nest another 
>extern "C++" block:
>
>// w32api/shlobj.h:
>extern "C" {
>#include ...
>   ...
>   // cygwin/wait.h:
>   ...
>   #ifdef __cplusplus
>   extern "C++" {
>   inline int __wait_status_to_int(int __status) { .... }
>   inline int __wait_status_to_int(const union wait &__status) { .... }
>   }
>   #endif
>
>}
>
>So it would be possible to move union wait and related functions to 
>cygwin/wait.h. Possible new problem: This pollutes the stdlib.h 
>namespace with 'union wait' and '#define w_termsig' etc..
>
>
>>>> Also since Cygwin is C++ why do you need the __INSIDE_CYGWIN__ here?
>>> There are still ten *.c files in winsup/cygwin :-)
>> % cd winsup/cygwin
>> % grep wait.h **/*.c
>> %
>
>OK, __INSIDE_CYGWIN__ is not needed here in practice (but possibly in 
>theory :-)

I would rather see as little __INSIDE_CYGWIN__ as possible
in external headers.

>Would the patch with __INSIDE_CYGWIN__ removed be GTG?

Yes.

cgf
