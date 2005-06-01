Return-Path: <cygwin-patches-return-5504-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27981 invoked by alias); 1 Jun 2005 23:05:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27969 invoked by uid 22791); 1 Jun 2005 23:05:08 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 01 Jun 2005 23:05:08 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id C1B8A13C098; Wed,  1 Jun 2005 19:05:06 -0400 (EDT)
Date: Wed, 01 Jun 2005 23:05:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: Cygwin patches <cygwin-patches@cygwin.com>
Subject: Re: memset & 'VirtualQuery'
Message-ID: <20050601230506.GD20901@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Cygwin patches <cygwin-patches@cygwin.com>
References: <003601c566f0$b7de23a0$96cefea9@none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003601c566f0$b7de23a0$96cefea9@none>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00100.txt.bz2

On Wed, Jun 01, 2005 at 11:27:30PM +0200, Christophe Jaillet wrote:
>when looking thrue cygwin code looking for function 'VirtualQuery', we can
>see that it is passed a structure (MEMORY_BASIC_INFORMATION).
>In some cases, this structure is memset'ed to 0 before the call, sometimes,
>not.

Please send questions or observations to the cygwin mailing list.  This
mailing list is for patches only.
