Return-Path: <cygwin-patches-return-4610-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6605 invoked by alias); 18 Mar 2004 05:49:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6595 invoked from network); 18 Mar 2004 05:49:25 -0000
Date: Thu, 18 Mar 2004 05:49:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: rmdir
Message-ID: <20040318054924.GB15439@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040317222144.007f3890@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040317222144.007f3890@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00100.txt.bz2

On Wed, Mar 17, 2004 at 10:21:44PM -0500, Pierre A. Humblet wrote:
>This is not a bug fix, just the reversion of a comment removal
>following some recent tests on NT, plus some code simplification.
>
>Here are the details:
>- Until last Sunday, rmdir(".") didn't work.
>- Now it works on 9x if the directory is empty. 
>  "rmdir ." from a shell works there too.
>- It also works on NT if the directory is empty AND no other process
>  is using it as working directory. "rmdir ." doesn't work from a shell.
>Following my initial experience on 9x, I had deleted some comments.
>That was premature.
>
>2004-03-17  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* dir.cc (rmdir): Reorganize error handling to reduce indentation. 

Go ahead and check this in.

Thanks,
cgf
