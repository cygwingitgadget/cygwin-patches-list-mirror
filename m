Return-Path: <cygwin-patches-return-4817-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6123 invoked by alias); 3 Jun 2004 21:26:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6097 invoked from network); 3 Jun 2004 21:26:46 -0000
Message-ID: <40BF9795.F8CC1E82@phumblet.no-ip.org>
Date: Thu, 03 Jun 2004 21:26:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: NUL and other special names
References: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net> <40BF81C4.1020105@att.net> <20040603203500.GA6889@coe.casa.cgf.cx> <40BF9029.9FC61432@phumblet.no-ip.org> <20040603210855.GB14401@coe.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00169.txt.bz2



Christopher Faylor wrote:
> 
> On Thu, Jun 03, 2004 at 04:55:05PM -0400, Pierre A. Humblet wrote:
> >>I believe that whenever I try to limit COM to single digits someone
> >>complains about their special board with 527 com ports or something.
> >
> >That's another issue.  COM12 is not a DOS device (on NT), but it can be
> >the basename of an NT device.
> 
> How do you know that it isn't a DOS device on NT?

With 1.5.10
"touch COM12" followed by "rm COM12" just works.

Also
<http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/base/naming_a_file.asp>

Pierre
