Return-Path: <cygwin-patches-return-5385-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7661 invoked by alias); 27 Mar 2005 20:04:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7634 invoked from network); 27 Mar 2005 20:04:32 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.219.218)
  by sourceware.org with SMTP; 27 Mar 2005 20:04:32 -0000
Received: from [192.168.1.10] (helo=Compaq)
	by phumblet.no-ip.org with smtp (Exim 4.50)
	id IE10W0-0002XC-OB
	for cygwin-patches@cygwin.com; Sun, 27 Mar 2005 15:00:00 -0500
Message-Id: <3.0.5.32.20050327145927.00b60730@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 27 Mar 2005 20:04:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] hires.h
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2005-q1/txt/msg00088.txt.bz2

        * timer.cc (nanosleep): Treat tv_sec < 0 as invalid.

Should be in signal.cc. But then I thought I had covered that case way
back. Turns out the root cause is in hires.h. With this patch, the nanosleep
patch can be reverted.

Pierre


2005-03-27  Pierre Humblet <pierre.humblet@ieee.org>

	* hires.h: Add parentheses to HIRES_DELAY_MAX.

--- hires.h     23 Dec 2003 16:26:30 -0000      1.7
+++ hires.h     27 Mar 2005 19:54:04 -0000
@@ -19,7 +19,7 @@ details. */
    The tv_sec argument in timeval structures cannot exceed
    HIRES_DELAY_MAX / 1000 - 1, so that adding fractional part
    and rounding won't exceed HIRES_DELAY_MAX */
-#define HIRES_DELAY_MAX (((UINT_MAX - 10000) / 1000) * 1000) + 10
+#define HIRES_DELAY_MAX ((((UINT_MAX - 10000) / 1000) * 1000) + 10)
 
 class hires_base
 {
