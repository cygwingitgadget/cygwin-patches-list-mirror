Return-Path: <cygwin-patches-return-6775-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4759 invoked by alias); 16 Oct 2009 09:13:45 -0000
Received: (qmail 4748 invoked by uid 22791); 16 Oct 2009 09:13:44 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from mail.lysator.liu.se (HELO mail.lysator.liu.se) (130.236.254.3)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 16 Oct 2009 09:13:38 +0000
Received: from mail.lysator.liu.se (localhost [127.0.0.1]) 	by mail.lysator.liu.se (Postfix) with ESMTP id A9CD140024 	for <cygwin-patches@cygwin.com>; Fri, 16 Oct 2009 11:12:46 +0200 (CEST)
Received: from [192.168.0.33] (81-234-184-115-o1095.tbon.telia.com [81.234.184.115]) 	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) 	(No client certificate requested) 	by mail.lysator.liu.se (Postfix) with ESMTP id 8A2354000B 	for <cygwin-patches@cygwin.com>; Fri, 16 Oct 2009 11:12:46 +0200 (CEST)
Message-ID: <4AD8393C.6040805@lysator.liu.se>
Date: Fri, 16 Oct 2009 09:13:00 -0000
From: Peter Rosin <peda@lysator.liu.se>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] Case-sensitive programs exist but cannot both be run
References: <4AD7F017.5080609@users.sourceforge.net> <20091016080302.GO27964@calimero.vinschen.de> <4AD832FB.2050901@users.sourceforge.net>
In-Reply-To: <4AD832FB.2050901@users.sourceforge.net>
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
X-SW-Source: 2009-q4/txt/msg00106.txt.bz2

Den 2009-10-16 10:46 skrev Yaakov (Cygwin/X):
> On 16/10/2009 03:03, Corinna Vinschen wrote:
>> On Oct 15 23:01, Yaakov S wrote:
>>> It appears that two EXEs can coexist (with the registry setting) but 
>>> only
>>> whichever one was so named first will be run:
>>> [...]
>>> Bug?  Limitation?  If it hurts, don't do that?
>>
>> Limitation.  While we can do everything with files using native NT
>> calls, we can't use NtCreateProcess to create new processes.  We
>> have to use CreateProcess, and there's no flag available which defines
>> case-sensitivity for this call, unfortunately.
> 
> In that case, let's document it.  Patch attached.

*snip*

> +trying to run either of them will always run whichever was so named first.  

I suspect that you don't necessarily get the one which was named first. My
guess is that you'll get whichever file happening to appear first in the
unsorted directory list. Seems bad to make "promises" in the docs in this
case...

Cheers,
Peter
