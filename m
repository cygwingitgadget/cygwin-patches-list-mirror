Return-Path: <cygwin-patches-return-4400-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19260 invoked by alias); 15 Nov 2003 17:05:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19251 invoked from network); 15 Nov 2003 17:05:24 -0000
Date: Sat, 15 Nov 2003 17:05:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: src/winsup/cygwin ChangeLog bsdlib.cc cygheap. ...
Message-ID: <20031115170520.GB3376@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20031114234006.19467.qmail@sources.redhat.com> <20031115163334.GA3039@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031115163334.GA3039@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00119.txt.bz2

On Sat, Nov 15, 2003 at 11:33:34AM -0500, Christopher Faylor wrote:
>The patch below modifies user-visible files in the include tree.
>I thought we were just making the CYG_MAX_PATH change and, even if
>that was not the case, the ChangeLog does not correctly deal with
>this scenario.

I've reverted this part of the check-in.

FYI.
cgf
