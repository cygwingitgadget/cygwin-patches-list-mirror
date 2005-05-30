Return-Path: <cygwin-patches-return-5493-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32483 invoked by alias); 30 May 2005 18:39:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32469 invoked by uid 22791); 30 May 2005 18:39:17 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 30 May 2005 18:39:17 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 9671F13CA7E; Mon, 30 May 2005 14:39:15 -0400 (EDT)
Date: Mon, 30 May 2005 18:39:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Probably unnecessary InterlockedCompareExchangePointer in List_remove in thread.h
Message-ID: <20050530183915.GB15421@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050529165435.H81503@logout.sh.cvut.cz> <20050530105312.GA9933@calimero.vinschen.de> <20050530193427.C19887@logout.sh.cvut.cz> <20050530183330.GA15421@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530183330.GA15421@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00089.txt.bz2

On Mon, May 30, 2005 at 02:33:30PM -0400, Christopher Faylor wrote:
>I think this patch should be ok to apply.

So I applied it.  I beefed up the ChangeLog entry a little more
descriptive about the reason for the change (even though that may not be
100% GNU compliant).

Thanks.

cgf
