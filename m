Return-Path: <cygwin-patches-return-2255-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24623 invoked by alias); 29 May 2002 07:17:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24516 invoked from network); 29 May 2002 07:17:32 -0000
Date: Wed, 29 May 2002 00:17:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: passwd help/version patch
Message-ID: <20020529091720.G30892@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.44.0205282255460.1556-200000@iocc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.44.0205282255460.1556-200000@iocc.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00238.txt.bz2

On Tue, May 28, 2002 at 10:56:21PM -0500, Joshua Daniel Franklin wrote:
> Here is the --help, --version patch for passwd.
> I used the idea from a recent cygpath patch to separate usage output into
> sections, though I feel I've improved on it a bit. :)
> Corinna, you might want to take a look at these longopt names I chose to
> make sure they're OK:

Cool.  Applied.

While playing with it, I'd suddenly missed a short text in the usage,
that the username has to be the windows username, not the Cygwin
username.  Passwd has been written before all that ntsec stuff AFAIR,
so it has no idea that the user "Administrator" might be renamed
to "root" in /etc/passwd.  Do you think you could add something
appropriate?  Or perhaps change passwd to take the Cygwin name and
convert it to the windows name???

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
