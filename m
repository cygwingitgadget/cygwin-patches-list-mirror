Return-Path: <cygwin-patches-return-2677-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31868 invoked by alias); 21 Jul 2002 00:29:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31854 invoked from network); 21 Jul 2002 00:29:02 -0000
Message-ID: <20020721002857.67645.qmail@web14507.mail.yahoo.com>
Date: Sat, 20 Jul 2002 17:29:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: Re: [PATCH] w32api (some general, some Watcom related)
To: Bart Oldeman <bart.oldeman@btinternet.com>,
  cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <Pine.LNX.4.33.0207192007530.1882-100000@enm-bo-lt.enm.bris.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q3/txt/msg00125.txt.bz2

> 2002-07-17   Bart Oldeman  <bart.oldeman@btinternet.com>
> 
> 	* include/shlobj.h (FCIDM_MENU_FAVORITES): remove bogus character.
> 	* include/winsock2.h (struct sockaddr): use __int64 instead of
> 	long long
> 	* include/kernel32.c (GetCurrentFiber): Watcom does not need
> 	external *Fiber library functions.
> 	* include/kernel32.c (GetFiberData): likewise
>

I have checked in above changes, but not this:

> 	* include/windef.h: (PACKED) Watcom compatible #define for
> 	structure packing
> 	* include/wincon.h (KEY_EVENT_RECORD): use the above
 

My tests indicate that the packed attribute is not necessary for
KEY_EVENT_RECORD (the default alignment is same as PACKED) and could be
removed.  Bart indicates that it is not necesssary for Watcom either. Since the
PACKED define is used nowhere else in w32api, I would be inclined to remove it
completely from windef.h, but that may break some user code that depends on
it..., so I'll leave it alone. 

Danny

http://www.sold.com.au - SOLD.com.au
- Find yourself a bargain!
