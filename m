Return-Path: <cygwin-patches-return-2415-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27072 invoked by alias); 13 Jun 2002 16:07:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27033 invoked from network); 13 Jun 2002 16:07:17 -0000
Date: Thu, 13 Jun 2002 09:07:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: passwd edited /etc/passwd patch
Message-ID: <20020613180714.N30892@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.44.0206112017330.772-200000@iocc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.44.0206112017330.772-200000@iocc.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00398.txt.bz2

On Tue, Jun 11, 2002 at 08:18:15PM -0500, Joshua Daniel Franklin wrote:
> +  /* Try getting a Win32 username in case the user edited /etc/passwd */
> +  if (ret == NERR_UserNotFound)
> +  {
> +    if ((pw = getpwnam (user)))
> +      cygwin_internal (CW_EXTRACT_DOMAIN_AND_USER, pw, domain, (char *) user);

Thanks for the patch but, hmm, I think I'd prefer to look always for
the Cygwin username first.
It's unlikely and probably just an academic case but you could have
the Cygwin username user_a for the windows user user_b and vice versa.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
