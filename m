Return-Path: <cygwin-patches-return-4936-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3954 invoked by alias); 9 Sep 2004 14:05:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3944 invoked from network); 9 Sep 2004 14:05:39 -0000
Date: Thu, 09 Sep 2004 14:05:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] implementation of nonblocking writes on pipes
Message-ID: <20040909140656.GE27325@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040907195148.9F797E5C1@wildcard.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907195148.9F797E5C1@wildcard.curl.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00088.txt.bz2

On Tue, Sep 07, 2004 at 03:51:48PM -0400, Bob Byrnes wrote:
>The following patch implements nonblocking writes on pipes.  Currently,
>pipes ignore the O_NONBLOCK flag for writing, and programs like sshd or
>rsync that use nonblocking I/O heavily can hang when writes unexpectedly
>block.

Before we start adding more patches which are based on your previous work,
could you reply to some of the problems raised in the cygwin mailing list?

There was one problem with Windows 95 which Corinna fixed but now there
is another problem with using rsync, which I thought was one of the impetuses
for your patch.

cgf
