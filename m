Return-Path: <cygwin-patches-return-5311-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9521 invoked by alias); 21 Jan 2005 18:55:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9462 invoked from network); 21 Jan 2005 18:55:09 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 21 Jan 2005 18:55:09 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 3B8871B522; Fri, 21 Jan 2005 13:55:17 -0500 (EST)
Date: Fri, 21 Jan 2005 18:55:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: RE: ssh problem on Windows XP]
Message-ID: <20050121185517.GC20866@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050121173426.GA16347@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121173426.GA16347@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2005-q1/txt/msg00014.txt.bz2

On Fri, Jan 21, 2005 at 06:34:26PM +0100, Corinna Vinschen wrote:
>If we don't get a patch, I'm inclined to revert the pipe patch before
>we release 1.5.13.  IMHO it's not worth to have one application working
>in favorite of tons of other applications.

FWIW, I agree with Corinna.  The patch will have to be reverted if we
can't get it fixed soon.

cgf
