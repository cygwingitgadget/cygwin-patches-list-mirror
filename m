Return-Path: <cygwin-patches-return-5392-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22722 invoked by alias); 29 Mar 2005 17:47:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22675 invoked from network); 29 Mar 2005 17:47:06 -0000
Received: from unknown (HELO cygbert.vinschen.de) (84.148.28.104)
  by sourceware.org with SMTP; 29 Mar 2005 17:47:06 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id EA0C457D74; Tue, 29 Mar 2005 19:47:04 +0200 (CEST)
Date: Tue, 29 Mar 2005 17:47:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: exceeding PATH_MAX
Message-ID: <20050329174704.GD2495@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4245843E.10700@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4245843E.10700@byu.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00095.txt.bz2

On Mar 26 08:48, Eric Blake wrote:
> 	* include/limits.h (NAME_MAX): New define.
> 	(PATH_MAX): POSIX allows PATH_MAX to include trailing NUL.

I've applied this change to limits.h, just with shorter comments.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
