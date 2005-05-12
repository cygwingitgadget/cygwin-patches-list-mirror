Return-Path: <cygwin-patches-return-5447-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21747 invoked by alias); 12 May 2005 20:02:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21714 invoked from network); 12 May 2005 20:02:22 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 12 May 2005 20:02:22 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 920F013C9F2; Thu, 12 May 2005 16:02:22 -0400 (EDT)
Date: Thu, 12 May 2005 20:02:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: mkdir -p and network drives
Message-ID: <20050512200222.GD5569@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net> <3.0.5.32.20050505225708.00b64250@incoming.verizon.net> <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net> <3.0.5.32.20050510205301.00b4b658@incoming.verizon.net> <20050511085307.GA2805@calimero.vinschen.de> <007b01c5572b$b3925890$3e0010ac@wirelessworld.airvananet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007b01c5572b$b3925890$3e0010ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00043.txt.bz2

On Thu, May 12, 2005 at 03:49:21PM -0400, Pierre A. Humblet wrote:
>----- Original Message ----- 
>From: "Corinna Vinschen" <corinna-cygwin@cygwin.com>
>To: <cygwin-patches@cygwin.com>
>Sent: Wednesday, May 11, 2005 4:53 AM
>Subject: Re: [Patch]: mkdir -p and network drives
>
>
>> I don't like the idea of isrofs being an inline function in dir.cc.
>> Wouldn't that be better a method in path_conv?  It would be helpful
>> for other functions, too.  For instance, unlink and symlink_worker.
>> In the (not so) long run we should really move all of these functions
>> into the fhandlers, though.
>
>After looking into it, moving mkdir and rmdir to fhandlers should be
>quite simple. I will do that early next week.

In the meantime, I'm going to follow through on Corinna's suggestion.
Moving this into path.cc would mean that we could eventually add a "-r"
option to mount which would be a nice thing.

I'm getting ready to roll out a 1.5.17 so I'll get something with EROFS
functionality into that.

cgf
