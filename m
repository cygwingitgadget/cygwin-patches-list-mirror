Return-Path: <cygwin-patches-return-2914-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12873 invoked by alias); 2 Sep 2002 13:52:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12853 invoked from network); 2 Sep 2002 13:52:24 -0000
Date: Mon, 02 Sep 2002 06:52:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Added Kazuhiro's new wchar functions to cygwin.din
Message-ID: <20020902155152.P12899@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020830142028.F5475@cygbert.vinschen.de> <97179922214.20020830163339@logos-m.ru> <20020830150147.G5475@cygbert.vinschen.de> <110182341242.20020830171358@logos-m.ru> <20020830153031.J5475@cygbert.vinschen.de> <3D6FAC14.5080704@netscape.net> <20020902124941.J12899@cygbert.vinschen.de> <3D7344EC.1020701@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D7344EC.1020701@netscape.net>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00362.txt.bz2

On Mon, Sep 02, 2002 at 07:01:00AM -0400, Nicholas Wourms wrote:
> Corinna Vinschen wrote:
> 
> >On Fri, Aug 30, 2002 at 01:32:04PM -0400, Nicholas Wourms wrote:
> >
> >>Corinna Vinschen wrote:
> >>
> >>>On Fri, Aug 30, 2002 at 05:13:58PM +0400, Egor Duda wrote:
> >>>
> >>>
> >>>>It was a typo, sorry. Now, after double-checking, it should read
> >>>>
> >>>>btowc, wctob,
> >>>>mbsinit, mbrlen,
> >>>>mbrtowc, mbstowcs, mbsrtowcs,
> >>>>wcrtomb, wcstombs, wcsrtombs
> >>>>
> >>Corinna,
> >>
> >>You forgot to bump the API after you added these remaining 
> >>symbols to cygwin.din.
> >>
> >
> >Not this time.  I didn't bump it since the additions where within a
> >few minutes.
> >
> Well for some reason, the don't-forget-to-bump-the-api thingy (Egor's 
> script) came into action while trying to compile, causing the build to 
> fail unless I bumped the api.  Perhaps this has to do with the fact that 
> I'm compiling from a branch(cygdaemon-branch) rather then HEAD?

touch include/cygwin/version.h

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
