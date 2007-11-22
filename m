Return-Path: <cygwin-patches-return-6176-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14198 invoked by alias); 22 Nov 2007 17:55:23 -0000
Received: (qmail 14184 invoked by uid 22791); 22 Nov 2007 17:55:22 -0000
X-Spam-Check-By: sourceware.org
Received: from s200aog11.obsmtp.com (HELO s200aog11.obsmtp.com) (207.126.144.125)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 22 Nov 2007 17:55:09 +0000
Received: from source ([164.129.1.35]) (using TLSv1) by eu1sys200aob011.postini.com ([207.126.147.11]) with SMTP; 	Thu, 22 Nov 2007 17:55:06 UTC
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9]) 	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 13E3EDABA 	for <cygwin-patches@cygwin.com>; Thu, 22 Nov 2007 17:55:06 +0000 (GMT)
Received: from mail1.bri.st.com (mail1.bri.st.com [164.129.8.218]) 	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A26794C111 	for <cygwin-patches@cygwin.com>; Thu, 22 Nov 2007 17:55:05 +0000 (GMT)
Received: from [164.129.15.13] (bri1043.bri.st.com [164.129.15.13]) 	by mail1.bri.st.com (MOS 3.7.5a-GA) 	with ESMTP id CJL62742 (AUTH stubbsa); 	Thu, 22 Nov 2007 17:55:04 GMT
Message-ID: <4745C279.3030708@st.com>
Date: Thu, 22 Nov 2007 17:55:00 -0000
From: Andrew STUBBS <andrew.stubbs@st.com>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Resource Temporarily Unavailable workaround
References: <4745B152.3070704@st.com> <20071122170051.GA29996@ednor.casa.cgf.cx> <20071122170518.GA30136@ednor.casa.cgf.cx>
In-Reply-To: <20071122170518.GA30136@ednor.casa.cgf.cx>
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
X-SW-Source: 2007-q4/txt/msg00028.txt.bz2

Christopher Faylor wrote:
> On Thu, Nov 22, 2007 at 12:00:51PM -0500, Christopher Faylor wrote:
>> On Thu, Nov 22, 2007 at 04:41:54PM +0000, Andrew STUBBS wrote:
>>> The attached patch adds a 'retry' to the fork system call.  Basically
>>> it waits 10 seconds to allow the 'resource temporarily unavailable' to
>>> become (temporarily) available once more, and tries again, up to a
>>> maximum of three attempts.
>> There is already a retry in the fork and spawn system calls.  This
>> technique has proved to be problematic since it can mask problems and
>> you can end up with situations where a process starts successfully but
>> cygwin thinks it fails and restarts the process again.  For the exec
>> case, there is also a problem with non-cygwin .exes.
>>
>> If you look for retry in the fork call you should see where this is
>> supposed to be happening.
> 
> Btw, it is likely that if you are seeing this problem that there is
> something happening after the retry code in fork which is causing an
> EAGAIN.  The existing retry code could be expanded to take that into
> account if that is the case.

Thanks, now I see the retry, but the code is impossible to follow 
without knowing both Cygwin and Windows backwards, and I don't have that 
much time to spend on this. :(

Clearly its retries aren't (always) sufficient. Perhaps it isn't 
retrying enough, or retrying the right stuff, or maybe not waiting long 
enough between retries.

There is quite a lot of stuff outside the "while (1)" that I assume is 
the retried code. EAGAIN is mentioned a few times, and that's without 
taking into account the contents of the various function calls. In 
particular there's one comment that says "Hopefully, this will succeed." 
- which is reassuring.

Unfortunately the problem isn't easily reproducible. I can't use strace 
as it runs way too slowly and I would just never get to the problem. I 
could instrument the whole file up so that I can trace just that, and 
then sit back and wait.

Any suggestions?

Andrew
