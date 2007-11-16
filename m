Return-Path: <cygwin-patches-return-6169-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27272 invoked by alias); 16 Nov 2007 19:35:55 -0000
Received: (qmail 27258 invoked by uid 22791); 16 Nov 2007 19:35:54 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout02.sul.t-online.de (HELO mailout02.sul.t-online.com) (194.25.134.17)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 16 Nov 2007 19:35:51 +0000
Received: from fwd26.aul.t-online.de  	by mailout02.sul.t-online.com with smtp  	id 1It6yi-0007RI-00; Fri, 16 Nov 2007 20:35:48 +0100
Received: from [10.3.2.2] (TvrLzoZbohrZUg+Ef-lSJnz6aKDFJFuTB91UwzpGGYsNCJdGji0AjDznETJS+dNQvO@[217.235.208.193]) by fwd26.aul.t-online.de 	with esmtp id 1It6ye-1oDbSC0; Fri, 16 Nov 2007 20:35:44 +0100
Message-ID: <473DF114.1090108@t-online.de>
Date: Fri, 16 Nov 2007 19:35:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070802 SeaMonkey/1.1.4
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] Encode invalid chars in /proc/registry entries
References: <473CC0A6.6010409@t-online.de> <20071116110901.GK30894@calimero.vinschen.de> <20071116134022.GA7993@ednor.casa.cgf.cx>
In-Reply-To: <20071116134022.GA7993@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: TvrLzoZbohrZUg+Ef-lSJnz6aKDFJFuTB91UwzpGGYsNCJdGji0AjDznETJS+dNQvO
X-TOI-MSGID: 82ae5c84-6b8a-4fc2-836e-4d2059c96ee6
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00021.txt.bz2

Christopher Faylor wrote:
> ..
>>> Patch is tested with 1.5.24-2. Merge with HEAD looks good, but was not 
>>> actually tested. Therefore, no changelog provided yet.
>>>       
>> Thanks for this patch.  Apart from the missing ChangeLog I'm inclined
>> to apply it to the upcoming 1.5.25 release, but I don't like to have it
>> in HEAD as is.
>>     
>
> I'm not so sure it's appropriate for either yet.
>
> Isn't it possible to use at least some of the managed mode functions
> which deal with munging characters to do some of encoding?  It seems
> like the patch duplicates some of the functionality from path.cc.
>
> I realize that the registry is sort of the opposite of a managed mount
> but it seems like the encoding functions might be potentially used in
> reverse for this.
>
>   

I actually consulted path.cc before starting the patch but did not find 
any function which provides the required functionality OOTB. Therefore, 
I solved the tradeoff between "reuse" and "do not change working code if 
you don't have time for thorough regression testing" by the latter :-)

Christian
