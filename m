Return-Path: <cygwin-patches-return-1598-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11782 invoked by alias); 16 Dec 2001 17:26:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11766 invoked from network); 16 Dec 2001 17:26:05 -0000
Date: Tue, 06 Nov 2001 08:56:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: RFP : shell defaults
Message-ID: <20011216172634.GF28210@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <104801c18603$c811fb10$0200a8c0@lifelesswks> <Pine.LNX.4.21.0112161721240.2658-100000@lupus.ago.vpn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0112161721240.2658-100000@lupus.ago.vpn>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2001-q4/txt/msg00130.txt.bz2

On Sun, Dec 16, 2001 at 05:25:11PM +0100, Alexander Gottwald wrote:
>On Sun, 16 Dec 2001, Robert Collins wrote:
>> If someone wants to follow my notes in reply to Corinna and create a
>> shell defaults package, that would be great. AFAIK all distro's generate
>> a very simply prompt for you, and then leave it up to you.
>
>One thing that might be useful: 
>
>SuSE Linux sets PROFILEREAD=yes as first thing in /etc/profile and
>all $HOME/.profile depend on this and read /etc/profile if this is
>not set. 
>
>Running cygwin and accessing homes on a SuSE box will fall into an 
>never ending loop.

And, it sounds like (possibly) running Mandrake linux and accessing home
on a SuSE box will fall into an infinite loop, and (definitely) running
Red Hat will do so.

This sounds like a dubious feature to me.

cgf
