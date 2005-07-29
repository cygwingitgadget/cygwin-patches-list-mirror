Return-Path: <cygwin-patches-return-5593-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21300 invoked by alias); 29 Jul 2005 14:28:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21239 invoked by uid 22791); 29 Jul 2005 14:28:25 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 29 Jul 2005 14:28:25 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id DB8C913C0EC; Fri, 29 Jul 2005 10:28:23 -0400 (EDT)
Date: Fri, 29 Jul 2005 14:28:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix seg fault in fork_parent
Message-ID: <20050729142823.GE9031@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1122632688.7369.160.camel@tkuwhuuskartlnx.novogroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122632688.7369.160.camel@tkuwhuuskartlnx.novogroup.com>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00048.txt.bz2

On Fri, Jul 29, 2005 at 01:24:48PM +0300, Arto Huusko wrote:
>2005-07-29  Arto Huusko  <arto.huusko@wmdata.fi>
>
>	* fork.cc (fork_parent): Fix null deref if creation of pinfo
>	of the child fails.

Applied.  Thanks.

cgf
