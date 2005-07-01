Return-Path: <cygwin-patches-return-5548-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23032 invoked by alias); 1 Jul 2005 18:54:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22978 invoked by uid 22791); 1 Jul 2005 18:53:56 -0000
Received: from p54941b3c.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (84.148.27.60)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 01 Jul 2005 18:53:56 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 238766D4235; Fri,  1 Jul 2005 20:54:05 +0200 (CEST)
Date: Fri, 01 Jul 2005 18:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: cygwin_internal
Message-ID: <20050701185405.GP21074@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <044501c57e45$06cba620$3e0010ac@wirelessworld.airvananet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044501c57e45$06cba620$3e0010ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q3/txt/msg00003.txt.bz2

On Jul  1 09:58, Pierre A. Humblet wrote:
> The situation is that exim has the concept that some groups
> are privileged and can have write access to the configuration file.
> They are normally initialized to hard values set at compile time.
> 
> The Cygwin port of exim fakes things up so that the gid of Admins
> (obtained from cygwin_internal) is put in the list of exim's privileged
> groups.
> The  problem is that the gid obtained by cygwin_internal (from the
> Admins sid) may not match the gid reported by stat, which is obtained by
> cygpsid::get_id () from the same Admins sid.

Ok, that makes sense.  It seems that cygserver can stumble over the
same problem.

Chris, is removing cygwin_regname ok with you?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
