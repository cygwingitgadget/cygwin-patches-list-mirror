Return-Path: <cygwin-patches-return-1699-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19357 invoked by alias); 14 Jan 2002 23:32:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19340 invoked from network); 14 Jan 2002 23:32:41 -0000
Date: Mon, 14 Jan 2002 15:32:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Danny Smith <danny_r_smith_2001@yahoo.co.nz>
Cc: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/w32api ChangeLog include/winnt.h
Message-ID: <20020115003233.L2015@cygbert.vinschen.de>
Mail-Followup-To: Danny Smith <danny_r_smith_2001@yahoo.co.nz>,
	cygwin-patches <cygwin-patches@cygwin.com>
References: <20020114201534.26518.qmail@sources.redhat.com> <20020114230034.36669.qmail@web14504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114230034.36669.qmail@web14504.mail.yahoo.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00056.txt.bz2

On Tue, Jan 15, 2002 at 10:00:34AM +1100, Danny Smith wrote:
> --- w32api/ChangeLog	2002/01/11 23:33:22	1.80
> +++ w32api/ChangeLog	2002/01/14 22:52:19
> @@ -1,3 +1,9 @@
> +2002-01-14  Danny Smith  <dannysmith@users.sourceforge.net>
> +
> +	* include/winnt.h (FILE_ATTRIBUTE_ENCRYPTED): Correct constant.
> +	(FILE_ATTRIBUTE_DEVICE): Add define.
> +
> +

Thanks, I've applied it to the Cygwin repository.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
