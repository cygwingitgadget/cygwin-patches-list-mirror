Return-Path: <cygwin-patches-return-2232-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19837 invoked by alias); 27 May 2002 12:34:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19788 invoked from network); 27 May 2002 12:34:01 -0000
Date: Mon, 27 May 2002 05:34:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: lsa string translation in security.cc, on NT.
Message-ID: <20020527143359.R12995@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020524214852.007f86b0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020524214852.007f86b0@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00216.txt.bz2

On Fri, May 24, 2002 at 09:48:52PM -0400, Pierre A. Humblet wrote:
> 2002/05/24  Pierre Humblet <Pierre.Humblet@ieee.org>
> 
> 	* security.cc (lsau2str): Create.
> 	(get_priv_list): Call lsau2str instead of sys_wcstombs.

Applied with several changes.  The function didn't follow the style
of the already existing lsa2wchar function so I took the freedom to
change it accordingly.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
