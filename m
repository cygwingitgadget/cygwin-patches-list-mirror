Return-Path: <cygwin-patches-return-5247-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31401 invoked by alias); 18 Dec 2004 20:28:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31317 invoked from network); 18 Dec 2004 20:28:06 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 18 Dec 2004 20:28:06 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.34)
	id 1CflDD-0004ZV-Rh
	for cygwin-patches@cygwin.com; Sat, 18 Dec 2004 20:29:59 +0000
Message-ID: <41C49377.57107AA9@dessent.net>
Date: Sat, 18 Dec 2004 20:28:00 -0000
From: Brian Dessent <brian@dessent.net>
Organization: My own little world...
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
References: <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <20041217032627.GF26712@trixie.casa.cgf.cx> <3.0.5.32.20041216224347.0082d210@incoming.verizon.net> <20041217061741.GG26712@trixie.casa.cgf.cx> <41C31496.4D9140C7@phumblet.no-ip.org> <20041217175649.GA1237@trixie.casa.cgf.cx> <41C36530.89F5A621@phumblet.no-ip.org> <20041218003615.GB3068@trixie.casa.cgf.cx> <20041218172053.GA9932@trixie.casa.cgf.cx> <41C476F1.6060700@x-ray.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00248.txt.bz2

Reini Urban wrote:

> > Thinking some more about this, there are really some inconsistencies with
> > the current and proposed behavior that I don't like.
> > [...]
> I have no strong opinion in these issues (yet), but please look also at
> the related ending-colon ':extension' problem on NTFS.
> Such files are also not listed, but probably should be.

Why are you hijacking this thread for something unrelated?  The
alternate streams are not seperate files, they are just additional file
data.  If the need arises then standalone tools should be made to access
them, just like getfacl and friends.  They should not be treated as
seperate files because they're not.

Brian
