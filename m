From: Alexander Gottwald <Alexander.Gottwald@informatik.tu-chemnitz.de>
To: egcs@cygnus.com
Cc: cygwin-patches@cygwin.com
Subject: Re: RFP : shell defaults
Date: Sun, 16 Dec 2001 08:49:00 -0000
Message-ID: <Pine.LNX.4.21.0112161721240.2658-100000@lupus.ago.vpn>
References: <104801c18603$c811fb10$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/msg00324.html
Message-ID: <20011216084900.rfCCKohFsXY3dlTgfmrlwQ1tfonXh2mQpxJX5xzsDdI@z>

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
