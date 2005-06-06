Return-Path: <cygwin-patches-return-5518-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9696 invoked by alias); 6 Jun 2005 20:06:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9663 invoked by uid 22791); 6 Jun 2005 20:06:41 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 06 Jun 2005 20:06:41 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 0965F13C28E; Mon,  6 Jun 2005 16:06:40 -0400 (EDT)
Date: Mon, 06 Jun 2005 20:06:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC
Message-ID: <20050606200639.GC13442@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1118084587.5031.128.camel@fulgurite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118084587.5031.128.camel@fulgurite>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00114.txt.bz2

On Mon, Jun 06, 2005 at 12:03:07PM -0700, Max Kaehn wrote:
>This patch contains a revised version of the "cygload" test utility,
>this time with better adherence to cygwin naming and indentation.

Sorry, Max, but this is still using K&R indentation.  Cygwin uses:

  if (x)
    {
      y;
    }

not

  if (x) {
    y;
  }

cgf
