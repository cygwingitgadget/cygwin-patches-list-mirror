Return-Path: <cygwin-patches-return-5325-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22159 invoked by alias); 28 Jan 2005 15:14:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22123 invoked from network); 28 Jan 2005 15:14:22 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 28 Jan 2005 15:14:22 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 4AB941B527; Fri, 28 Jan 2005 10:14:54 -0500 (EST)
Date: Fri, 28 Jan 2005 15:14:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: fs_info::update
Message-ID: <20050128151453.GB10301@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050127215809.00f1d4c0@incoming.verizon.net> <20050128094524.GY31117@cygbert.vinschen.de> <41FA5600.FD6CE295@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FA5600.FD6CE295@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2005-q1/txt/msg00028.txt.bz2

On Fri, Jan 28, 2005 at 10:10:56AM -0500, Pierre A. Humblet wrote:
>Corinna Vinschen wrote:
>>This looks pretty much like a band-aid.  I can see the use for checking
>>the last error code, but shouldn't Cygwin opt for safety and not assume
>>ACLs?  Also, if there's no right to read a remote drive, there might be
>>a good reason for that, which doesn't necessarily mean the drive has
>>acls.
>>
>>After all, the effect of chmod -r can be reverted with Windows own
>>means.
>
>Background: I noticed all of that when testing the
>SetCurrentDirectory("c:\\").  Took me a while to understand why chmod
>stopped working.  On XP HOME there is no security gui, so I had to use
>cacls.  Not nice.

Are you saying this is somehow a side-effect of
SetCurrentDirectory("c:\\") in exit()?  I can't imagine how that change
could cause this behavior.

cgf
