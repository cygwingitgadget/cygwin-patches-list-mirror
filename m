Return-Path: <cygwin-patches-return-4018-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20426 invoked by alias); 17 Jul 2003 08:25:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20413 invoked from network); 17 Jul 2003 08:25:06 -0000
Message-ID: <20030717082505.65961.qmail@web21407.mail.yahoo.com>
Date: Thu, 17 Jul 2003 08:25:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: Re: mmsystem.h patch
To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>, cygwin-patches@cygwin.com
In-Reply-To: <3.0.5.32.20030717000711.008162b0@mail.attbi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2003-q3/txt/msg00034.txt.bz2

 --- "Pierre A. Humblet" <Pierre.Humblet@ieee.org> wrote: > As per
> 
> <http://www.winehq.com/hypermail/wine-patches/2003/01/0033.html>
> and (slight difference)
> <http://csislabs.palomar.edu/Student/dx81/DXSDK/samples/Multimedia/DirectSho
> w/BaseClasses/readme.txt>
> and thread
> <http://www.aewnet.com/newsgroups/rnews.asp?newsid=105001&group=9>
> 
> 
> 2003-07-17  Pierre Humblet  <pierre.humblet@ieee.org>
> 
> 	* include/mmsystem.h: Add TIME_KILL_SYNCHRONOUS.
> 

Thanks
Committed, with addition of WINVER >= 0x0501 guard (as per the references 2 and 3
above)

Danny

http://mobile.yahoo.com.au - Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
