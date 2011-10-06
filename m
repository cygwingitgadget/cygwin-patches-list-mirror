Return-Path: <cygwin-patches-return-7515-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31668 invoked by alias); 6 Oct 2011 11:04:19 -0000
Received: (qmail 31656 invoked by uid 22791); 6 Oct 2011 11:04:17 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD,TW_XF,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout10.t-online.de (HELO mailout10.t-online.de) (194.25.134.21)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 06 Oct 2011 11:03:46 +0000
Received: from fwd11.aul.t-online.de (fwd11.aul.t-online.de )	by mailout10.t-online.de with smtp 	id 1RBljs-0004C2-SG; Thu, 06 Oct 2011 13:03:44 +0200
Received: from [192.168.2.108] (Vg-1w4ZfYhLuzLwJU34KE+isgMiyFOrWP+ye+ui9BYIKzE5NpA5VPmXvaGLirXFZhZ@[79.224.127.17]) by fwd11.t-online.de	with esmtp id 1RBljq-1rbPlo0; Thu, 6 Oct 2011 13:03:42 +0200
Message-ID: <4E8D8B0D.1060805@t-online.de>
Date: Thu, 06 Oct 2011 11:04:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110928 Firefox/7.0.1 SeaMonkey/2.4.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Allow usage of union wait for wait() functions and macros
References: <4E8C3828.4010009@t-online.de> <20111005132620.GA8422@ednor.casa.cgf.cx> <4E8CC986.3080001@t-online.de> <20111006023729.GM1955@ednor.casa.cgf.cx>
In-Reply-To: <20111006023729.GM1955@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00005.txt.bz2

Christopher Faylor wrote:
> On Wed, Oct 05, 2011 at 11:17:58PM +0200, Christian Franke wrote:
>> Christopher Faylor wrote:
>>> On Wed, Oct 05, 2011 at 12:57:44PM +0200, Christian Franke wrote:
>>>> ...
>>>> diff --git a/winsup/cygwin/include/cygwin/wait.h b/winsup/cygwin/include/cygwin/wait.h
>>>> index bed81b7..e4edba2 100644
>>>> --- a/winsup/cygwin/include/cygwin/wait.h
>>>> +++ b/winsup/cygwin/include/cygwin/wait.h
>>>> @@ -1,6 +1,6 @@
>>>> /* cygwin/wait.h
>>>>
>>>> -   Copyright 2006, 2009 Red Hat, Inc.
>>>> +   Copyright 2006, 2009, 2011 Red Hat, Inc.
>>>>
>>>> This file is part of Cygwin.
>>>>
>>>> @@ -16,6 +16,9 @@ details. */
>>>> #define WCONTINUED 8
>>>> #define __W_CONTINUED	0xffff
>>>>
>>>> +/* Will be redefined in sys/wait.h.  */
>>>> +#define __wait_status_to_int(w)  (w)
>>>> +
>>> Why is this necessary?  It doesn't look like it is ever expanded in cygwin/wait.h.
>> This would be needed if cygwin/wait.h is included separately without
>> sys/wait.h
>> (e.g. stdlib.h ->  cygwin/stdlib.h ->  cygwin/wait.h)
>> and some W*() macro is actually used.
>>
>>
>>> If a redefinition is necessary why not put it all in one place?
>> The W*() macros and union wait are closely related. So a probably better
>> approach would be to move union wait to cygwin/wait.h and define
>> __wait_status_to_int() only there.
>>
>> But then C++ compile may fail because cygwin/wait.h is sometimes
>> included indirectly inside an extern "C" block:
>> w32api/shlobj.h ->  extern "C" { w32api/ole2.h ...->  stdlib.h ...->
>> cygwin/wait.h }
> Ok.  I see that Linux's use of similar macros is convoluted too.
> I really would rather keep this all together but I guess it isn't
> possible without redesigning stdlib.h and */wait.h.

Linux uses the following approach for the C++ case:

typedef void *__wait_status_ptr_t;
#define __wait_status_to_int(w)  (*(int*)&(w))

This prevents the C++ inline function problem but is not typesafe at all.

Meantime I found out that the inline functions can be used even if a 
file is included in an extern "C" block. It is possible to nest another 
extern "C++" block:

// w32api/shlobj.h:
extern "C" {
#include ...
   ...
   // cygwin/wait.h:
   ...
   #ifdef __cplusplus
   extern "C++" {
   inline int __wait_status_to_int(int __status) { .... }
   inline int __wait_status_to_int(const union wait &__status) { .... }
   }
   #endif

}

So it would be possible to move union wait and related functions to 
cygwin/wait.h. Possible new problem: This pollutes the stdlib.h 
namespace with 'union wait' and '#define w_termsig' etc..


>>> Also since Cygwin is C++ why do you need the __INSIDE_CYGWIN__ here?
>> There are still ten *.c files in winsup/cygwin :-)
> % cd winsup/cygwin
> % grep wait.h **/*.c
> %

OK, __INSIDE_CYGWIN__ is not needed here in practice (but possibly in 
theory :-)

Would the patch with __INSIDE_CYGWIN__ removed be GTG?

Christian
