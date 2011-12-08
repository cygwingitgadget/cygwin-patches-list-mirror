Return-Path: <cygwin-patches-return-7559-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24155 invoked by alias); 8 Dec 2011 06:43:12 -0000
Received: (qmail 24141 invoked by uid 22791); 8 Dec 2011 06:43:11 -0000
X-SWARE-Spam-Status: No, hits=-2.1 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout03.t-online.de (HELO mailout03.t-online.de) (194.25.134.81)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 08 Dec 2011 06:42:55 +0000
Received: from fwd11.aul.t-online.de (fwd11.aul.t-online.de )	by mailout03.t-online.de with smtp 	id 1RYXgz-0004YJ-TL; Thu, 08 Dec 2011 07:42:53 +0100
Received: from [192.168.2.108] (V+Oh-aZvQhobXHw5y37OcIPEcKgoaX1QJ65CV5oNRbIUa50kvcDl5mJDWiXvcOxZxg@[79.224.118.121]) by fwd11.t-online.de	with esmtp id 1RYXgx-0UgsRE0; Thu, 8 Dec 2011 07:42:51 +0100
Message-ID: <4EE05C68.8070106@t-online.de>
Date: Thu, 08 Dec 2011 06:43:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110928 Firefox/7.0.1 SeaMonkey/2.4.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Problem with: Re: [PATCH] Allow usage of union wait for wait() functions and macros
References: <4E8C3828.4010009@t-online.de> <20111005132620.GA8422@ednor.casa.cgf.cx> <4E8CC986.3080001@t-online.de> <20111006023729.GM1955@ednor.casa.cgf.cx> <4E8D8B0D.1060805@t-online.de> <20111006130357.GA20063@ednor.casa.cgf.cx> <4E8DD373.2070008@t-online.de> <20111006171749.GC22971@ednor.casa.cgf.cx> <20111207223609.GA24624@ednor.casa.cgf.cx> <4EDFF3F7.1090704@t-online.de> <20111208023353.GA26402@ednor.casa.cgf.cx>
In-Reply-To: <20111208023353.GA26402@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q4/txt/msg00049.txt.bz2

Christopher Faylor wrote:
> On Thu, Dec 08, 2011 at 12:17:11AM +0100, Christian Franke wrote:
>> Christopher Faylor wrote:
>>> ...
>>> /usr/local/src/trunk/objdir.withada/./prev-gcc/g++
>>> -B/usr/local/src/trunk/objdir.withada/./prev-gcc/
>>> ...
>>> -I/usr/local/src/trunk/gcc/gcc/../libdecnumber/bid -I../libdecnumber
>>>     /usr/local/src/trunk/gcc/gcc/ada/adaint.c -o ada/adaint.o
>>> In file included from /usr/local/src/trunk/gcc/gcc/system.h:346:0,
>>>                    from /usr/local/src/trunk/gcc/gcc/ada/adaint.c:107:
>>> /usr/include/sys/wait.h: In function 'int __wait_status_to_int(const wait&)':
>>> /usr/include/sys/wait.h:77:61: error: declaration of C function 'int
>>> __wait_status_to_int(const wait&)' conflicts with
>>> /usr/include/sys/wait.h:75:12: error: previous declaration 'int
>>> __wait_status_to_int(int)' here
>> This suggests that sys/wait.h is included within an extern "C" { ... }
>> block.
>> If this is the case then an extern "C++" {...} block around the C++
>> inline functions of sys/wait.h should fix this.
>> See:
>> http://cygwin.com/ml/cygwin-patches/2011-q4/msg00005.html
> Yes, I'm responding to this very thread.
>
> But, I don't see how extern "c++" fixes anything.  #ifdef __cplusplus maybe...

No, #ifdef __cplusplus won't help. Example:

foo.h:
extern "C" {
#include <sys/wait.h>
}


sys/wait.h:
...
#ifdef __cplusplus
...
inline int __wait_status_to_int(int __status) { .... }
// This fails because both are interpreted as C-functions:
inline int __wait_status_to_int(const union wait &__status) { .... }
...
#endif


Fix:
#ifdef __cplusplus
+extern "C++" {
...
inline int __wait_status_to_int(int __status) { .... }
inline int __wait_status_to_int(const union wait &__status) { .... }
...
+}
#endif


Christian
