Return-Path: <cygwin-patches-return-4785-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2341 invoked by alias); 28 May 2004 19:01:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2329 invoked from network); 28 May 2004 19:01:50 -0000
Date: Fri, 28 May 2004 19:01:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] fallout of path conversion work?
Message-ID: <20040528190149.GA5391@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <40B77DBA.D147A597@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B77DBA.D147A597@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00137.txt.bz2

On Fri, May 28, 2004 at 01:58:18PM -0400, Pierre A. Humblet wrote:
>Here it is.
>
>FYI, in 1.5.9 the test changed below was
>
>if ((!path.has_symlinks () && strpbrk (dir, ":\\") == NULL
>	    && pcheck_case == PCHECK_RELAXED)
>   posix_cwd = normalized_posix_path (dir)
>
>
>I think it's correct this time, but more testing never hurts.

Thanks for the quick response.  Please check in.

We really need someone to spend some time on the test suite.  Any
takers?

cgf
