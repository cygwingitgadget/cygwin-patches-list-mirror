Return-Path: <cygwin-patches-return-7209-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9947 invoked by alias); 17 Mar 2011 00:03:07 -0000
Received: (qmail 9936 invoked by uid 22791); 17 Mar 2011 00:03:06 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 17 Mar 2011 00:03:01 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.0.13]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 17 Mar 2011 00:02:58 +0000
Message-ID: <4D814FB3.5050405@dronecode.org.uk>
Date: Thu, 17 Mar 2011 00:03:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add an additional relocation attempt pass to load_after_fork()
References: <4D7CDDC7.5060708@dronecode.org.uk> <1300232277.2104.3.camel@YAAKOV04>
In-Reply-To: <1300232277.2104.3.camel@YAAKOV04>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00064.txt.bz2

On 15/03/2011 23:37, Yaakov (Cygwin/X) wrote:
> On Sun, 2011-03-13 at 15:07 +0000, Jon TURNEY wrote:
>> Attached is a patch which avoids a fork failure due to remap error in the
>> specific circumstances described in my email [1], by adding an additional pass
>> to load_after_fork() which forces the DLL to be relocated by VirtualAlloc()ing
>> a block of memory at the load address as well.
>>
>> Hopefully it can be seen by inspection that this code doesn't change the
>> behaviour of the first two passes, and so will only be changing the behaviour
>> in what was an fatal error case before.
> 
> This patch causes a warning with GCC 4.5:
> 
> cc1plus: warnings being treated as errors
> dll_init.cc: In member function âvoid dll_list::load_after_fork(void*)â:
> dll_init.cc:328:33: error: converting to non-pointer type âDWORDâ from
> NULL

Thanks, I guess that should be a 0 instead.
