Return-Path: <cygwin-patches-return-1835-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14105 invoked by alias); 2 Feb 2002 04:44:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14080 invoked from network); 2 Feb 2002 04:44:40 -0000
Message-ID: <006701c1aba4$4996cb50$0d00a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
References: <FC169E059D1A0442A04C40F86D9BA760629F@itdomain003.itdomain.net.au>
Subject: Re: For the curious: Setup.exe char-> String patch
Date: Fri, 01 Feb 2002 20:44:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00192.txt.bz2

----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>; <cygwin-patches@cygwin.com>
Sent: Friday, February 01, 2002 18:45
Subject: RE: For the curious: Setup.exe char-> String patch

>> -----Original Message-----
>> From: Michael A Chase [mailto:mchase@ix.netcom.com]
>> . . .
>> String++.h:
>>
>> ### Do you want String::concat() and String::vconcat to be
>> public?  The few
>> places I see them being used could be ... String ("first") +
>> next + next ...
>> You lose a little efficiency by not calling String::concat,
>> but you make up
>> some of it by not having to call String::cstr_oneuse().
>
> HMMM, worth thinking about. Remeber that vconcat can only be used with
> char *'s, and we don't want them :}. (think unicode native storage).
> There are other lower lever mechanisms to optimise String, but as we
> aren't CPU bound, I'm not concerned at this point. One such example you
> could look at is the SGI Rope class template. (I've not looked at that
> but it's similar to what another project I'm on has been creating from
> scratch, a team member recently said "hey, this is similar :}". As for
> concat vs +, concat canonicalises paths, which is what broke Chuck's //
> path references (because / indicated a posix path to the code AFAIK). I
> don't think thats an appropriate use for String:: though, so wrote +,
> and used that. Also, canonicalisation IMO should occur at the
> io_stream::open and related calls, not at every manipulation: file path
> fragments shouldn't get canonicalised.

This sounds like a case of violent agreement.  I'll apply the big patch in a
separate directory and see where concat and vconcat are being used in hopes
of replacing them.

>> log.cc/log.h:
>>
>> ### If I understand the change, a log line may be either
>> timestamped or
>> babble.  So a line can't be timestamped and only go to setup.log.full.
>> Likewise all lines in setup.log must be timestamped.  I think
>> we are losing
>> some useful capablities by changing from flags to level.
>
> mmm, yes, but we've also gained type safety. If you wish to submit a
> flags class ( I can enlarge on that if needed) to allow log
> (LOG_BABBLE|LOG_FULL & LOG_TIMESTAMP|LOG_LITERAL, String const &) that'd
> be fine by me. I like enforcing type safety where possible.

I'll have to do some thinking on that.  I've never tried to create a class.
Other changes would be more important at this point.  Would a LOG_PLAIN
(==LOG_TIMESTAMP) be acceptable to replace 0 in log() calls for now?  That
way it would be fairly easy to get back to the current log appearance if we
decide to.

>> mount.cc:
>>
>> ### It looks like it might be cleaner to make String cygpath
>> (String const
>> &) visible along with String cygpath (const char *, ...).  It
>> seems like
>> nearly every place I saw it used you are doing cygpath
>> (xxx.cstr_oneuse(),0).
>
> Yes, I want to... but doing it was going to be a right ol' pain
> initially, so I pu tit to the side.
>
>> ### The few places that involve concatenation could be handled by
>> String()+x+...  I'm willing to make a patch to catch any
>> leftovers so String
>> cygpath( const char *, ...) could be dropped.
>
> Please do.

I'll start on a patch to go over your big one.


