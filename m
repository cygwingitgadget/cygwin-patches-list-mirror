Return-Path: <cygwin-patches-return-4566-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9140 invoked by alias); 9 Feb 2004 02:29:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9119 invoked from network); 9 Feb 2004 02:29:00 -0000
Date: Mon, 09 Feb 2004 02:29:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: DEBUGGING guards in winsup/cygwin/exceptions.cc are missing
Message-ID: <20040209022900.GA8046@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4026E66F.9030207@scytek.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4026E66F.9030207@scytek.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00056.txt.bz2

On Sun, Feb 08, 2004 at 08:46:23PM -0500, Volker Quetschke wrote:
>When compiling the cygwin dll from cvs, without --enable-debugging
>the build fails in winsup/cygwin/exceptions.cc because console_printf
>has no prototype defined without DEBUGGING set.

Thanks for the heads up.  I will check in a fix.

cgf
