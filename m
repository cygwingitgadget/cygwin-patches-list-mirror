Return-Path: <cygwin-patches-return-3586-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11611 invoked by alias); 18 Feb 2003 22:12:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11591 invoked from network); 18 Feb 2003 22:12:50 -0000
Date: Tue, 18 Feb 2003 22:12:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Message-ID: <20030218221257.GA2458@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030218221239.U46120-100000@logout.sh.cvut.cz> <009c01c2d79a$552579d0$78d96f83@pomello>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009c01c2d79a$552579d0$78d96f83@pomello>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00235.txt.bz2

On Tue, Feb 18, 2003 at 10:08:56PM -0000, Max Bowsher wrote:
>Two things - First:
>
>Please, please don't make this the default! Once a file is sparsified, it
>cannot be unsparsified except by copying the contents to a new file! This
>seems like an optimization for a corner case is trying to cause a global
>change.

Why is it a big deal if a file is sparse?  I don't get it.  In 99% of the
cases this won't be a big deal.  In the cases where it is a big deal, cygwin
will be operating more like UNIX.

>And:
>
>FSCTL_SET_SPARSE, used in the patch, is *not defined* in current w32api !!!

Calm down:

2003-02-17 Vaclav Haisman <V.Haisman@sh.cvut.cz>

        * include/winioctl.h (FSCTL_SET_SPARSE): Define.

cgf
