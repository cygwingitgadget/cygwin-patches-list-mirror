Return-Path: <cygwin-patches-return-5546-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5747 invoked by alias); 1 Jul 2005 08:42:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5678 invoked by uid 22791); 1 Jul 2005 08:42:04 -0000
Received: from p54941b3c.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (84.148.27.60)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 01 Jul 2005 08:42:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AB07C6D422F; Fri,  1 Jul 2005 10:42:11 +0200 (CEST)
Date: Fri, 01 Jul 2005 08:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: cygwin_internal
Message-ID: <20050701084211.GB17235@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050701005237.00b69b68@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20050701005237.00b69b68@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q3/txt/msg00001.txt.bz2

On Jul  1 00:52, Pierre A. Humblet wrote:
> 
> The patch below uses cygpsid::get_id to implement CW_GET_UID_FROM_SID
> and CW_GET_GID_FROM_SID in cygwin_internal. Thus the sid is first
> compared to the user (or primary group) sid, before looking up
> the passwd (or group) file.
> 
> This can make a difference when a sid appears multiple times in the
> passwd or group file, e.g. when one has both 544 and 0.
> This difference can cause exim (and perhaps others) to fail (it did
> happen to me).

Can you please describe the exact situation?  I think I see it, but I
want to be really sure.  I'm not keen on accidentally breaking Cygserver's
authentication routine.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
