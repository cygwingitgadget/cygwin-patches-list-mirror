Return-Path: <cygwin-patches-return-2448-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8794 invoked by alias); 17 Jun 2002 12:00:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8761 invoked from network); 17 Jun 2002 12:00:46 -0000
Message-ID: <3D0DCF70.33E27FB7@certum.pl>
Date: Mon, 17 Jun 2002 05:00:00 -0000
From: Jacek Trzcinski <jacek@certum.pl>
Reply-To: jacek@certum.pl
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Reorganizing internal_getlogin() patch is in
References: <20020613052709.GA17779@redhat.com> <20020613052709.GA17779@redhat.com> <3.0.5.32.20020616000701.007f7df0@mail.attbi.com> <20020616051506.GA6188@redhat.com> <20020617133144.A30892@cygbert.vinschen.de>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00431.txt.bz2

Hello Corinna !
About one Year ago I created patch to serial device which was serving
ioctl function enabling setting RTS and DTR lines and reading CTS and
DSR lines. As I remember our last discussion one thing left - copyright
assignment. I had agreement of my boss but I was "too lazy" to post it.
Other matter is that recently I use Cygwin relatively rarely so I had no
motivation to do it.
Recently I have got few e-mails fom Cygwin list what is on with the
patch. I wonder If You are still interested in the patch . If so I can
immediately post copyright assignment. In this case remind me please
where can I find correct form sheets for such assignment.

Best regards
Jacek

Corinna Vinschen wrote:
> 
> On Sun, Jun 16, 2002 at 01:15:06AM -0400, Chris Faylor wrote:
> > On Sun, Jun 16, 2002 at 12:07:01AM -0400, Pierre A. Humblet wrote:
> > >b) NetUserGetInfo() must always be called with the env_logsrv, otherwise
> > >name aliasing can occur. Don't call if env_logsrv is NULL, which should
> > >be the case only for SYSTEM.
> >
> > I seem to recall that Corinna added this code for a reason.
> 
> The original reason was to speed up things in domain environments.
> The local machine has buffered the user information so it's called
> first.  Only if that fails we fallback to calling the logon server
> (a PDC probably).  This should avoid unnecessary net access.
> 
> I'm curious, too, what you mean by "name aliasing".  Are you talking
> about having a local and a domain user of the same name?
> 
> > >c) get_logon_server() will fail for SYSTEM. There should be a test
> > >"if (strcasematch (Windowname (), "SYSTEM"))" before calling it as it
> > >will looked up repeatedly if plogsrv remains NULL.
> 
> That test is ok.
> 
> Corinna
