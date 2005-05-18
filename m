Return-Path: <cygwin-patches-return-5465-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21890 invoked by alias); 18 May 2005 13:34:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21524 invoked from network); 18 May 2005 13:34:05 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 18 May 2005 13:34:05 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 39B7D13C1FE; Wed, 18 May 2005 09:34:17 -0400 (EDT)
Date: Wed, 18 May 2005 13:34:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] gcc4 fixes
Message-ID: <20050518133417.GB19793@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <428A7520.7FD9925C@dessent.net> <20050518080133.GA25438@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518080133.GA25438@calimero.vinschen.de>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00061.txt.bz2

On Wed, May 18, 2005 at 10:01:33AM +0200, Corinna Vinschen wrote:
>On May 17 15:50, Brian Dessent wrote:
>> diff -u -r1.109 mmap.cc
>> --- mmap.cc	2 May 2005 03:50:07 -0000	1.109
>> +++ mmap.cc	17 May 2005 22:40:14 -0000
>> @@ -500,14 +500,14 @@
>>      }
>>  }
>>  
>> +static DWORD granularity = getshmlba ();
>> +
>>  extern "C" void *
>>  mmap64 (void *addr, size_t len, int prot, int flags, int fd, _off64_t off)
>>  {
>>    syscall_printf ("addr %x, len %u, prot %x, flags %x, fd %d, off %D",
>>  		  addr, len, prot, flags, fd, off);
>>  
>> -  static DWORD granularity = getshmlba ();
>> -
>>    /* Error conditions according to SUSv2 */
>>    if (off % getpagesize ()
>>        || (!(flags & MAP_SHARED) && !(flags & MAP_PRIVATE))
>> 
>
>While this might help to avoid... something, I'm seriously wondering
>what's wrong with this expression.  Why does each new version of gcc
>add new incompatibilities?

Well, it might actually be "a gcc bug".

cgf
