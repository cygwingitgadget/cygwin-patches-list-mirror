Return-Path: <cygwin-patches-return-5401-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23009 invoked by alias); 30 Mar 2005 20:02:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22958 invoked from network); 30 Mar 2005 20:02:19 -0000
Received: from unknown (HELO cygbert.vinschen.de) (84.148.29.205)
  by sourceware.org with SMTP; 30 Mar 2005 20:02:19 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id D383857D73; Wed, 30 Mar 2005 22:02:16 +0200 (CEST)
Date: Wed, 30 Mar 2005 20:02:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Problem with filenames ending in "." with check_case:strict
Message-ID: <20050330200216.GA27101@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.61.0503211850270.8708@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0503211850270.8708@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00104.txt.bz2

On Mar 30 13:51, Igor Pechtchanski wrote:
> 	* path.cc (symlink_info::case_check): Ignore trailing characters
> 	in paths when comparing case.

Thanks, I've applied a slightly modified version of this patch.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
