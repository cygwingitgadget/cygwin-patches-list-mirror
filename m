Return-Path: <cygwin-patches-return-5139-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7583 invoked by alias); 18 Nov 2004 04:01:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7201 invoked from network); 18 Nov 2004 04:01:29 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 18 Nov 2004 04:01:29 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 54E431B422; Wed, 17 Nov 2004 23:01:56 -0500 (EST)
Date: Thu, 18 Nov 2004 04:01:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: New function: eprintf.
Message-ID: <20041118040155.GA10141@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cnh67l.3vv64o3.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cnh67l.3vv64o3.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00140.txt.bz2

On Thu, Nov 18, 2004 at 04:12:45AM +0100, Bas van Gompel wrote:
>Hi,
>
>Following patch probably does not make much sense "as is", but I
>intend to flesh out this function in the near future. ``eprintf''
>is intended to be called by display_error.
>
>The patch takes this shape in order to keep things trivial (I hope).

Go ahead and check this in and don't worry about keeping things
trivial in cygcheck.  I don't think Red Hat is overly worried about
the intellectual property in that source.

cgf
