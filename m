Return-Path: <cygwin-patches-return-5380-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5433 invoked by alias); 24 Mar 2005 14:49:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5269 invoked from network); 24 Mar 2005 14:48:57 -0000
Received: from unknown (HELO cygbert.vinschen.de) (84.148.42.34)
  by sourceware.org with SMTP; 24 Mar 2005 14:48:57 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id BB36057D73; Thu, 24 Mar 2005 15:48:54 +0100 (CET)
Date: Thu, 24 Mar 2005 14:49:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] fix for cygcheck -s if run from /usr/bin
Message-ID: <20050324144854.GA22213@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <42428E10.3569CCB7@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42428E10.3569CCB7@dessent.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00083.txt.bz2

On Mar 24 01:53, Brian Dessent wrote:
> 	* cygcheck.cc (init_paths): Use full path instead of "." for the
> 	current directory.  Do not add "." if present in $PATH.
> 	(dump_sysinfo): Skip placeholder first value of paths[].

Looks good.  I've checked this in.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
