Return-Path: <cygwin-patches-return-2219-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32716 invoked by alias); 24 May 2002 14:40:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32676 invoked from network); 24 May 2002 14:40:04 -0000
Date: Fri, 24 May 2002 07:40:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: setfacl version patch
Message-ID: <20020524164001.H12995@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.44.0205231943140.1096-200000@iocc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.44.0205231943140.1096-200000@iocc.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00203.txt.bz2

On Thu, May 23, 2002 at 07:43:51PM -0500, Joshua Daniel Franklin wrote:
> 2002-05-23  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
> 	* setfacl.c (usage) Standardize usage output. Change return type to
> 	static void.
> 	(print_version) New function.
> 	(longopts) Added longopts for all options.
> 	(main) Accommodate changes in usage function and new version option.

I've applied this patch with an additionl word and a missing line feed
in the description.  Thanks.

However, I had to correct your above ChangeLog again, as I had already
with the getfacl patch.  You forgot the empty line between the header
and the body and there are colons missing after the name of the functions.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
