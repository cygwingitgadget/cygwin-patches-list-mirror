Return-Path: <cygwin-patches-return-4210-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30178 invoked by alias); 12 Sep 2003 15:13:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30158 invoked from network); 12 Sep 2003 15:13:58 -0000
Date: Fri, 12 Sep 2003 15:13:00 -0000
From: Jason Tishler <jason@tishler.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: do not check package integrity with a -d flag
Message-ID: <20030912151807.GD1840@tishler.net>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0309111108450.5235@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0309111108450.5235@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q3/txt/msg00226.txt.bz2

Igor,

On Thu, Sep 11, 2003 at 11:12:36AM -0400, Igor Pechtchanski wrote:
> As requested on cygwin-developers@ and cygwin@, this patch adds a flag
> ("-d", or "--dump-only") that instructs cygcheck to not check for the
> presense of all package files on "-c".  So, to get the "old" "cygcheck
> -c" functionality, call "cygcheck -cd".

Thanks!

Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6
