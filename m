Return-Path: <cygwin-patches-return-2951-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4461 invoked by alias); 11 Sep 2002 10:38:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4413 invoked from network); 11 Sep 2002 10:38:20 -0000
Date: Wed, 11 Sep 2002 03:38:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: initgroups
Message-ID: <20020911123808.Q1574@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020910213124.0080e5a0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020910213124.0080e5a0@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00399.txt.bz2

On Tue, Sep 10, 2002 at 09:31:24PM -0400, Pierre A. Humblet wrote:
> P.S.: Why is there a need to define ILLEGAL_GID? It
> is never used to set a value.

It's used in chown_worker() to check against gid -1 on input.

> 2002-09-10  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* grp.cc (initgroups): Call groups::clear_supp to free the 
> 	supplementary group sids that may have been set by setgroups.
> 	* security.cc (cygsidlist::free_sids): Also zero the class members.
> 	* security.h (groups::clear_supp): New.
> 	Rename cygsidlist_unknown to cygsidlist_empty.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
