Return-Path: <cygwin-patches-return-5026-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32652 invoked by alias); 6 Oct 2004 15:30:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32621 invoked from network); 6 Oct 2004 15:30:26 -0000
Message-ID: <41640F89.9AEEFD2A@phumblet.no-ip.org>
Date: Wed, 06 Oct 2004 15:30:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: warn about trailing (back)slash on mount entries
References: <n2m-g.ck100t.3vvcra7.1@buzzy-box.bavag> <20041006145931.GC29289@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00027.txt.bz2



Christopher Faylor wrote:
> 
> On Wed, Oct 06, 2004 at 03:12:45PM +0200, Bas van Gompel wrote:
> >Another (hopefully trivial) patch, to help in trouble-shooting.
> 
> Wasn't there another problem where "foo\/bar" type of entries were
> showing up?  Could you add a check for that, too?

I while ago I have modified Cygwin to accept this kind of syntax.
Is there a remaining problem in the current release?
Otherwise I don't see the need to alarm the user.

Pierre
