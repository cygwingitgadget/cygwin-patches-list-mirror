Return-Path: <cygwin-patches-return-3603-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32143 invoked by alias); 20 Feb 2003 11:13:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32133 invoked from network); 20 Feb 2003 11:13:46 -0000
Date: Thu, 20 Feb 2003 11:13:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Message-ID: <20030220111343.GB2467@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000701c2d7b3$fbed0e90$78d96f83@pomello> <20030219021346.P54058-100000@logout.sh.cvut.cz> <20030219012118.GC5253@redhat.com> <3E53A525.9080405@hekimian.com> <20030219175738.GA3544@redhat.com> <20030219194135.GE29232@cygbert.vinschen.de> <20030219201925.GA28790@cygbert.vinschen.de> <20030219210637.GB28790@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219210637.GB28790@cygbert.vinschen.de>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00252.txt.bz2

On Wed, Feb 19, 2003 at 10:06:37PM +0100, Corinna Vinschen wrote:
> Since st_blocks contains the number of blocks allocated, according to
> the Linux man page and SUSv3, shouldn't we change st_blocks to reflect
> the value of GetCompressedFileSize() now?

I've checked in a patch so st_blocks is now computed using
GetCompressedFileSize() on NT systems.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
