Return-Path: <cygwin-patches-return-5391-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10321 invoked by alias); 29 Mar 2005 10:45:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8647 invoked from network); 29 Mar 2005 10:43:24 -0000
Received: from unknown (HELO cygbert.vinschen.de) (84.148.28.104)
  by sourceware.org with SMTP; 29 Mar 2005 10:43:24 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 2937A57D74; Tue, 29 Mar 2005 12:43:22 +0200 (CEST)
Date: Tue, 29 Mar 2005 10:45:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: "decorate" gcc extensions with __extension__
Message-ID: <20050329104322.GB28534@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050327065657.21624.qmail@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050327065657.21624.qmail@gawab.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00094.txt.bz2

On Mar 27 06:56, Nicholas Wourms wrote:
> This patch is the first of many patches as part of my attempt to
> clean up warnings/errors triggered when building with "-W -Wall
> pedantic" flags.  In this patch, I have "decorated" all
> occurances of gcc c/c++ extensions with the the __extension__
> label.

I don't quite understand why it's necessary to build Cygwin using pedantic
mode.  Cygwin is certainly never meant to be built in pedantic mode and it's
an annoying mess to have to care for this all the time instead of fixing the
real problems.  If you personally have fun to build Cygwin in pedantic mode,
go ahead, but don't expect that the whole code will be changed to support
it.  If you find real bugs by using pedantic mode, then better send fixes
for those bugs.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
