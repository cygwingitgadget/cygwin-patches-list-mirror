Return-Path: <cygwin-patches-return-5500-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23401 invoked by alias); 31 May 2005 23:05:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23349 invoked by uid 22791); 31 May 2005 23:05:14 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 31 May 2005 23:05:14 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 492E013CA7E; Tue, 31 May 2005 19:05:12 -0400 (EDT)
Date: Tue, 31 May 2005 23:05:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: winbase.h (ilockexch)
Message-ID: <20050531230512.GH9864@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050601004223.I56374@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601004223.I56374@logout.sh.cvut.cz>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00096.txt.bz2

On Wed, Jun 01, 2005 at 12:52:26AM +0200, Vaclav Haisman wrote:
>I think that ilockexch() in winbase.h should look like what is in my
>patch.  Explicit lock prefix is not needed because xchg instruction
>sets LOCK# signal implicitly.

A similar implementation in the linux kernel seems to disagree with you.

cgf
