Return-Path: <cygwin-patches-return-1597-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2851 invoked by alias); 16 Dec 2001 16:49:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2837 invoked from network); 16 Dec 2001 16:49:06 -0000
Date: Tue, 06 Nov 2001 06:15:00 -0000
From: Alexander Gottwald <Alexander.Gottwald@informatik.tu-chemnitz.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: RFP : shell defaults
In-Reply-To: <104801c18603$c811fb10$0200a8c0@lifelesswks>
Message-ID: <Pine.LNX.4.21.0112161721240.2658-100000@lupus.ago.vpn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2001-q4/txt/msg00129.txt.bz2

On Sun, 16 Dec 2001, Robert Collins wrote:
> If someone wants to follow my notes in reply to Corinna and create a
> shell defaults package, that would be great. AFAIK all distro's generate
> a very simply prompt for you, and then leave it up to you.

One thing that might be useful: 

SuSE Linux sets PROFILEREAD=yes as first thing in /etc/profile and
all $HOME/.profile depend on this and read /etc/profile if this is
not set. 

Running cygwin and accessing homes on a SuSE box will fall into an 
never ending loop.

So it would be great, if PROFILEREAD=yes could be set in the default 
/etc/profile.

bye
    ago
-- 
 Alexander.Gottwald@informatik.tu-chemnitz.de 
 http://www.gotti.org           ICQ: 126018723
 phone: +49 3725 349 80 80	mobile: +49 172 7854017
 4. Chemnitzer Linux-Tag http://www.tu-chemnitz.de/linux/tag/lt4
