Return-Path: <cygwin-patches-return-1698-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13663 invoked by alias); 14 Jan 2002 23:25:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13649 invoked from network); 14 Jan 2002 23:25:50 -0000
From: "Gary R Van Sickle" <tiberius@braemarinc.com>
To: "'Corinna Vinschen'" <cygwin-patches@cygwin.com>
Subject: RE: src/winsup/w32api ChangeLog include/winnt.h
Date: Mon, 14 Jan 2002 15:25:00 -0000
Message-ID: <000f01c19d52$df22e650$2101a8c0@BRAEMARINC.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20020115001207.K2015@cygbert.vinschen.de>
Importance: Normal
X-SW-Source: 2002-q1/txt/msg00055.txt.bz2

> Oh, btw., I put it into winnt.h since all FILE_ATTRIBUTE_* defines
> are in winnt.h.  MSDN requires INVALID_FILE_ATTRIBUTES to be in
> winbase.h.  Do you think I should move it?

Assuming it makes no difference to code using the headers (and I don't know
either way), I'd at least put a comment in winbase.h explaining why it isn't
there.

--
Gary R. Van Sickle
Braemar Inc.
11481 Rupp Dr.
Burnsville, MN 55337
