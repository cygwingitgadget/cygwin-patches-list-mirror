Return-Path: <cygwin-patches-return-2775-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29143 invoked by alias); 6 Aug 2002 05:49:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29129 invoked from network); 6 Aug 2002 05:49:51 -0000
Date: Mon, 05 Aug 2002 22:49:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: add_handle and malloc
Message-ID: <20020806054946.GC14302@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <023c01c23cf4$823d56e0$6132bc3e@BABEL> <026301c23cf5$eabeebb0$6132bc3e@BABEL> <20020806030558.GB19362@redhat.com> <027301c23cfb$108b7cf0$6132bc3e@BABEL> <20020806045937.GA23281@redhat.com> <030b01c23d0b$ec59d500$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <030b01c23d0b$ec59d500$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00223.txt.bz2

On Tue, Aug 06, 2002 at 06:41:33AM +0100, Conrad Scott wrote:
>It looks like it's cygwin_mount_h, at memory_init():155.  I'll go and
>zap something.

It's probably happening because fork isn't setting mount_h in
child_proc_info.  mount_h should be changed to be NO_COPY and
fork_parent should fill out this field the same way spawn.cc
does.

I just checked in a change which may fix this.

cgf
