Return-Path: <cygwin-patches-return-1474-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 20575 invoked by alias); 12 Nov 2001 11:18:10 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 20533 invoked from network); 12 Nov 2001 11:18:01 -0000
Date: Tue, 02 Oct 2001 20:59:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFD, PATCH]: Set "hidden" attribute when creating files/dirs/symlinks with trailing dot
Message-ID: <20011112121756.H2618@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20011112014116.B2618@cygbert.vinschen.de> <20011112024721.GB28017@redhat.com> <002501c16b28$38f79ca0$0200a8c0@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002501c16b28$38f79ca0$0200a8c0@lifelesswks>; from robert.collins@itdomain.com.au on Mon, Nov 12, 2001 at 02:15:02PM +1100
X-SW-Source: 2001-q4/txt/msg00006.txt.bz2

On Mon, Nov 12, 2001 at 02:15:02PM +1100, Robert Collins wrote:
> I don't like it. If I'm browsing the cygwin directory tree via explorer,
> I should see everything by default - otherwise _why_ am I browsing that
> tree?

Hmm, you don't like it and that's ok but the question "why am I
browsing...?"  is somewhat confusing.

When you "browse" a tree using `ls' it's the same situation.  If
you don't like ls to hide the hidden files (beginning with a dot),
you give the option -a.  In Explorer it's the same situation.  If
you don't like Explorer to hide the hidden files (having the HIDDEN
attribute) you set the option "Show hidden files and folders".
So, what's the difference?  In both cases it's a user decision.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
