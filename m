Return-Path: <cygwin-patches-return-5320-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5362 invoked by alias); 25 Jan 2005 22:03:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5232 invoked from network); 25 Jan 2005 22:03:29 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.112.219)
  by sourceware.org with SMTP; 25 Jan 2005 22:03:29 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 384DF57D73; Tue, 25 Jan 2005 23:03:28 +0100 (CET)
Date: Tue, 25 Jan 2005 22:03:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: setting errno to ENOTDIR rather than ENOENT
Message-ID: <20050125220328.GH31117@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <41F6B1F6.5207C318@phumblet.no-ip.org> <20050125212445.GG31117@cygbert.vinschen.de> <41F6BD82.B5BA299A@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F6BD82.B5BA299A@phumblet.no-ip.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00023.txt.bz2

On Jan 25 16:43, Pierre A. Humblet wrote:
> Do you agree about removing the unreachable (?) code?

Yes, it seems correct to me.  PC_SYM_IGNORE is apparently only set if
pcheck_case is != PCHECK_RELAXED.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
