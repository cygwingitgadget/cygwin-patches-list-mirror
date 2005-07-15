Return-Path: <cygwin-patches-return-5570-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3638 invoked by alias); 15 Jul 2005 19:25:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3610 invoked by uid 22791); 15 Jul 2005 19:25:38 -0000
Received: from nat.electric-cloud.com (HELO main.electric-cloud.com) (63.82.0.114)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 15 Jul 2005 19:25:38 +0000
Received: from fulgurite.electric-cloud.com (fulgurite.electric-cloud.com [192.168.1.58])
	by main.electric-cloud.com (8.13.1/8.13.1) with ESMTP id j6FJPanH014844
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <cygwin-patches@cygwin.com>; Fri, 15 Jul 2005 12:25:36 -0700
Subject: Re: [Patch]: Changes to how-programming.texinfo
From: Max Kaehn <slothman@electric-cloud.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20050715190853.GH13238@trixie.casa.cgf.cx>
References: <1121451065.13490.13.camel@fulgurite>
	 <20050715183012.GG13238@trixie.casa.cgf.cx>
	 <1121453602.13490.24.camel@fulgurite>
	 <20050715190853.GH13238@trixie.casa.cgf.cx>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 19:25:00 -0000
Message-Id: <1121455535.13490.28.camel@fulgurite>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q3/txt/msg00025.txt.bz2

On Fri, 2005-07-15 at 15:08 -0400, Christopher Faylor wrote:
> On Fri, Jul 15, 2005 at 11:53:22AM -0700, Max Kaehn wrote:
> >I'm concerned about that FAQ entry giving incomplete information
> 
> And, I'm always concerned about people who can't find any information unless
> it is in in the FAQ.

Think of how much time it could save you to not have to answer
questions about contradictions between the FAQ and the Cygwin
license. :-)

> I'd rather not refer to this as "exceptions to the GPL requirement".  I
> think that something along the lines of:
> 
>   Before you begin, note that Cygwin is licensed under the GNU GPL (as
>   indeed are all other Cygwin-based libraries).  That means that if your
>   code links against the cygwin dll (and if your program is calling
>   functions from Cygwin, it must, as a matter of fact, be linked against
>   it), and you are distributing binaries, the GPL, in general, applies to
>   your source as well.  See http://cygwin.com/licensing.html for more
>   details about the GPL and Cygwin's use of it.
> 
> would be preferable.  I'd like to get Corinna's take on this, however,
> and that won't be happening for a week or so.

Sounds good.

