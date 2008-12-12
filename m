Return-Path: <cygwin-patches-return-6390-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5773 invoked by alias); 12 Dec 2008 17:33:32 -0000
Received: (qmail 5756 invoked by uid 22791); 12 Dec 2008 17:33:31 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout02.t-online.de (HELO mailout02.t-online.de) (194.25.134.17)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 12 Dec 2008 17:32:52 +0000
Received: from fwd10.aul.t-online.de  	by mailout02.sul.t-online.de with smtp  	id 1LBBsf-0004D0-02; Fri, 12 Dec 2008 18:32:49 +0100
Received: from [10.3.2.2] (G5xS6sZ6rhxQGi9awxBpfBC72Oc1EZ8AB+5au2t6DZUiqa8rGVJPiR++PuQ6fMgZEH@[217.235.229.13]) by fwd10.aul.t-online.de 	with esmtp id 1LBBsX-1nPHVI0; Fri, 12 Dec 2008 18:32:41 +0100
Message-ID: <4942A03A.5060104@t-online.de>
Date: Fri, 12 Dec 2008 17:33:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 SeaMonkey/1.1.11
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Avoid duplicate names in /proc/registry (which may 	crash     find)
References: <4939A9F7.1000400@t-online.de> <20081207171802.GV12905@calimero.vinschen.de> <493C1DF7.6090905@t-online.de> <20081208114800.GW12905@calimero.vinschen.de> <20081208115433.GX12905@calimero.vinschen.de> <49417625.4030209@t-online.de> <20081212152000.GA32492@calimero.vinschen.de> <494287F4.2080505@byu.net> <20081212161304.GK32197@calimero.vinschen.de> <49428EA4.5090402@byu.net> <20081212164007.GL32197@calimero.vinschen.de>
In-Reply-To: <20081212164007.GL32197@calimero.vinschen.de>
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
X-SW-Source: 2008-q4/txt/msg00034.txt.bz2

Corinna Vinschen wrote:
> On Dec 12 09:17, Eric Blake wrote:
>   
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> According to Corinna Vinschen on 12/12/2008 9:13 AM:
>>     
>>>> "@" for the named value, and "%.val" for the unnamed default?
>>>>         
>>> Backward compatibility would ask for sticking to @ for the default
>>> value.  Actually there could be a key and a value called @ so you
>>> have three @ items. :-P
>>>       
>> If there is no key or value @, then use @ for the default for
>> compatibility.  If there is either a key or a value named @, then use:
>>
>> @ - named key
>> @%val - named value
>> %val - default value
>>     
>
> Something like that, I guess, though it I get headaches imagining that
> the default value is not the default value anymore if by chance a @ key
> or value exists.  It's a pity that we didn't have Christian's patch
> right from the start.  I'm just glad that this is a seldom border case.
>
>
>   

Why not encode "@" as a reserved name like it is already done for "." 
and ".." (which appear as "%2E" and "%2E.")? This would provide backward 
compatibility and consistency with current conversions:

@ - default value
%40 - named key or value
%40%val - named value if key exists

I will post a patch.

Christian
