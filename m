Return-Path: <cygwin-patches-return-7154-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24819 invoked by alias); 13 Jan 2011 13:24:59 -0000
Received: (qmail 24795 invoked by uid 22791); 13 Jan 2011 13:24:44 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 13 Jan 2011 13:24:40 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BF0872C05C8; Thu, 13 Jan 2011 14:24:37 +0100 (CET)
Date: Thu, 13 Jan 2011 13:24:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck -s should not imply -d
Message-ID: <20110113132437.GB25033@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D24CB9A.2030906@dronecode.org.uk> <20110110125102.GA14789@calimero.vinschen.de> <20110110175244.GC10806@ednor.casa.cgf.cx> <20110111081043.GB8899@calimero.vinschen.de> <4D2C688E.9080204@dronecode.org.uk> <20110113123336.GA25033@calimero.vinschen.de> <4D2EF866.9090809@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D2EF866.9090809@dronecode.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00009.txt.bz2

On Jan 13 13:04, Jon TURNEY wrote:
> On 13/01/2011 12:33, Corinna Vinschen wrote:
> > On Jan 11 14:26, Jon TURNEY wrote:
> >> On 11/01/2011 08:10, Corinna Vinschen wrote:
> >>> I wasn't quite sure either, but while running cygcheck with Jon's patch
> >>> it started to make more sense.  We can also change the docs to ask for
> >>> `cygcheck -svrd' output, but I guess we should just wait and see.
> >>
> >> FWIW (I don't have all packages installed), mutt is the only package I have
> >> installed for which cygcheck -c falsely reports a problem.
> >>
> >> $ cygcheck -c | grep -v OK
> >> Cygwin Package Information
> >> Package                        Version                  Status
> >> mutt                           1.5.20-1                 Incomplete
> > 
> > Do you happen to know why?
> 
> You can read my ill-informed speculation about this matter at [1] :-)
> 
> [1] http://sourceware.org/ml/cygwin-apps/2010-11/msg00065.html

Uh, ok.  Thanks for the pointer.

> >> Would a patch to http://cygwin.com/setup.html be welcome recommending that:
> >> (a) if a package installs files which a user is expected to customize, don't
> >> trample over those customizations when the package is upgraded/reinstalled
> > 
> > Isn't that what /etc/defaults and /etc/postinstall is for, basically?
> > I'm not sure I understand what you're proposing.  At which point should
> > setup warn and how is it supposed to know that a file is a
> > user-customizable one?  In theory, that's all in the responsibility
> > of the package.
> 
> Sorry, that URL isn't very helpfully named.  I'm not proposing to change
> setup.exe, I'm just suggesting adding some text to the 'Cygwin Package
> Contributor's Guide' web page, recommending those things. (I only became aware
> of the existence of /etc/defaults by looking at what other packages do, I
> can't see it mentioned on that page)

Ouch.  Sorry about that.  Yes, sure, it would surely be welcome
to see progress in the docs, too.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
