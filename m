Return-Path: <cygwin-patches-return-5295-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8099 invoked by alias); 31 Dec 2004 20:12:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7828 invoked from network); 31 Dec 2004 20:12:13 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 31 Dec 2004 20:12:13 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 9AB4C1B4C2; Fri, 31 Dec 2004 15:12:19 -0500 (EST)
Date: Fri, 31 Dec 2004 20:12:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: pipe chmod patch
Message-ID: <20041231201219.GA10856@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <fd80972e04122523307f0a1922@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd80972e04122523307f0a1922@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00296.txt.bz2

On Sat, Dec 25, 2004 at 11:30:13PM -0800, Jeremy Lin wrote:
>This trivial patch allows chmod to work on FIFOs. Actually, it doesn't
>seem to allow changing mode for group or other, but it's good enough
>for my purposes (i.e., to make 'screen' be able to detach/attach). Let
>me know if anything needs to be changed.

I thought I'd responded to this but apparently I hadn't.  Sorry for the
delay.

I appreciate the patch, but the problem was more far-reaching than just
pipes and needed to be fixed in a more generic way.  The current snapshot
should solve this problem.

Btw, please be advised that fifo support in cygwin should still be
considered experimental.

cgf
