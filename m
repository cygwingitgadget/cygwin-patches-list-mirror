Return-Path: <cygwin-patches-return-2164-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6040 invoked by alias); 8 May 2002 11:15:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6000 invoked from network); 8 May 2002 11:15:32 -0000
Date: Wed, 08 May 2002 04:15:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Security patches
Message-ID: <20020508131529.D9238@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3CB58D37.52F084E@ieee.org> <3.0.5.32.20020309192813.007fcb70@pop.ne.mediaone.net> <20020314133309.Q29574@cygbert.vinschen.de> <3C90B0D7.EB06F222@ieee.org> <3CB58D37.52F084E@ieee.org> <3.0.5.32.20020507223050.007b2550@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020507223050.007b2550@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00148.txt.bz2

On Tue, May 07, 2002 at 10:30:50PM -0400, Pierre A. Humblet wrote:
> At 09:54 AM 4/12/2002 +0200, Corinna Vinschen wrote:
> >I hope you don't mind that I'm asking you to send the patch again
> >to cygwin-patches, relative to the current CVS. 
> 
> Here is the second installment. The only substantial change is that
> in __sec_user() sid1 is not obtained from cygheap->user.sid ()
> but from a new function getting the sid of the process token user.
> That is because we want the "old" sid, but cygheap->user.sid can
> already be the "new" sid.
> Instead of having this new function it would be more elegant to
> keep this important sid as a NO_COPY variable (initialized in
> dcrt0.cc), or perhaps in cygheap. It's largely a matter of taste.

We should get that SID easily:

  cygsid sid;
  sid.getfrompw (getpwuid (cygheap->user.orig_uid));

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
