Return-Path: <cygwin-patches-return-2166-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16035 invoked by alias); 8 May 2002 14:23:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16021 invoked from network); 8 May 2002 14:23:18 -0000
Date: Wed, 08 May 2002 07:23:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Security patches
Message-ID: <20020508162312.J9238@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3CB58D37.52F084E@ieee.org> <3.0.5.32.20020309192813.007fcb70@pop.ne.mediaone.net> <20020314133309.Q29574@cygbert.vinschen.de> <3C90B0D7.EB06F222@ieee.org> <3CB58D37.52F084E@ieee.org> <3.0.5.32.20020507223050.007b2550@mail.attbi.com> <20020508131529.D9238@cygbert.vinschen.de> <3CD92ECC.2377927E@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CD92ECC.2377927E@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00150.txt.bz2

On Wed, May 08, 2002 at 09:57:32AM -0400, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> > 
> > We should get that SID easily:
> > 
> >   cygsid sid;
> >   sid.getfrompw (getpwuid (cygheap->user.orig_uid));
> 
> That's a nice looking statement but behind it we are
> searching the whole passwd file (*)
> Also it seems that the rest of Cygwin gets SIDs directly from 
> Windows and not from the less reliable passwd (which may not 
> exist), whenever practical.
> Do you wish to use this method anyway or do you have another
> idea?

I don't insist on using that method.  I think you're right in
your original mail that having the original SID in cygheap
would be the way to go.  So I've just commited an extension
to `class cygheap_user'.  It now holds a new member `orig_psid'
which contains the SID on application start.  This is done in
the already existing method cygheap_user::set_sid() which now
fills `orig_sid' with the same value as `psid' if `psid' is NULL.

You can retrieve the value of `orig_psid' by calling the method
`orig_sid()' now.

Hope that helps,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
