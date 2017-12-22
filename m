Return-Path: <cygwin-patches-return-8987-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 57053 invoked by alias); 22 Dec 2017 13:30:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 57025 invoked by uid 89); 22 Dec 2017 13:30:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-3.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=Hx-spam-relays-external:ESMTPA, HContent-Transfer-Encoding:8bit
X-HELO: out1-smtp.messagingengine.com
Received: from out1-smtp.messagingengine.com (HELO out1-smtp.messagingengine.com) (66.111.4.25) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Dec 2017 13:30:31 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])	by mailout.nyi.internal (Postfix) with ESMTP id A591C20BE8;	Fri, 22 Dec 2017 08:30:29 -0500 (EST)
Received: from frontend2 ([10.202.2.161])  by compute6.internal (MEProxy); Fri, 22 Dec 2017 08:30:29 -0500
X-ME-Sender: <xms:9Qg9WtAFXjnYXt4JRppmho6HsKhYBFWWcB_0rd58oQDaFsaTpf6Ejw>
Received: from [192.168.1.102] (host86-141-131-139.range86-141.btcentralplus.com [86.141.131.139])	by mail.messagingengine.com (Postfix) with ESMTPA id 32DD12436B;	Fri, 22 Dec 2017 08:30:29 -0500 (EST)
Subject: Re: [PATCH] cygwin_internal methods to get/set thread name
To: Mark Geisert <mark@maxrnd.com>
References: <20171220080832.2328-1-mark@maxrnd.com> <20171220115122.GF19986@calimero.vinschen.de> <Pine.BSF.4.63.1712202346060.17134@m0.truegem.net> <20171221102502.GJ19986@calimero.vinschen.de> <Pine.BSF.4.63.1712220116310.32087@m0.truegem.net>
Cc: Cygwin Patches <cygwin-patches@cygwin.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <d2e7e624-8f52-d1b8-518f-d26108158bbb@dronecode.org.uk>
Date: Fri, 22 Dec 2017 13:30:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <Pine.BSF.4.63.1712220116310.32087@m0.truegem.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SW-Source: 2017-q4/txt/msg00117.txt.bz2

On 22/12/2017 09:48, Mark Geisert wrote:
> 
> I'd still like to get a vote of acceptance for what I've called the 
> "courtesy" code in cygthread.cc, cygthread::name method.Â  The method is 
> called with a Windows tid and that tid is looked up in the table of 
> cygthreads.Â  If found, you immediately have the thread's name.Â  I added 
> code on the failure path for the case where tid represents a pthread.  
> If it does, the pthread's name is retrieved into the result buffer.
> 
> This would be useful in straces of any application whose pthreads issue 
> Cygwin syscalls: It means the strace log has messages referring to 
> pthreads by their names and not by "unknown 0x###" as at present.Â  It 
> was a help while debugging my "aio library built in userspace using 
> pthreads" that shall never be mentioned again ;-).Â  But somebody else 
> coding or debugging their own multi-threaded app will run into this need 
> eventually.

Yeah, there's definitely a piece missing if pthread names aren't being 
reported correctly in strace output.

I'd suggest it might be a bit cleaner to have a utility function used by 
strace::vsprntf() to get the thread name, which tries cygthread::name() 
or pthread_getname_np(), rather than having cygthread::name() be the 
only part of cygthread which knows about pthreads...

Other uses of cygthread::name() need inspecting to see if they need to 
change or not.  Given [1], I think CW_GETTHREADNAME should stay as it is.

[1] https://cygwin.com/ml/cygwin/2009-05/msg00263.html
