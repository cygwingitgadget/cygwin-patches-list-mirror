Return-Path: <cygwin-patches-return-4252-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12449 invoked by alias); 26 Sep 2003 14:39:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12439 invoked from network); 26 Sep 2003 14:39:41 -0000
Date: Fri, 26 Sep 2003 14:39:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: {Patch]: Giving access to pinfo after seteuid and exec
Message-ID: <20030926143940.GQ22787@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030925214748.0081f330@incoming.verizon.net> <20030926122220.GA29894@cygbert.vinschen.de> <3F7441FD.8D36D01C@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7441FD.8D36D01C@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00268.txt.bz2

On Fri, Sep 26, 2003 at 09:41:17AM -0400, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> > Somehow I'm missing a description why that's necessary and the
> > implications.
> > 
> I am getting paranoid. Most often we duplicate DUPLICATE_SAME_ACCESS
> without thinking about what access is really needed. It would be a good
> discipline to ask ourselves what is needed and give just that. Here nothing
> is needed at all. 
> Also, if you use sysinternals you can see the access mask. Setting it
> properly creates differentiating features that help distinguish between
> all the handles.

This handle is only used to have a handle.  It's never accessed, just
kept so that we not get the same Winpid again, right?  If so, the
patch is ok, of course.  I was just missing a description.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
