Return-Path: <cygwin-patches-return-4821-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7833 invoked by alias); 3 Jun 2004 22:06:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7799 invoked from network); 3 Jun 2004 22:06:41 -0000
Date: Thu, 03 Jun 2004 22:06:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: NUL and other special names
Message-ID: <20040603220641.GA12726@coe.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net> <40BF81C4.1020105@att.net> <20040603203500.GA6889@coe.casa.cgf.cx> <40BF9029.9FC61432@phumblet.no-ip.org> <20040603210855.GB14401@coe.casa.cgf.cx> <40BF9795.F8CC1E82@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BF9795.F8CC1E82@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00173.txt.bz2

On Thu, Jun 03, 2004 at 05:26:45PM -0400, Pierre A. Humblet wrote:
>
>
>Christopher Faylor wrote:
>> 
>> On Thu, Jun 03, 2004 at 04:55:05PM -0400, Pierre A. Humblet wrote:
>> >>I believe that whenever I try to limit COM to single digits someone
>> >>complains about their special board with 527 com ports or something.
>> >
>> >That's another issue.  COM12 is not a DOS device (on NT), but it can be
>> >the basename of an NT device.
>> 
>> How do you know that it isn't a DOS device on NT?
>
>With 1.5.10
>"touch COM12" followed by "rm COM12" just works.

But I suspect that you don't have a board on your system which supports 12
com ports.

cgf
