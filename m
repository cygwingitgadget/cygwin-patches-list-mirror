Return-Path: <cygwin-patches-return-4786-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28125 invoked by alias); 28 May 2004 19:34:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28116 invoked from network); 28 May 2004 19:34:48 -0000
Message-ID: <40B79455.83A6C71@phumblet.no-ip.org>
Date: Fri, 28 May 2004 19:34:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] fallout of path conversion work?
References: <40B77DBA.D147A597@phumblet.no-ip.org> <20040528190149.GA5391@coe.bosbc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00138.txt.bz2



Christopher Faylor wrote:
> 
> On Fri, May 28, 2004 at 01:58:18PM -0400, Pierre A. Humblet wrote:
> >Here it is.
> >
> >FYI, in 1.5.9 the test changed below was
> >
> >if ((!path.has_symlinks () && strpbrk (dir, ":\\") == NULL
> >           && pcheck_case == PCHECK_RELAXED)
> >   posix_cwd = normalized_posix_path (dir)
> >
> >
> >I think it's correct this time, but more testing never hurts.
> 
> Thanks for the quick response.  Please check in.

I don't have access to my cvs/ssh keys for the moment.
Can you do check it in?

Pierre
