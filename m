Return-Path: <cygwin-patches-return-4095-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7643 invoked by alias); 16 Aug 2003 09:09:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7621 invoked from network); 16 Aug 2003 09:09:45 -0000
Date: Sat, 16 Aug 2003 09:09:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Package content search and listing functionality for cygcheck
Message-ID: <20030816090943.GH3101@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <16189.37381.740000.619089@gargle.gargle.HOWL> <Pine.GSO.4.44.0308152213460.8431-200000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0308152213460.8431-200000@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00111.txt.bz2

On Fri, Aug 15, 2003 at 10:29:58PM -0400, Igor Pechtchanski wrote:
> On Fri, 15 Aug 2003, David Rothenberger wrote:
> 2003-08-15  David Rothenberger  <daveroth@acm.org>
> 
> 	* dump_setup.cc (package_find): Don't stop searching on missing
> 	file list.
> 	(package_list): Ditto.
> 
> 2003-08-15  Igor Pechtchanski  <pechtcha@cs.nyu.edu>
> 
> 	* dump_setup.cc: (package_list): Make output terse unless
> 	verbose requested.  Fix formatting.
> 	(package_find): Ditto.

Applied.

Thanks to you both,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
