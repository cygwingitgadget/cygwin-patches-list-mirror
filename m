Return-Path: <cygwin-patches-return-4218-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2508 invoked by alias); 16 Sep 2003 01:03:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2499 invoked from network); 16 Sep 2003 01:03:07 -0000
Message-Id: <3.0.5.32.20030915210152.0081a860@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 16 Sep 2003 01:03:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: Part 2 of Fixing a security hole in pinfo.
In-Reply-To: <20030915080322.GV9981@cygbert.vinschen.de>
References: <20030914023055.GA10962@redhat.com>
 <3.0.5.32.20030913220742.0082d260@incoming.verizon.net>
 <20030914023055.GA10962@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00234.txt.bz2

At 10:03 AM 9/15/2003 +0200, you wrote:
>On Sat, Sep 13, 2003 at 10:30:55PM -0400, Christopher Faylor wrote:
>> On Sat, Sep 13, 2003 at 10:07:42PM -0400, Pierre A. Humblet wrote:
>> >This is the second and final part of the pinfo security patch. 
>> 
>> Looks like a Corinna yea or nay on this one.
>
>The changes look good.  Please apply, Pierre.

Done

>FYI:
>
>What bugged me when reading the patch was my decision at one point to
>use the phrase "orig_sid".  The "orig_sid" is basically what is called
>a "saved id" in POSIX systems and I think it would help reading the
>code if we also rename orig_sid/orig_uid/orig_gid to saved_sid/saved_uid/
>saved_gid and using the phrase "saved" instead of "orig" or "original"
>throughout.

It's true that there are similarities, but there are also important
differences, so using the exact same name may be confusing. 
Not sure what to suggest, your original choice makes sense to me :)

There is also a change I'd like to make eventually: the original_sid
and the sid are cmalloc'ed. As they have a fixed size and every process
needs them, we might as well make them cygsid's in the user structure.
That would be safer and would simplify a few things.

Pierre
