Return-Path: <cygwin-patches-return-2773-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17203 invoked by alias); 6 Aug 2002 05:23:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17189 invoked from network); 6 Aug 2002 05:23:57 -0000
Date: Mon, 05 Aug 2002 22:23:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: add_handle and malloc
Message-ID: <20020806052352.GC23281@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <023c01c23cf4$823d56e0$6132bc3e@BABEL> <026301c23cf5$eabeebb0$6132bc3e@BABEL> <20020806030558.GB19362@redhat.com> <027301c23cfb$108b7cf0$6132bc3e@BABEL> <20020806045937.GA23281@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020806045937.GA23281@redhat.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00221.txt.bz2

On Tue, Aug 06, 2002 at 12:59:37AM -0400, Christopher Faylor wrote:
>If there is a handle leak then the thread code should be a good clue
                                    ^^^^^^
                                    debug handle
>where it is.  If you look at the cygheap->debug.freeh table it should
>be filled with a repeating handle, I would think.

Gee.  I wonder what I've been working on...

cgf
