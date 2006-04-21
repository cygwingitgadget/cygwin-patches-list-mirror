Return-Path: <cygwin-patches-return-5834-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4146 invoked by alias); 21 Apr 2006 19:47:20 -0000
Received: (qmail 4136 invoked by uid 22791); 21 Apr 2006 19:47:19 -0000
X-Spam-Check-By: sourceware.org
Received: from vms046pub.verizon.net (HELO vms046pub.verizon.net) (206.46.252.46)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 21 Apr 2006 19:47:17 +0000
Received: from PHUMBLETXP ([12.6.244.2])  by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep  9 2005)) with ESMTPA id <0IY300DBN8ANDND1@vms046.mailsrvcs.net> for  cygwin-patches@cygwin.com; Fri, 21 Apr 2006 14:47:11 -0500 (CDT)
Date: Fri, 21 Apr 2006 19:47:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Make getenv() functional before the environment is  initialized
To: <cygwin-patches@cygwin.com>
Message-id: <01fc01c6657c$347794c0$280010ac@wirelessworld.airvananet.com>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Content-transfer-encoding: 7bit
References: <027701c65998$178103f0$280010ac@wirelessworld.airvananet.com>  <20060421172328.GD7685@calimero.vinschen.de>  <01ca01c66574$b295c7d0$280010ac@wirelessworld.airvananet.com>  <20060421191314.GA11311@trixie.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00022.txt.bz2


----- Original Message ----- 
From: "Christopher Faylor" <cgf-no-personal-reply-please@cygwin.com>
To: <cygwin-patches@cygwin.com>
Sent: Friday, April 21, 2006 3:13 PM
Subject: Re: [Patch] Make getenv() functional before the environment is 
initialized


> On Fri, Apr 21, 2006 at 02:52:06PM -0400, Pierre A. Humblet wrote:
>>
>>In particular GetEnvironmentStrings returns a big block of
>>storage that should be free (which we can't do), and that is
>>going to be lost on a fork, potentially leading to trouble.
>>
>>Thus I have another implementation using GetEnvironmentValue
>>and cmalloc. (with HEAP_1_MAX, so that it will be released
>>on the next exec).
>>I also take advantage of spawn_info, whose existence I had forgotten.
>>Overall it's also simpler.
>>
>>Here is another patch, sorry for not sending this earlier.
>
> I don't see any reason to permanently allocate memory with cmalloc.
>
> I think that using GetEnvironmentStrings is still the right choice here.
> You just have to make sure that it gets freed.  I'm going to check in a
> cleanup of getearly which will move the rawenv variable to a static
> which will potentially be used by environ_init.  Then environ_init will
> free it if it has been previously set.

But doesn't the program then have a pointer to memory that has been freed?
That pointer can also be accessed after forks.

Pierre
