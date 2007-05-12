Return-Path: <cygwin-patches-return-6079-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27171 invoked by alias); 12 May 2007 12:48:09 -0000
Received: (qmail 27159 invoked by uid 22791); 12 May 2007 12:48:08 -0000
X-Spam-Check-By: sourceware.org
Received: from jerry.kiev.farlep.net (HELO jerry.kiev.farlep.net) (213.130.24.8)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 12 May 2007 12:48:05 +0000
Received: from ilya.kiev.farlep.net ([62.221.47.37] helo=[10.0.0.3]) 	by jerry.kiev.farlep.net with esmtps (TLSv1:AES256-SHA:256) 	(Exim 4.62 (FreeBSD)) 	(envelope-from <ilya@po4ta.com>) 	id 1Hmr0z-000FFP-6N 	for cygwin-patches@cygwin.com; Sat, 12 May 2007 15:48:01 +0300
Message-ID: <4645B776.6000708@po4ta.com>
Date: Sat, 12 May 2007 12:48:00 -0000
From: Ilya Bobir <ilya@po4ta.com>
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: Bug fix and enchantment in cygpath.cc
References: <44CB2A70.9020807@po4ta.com> <20060730124524.GC8152@calimero.vinschen.de> <44CCB327.6010607@po4ta.com> <20060731073251.GE8152@calimero.vinschen.de>
In-Reply-To: <20060731073251.GE8152@calimero.vinschen.de>
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
X-SW-Source: 2007-q2/txt/msg00025.txt.bz2

Corinna Vinschen wrote:
> On Jul 30 16:24, Ilya wrote:
>   
>> Corinna Vinschen wrote:
>>     
>>> On Jul 29 12:29, Ilya wrote:
>>>  
>>>       
>>>> This patch is against cygpath.cc 1.42.
>>>> In 1.43 addressed bug was already fixed, but I believe my fix is a bit 
>>>> better.
>>>>
>>>> Current fix just returns filename, in case filename is for a nonexistent 
>>>> file.  I think that internal short to long file name conversion routine 
>>>> could be used in this case, because it deals ok with nonexistent files.
>>>>    
>>>>         
>>> If you could regenerate your patch so that it's against current CVS, I
>>> will take it, since its size will then be below the "trivial fix" rule.
>>> Please see http://cygwin.com/contrib.html, "Before you get started",
>>> second paragraph.
>>>
>>>
>>> Thanks,
>>> Corinna
>>>  
>>>       
>> No problem :)
>> [...]
>> 	* cygpath.cc (get_long_name): Fallback to get_long_path_name_w32impl.
>> 	Properly null-terminate 'buf'.
>>     
>
> Thanks.  Applied with minor changes.
>
>
> Corinna
>
>
>   

I've submitted this patch on 30.07.2006, but it seems that the bug still 
exists in cygwin-1.5.24-2 that was released on 31.01.2007.
I can see that HEAD CVS brunch contains the fix.

Why is that so?  Is it some kind of mistake?

Ilya Bobir
