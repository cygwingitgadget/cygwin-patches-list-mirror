Return-Path: <cygwin-patches-return-5143-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3509 invoked by alias); 18 Nov 2004 17:06:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3495 invoked from network); 18 Nov 2004 17:06:47 -0000
Received: from unknown (HELO mail.epost.de) (193.28.100.151)
  by sourceware.org with SMTP; 18 Nov 2004 17:06:47 -0000
Received: from seneca.benny.turtle-trading.net.epost.de (193.99.153.30) by mail.epost.de (7.2.033.1) (authenticated as Benjamin.Riefenstahl)
        id 419C047000010DAF for cygwin-patches@cygwin.com; Thu, 18 Nov 2004 18:06:46 +0100
To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Subject: Re: [Patch] cygcheck: eprintf + display_error: Do more.
References: <n2m-g.cnhqes.3vv4uqn.1@buzzy-box.bavag>
From: Benjamin Riefenstahl <Benjamin.Riefenstahl@epost.de>
Date: Thu, 18 Nov 2004 17:06:00 -0000
In-Reply-To: <n2m-g.cnhqes.3vv4uqn.1@buzzy-box.bavag> (Bas van Gompel's
 message of "Thu, 18 Nov 2004 09:52:04 +0100 (MET)")
Message-ID: <m33bz7w0hn.fsf@seneca.benny.turtle-trading.net>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2004-q4/txt/msg00144.txt.bz2

Hi Bas,

Bas van Gompel writes:
> +  if (fileno (stdout) != fileno (stderr) [...]

I thought that fileno(stdout) is *always* 1 and fileno(stderr) is
*always* 2.  Isn't that true?

benny
