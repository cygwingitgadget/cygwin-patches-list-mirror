Return-Path: <cygwin-patches-return-5303-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15320 invoked by alias); 11 Jan 2005 22:51:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15256 invoked from network); 11 Jan 2005 22:51:32 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.117.17)
  by sourceware.org with SMTP; 11 Jan 2005 22:51:32 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id CB0E55808D; Tue, 11 Jan 2005 23:51:31 +0100 (CET)
Date: Tue, 11 Jan 2005 22:51:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] mkpasswd
Message-ID: <20050111225131.GI23702@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <41E43BB5.714062AA@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E43BB5.714062AA@phumblet.no-ip.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00006.txt.bz2

Hi Pierre,

just go ahead.  You hacked already enough code in these files and know
them pretty well.  You don't have to ask for approval when you change
mkpasswd or mkgroup.  Same goes for setfacl and getfacl btw.


Thanks,
Corinna

On Jan 11 15:48, Pierre A. Humblet wrote:
> 2005-01-11  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* mkpasswd.c (print_win_error): Transform into macro.
> 	(_print_win_error): Upgrade former print_win_error by
> 	 printing the line.
> 	(current_user): Call _print_win_error.
> 	(enum_users): Print name in case of lookup failure.
> 	(enum_local_groups): Ditto.

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
