Return-Path: <cygwin-patches-return-4973-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19101 invoked by alias); 22 Sep 2004 13:58:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19085 invoked from network); 22 Sep 2004 13:58:31 -0000
Message-ID: <41518501.B3406DCF@phumblet.no-ip.org>
Date: Wed, 22 Sep 2004 13:58:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Still path.cc
References: <3.0.5.32.20040921215840.0081d100@incoming.verizon.net> <20040922134608.GA26453@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q3/txt/msg00125.txt.bz2



Christopher Faylor wrote:
> 
> On Tue, Sep 21, 2004 at 09:58:40PM -0400, Pierre A. Humblet wrote:
> >It's a safe time to take care of a few nits...
> >
> >2004-09-22  Pierre Humblet <pierre.humblet@ieee.org>
> >
> >       * path.cc (normalize_win32_path): Only look for : in second position.
> >       Avoid infinite loop with names starting in double dots.
> >       (mount_info::conv_to_win32_path): Do not worry about a trailing dot.
> 
> Why not worry about a trailing dot?  Is it handled somewhere else?  The
> intent is to make the inode of /foo/.  == /foo .

Yes, that's handled in the appropriate normalize_xx_path function,
together with xx/./yy , xx/../yy, and friends.

Pierre
