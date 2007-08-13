Return-Path: <cygwin-patches-return-6134-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1979 invoked by alias); 13 Aug 2007 19:33:12 -0000
Received: (qmail 1882 invoked by uid 22791); 13 Aug 2007 19:33:08 -0000
X-Spam-Check-By: sourceware.org
Received: from artdemusee.com (HELO rehley.net) (66.36.178.154)     by sourceware.org (qpsmtpd/0.31) with SMTP; Mon, 13 Aug 2007 19:32:59 +0000
Received: (qmail 15444 invoked from network); 13 Aug 2007 12:25:51 -0700
Received: from gateway-1237.mvista.com (HELO ?10.0.10.138?) (63.81.120.158)   by artdemusee.com with SMTP; 13 Aug 2007 12:25:50 -0700
Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <20070809171911.GA9596@ednor.casa.cgf.cx>
References: <76087731258D2545B1016BB958F00ADA123A4B@STEELPO.steeleye.com> <20070809171911.GA9596@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9E96C9F8-A1C5-4EE5-A24C-68896AD82D6B@rehley.net>
Content-Transfer-Encoding: 7bit
From: Peter Rehley <peter@rehley.net>
Subject: Re: Signal handler not executed
Date: Mon, 13 Aug 2007 19:33:00 -0000
To: cygwin-patches@cygwin.com
X-Mailer: Apple Mail (2.752.2)
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00009.txt.bz2


On Aug 9, 2007, at 10:19 AM, Christopher Faylor wrote:

> On Thu, Aug 09, 2007 at 01:09:48PM -0400, Ernie Coskrey wrote:
>> There's a very small window of vulnerability in _sigbe, which can  
>> lead
>> to signal handlers not being executed.  In _sigbe, the _cygtls  
>> lock is
>> released before incyg is decremented.  If setup_handler acquires the
>> lock just after _sigbe releases it, but before incyg is decremented,
>> setup_handler will mistakenly believe that the thread is in Cygwin  
>> code,
>> and will set up the interrupt using the tls stack.
>>
>> _sigbe should decrement incyg before releasing the lock.
>
> I'll apply this but are you saying that this actually fixes your  
> problem
> or that you think it fixes your problem?
>

Chris,

I noticed in the cvs log that at one point you changed from what the  
patch applied to releasing incyg later.  (version 1.22 to 1.23 of  
gendef).  Do you remember why you did this change?  and could this  
patch break what you tried fixing earlier?

I'm just curious.

Thanks,
Peter



