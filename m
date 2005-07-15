Return-Path: <cygwin-patches-return-5568-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18753 invoked by alias); 15 Jul 2005 18:53:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18726 invoked by uid 22791); 15 Jul 2005 18:53:45 -0000
Received: from nat.electric-cloud.com (HELO main.electric-cloud.com) (63.82.0.114)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 15 Jul 2005 18:53:45 +0000
Received: from fulgurite.electric-cloud.com (fulgurite.electric-cloud.com [192.168.1.58])
	by main.electric-cloud.com (8.13.1/8.13.1) with ESMTP id j6FIrN8N013827
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <cygwin-patches@cygwin.com>; Fri, 15 Jul 2005 11:53:23 -0700
Subject: Re: [Patch]: Changes to how-programming.texinfo
From: Max Kaehn <slothman@electric-cloud.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20050715183012.GG13238@trixie.casa.cgf.cx>
References: <1121451065.13490.13.camel@fulgurite>
	 <20050715183012.GG13238@trixie.casa.cgf.cx>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 18:53:00 -0000
Message-Id: <1121453602.13490.24.camel@fulgurite>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q3/txt/msg00023.txt.bz2

On Fri, 2005-07-15 at 14:30 -0400, Christopher Faylor wrote:
> IMO, if we need additional wording about licensing, it should reference
> the web site.

I'm concerned about that FAQ entry giving incomplete information--
it's very clear about the default case of the GPL, but it doesn't
mention the exceptions in the Cygwin license.  Would this work?
---
Before you begin, note that Cygwin is licensed under the GNU GPL (as
indeed are all other Cygwin-based libraries). That means that if your
code links against the cygwin dll (and if your program is calling
functions from Cygwin, it must, as a matter of fact, be linked against
it), you must apply the GPL to your source as well. Of course, this only
matters if you plan to distribute your program in binary form. For more
information on the GPL, see http://gnu.org/licenses/gpl-faq.html.  For
details of Cygwin licensing and exceptions to the GPL requirement,
see http://cygwin.com/licensing.html.  If licensing is not a problem,
read on.
---
I'll compose that into a proper patch if the gurus on cygwin-patches
approve.

