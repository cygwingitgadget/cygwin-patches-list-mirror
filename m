Return-Path: <cygwin-patches-return-3049-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9963 invoked by alias); 7 Oct 2002 10:35:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9948 invoked from network); 7 Oct 2002 10:35:08 -0000
From: "Ralf Habacker" <Ralf.Habacker@freenet.de>
To: "Cygwin-Patches" <cygwin-patches@cygwin.com>
Subject: [patch] postgresql 'rc' like start script 
Date: Mon, 07 Oct 2002 03:35:00 -0000
Message-ID: <006901c26ded$319f37b0$686607d5@BRAMSCHE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
X-SW-Source: 2002-q4/txt/msg00000.txt.bz2

Hi all, 

this patch add a unix like 'rc'-start script for the postgresql server. 


Regards

Ralf 


2002-10-17 Ralf Habacker <ralf.habacker@freenet.de>

	rcpostgresql: new file 


--- /dev/null   2002-10-07 12:30:54.000000000 +0200
+++ /usr/sbin/rcpostgresql      2002-10-07 12:30:41.000000000 +0200
@@ -0,0 +1,2 @@
+/usr/bin/pg_ctl -D /usr/share/postgresql/data -l /var/log/pgsql.log $1
