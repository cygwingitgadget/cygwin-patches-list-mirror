Return-Path: <cygwin-patches-return-7507-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6847 invoked by alias); 9 Sep 2011 12:28:24 -0000
Received: (qmail 6777 invoked by uid 22791); 9 Sep 2011 12:28:23 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 09 Sep 2011 12:28:00 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.0.6]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 09 Sep 2011 13:27:59 +0100
Message-ID: <4E6A0653.5010206@dronecode.org.uk>
Date: Fri, 09 Sep 2011 12:28:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0) Gecko/20110905 Thunderbird/7.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix strace -T
References: <4E690B69.6020306@dronecode.org.uk> <20110908190952.GB30425@ednor.casa.cgf.cx>
In-Reply-To: <20110908190952.GB30425@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
X-SW-Source: 2011-q3/txt/msg00083.txt.bz2

On 08/09/2011 20:09, Christopher Faylor wrote:
> On Thu, Sep 08, 2011 at 07:37:29PM +0100, Jon TURNEY wrote:
>>
>> strace -T to toggle stracing of a process doesn't seem to work at the moment.
>> Attached is a patch to make it work again.
>>
>> 2011-09-08  Jon TURNEY<jon.turney@dronecode.org.uk>
>>
>> 	* include/sys/strace.h (strace): Add toggle() method
>> 	* strace.cc (toggle): Implement toggle() method
>> 	* sigproc.cc (wait_sig): Use strace.toggle() in __SIGSTRACE
>
> IIRC, the intent was for hello() to toggle (in which case I guess it
> should be hellogoodbye).  Why do you even need this functionality?
> I'd just as soon remove it.

I found it very helpful to have this working when I was looking at a problem 
which occurred when running the twisted testsuite ([1], I think), as running 
the entire testsuite with strace enabled greatly slowed it down and generated 
a vast amount of output, and the problem did not reproduce when running a 
single test.  Being able to disable strace output until close to the point of 
failure was useful.

I didn't want to touch strace::hello() as it's called from a few other places 
than __SIGSTRACE processing, and I don't understand them well enough to know 
if toggling in those places is correct.

[1] http://cygwin.com/ml/cygwin/2011-03/msg00437.html
