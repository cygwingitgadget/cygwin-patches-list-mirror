Return-Path: <cygwin-patches-return-2939-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11757 invoked by alias); 6 Sep 2002 04:25:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11743 invoked from network); 6 Sep 2002 04:25:34 -0000
Date: Thu, 05 Sep 2002 21:25:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: MinGW-users@lists.sourceforge.net
Cc: cygwin-patches@cygwin.com
Subject: Re: [Mingw-users] Re: WINVER constant value [WAS: GetConsoleWindow]
Message-ID: <20020906042522.GD27778@redhat.com>
Reply-To: MinGW-users@lists.sourceforge.net,
	cygwin-patches@cygwin.com
Mail-Followup-To: MinGW-users@lists.sourceforge.net,
	cygwin-patches@cygwin.com
References: <NCBBIHCHBLCMLBLOBONKEEMFDEAA.g.r.vansickle@worldnet.att.net> <3D780D71.F3F87271@yahoo.com> <7khzvl5r.fsf@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7khzvl5r.fsf@wanadoo.es>
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00387.txt.bz2

On Fri, Sep 06, 2002 at 05:42:24AM +0200, Oscar Fuentes wrote:
>But I think MinGW must not be a drop-in replacement for MSVC.

We aren't talking about just MinGW, though.  Several projects use these
header files.

I'd be interested in hearing your rationale for not making MinGW a
drop-in replacement for MSVC, though.  It seems like there are frequent
discussions about how to arrange things in the header files so that
they closely mimic the layout used by MSVC.  I'm sure I can easily
find examples of this in the email archives.

(maybe that's a discussion just for the mingw mailing list)

Obviously gcc itself is not a complete drop-in replacement for msvc
but we really don't have much control over that.

It seems inconsistent to be lax in this instance.

>If you think it should be, the logic way is to mimic MSVC on every
>possible detail.
>
>The argument about "Why can't MinGW find X API function" is not
>valid. Everyone who programs on Win32 *must* know that different
>Windows versions have different APIs, so if someone can't figure out
>the existence of WINVER, you are doing him a favor by forcing him to
>learn about it.

I've used the "for their own good" line of reasoning myself many times
in the cygwin project but I think I have, more often than not,
eventually reverted to fixing things so that they cause the minimal
amount of end-user confusion.

I think the bottom line is not that we should teach people for their own
good as much as not violate the principle of least surprise.  I honestly
don't know what would be the least surprising in this case, but I
suspect that most people would probably be less surprised by the MSVC
behavior.

cgf
