Return-Path: <cygwin-patches-return-2770-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28940 invoked by alias); 6 Aug 2002 03:06:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28926 invoked from network); 6 Aug 2002 03:06:03 -0000
Date: Mon, 05 Aug 2002 20:06:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: add_handle and malloc
Message-ID: <20020806030558.GB19362@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <023c01c23cf4$823d56e0$6132bc3e@BABEL> <026301c23cf5$eabeebb0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <026301c23cf5$eabeebb0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00218.txt.bz2

On Tue, Aug 06, 2002 at 04:04:02AM +0100, Conrad Scott wrote:
>Attached is a slightly more thorough version of the previous
>patch: this one also removes the `allocated' flag (and associated
>code) since it is only used for malloc'ed entries.
>
>This patch supersedes the previous one.

Go ahead and check this in.  You weren't actually seeing the malloc
code being hit, were you?

cgf
