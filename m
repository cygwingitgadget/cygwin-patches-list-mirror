Return-Path: <cygwin-patches-return-1950-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5862 invoked by alias); 6 Mar 2002 09:51:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5802 invoked from network); 6 Mar 2002 09:51:54 -0000
Message-ID: <20020306095152.13027.qmail@web14506.mail.yahoo.com>
Date: Wed, 06 Mar 2002 16:37:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: My last patch to mswsock.h breaks winsock1 interface
To: cygwin-patches <cygwin-patches@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q1/txt/msg00307.txt.bz2

This patch:

2002-03-05  dannysmith@users.sourceforge.net

	* include/mswsock.h (TP_*): Add new defines.
	(TRANSMIT_PACKETS_ELEMENT): Define new structure.
	(WSAMSG): Likewise.
	(WSACMSGHDR): Likewise.
	(DisconnectEx): Add new prototype.
	(WSARecvMsg): Likewise.
	(WSA_CMSG_*) Add empty macros, guarded by #if 0.

breaks code that includes <winsock.h> rather than <winsock2.h>.

Including <mswsock.h> from <winsock.h> causes the problem.  

I'll have it fixed by morning (NZDT) .

Sorry.

Danny


http://movies.yahoo.com.au - Yahoo! Movies
- Vote for your nominees in our online Oscars pool.
