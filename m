Return-Path: <cygwin-patches-return-4869-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2260 invoked by alias); 21 Jul 2004 17:01:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2250 invoked from network); 21 Jul 2004 17:01:00 -0000
Date: Wed, 21 Jul 2004 17:01:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix dup for /dev/dsp
Message-ID: <20040721170015.GC22390@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <40FE87D6.3C89AE1F@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FE87D6.3C89AE1F@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00021.txt.bz2

On Wed, Jul 21, 2004 at 11:12:22AM -0400, Pierre A. Humblet wrote:
>Here is another idea.
>As noted in your comments, the children cannot change any of the
>parameters (because they don't have access to the parent).  To fix that
>I am wondering if it wouldn't be better to use a FileMapping that can
>be shared between parent and children, instead of an archetype.
>Apparently that's what fhandler_tape does.  See mtinfo_init () in
>fhandler_tape.cc Perhaps that share can be created on demand when the
>dsp is opened, instead of creating it for every process as tape does.
>My understanding is very superficial, I apologize in advance if I
>mislead you.

If this is all that's required, you could use an __attribute__((shared))
option to share the state among all processes.

cgf
