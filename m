Return-Path: <cygwin-patches-return-2321-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23725 invoked by alias); 6 Jun 2002 00:26:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23711 invoked from network); 6 Jun 2002 00:26:58 -0000
Message-Id: <3.0.5.32.20020605202359.007fc8a0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Wed, 05 Jun 2002 17:26:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Name aliasing in security.cc
In-Reply-To: <20020605140251.V30892@cygbert.vinschen.de>
References: <3.0.5.32.20020603223130.007f6e10@mail.attbi.com>
 <3.0.5.32.20020530215740.007fc380@mail.attbi.com>
 <3.0.5.32.20020530215740.007fc380@mail.attbi.com>
 <3.0.5.32.20020603223130.007f6e10@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00304.txt.bz2

At 02:02 PM 6/5/2002 +0200, Corinna Vinschen wrote:
>> At 07:06 PM 6/3/2002 +0200, Corinna Vinschen wrote:
>> >On Thu, May 30, 2002 at 09:57:40PM -0400, Pierre A. Humblet wrote:
>> >> a) keep lookup_name() as it is?
>> >> b) remove it entirely?
>> >> c) call it whenever a SID is missing from a passwd/group entry, using
>> >> user independent search rules (except if a user looks up itself)? 
>> >
>> >I think b) is the way to go.  IMHO we should deprecate using ntsec
>> >w/o SID in the passwd/group files.
>> 
>would you mind to look over that again?  I've just rearranged reading
>passwd and group files and found an easy method to have useful passwd
>and group info including SIDs even if both files are unavailable.

Hello Corinna,

I saw the changes in grp.cc and passwd.cc where you make default
entries from the token. That's a good idea, very close to what I had 
in mind for the "except" clause" in suggestion c) above.

At any rate this doesn't favor keeping lookup_name() and using it
up only in alloc_sd(). So you could still apply my patches, even if
you want to move from b) to the direction of c).
 
>However, I think calling lookup_name in internal_getlogin() is 
>somewhat useless.
I agree. My patches remove it, but replace it with something similar.
I will remove it later if you apply them.

By the way, your ChangeLog entry is missing "* passwd.cc " :) :) :) 

Pierre
