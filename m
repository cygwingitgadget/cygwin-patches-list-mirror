Return-Path: <cygwin-patches-return-4562-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25762 invoked by alias); 6 Feb 2004 15:58:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25748 invoked from network); 6 Feb 2004 15:58:05 -0000
Date: Fri, 06 Feb 2004 15:58:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: 2. Thread safe stdio update
Message-ID: <20040206155805.GA14846@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <40103708.1020501@gmx.net> <20040123100856.GD12512@cygbert.vinschen.de> <4010FF6D.6020504@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4010FF6D.6020504@gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00052.txt.bz2

On Fri, Jan 23, 2004 at 12:03:09PM +0100, Thomas Pfaff wrote:
>Corinna Vinschen wrote:
>>On Jan 22 21:48, Thomas Pfaff wrote:
>>
>>>This is an update of my previous patch. It adds support for newlibs 
>>>__LOCK_INIT macro.
>>>
>>>Thomas
>>>
>>>2004-01-22 Thomas Pfaff <tpfaff@gmx.net>
>>>
>>>	* include/sys/_types.h: New file.
>>
>>
>>I'm not quite sure if that's the way to go.  I'm wondering if we
>>shouldn't keep newlib's _types.h and change it like this:
>>
>>  #ifdef __CYGWIN__
>>  #include <cygwin/_types.h>
>>  #endif
>>
>>  #ifndef __CYGWIN__
>>  typedef int _flock_t;
>>  #endif
>>
>>Then we can create a cygwin/_types.h with the correct _flock_t definition.
>>IMHO that's cleaner than just overloading newlib's _types.h.
>
>You may be right.
>
>I just followed the way it was done in newlibs linux support where a 
>modified _types.h is in newlib/libc/sys/linux/sys (and it was the 
>easiest way for me to test it).

Btw, I agree with Corinna's assessment here.  That's one reason why I
didn't just drop this into the release.  I'd like to minimize the amount
of header duplication we have between cygwin and newlib.  And, wholesale
duplication with just one small change is always a bad idea.

cgf
