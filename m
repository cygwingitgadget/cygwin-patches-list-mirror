Return-Path: <cygwin-patches-return-4084-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19637 invoked by alias); 13 Aug 2003 19:38:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19626 invoked from network); 13 Aug 2003 19:38:06 -0000
Date: Wed, 13 Aug 2003 19:38:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
Message-ID: <20030813193804.GI3101@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.44.0308101528150.7386-200000@slinky.cs.nyu.edu> <Pine.GSO.4.44.0308131432260.192-200000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0308131432260.192-200000@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00100.txt.bz2

On Wed, Aug 13, 2003 at 02:33:57PM -0400, Igor Pechtchanski wrote:
> Ping!  This is pretty urgent, as the code that's currently in CVS won't
> work and has a buffer overflow.
> [...]
> > 2003-08-10  Igor Pechtchanski  <pechtcha@cs.nyu.edu>
> >
> > 	* dump_setup.cc (check_package_files): Fix extra '/' in filename.
> > 	Resize command buffer.  Fix buffer overflow bug.

Applied.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
