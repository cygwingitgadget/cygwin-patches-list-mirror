Return-Path: <cygwin-patches-return-4668-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24713 invoked by alias); 11 Apr 2004 03:45:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24702 invoked from network); 11 Apr 2004 03:45:53 -0000
Date: Sun, 11 Apr 2004 03:45:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Last path.cc
Message-ID: <20040411034553.GA6129@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040410233707.00846910@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040410233707.00846910@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00020.txt.bz2

On Sat, Apr 10, 2004 at 11:37:07PM -0400, Pierre A. Humblet wrote:
>This should take care of the issues I listed yesterday evening.
>
>I simply don't understand the logic in normalize_win32_path
>well enough to touch it intelligently. 
>So I removed the final . in the dumbest way possible

Why do we have to remove the final dot?

How does that jive with the goal of munging windows paths as little
as possible.

Sometimes I simply do not understand your email well enough to
respond intelligently.

cgf
