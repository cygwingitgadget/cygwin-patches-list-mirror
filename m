Return-Path: <cygwin-patches-return-5394-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5427 invoked by alias); 29 Mar 2005 20:30:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5397 invoked from network); 29 Mar 2005 20:30:33 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 29 Mar 2005 20:30:33 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id EDFAC13C84F; Tue, 29 Mar 2005 15:30:32 -0500 (EST)
Date: Tue, 29 Mar 2005 20:30:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: "decorate" gcc extensions with __extension__
Message-ID: <20050329203032.GB32369@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050327065657.21624.qmail@gawab.com> <20050329104322.GB28534@cygbert.vinschen.de> <4249A3F0.6020007@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4249A3F0.6020007@gawab.com>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q1/txt/msg00097.txt.bz2

On Tue, Mar 29, 2005 at 01:52:32PM -0500, Nicholas Wourms wrote:
>Corinna Vinschen wrote:
>Since I assume you and Chris are quite familiar with gcc, I will not
>waste your time by going into detail regarding what all pedantic
>covers.  The bottom line is that giving the developer the ability to
>compile at that level can provide one more opportunity to catch a bug
>before it manifests itself.

You have correctly surmised that both Corinna and I understand what
pedantic mode is.  You have to take that thought a step further,
however, and realize that the fact that there is no -pedantic in CFLAGS
is because we both want to use the full expressive power of gcc without
worrying if we are complying with ISO C or ISO C++.  This is a conscious
choice, not an oversight.

>>and it's an annoying mess to have to care for this all the time instead
>>of fixing the real problems.
>
>Give me a break, the work is already done (by me).  This is no more
>difficult to maintain then any other attribute flags.  You set it and
>forget it.  Remove it when you remove the statement, it doesn't get
>easier then that.  I'm not asking you to do the work of identifying
>issues which do not allow compiling at pedantic mode, I've already done
>that.

I thought Corinna's intent was clear in that sentence.  Apparently you
didn't.

What she was saying is, for this to be done right, both of us would have
to be rigorous in the future about making sure that we add decorate
every extension we use, or, worse, avoid using gcc extensions which
we've come to rely on.  That would be annoying.

However, if I am correctly interpreting your intent, it sounds like you
are saying that no one but you would have to worry about sprinkling
__extension__'s throughout the code and that we could just write code as
we always do.  If that is the case, then I don't see how it matters if
we check in your code or not.  You'll constantly be updating things to
match the latest checkins one way or the other.  However, if your
patches are not going to be checked in, then you don't have to worry
about packaging up your changes for cygwin-patches, which is less work
for you.

If you are expecting that both of us will sign onto the need to use
__extension__ and use it for all new code then your "give me a break"
statement does not make much sense.

Btw, the use of a ?: c is a conscious decision.

cgf
