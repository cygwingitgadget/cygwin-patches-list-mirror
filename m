Return-Path: <cygwin-patches-return-2457-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2403 invoked by alias); 18 Jun 2002 11:41:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2388 invoked from network); 18 Jun 2002 11:41:07 -0000
Date: Tue, 18 Jun 2002 04:41:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Reorganizing internal_getlogin() patch is in
Message-ID: <20020618134102.A23980@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020616051506.GA6188@redhat.com> <20020613052709.GA17779@redhat.com> <20020613052709.GA17779@redhat.com> <3.0.5.32.20020616000701.007f7df0@mail.attbi.com> <20020616051506.GA6188@redhat.com> <3.0.5.32.20020617224247.007faad0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020617224247.007faad0@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00440.txt.bz2

On Mon, Jun 17, 2002 at 10:42:47PM -0400, Pierre A. Humblet wrote:
> At 01:31 PM 6/17/2002 +0200, Corinna Vinschen wrote:
> >The original reason was to speed up things in domain environments.
> >The local machine has buffered the user information so it's called
> >first.  Only if that fails we fallback to calling the logon server
> >(a PDC probably).  This should avoid unnecessary net access.
> >
> >I'm curious, too, what you mean by "name aliasing".  Are you talking
> >about having a local and a domain user of the same name?
> 
> Yes, precisely.
> 
> About caching, I did some experiments on NT.
> The SID doesn't seem to be cached, in the sense that calling 
> LookupAccountSid() twice in a row, with the Ethernet unplugged the 
> second time, returns a failure after a very long delay.

What exactly did you try?  My intention was to eliminate a 
network access in case Cygwin is started on the Windows
desktop.  No setuid() is involved.  So the user information
is the one of the currently locally logged in user.  This
information should be available on the local machine even
in case of domain accounts.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
