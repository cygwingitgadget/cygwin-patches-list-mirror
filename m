Return-Path: <cygwin-patches-return-5115-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25848 invoked by alias); 11 Nov 2004 00:35:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25730 invoked from network); 11 Nov 2004 00:35:48 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 11 Nov 2004 00:35:48 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id C9F4D1B3E5; Wed, 10 Nov 2004 19:35:51 -0500 (EST)
Date: Thu, 11 Nov 2004 00:35:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: Make keyeprint more versatile.
Message-ID: <20041111003551.GA6196@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cmu9aj.3vvcqe5.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.cmu9aj.3vvcqe5.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00116.txt.bz2

On Thu, Nov 11, 2004 at 01:18:43AM +0100, Bas van Gompel wrote:
>Hi,
>
>Another (trivial, I hope) patch.
>
>It will add some optional parameters to keyeprint, so errormessages
>can be made more appropriate. When the options are not supplied, output
>will remain as is.
>
>
>ChangeLog-entry:
>
>2004-11-11  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
>
>	* cygcheck.cc (keyeprint): New optional parameters: show_error and
>	print_failed.

Please check in.  Thanks.

Have I mentioned that I don't like the name 'keyeprint'?  It seems like an odd
name to me.

cgf
