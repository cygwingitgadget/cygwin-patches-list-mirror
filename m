Return-Path: <cygwin-patches-return-3089-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13164 invoked by alias); 28 Oct 2002 09:24:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13102 invoked from network); 28 Oct 2002 09:24:29 -0000
Message-ID: <20021028092343.40352.qmail@web21411.mail.yahoo.com>
Date: Mon, 28 Oct 2002 01:24:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: Re: Make ip.h and tcp.h work under -fnative-struct or -fms-bitfields
To: Wu Yongwei <adah@netstd.com>, cygwin-patches@cygwin.com
In-Reply-To: <3DBCDFA6.5070905@netstd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q4/txt/msg00040.txt.bz2

 --- Wu Yongwei <adah@netstd.com> wrote: > These header files use "u_int xxx:4,
yyy:4", which in the MS convetion
> will generate 4-byte instead of 1-byte bit fields.
> 
> ChangeLog:
> 
> 2002-10-28  Wu Yongwei <adah@netstd.com>
> 
> 	* ip.h (struct ip): Use u_char to indicate bitfields to make it
> 	work with -fnative-struct/-fms-bitfields.
> 	(struct ip_timestamp): Ditto.
> 	* tcp.h (struct tcphdr): Ditto.


Changing types like that can cause problems.
Wouldn't it be better to just use __attribute__((packed)) to pack the fields?
Danny

http://careers.yahoo.com.au - Yahoo! Careers
- 1,000's of jobs waiting online for you!
