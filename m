Return-Path: <cygwin-patches-return-5236-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4225 invoked by alias); 17 Dec 2004 09:41:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4161 invoked from network); 17 Dec 2004 09:40:54 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.119.48)
  by sourceware.org with SMTP; 17 Dec 2004 09:40:54 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 0F1745808F; Fri, 17 Dec 2004 10:43:01 +0100 (CET)
Date: Fri, 17 Dec 2004 09:41:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: eprintf + display_error: Do /something/.
Message-ID: <20041217094301.GG9277@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cpt7kf.3vvb68n.1@buzzy-box.bavag> <20041217020205.GA26712@trixie.casa.cgf.cx> <n2m-g.cptl2c.3vvd6ov.1@buzzy-box.bavag> <20041217025607.GE26712@trixie.casa.cgf.cx> <n2m-g.cptncf.3vv6gv7.1@buzzy-box.bavag> <20041217061932.GH26712@trixie.casa.cgf.cx> <n2m-g.cpu9so.3vvckrb.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cpu9so.3vvckrb.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00237.txt.bz2

On Dec 17 09:46, Bas van Gompel wrote:
> Op Fri, 17 Dec 2004 01:19:32 -0500 schreef Christopher Faylor
> in <20041217061932.GH26712@trixie.casa.cgf.cx>:
> :  On Fri, Dec 17, 2004 at 04:33:10AM +0100, Bas van Gompel wrote:
> [...]
> : > 	* cygcheck.cc (eprintf): Flush stdout before, and stderr after output,
> : > 	when stdout and stderr both don't refer to ttys.
> : > 	(display_error): Use eprintf.
> :
> :   Ok.  I don't see any reason to check for ttyness, then.  If this is an issue
> :  then lets just flush stdout prior to doing anything with stderr.  Flushing
> :  stderr should always be a no-op.
> 
> It isn't (a no-op). (See the snippet in my previous mail.) Is this a
> difference between cygwin and mingw, maybe?

Hmm, if stderr is not unbuffered in mingw, then that should be fixed
in mingw, shouldn't it?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
