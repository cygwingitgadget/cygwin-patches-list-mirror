Return-Path: <cygwin-patches-return-7152-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2534 invoked by alias); 13 Jan 2011 12:34:03 -0000
Received: (qmail 2403 invoked by uid 22791); 13 Jan 2011 12:33:46 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 13 Jan 2011 12:33:39 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B9A7B2C05C8; Thu, 13 Jan 2011 13:33:36 +0100 (CET)
Date: Thu, 13 Jan 2011 12:34:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck -s should not imply -d
Message-ID: <20110113123336.GA25033@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D24CB9A.2030906@dronecode.org.uk> <20110110125102.GA14789@calimero.vinschen.de> <20110110175244.GC10806@ednor.casa.cgf.cx> <20110111081043.GB8899@calimero.vinschen.de> <4D2C688E.9080204@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D2C688E.9080204@dronecode.org.uk>
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
X-SW-Source: 2011-q1/txt/msg00007.txt.bz2

On Jan 11 14:26, Jon TURNEY wrote:
> On 11/01/2011 08:10, Corinna Vinschen wrote:
> > I wasn't quite sure either, but while running cygcheck with Jon's patch
> > it started to make more sense.  We can also change the docs to ask for
> > `cygcheck -svrd' output, but I guess we should just wait and see.
> 
> FWIW (I don't have all packages installed), mutt is the only package I have
> installed for which cygcheck -c falsely reports a problem.
> 
> $ cygcheck -c | grep -v OK
> Cygwin Package Information
> Package                        Version                  Status
> mutt                           1.5.20-1                 Incomplete

Do you happen to know why?

> Would a patch to http://cygwin.com/setup.html be welcome recommending that:
> (a) if a package installs files which a user is expected to customize, don't
> trample over those customizations when the package is upgraded/reinstalled

Isn't that what /etc/defaults and /etc/postinstall is for, basically?
I'm not sure I understand what you're proposing.  At which point should
setup warn and how is it supposed to know that a file is a
user-customizable one?  In theory, that's all in the responsibility
of the package.

> (b) a package should verify as correctly installed with cygcheck -c?

I don't understand this, sorry.  Would you mind to rephrase and maybe
give an example what you mean?


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
