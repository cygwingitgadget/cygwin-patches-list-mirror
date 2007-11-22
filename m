Return-Path: <cygwin-patches-return-6172-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4255 invoked by alias); 22 Nov 2007 11:13:35 -0000
Received: (qmail 4236 invoked by uid 22791); 22 Nov 2007 11:13:34 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 22 Nov 2007 11:13:25 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 0C7C06D4805; Thu, 22 Nov 2007 12:13:22 +0100 (CET)
Date: Thu, 22 Nov 2007 11:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Encode invalid chars in /proc/registry entries
Message-ID: <20071122111322.GL30894@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <473CC0A6.6010409@t-online.de> <20071116110901.GK30894@calimero.vinschen.de> <473DEEA7.1060901@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <473DEEA7.1060901@t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00024.txt.bz2

On Nov 16 20:25, Christian Franke wrote:
> Corinna Vinschen wrote:
>> Thanks for this patch.  Apart from the missing ChangeLog I'm inclined
>> to apply it to the upcoming 1.5.25 release, but I don't like to have it
>> in HEAD as is.
>
> Thanks, I would appreciate to have this issue fixed in the bugfix release.
>
> Here is a new version of the patch and a ChangeLog.
>
> The names "." and ".." are now also encoded. Theses are also valid as 
> Key/Value Names and ".." may result in infinite recursion.

Thanks, I've tested it on my machine and I've applied the patch to the
cr-0x5f1 branch.

>> So, for HEAD I'd like to ask you to allow arbitrary path lengths in your
>> code.  Personally I could live with restricting registry paths to
>> PATH_MAX as well.
>
> Agree. Probably Cygwin should never descend paths that exceed PATH_MAX, as 
> an application using PATH_MAX may have no buffer overflow check.

I agree.

>> While you're digging in registry code anyway... would you be interested
>> to convert the entire registry code to wide char and long path names?
>> I'd be glad for any help.
>
> I will have a look at it, but be patient. Is current HEAD a reasonable 
> starting point or is there a better (more stable) snapshot?

Usually HEAD is the *only* valid starting point.


Thanks again for the patch,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
