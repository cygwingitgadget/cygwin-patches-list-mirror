Return-Path: <cygwin-patches-return-1944-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25802 invoked by alias); 4 Mar 2002 22:44:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25782 invoked from network); 4 Mar 2002 22:44:15 -0000
Message-ID: <20020304224414.13778.qmail@web14510.mail.yahoo.com>
Date: Mon, 04 Mar 2002 14:46:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: RFC: Silence pedantic warnings at header file level
To: cygwin-patches <cygwin-patches@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q1/txt/msg00301.txt.bz2

GCC 3.x has a a new pragma that causes the rest of the code in
the current file to be treated as if it came from a system header

Putting this right after the header guard of runtime and w32api headers
would silence all the "long long"  and bitfield pedantic warnings that
still occur.  It would also allow cleanup of the anonymous union
__extension__ business.

#if defined __GNUC__ && __GNUC__ >= 3
#pragma GCC system_header
#endif


This approach is used in GCC's STL headers.

Any comments

Danny

http://movies.yahoo.com.au - Yahoo! Movies
- Vote for your nominees in our online Oscars pool.
