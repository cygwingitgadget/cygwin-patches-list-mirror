Return-Path: <cygwin-patches-return-6892-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28376 invoked by alias); 9 Jan 2010 19:28:48 -0000
Received: (qmail 28357 invoked by uid 22791); 9 Jan 2010 19:28:47 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f222.google.com (HELO mail-ew0-f222.google.com) (209.85.219.222)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 09 Jan 2010 19:28:43 +0000
Received: by ewy22 with SMTP id 22so24372190ewy.19         for <cygwin-patches@cygwin.com>; Sat, 09 Jan 2010 11:28:40 -0800 (PST)
Received: by 10.213.110.132 with SMTP id n4mr5784065ebp.88.1263065319511;         Sat, 09 Jan 2010 11:28:39 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm47491811eyg.9.2010.01.09.11.28.37         (version=SSLv3 cipher=RC4-MD5);         Sat, 09 Jan 2010 11:28:38 -0800 (PST)
Message-ID: <4B48DCD7.3090809@gmail.com>
Date: Sat, 09 Jan 2010 19:28:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix maybe-used-uninitialised warning.
References: <4B4868F7.1000100@gmail.com> <20100109164023.GB12815@ednor.casa.cgf.cx>
In-Reply-To: <20100109164023.GB12815@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
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
X-SW-Source: 2010-q1/txt/msg00008.txt.bz2

Christopher Faylor wrote:
> On Sat, Jan 09, 2010 at 11:31:03AM +0000, Dave Korn wrote:

>> winsup/cygwin/ChangeLog:
>>
>> 	* hookapi.cc (hook_or_detect_cygwin): Initialise i earlier to avoid
>> 	warning.
>>
>>  OK?
> 
> I'd prefer i be initialized to zero.

  I don't understand why, please explain?  It looks to me like i should only
ever be -1 before the first call to makename.  Is it conceivable that the code
could make it past the loop without ever setting i from 0 to -1?  Well, we may
not want to support it, but what if a win32/cygload exe tried to use the
CW_HOOK functionality?  So I thought it would be best to initialise i with the
value that it will need to have if it ever gets used.

>> winsup/cygwin/ChangeLog:
>>
>> 	* fhandler_tty.cc (process_input): Add redundant final return to
>> 	silence (bogus?) warning.
> 
> These are ok.  As usual, I hate that we have to make these pointless
> accommodations.  But I've been hating that for many years so it's
> nothing newo.

  Let's hold on this one; upstream have confirmed it's a bug(*), so it might
be fixed before we need it anyway.

    cheers,
      DaveK

-- 
(*) - http://gcc.gnu.org/bugzilla/show_bug.cgi?id=42674
