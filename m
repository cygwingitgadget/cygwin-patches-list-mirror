Return-Path: <cygwin-patches-return-4681-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30988 invoked by alias); 13 Apr 2004 14:14:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30979 invoked from network); 13 Apr 2004 14:14:52 -0000
Message-ID: <407BF5D9.23561E65@phumblet.no-ip.org>
Date: Tue, 13 Apr 2004 14:14:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: path.cc
References: <3.0.5.32.20040404234622.00800100@incoming.verizon.net> <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net> <3.0.5.32.20040403214940.007f2650@incoming.verizon.net> <3.0.5.32.20040403214940.007f2650@incoming.verizon.net> <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net> <3.0.5.32.20040404234622.00800100@incoming.verizon.net> <3.0.5.32.20040409231957.00857bb0@incoming.verizon.net> <20040410110343.GM26558@cygbert.vinschen.de> <3.0.5.32.20040412190645.00809e10@incoming.verizon.net> <3.0.5.32.20040412200933.0080b8f0@incoming.verizon.net> <20040413122109.GC26558@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00033.txt.bz2


Corinna Vinschen wrote:
> 
> Hmm, yes, the allow_smbntsec flag is not set by default and I have no
> idea when that disappeared, actually.  Should we revert that or should
> we better keep it as it is?  Somehow I have the vague feeling that we
> have less complaints about Samba file access for a while...

The smbntsec has not been set by default for as far back as I can 
remember. I care a lot about it because of limitations of my work
environment, so I would have noticed.

I just rebuilt from cvs and everything looks fine on NT4.0.
Thanks.

Pierre
