Return-Path: <cygwin-patches-return-5569-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29137 invoked by alias); 15 Jul 2005 19:08:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29115 invoked by uid 22791); 15 Jul 2005 19:08:55 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 15 Jul 2005 19:08:55 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id D534013C12A; Fri, 15 Jul 2005 15:08:53 -0400 (EDT)
Date: Fri, 15 Jul 2005 19:08:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Changes to how-programming.texinfo
Message-ID: <20050715190853.GH13238@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1121451065.13490.13.camel@fulgurite> <20050715183012.GG13238@trixie.casa.cgf.cx> <1121453602.13490.24.camel@fulgurite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121453602.13490.24.camel@fulgurite>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00024.txt.bz2

On Fri, Jul 15, 2005 at 11:53:22AM -0700, Max Kaehn wrote:
>On Fri, 2005-07-15 at 14:30 -0400, Christopher Faylor wrote:
>>IMO, if we need additional wording about licensing, it should reference
>>the web site.
>
>I'm concerned about that FAQ entry giving incomplete information

And, I'm always concerned about people who can't find any information unless
it is in in the FAQ.

>it's very clear about the default case of the GPL, but it doesn't
>mention the exceptions in the Cygwin license.  Would this work?

I'd rather not refer to this as "exceptions to the GPL requirement".  I
think that something along the lines of:

  Before you begin, note that Cygwin is licensed under the GNU GPL (as
  indeed are all other Cygwin-based libraries).  That means that if your
  code links against the cygwin dll (and if your program is calling
  functions from Cygwin, it must, as a matter of fact, be linked against
  it), and you are distributing binaries, the GPL, in general, applies to
  your source as well.  See http://cygwin.com/licensing.html for more
  details about the GPL and Cygwin's use of it.

would be preferable.  I'd like to get Corinna's take on this, however,
and that won't be happening for a week or so.

cgf
