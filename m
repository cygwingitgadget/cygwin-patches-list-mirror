Return-Path: <cygwin-patches-return-2264-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19945 invoked by alias); 30 May 2002 01:00:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19922 invoked from network); 30 May 2002 01:00:41 -0000
X-WM-Posted-At: avacado.atomice.net; Thu, 30 May 02 02:03:53 +0100
Message-ID: <00af01c20775$ddf2a530$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: Patch to add missing ANSI_STRING typedef to ntdef.h
Date: Wed, 29 May 2002 18:00:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00247.txt.bz2

This patch adds typedefs for ANSI_STRING, PANSI_STRING, OEM_STRING and
POEM_STRING to ntdef.h

Regards
Chris

---

2002-05-30  Christopher January  <chris@atomice.net>

    * include/ntdef.h (ANSI_STRING, PANSI_STRING, OEM_STRING, POEM_STRING):
Add missing typedefs.

