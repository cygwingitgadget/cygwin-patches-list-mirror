Return-Path: <cygwin-patches-return-5358-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8203 invoked by alias); 23 Feb 2005 18:00:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7777 invoked from network); 23 Feb 2005 17:59:49 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.115.226)
  by sourceware.org with SMTP; 23 Feb 2005 17:59:49 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 8B56D57D77; Wed, 23 Feb 2005 18:59:47 +0100 (CET)
Date: Wed, 23 Feb 2005 18:00:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch for devices.in
Message-ID: <20050223175947.GQ18314@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20050223T175658-904@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050223T175658-904@post.gmane.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00061.txt.bz2

On Feb 23 17:03, Eric Blake wrote:
> Found this when reviewing the change to add /dev/full
> 
> 2005-02-23  Eric Blake  <ebb9@byu.net>  (tiny change)
                                        ^^^^^^^^^^^^^^^
                                        That's unnecessary.

> 	* devices.in (parsedisk): Fix typo.

Thanks for catching that.  Patch checked in.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
