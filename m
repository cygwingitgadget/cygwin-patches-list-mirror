Return-Path: <cygwin-patches-return-2349-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11563 invoked by alias); 6 Jun 2002 15:05:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11534 invoked from network); 6 Jun 2002 15:05:07 -0000
Date: Thu, 06 Jun 2002 08:05:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Name aliasing in security.cc
Message-ID: <20020606170505.H22789@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020603223130.007f6e10@mail.attbi.com> <3.0.5.32.20020530215740.007fc380@mail.attbi.com> <3.0.5.32.20020530215740.007fc380@mail.attbi.com> <3.0.5.32.20020603223130.007f6e10@mail.attbi.com> <3.0.5.32.20020605202359.007fc8a0@mail.attbi.com> <20020606131834.H30892@cygbert.vinschen.de> <3CFF6CB2.66B80261@ieee.org> <20020606162548.E22789@cygbert.vinschen.de> <3CFF761E.720EC8C6@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CFF761E.720EC8C6@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00332.txt.bz2

On Thu, Jun 06, 2002 at 10:47:58AM -0400, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> 
> > You're right but it doesn't matter since I have to open the token
> > anyway since I need the primary group which isn't available at that
> > point.
> 
> Yes, but you open, read and close it and passwd.cc, and then open, read
> and close it in grp.cc. 

Yeah, that's true.  I don't think it slows down the startup as
much as reading passwd and group files, though.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
