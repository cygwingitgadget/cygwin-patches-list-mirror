Return-Path: <cygwin-patches-return-7748-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7926 invoked by alias); 24 Oct 2012 07:49:52 -0000
Received: (qmail 7850 invoked by uid 22791); 24 Oct 2012 07:49:37 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 24 Oct 2012 07:49:33 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EC7F12C00AF; Wed, 24 Oct 2012 09:49:30 +0200 (CEST)
Date: Wed, 24 Oct 2012 07:49:00 -0000
From: Corinna Vinschen <corinna@vinschen.de>
To: Earnie Boyd <earnie@users.sourceforge.net>,	Keith Marshall <keith.d.marshall@ntlworld.com>
Cc: Christopher Faylor <me@cgf.cx>, cygwin-patches@cygwin.com
Subject: Re: Fwd: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121024074930.GA28885@calimero.vinschen.de>
Mail-Followup-To: Earnie Boyd <earnie@users.sourceforge.net>,	Keith Marshall <keith.d.marshall@ntlworld.com>,	Christopher Faylor <me@cgf.cx>, cygwin-patches@cygwin.com
References: <508700E3.7000609@users.sourceforge.net> <50870302.5060303@ntlworld.com> <20121023214806.GA2095@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20121023214806.GA2095@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
X-SW-Source: 2012-q4/txt/msg00025.txt.bz2

On Oct 23 17:48, Christopher Faylor wrote:
> On Tue, Oct 23, 2012 at 09:50:10PM +0100, Keith Marshall wrote:
> >And just like Earnie's, the response he requested from me also bounced.
> >Forwarded copy below:
> 
> >-------- Original Message --------
> >Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api 
> >building
> >Date: Tue, 23 Oct 2012 21:41:07 +0100
> >From: Keith Marshall <...>
> >Organization: MinGW Project
> >To: Earnie Boyd <...>
> >CC: cygwin-patches<...>
> >
> >On 22/10/12 12:14, Earnie Boyd wrote:
> >> On Mon, Oct 22, 2012 at 12:09 AM, Christopher Faylor wrote:
> >>>Earnie, we seem to be transitioning from the need to have a
> >>>mingw/w32api in the source tree.  What do you think about removing
> >>>these directories from the depot and moving repo to sourceforge, or
> >>>some other place?
> >>
> >>In anticipation of this event I've already copied the source.  I would
> >>like to leave the code in winsup until the end of the year if that
> >>timeline is fine with Keith.
> >
> >Fine by me; I also have my Mercurial clones of both repositories, from
> >the time when we abandoned them in favour of our own git repository on
> >SourceForge.
> >
> >>>You've got a home for as long as you like on sourceware.org but I was
> >>>thinking that it might be advantageous for mingw to move anyway.
> >>
> >>Thanks and we agree that the move is advantageous.
> >>
> >>>If it helps, I can provide tar copies of the directories from
> >>>sourceware.
> >>
> >>I don't think I need them; Keith what do you think?
> >
> >We've moved on, anyway; any such copies would surely be obsolete.
> 
> I think it's pretty clear that we didn't know you had moved on.  The
> last update to w32api was on 2012-08-10 and mingw was on 2012-08-06.
> 
> A heads up would have been appreciated.

Just to be sure:  Does that mean we can simply remove the mingw and
w32api dirs in the sourceware repo any time?


Corinna
