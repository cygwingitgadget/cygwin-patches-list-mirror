Return-Path: <cygwin-patches-return-4529-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16931 invoked by alias); 23 Jan 2004 11:03:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16842 invoked from network); 23 Jan 2004 11:03:32 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <4010FF6D.6020504@gmx.net>
Date: Fri, 23 Jan 2004 11:03:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH]: 2. Thread safe stdio update
References: <40103708.1020501@gmx.net> <20040123100856.GD12512@cygbert.vinschen.de>
In-Reply-To: <20040123100856.GD12512@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q1/txt/msg00019.txt.bz2

Corinna Vinschen wrote:
> On Jan 22 21:48, Thomas Pfaff wrote:
> 
>>This is an update of my previous patch. It adds support for newlibs 
>>__LOCK_INIT macro.
>>
>>Thomas
>>
>>2004-01-22 Thomas Pfaff <tpfaff@gmx.net>
>>
>>	* include/sys/_types.h: New file.
> 
> 
> I'm not quite sure if that's the way to go.  I'm wondering if we
> shouldn't keep newlib's _types.h and change it like this:
> 
>   #ifdef __CYGWIN__
>   #include <cygwin/_types.h>
>   #endif
> 
>   #ifndef __CYGWIN__
>   typedef int _flock_t;
>   #endif
> 
> Then we can create a cygwin/_types.h with the correct _flock_t definition.
> IMHO that's cleaner than just overloading newlib's _types.h.
> 

You may be right.

I just followed the way it was done in newlibs linux support where a 
modified _types.h is in newlib/libc/sys/linux/sys (and it was the 
easiest way for me to test it).

Will you make this change in newlibs _types.h ?

Thomas
