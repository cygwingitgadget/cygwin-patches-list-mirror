Return-Path: <cygwin-patches-return-1863-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27139 invoked by alias); 11 Feb 2002 13:53:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27116 invoked from network); 11 Feb 2002 13:53:12 -0000
Date: Mon, 11 Feb 2002 11:29:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: Rebase Patch Review
In-reply-to: <002a01c1b144$c002b560$7c00a8c0@mchasecompaq>
To: Michael A Chase <mchase@ix.netcom.com>
Cc: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Mail-followup-to: Michael A Chase <mchase@ix.netcom.com>,
 Cygwin-Patches <cygwin-patches@sources.redhat.com>
Message-id: <20020211135812.GC2256@dothill.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.24i
References: <20020205193627.GA816@dothill.com>
 <002a01c1b144$c002b560$7c00a8c0@mchasecompaq>
X-SW-Source: 2002-q1/txt/msg00220.txt.bz2

Michael,

On Sat, Feb 09, 2002 at 12:35:28AM -0800, Michael A Chase wrote:
> I've looked the patch over and don't see any obvious problems.  My technical
> knowledge of C++ has some severe limits though.

Thanks for the review -- I appreciate your efforts.

> It might be better to have rebase in some of the names; rebase_config
> instead of config_file for example.

The above is one of those "niggling" items that I indicated in my post.
I was intending to prevent setup.exe global name space pollution by using
namespaces (if necessary), but I'm willing to change names if that is
more preferable.

Thanks,
Jason
