Return-Path: <cygwin-patches-return-3313-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9479 invoked by alias); 13 Dec 2002 14:51:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9470 invoked from network); 13 Dec 2002 14:51:23 -0000
Message-ID: <3DF9F40E.8DE0673B@ieee.org>
Date: Fri, 13 Dec 2002 06:51:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Small security patches
References: <3DF76981.86674258@ieee.org> <20021211192211.GD29798@redhat.com> <3DF7A670.E7BA1862@ieee.org> <20021211210349.GB31049@redhat.com> <3DF8BA7A.37C82FE5@ieee.org> <20021213133801.A17831@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00264.txt.bz2

Corinna Vinschen wrote:
> 
> On Thu, Dec 12, 2002 at 11:34:02AM -0500, Pierre A. Humblet wrote:
> > Christopher Faylor wrote:
> > >
> > > Actually, if you can get away without using a
> > > constructor that would be best.  Constructors are a noticeable part of
> > > cygwin's startup cost.

> What about this idea:
> 
> Add a static method init() called from .  Init() checks if it has been
> called already before and returns immendiately if so.  Otherwise it
> initializes the external objects.
> 
> Shouldn't that be sufficient?

That looks great. Can that be generalized? There must be other
modules inside Cygwin that also need to initialize constant structures.
Could all of these initializers be called from some central place, if needed,
rather than having everybody maintain a separate "isinitialized" variable and
add lines in the middle of dll_crt0_1 ()?
In fact we may not even need a central "isinitialized" variable if the
centralized routine is skipped only in case of forks.

Pierre
