Return-Path: <cygwin-patches-return-1947-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29582 invoked by alias); 4 Mar 2002 23:28:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29541 invoked from network); 4 Mar 2002 23:28:01 -0000
Message-ID: <20020304232800.10085.qmail@web14501.mail.yahoo.com>
Date: Tue, 05 Mar 2002 00:16:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: RE: Silence pedantic warnings at header file level
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <FC169E059D1A0442A04C40F86D9BA76008AB0E@itdomain003.itdomain.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q1/txt/msg00304.txt.bz2

 --- Robert Collins <robert.collins@itdomain.com.au> wrote: > Would this
also fix the 'is not a prototype' error that cinstall
> experiences?
> 
> Rob
> 
Compiling  w32api/lib/test.c with 
gcc -I../include -Wall  -Wstrict-prototypes -Wmissing-prototypes -pedantic 
test.c >err.log 
does not give that warning after installing the patch to w32api headers.

<snip>
Chris, the reason I did this
> > #if defined __GNUC__ && __GNUC__ >= 3

 is beacuse I've seen this test so often lately
#if defined (__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
and its stuck in my head

Also, the w32api headers are being used by Open Watcom (or whatever its
called) folk and I don't know anything about there preprocessor.

Danny


http://movies.yahoo.com.au - Yahoo! Movies
- Vote for your nominees in our online Oscars pool.
