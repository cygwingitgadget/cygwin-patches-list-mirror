Return-Path: <cygwin-patches-return-4669-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1444 invoked by alias); 11 Apr 2004 04:00:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1432 invoked from network); 11 Apr 2004 04:00:18 -0000
Date: Sun, 11 Apr 2004 04:00:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: dtable.cc
Message-ID: <20040411040013.GA6064@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040410234239.00819ea0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040410234239.00819ea0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00021.txt.bz2

On Sat, Apr 10, 2004 at 11:42:39PM -0400, Pierre A. Humblet wrote:
>Here is a minor fix in dtable.cc.

Thanks.  Applied.

>My next fix is to remove the normalized_path from path_conv,
>and the attendant malloc and path_conv destructor.

Please, don't bother.  I don't want to do this.  I want to have the
posix names available for their current use.

cgf
