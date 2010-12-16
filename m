Return-Path: <cygwin-patches-return-7141-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10021 invoked by alias); 15 Dec 2010 18:47:04 -0000
Received: (qmail 10011 invoked by uid 22791); 15 Dec 2010 18:47:04 -0000
X-SWARE-Spam-Status: No, hits=-0.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout09.t-online.de (HELO mailout09.t-online.de) (194.25.134.84)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 15 Dec 2010 18:46:59 +0000
Received: from fwd02.aul.t-online.de (fwd02.aul.t-online.de )	by mailout09.t-online.de with smtp 	id 1PSwNL-0002ir-SQ; Wed, 15 Dec 2010 19:46:55 +0100
Received: from [192.168.2.100] (ToSQo-ZTQhXISjIc9jZaRK0x3Wb8aSP9nBe3cVafzObOoQvw5QKizyL+amBtWCUQJu@[79.224.121.68]) by fwd02.aul.t-online.de	with esmtp id 1PSwN9-0emBea0; Wed, 15 Dec 2010 19:46:43 +0100
Message-ID: <4D090D12.6020407@t-online.de>
Date: Thu, 16 Dec 2010 11:10:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.15) Gecko/20101027 SeaMonkey/2.0.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ensure that the default ACL contains the standard entries
References: <4D02A41C.8030406@t-online.de> <20101211204653.GA26611@calimero.vinschen.de> <4D07E02A.2020202@t-online.de> <20101215141149.GW10566@calimero.vinschen.de>
In-Reply-To: <20101215141149.GW10566@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-SW-Source: 2010-q4/txt/msg00020.txt.bz2

Corinna Vinschen wrote:
>>
>> New patch attached.
>>      
> Thanks, applied.
>
>    

Thanks - rsync issue is now fixed.


>> mkdir() may duplicate Windows ACL entries. Testcase (German XP SP3):
>> [...]
>> Problem in security.cc:alloc_sd() ?
>>      
> Indeed.  Thanks for the report.  I fixed that in CVS, hopefully.
>
>
>    

At least the testcase is now OK :-)


BTW: Are there any long term plans to actually implement the acl "mask" ?
Should be possible by mapping the "mask" restrictions to deny acl 
entries for each named entry:
Adds further complexity - might or might not be worth the effort, I'm 
not sure.

Christian
