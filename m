Return-Path: <cygwin-patches-return-2614-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4039 invoked by alias); 7 Jul 2002 18:04:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4022 invoked from network); 7 Jul 2002 18:04:40 -0000
Date: Sun, 07 Jul 2002 11:04:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: mark_closed messages
Message-ID: <20020707180435.GA1213@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <015501c225c3$d8ddcc20$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015501c225c3$d8ddcc20$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00062.txt.bz2

On Sun, Jul 07, 2002 at 03:37:40PM +0100, Conrad Scott wrote:
>AFAICT (and this was all new to me, so I may be utterly adrift
>here), the difficulty is that the child process needs to create
>and protect handles *before* the parent's data space is copied
>down into it.  So, the child would need to keep a temporary list
>of protected handles and merge these into the list it inherited
>from the parent once it had access to it.  Not impossible but not
>my cup of tea today.

Thanks for the analysis.  I'll incorporate some of your ideas into
debug.cc but I have to think about the clexec stuff.  I must have
changed the handle list to NO_COPY at some point which caused
some of these problems.

It sounds like the handle list is a candidate for the cygheap, so
that it can be properly dealt with in execed and forked processes.

Of course, maybe we should just nuke the whole concept, too.  I
think the vast majority of "problems" that the ProtectHandle stuff
has unearthed have been "false positives", lately.

cgf
