Return-Path: <cygwin-patches-return-3073-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20972 invoked by alias); 21 Oct 2002 16:21:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20963 invoked from network); 21 Oct 2002 16:21:04 -0000
Date: Mon, 21 Oct 2002 09:21:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Avoiding /etc/passwd and /etc/group scans
Message-ID: <20021021162246.GC15828@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DB416E7.99E22851@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB416E7.99E22851@ieee.org>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00024.txt.bz2

On Mon, Oct 21, 2002 at 11:01:59AM -0400, Pierre A. Humblet wrote:
>Cygwin scans the passwd and group files to map sids
>to/from uid & gid. It does so even for the current user,
>although the relevant mappings are stored internally.
>This is inefficient and causes problems (e.g. gcc produces
>non executable files) as soon as /etc/passwd is incomplete.

It's only supposed to be doing this for the first cygwin process that
start up on a given console.  Is that, again, no longer the case?  It
seems like we keep drifting here.  We shouldn't be incurring the
/etc/group and /etc/passwd startup costs even when ntsec isn't
available.

Anyway, I'll take a look at your patch later today, Pierre.

cgf
