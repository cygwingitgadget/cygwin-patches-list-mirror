Return-Path: <cygwin-patches-return-5549-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8318 invoked by alias); 1 Jul 2005 19:11:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8309 invoked by uid 22791); 1 Jul 2005 19:11:50 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 01 Jul 2005 19:11:50 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 82FDE4A82F4; Fri,  1 Jul 2005 15:11:46 -0400 (EDT)
Date: Fri, 01 Jul 2005 19:11:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: cygwin_internal
Message-ID: <20050701191146.GB15927@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <044501c57e45$06cba620$3e0010ac@wirelessworld.airvananet.com> <20050701185405.GP21074@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701185405.GP21074@calimero.vinschen.de>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00004.txt.bz2

On Fri, Jul 01, 2005 at 08:54:05PM +0200, Corinna Vinschen wrote:
>On Jul  1 09:58, Pierre A. Humblet wrote:
>>The situation is that exim has the concept that some groups are
>>privileged and can have write access to the configuration file.  They
>>are normally initialized to hard values set at compile time.
>>
>>The Cygwin port of exim fakes things up so that the gid of Admins
>>(obtained from cygwin_internal) is put in the list of exim's privileged
>>groups.  The problem is that the gid obtained by cygwin_internal (from
>>the Admins sid) may not match the gid reported by stat, which is
>>obtained by cygpsid::get_id () from the same Admins sid.
>
>Ok, that makes sense.  It seems that cygserver can stumble over the
>same problem.
>
>Chris, is removing cygwin_regname ok with you?

Yep.

cgf
