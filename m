Return-Path: <cygwin-patches-return-2307-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9178 invoked by alias); 5 Jun 2002 12:02:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9153 invoked from network); 5 Jun 2002 12:02:55 -0000
Date: Wed, 05 Jun 2002 05:02:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Name aliasing in security.cc
Message-ID: <20020605140251.V30892@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020530215740.007fc380@mail.attbi.com> <3.0.5.32.20020530215740.007fc380@mail.attbi.com> <3.0.5.32.20020603223130.007f6e10@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020603223130.007f6e10@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00290.txt.bz2

On Mon, Jun 03, 2002 at 10:31:30PM -0400, Pierre A. Humblet wrote:
> At 07:06 PM 6/3/2002 +0200, Corinna Vinschen wrote:
> >On Thu, May 30, 2002 at 09:57:40PM -0400, Pierre A. Humblet wrote:
> >> a) keep lookup_name() as it is?
> >> b) remove it entirely?
> >
> >I think b) is the way to go.  IMHO we should deprecate using ntsec
> >w/o SID in the passwd/group files.
> 
> Here it is. Lots of trivial changes. Tested by running chown.

Hi Pierre,

would you mind to look over that again?  I've just rearranged reading
passwd and group files and found an easy method to have useful passwd
and group info including SIDs even if both files are unavailable.

This slightly changes the way we could handle that situation.  We're
not necessarily requiring these files for a working ntsec now and
AFAICS, this results in a different state of the lookup_name function.

However, I think calling lookup_name is somewhat useless.  If a process
can't read it's own token, something's really broken (and this is
in retrospect the reason you investigated in changing the security
stuff).

I'm sorry to step in that late.  I hope you're not too frustrated...

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
