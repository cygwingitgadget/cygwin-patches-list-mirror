Return-Path: <cygwin-patches-return-4715-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30003 invoked by alias); 6 May 2004 14:00:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29985 invoked from network); 6 May 2004 14:00:38 -0000
Message-ID: <409A4505.7868167F@phumblet.no-ip.org>
Date: Thu, 06 May 2004 14:00:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: chdir
References: <20040505002003.GA8846@coe.bosbc.com> <3.0.5.32.20040504200359.007fcec0@incoming.verizon.net> <20040505002003.GA8846@coe.bosbc.com> <3.0.5.32.20040505004236.007ff280@incoming.verizon.net> <20040505095134.GA6206@cygbert.vinschen.de> <3.0.5.32.20040505235853.00806100@incoming.verizon.net> <20040506094334.GV2201@cygbert.vinschen.de> <20040506123720.GB17511@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00067.txt.bz2


Corinna Vinschen wrote:
> Ooops:
> 
>   $ cd /
>   /: No such file or directory.

Oops, nothing to do with chdir. It's in the code that detects
file components consisting entirely of dots or spaces.

Something crossed my mind. Should we allow trailing dots and
spaces on managed mounts (and encode that)? After all the goal
is to be fully Unix like there. 
Not sure how to make that backward compatible.

Pierre
