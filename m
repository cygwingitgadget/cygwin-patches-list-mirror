Return-Path: <cygwin-patches-return-4534-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23833 invoked by alias); 23 Jan 2004 16:04:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23824 invoked from network); 23 Jan 2004 16:04:07 -0000
Message-ID: <401145F5.5ECCA8DF@phumblet.no-ip.org>
Date: Fri, 23 Jan 2004 16:04:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: secret event
References: <3.0.5.32.20040122183313.00839860@incoming.verizon.net> <20040123095952.GC12512@cygbert.vinschen.de> <20040123151621.GC10708@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q1/txt/msg00024.txt.bz2


Christopher Faylor wrote:
> 
> 
> I agree, with one nit.  Was there a reason for getting rid of the handle
> protection in this patch?  We are apparently stumbling over a problem with
> handle corruption in the current CVS so removing a chance for protection
> seems like we're going backwards.

The previous code was assuming that a handle would never change from
inheritable to non-inheritable (or conversely) and was protecting it
accordingly.
That's not true anymore and I don't know how to protect in that situation.

I have seen the DEBUGGING_AND_FDS_PROTECTED stuff, but I am not sure
if/how it works.

Pierre
