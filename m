Return-Path: <cygwin-patches-return-2447-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30557 invoked by alias); 17 Jun 2002 11:31:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30514 invoked from network); 17 Jun 2002 11:31:50 -0000
Date: Mon, 17 Jun 2002 04:31:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin() patch is in
Message-ID: <20020617133144.A30892@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020613052709.GA17779@redhat.com> <20020613052709.GA17779@redhat.com> <3.0.5.32.20020616000701.007f7df0@mail.attbi.com> <20020616051506.GA6188@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020616051506.GA6188@redhat.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00430.txt.bz2

On Sun, Jun 16, 2002 at 01:15:06AM -0400, Chris Faylor wrote:
> On Sun, Jun 16, 2002 at 12:07:01AM -0400, Pierre A. Humblet wrote:
> >b) NetUserGetInfo() must always be called with the env_logsrv, otherwise
> >name aliasing can occur. Don't call if env_logsrv is NULL, which should
> >be the case only for SYSTEM.
> 
> I seem to recall that Corinna added this code for a reason.

The original reason was to speed up things in domain environments.
The local machine has buffered the user information so it's called
first.  Only if that fails we fallback to calling the logon server
(a PDC probably).  This should avoid unnecessary net access.

I'm curious, too, what you mean by "name aliasing".  Are you talking
about having a local and a domain user of the same name?

> >c) get_logon_server() will fail for SYSTEM. There should be a test
> >"if (strcasematch (Windowname (), "SYSTEM"))" before calling it as it 
> >will looked up repeatedly if plogsrv remains NULL.

That test is ok.

Corinna
