Return-Path: <cygwin-patches-return-7988-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13567 invoked by alias); 26 May 2014 10:09:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13553 invoked by uid 89); 26 May 2014 10:09:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.3 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,KAM_COUK,SPF_PASS autolearn=no version=3.3.2
X-HELO: out.ipsmtp3nec.opaltelecom.net
Received: from out.ipsmtp3nec.opaltelecom.net (HELO out.ipsmtp3nec.opaltelecom.net) (62.24.202.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (CAMELLIA256-SHA encrypted) ESMTPS; Mon, 26 May 2014 10:09:48 +0000
X-SMTPAUTH: drstacey@tiscali.co.uk
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtABAAcSg1NV0kCB/2dsb2JhbAANTINZrhqUTgGBJoMZAQEBBDhAEQsYCRYPCQMCAQIBRRMGAgEBiEuxWaVLF4xYggEWhCoEmzCJWotJaw
X-IPAS-Result: AtABAAcSg1NV0kCB/2dsb2JhbAANTINZrhqUTgGBJoMZAQEBBDhAEQsYCRYPCQMCAQIBRRMGAgEBiEuxWaVLF4xYggEWhCoEmzCJWotJaw
Received: from 85-210-64-129.dynamic.dsl.as9105.com (HELO [192.168.1.67]) ([85.210.64.129])  by out.ipsmtp3nec.opaltelecom.net with ESMTP; 26 May 2014 11:09:44 +0100
Message-ID: <538312E4.1040201@tiscali.co.uk>
Date: Mon, 26 May 2014 10:09:00 -0000
From: David Stacey <drstacey@tiscali.co.uk>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin_rexec() returns pointer to deallocated memory
References: <53811668.5010208@tiscali.co.uk> <5382E760.7@lysator.liu.se>
In-Reply-To: <5382E760.7@lysator.liu.se>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2014-q2/txt/msg00011.txt.bz2

On 26/05/14 08:04, Peter Rosin wrote:
> On 2014-05-25 00:00, David Stacey wrote:
>> In function cygwin_rexec(), a pointer to local buffer 'ahostbuf' is returned through 'ahost'. However, the buffer will have been deallocated at the end of the function, and so the contents of 'ahost' will be undefined. A trivial patch (attached) fixes the problem by making 'ahostbuf' static.
>>   
>> This patch fixes Coverity bug ID #60028.
>>   
>> Change Log:
>> 2014-05-24  David Stacey<drstacey@tiscali.co.uk>
>>   
>>          * libc/rexec.cc (cygwin_rexec):
>>          Corrected returning a pointer to a buffer that will have gone out of
>>          scope.
> I'm comparing with [1] and the same comment is applicable here (reading "it"
> as "static").
>
> [1]https://cygwin.com/viewvc/src/winsup/cygwin/libc/rcmd.cc?revision=1.8&view=markup#l134

The two functions behave in a similar fashion. In both cases, an out 
parameter called 'ahost' is assigned to a buffer that is local to the 
function. The case of cygwin_rcmd_af() is correct in that the buffer is 
created statically (and so the buffer will not be destroyed at the end 
of the function). This means that the contents of the buffer will be 
available to the calling function.

However, in the case of cygwin_rexec(), the buffer is not static and is 
allocated on the stack. Hence after the function, if the stack were to 
be used (e.g. for local variables or function parameters) the contents 
of the buffer could easily become corrupted.

So yes, I would argue that 'static' is appropriate in both cases.

Cheers,

Dave.
