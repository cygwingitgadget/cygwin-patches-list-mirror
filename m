Return-Path: <cygwin-patches-return-2733-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32726 invoked by alias); 26 Jul 2002 19:49:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32709 invoked from network); 26 Jul 2002 19:49:15 -0000
Date: Fri, 26 Jul 2002 12:49:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: setgroups
Message-ID: <20020726214913.M3921@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020726000410.00813de0@mail.attbi.com> <20020726105948.A30785@cygbert.vinschen.de> <3D415128.373F4E59@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D415128.373F4E59@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00181.txt.bz2

On Fri, Jul 26, 2002 at 09:39:52AM -0400, Pierre A. Humblet wrote:
> The idea is that setgroups finds the group sids in /etc/group and stores 
> them in a structure in cygheap->user. That structure must be cmalloc'ed,
> hence the new class. The primary group sid is also stored there,
> which requires minor changes in internal_getlogin and setegid.
> setgroups returns an error if sids are not in /etc/group.
> 
> When seteuid is called, create_token checks if setgroups was called. 
> + If not, it does exactly as before and calls the former get_group_sidlist, 
> which is broken into get_initgroups_sidlist and get_token_group_sidlist
> for software reuse reasons (see below).
> + If setgroups has been called, create_token calls get_setgroups_sidlist,
> which copies the group sids from the cygheap to the temporary cygsidlist
> and which also calls get_token_group_sidlist (reuse software).
> 
> Sorry if this is too terse, I'd be happy to answer more questions.

No, that's perfectly ok.  Hmm, somehow I'd still wish to avoid two
implementations of sidlists...

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
