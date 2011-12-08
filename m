Return-Path: <cygwin-patches-return-7558-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6131 invoked by alias); 8 Dec 2011 02:34:19 -0000
Received: (qmail 5990 invoked by uid 22791); 8 Dec 2011 02:34:15 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 08 Dec 2011 02:33:55 +0000
Received: from pool-173-76-42-41.bstnma.fios.verizon.net ([173.76.42.41] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1RYTo2-0000OJ-Ha	for cygwin-patches@cygwin.com; Thu, 08 Dec 2011 02:33:54 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id CC51213C0D3	for <cygwin-patches@cygwin.com>; Wed,  7 Dec 2011 21:33:53 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18SG+5oFnYJyg5GSFSuzECO
Date: Thu, 08 Dec 2011 02:34:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Problem with: Re: [PATCH] Allow usage of union wait for wait() functions and macros
Message-ID: <20111208023353.GA26402@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E8C3828.4010009@t-online.de> <20111005132620.GA8422@ednor.casa.cgf.cx> <4E8CC986.3080001@t-online.de> <20111006023729.GM1955@ednor.casa.cgf.cx> <4E8D8B0D.1060805@t-online.de> <20111006130357.GA20063@ednor.casa.cgf.cx> <4E8DD373.2070008@t-online.de> <20111006171749.GC22971@ednor.casa.cgf.cx> <20111207223609.GA24624@ednor.casa.cgf.cx> <4EDFF3F7.1090704@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EDFF3F7.1090704@t-online.de>
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
X-SW-Source: 2011-q4/txt/msg00048.txt.bz2

On Thu, Dec 08, 2011 at 12:17:11AM +0100, Christian Franke wrote:
>Christopher Faylor wrote:
>>
>> I guess this is why there was a __INSIDE_CYGWIN__ test.
>>
>> Christian, could you submit a new patch to rectify this problem?
>
>OK, will try soon.
>
>
>> ...
>> /usr/local/src/trunk/objdir.withada/./prev-gcc/g++
>> -B/usr/local/src/trunk/objdir.withada/./prev-gcc/
>> ...
>> -I/usr/local/src/trunk/gcc/gcc/../libdecnumber/bid -I../libdecnumber
>>    /usr/local/src/trunk/gcc/gcc/ada/adaint.c -o ada/adaint.o
>> In file included from /usr/local/src/trunk/gcc/gcc/system.h:346:0,
>>                   from /usr/local/src/trunk/gcc/gcc/ada/adaint.c:107:
>> /usr/include/sys/wait.h: In function 'int __wait_status_to_int(const wait&)':
>> /usr/include/sys/wait.h:77:61: error: declaration of C function 'int
>> __wait_status_to_int(const wait&)' conflicts with
>> /usr/include/sys/wait.h:75:12: error: previous declaration 'int
>> __wait_status_to_int(int)' here
>
>This suggests that sys/wait.h is included within an extern "C" { ... } 
>block.
>If this is the case then an extern "C++" {...} block around the C++ 
>inline functions of sys/wait.h should fix this.
>See:
>http://cygwin.com/ml/cygwin-patches/2011-q4/msg00005.html

Yes, I'm responding to this very thread.

But, I don't see how extern "c++" fixes anything.  #ifdef __cplusplus maybe...

cgf
