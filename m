Return-Path: <cygwin-patches-return-2006-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32344 invoked by alias); 26 Mar 2002 12:00:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32297 invoked from network); 26 Mar 2002 12:00:22 -0000
Date: Tue, 26 Mar 2002 08:01:00 -0000
From: Pavel Tsekov <ptsekov@syntrex.com>
Reply-To: Pavel Tsekov <ptsekov@syntrex.com>
Organization: Syntrex, Inc.
X-Priority: 3 (Normal)
Message-ID: <14813963858.20020326130006@syntrex.com>
To: "Robert Collins" <robert.collins@itdomain.com.au>
CC: cygwin-patches@cygwin.com
Subject: Re[4]: [PATCH] setup.exe: mkdir.cc. was: setup.exe crash
In-Reply-To: <FC169E059D1A0442A04C40F86D9BA76008ABB3@itdomain003.itdomain.net.au>
References: <FC169E059D1A0442A04C40F86D9BA76008ABB3@itdomain003.itdomain.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q1/txt/msg00363.txt.bz2

>> Btw.  I haven't checked if the new return value is a problem
>> for any of the mkdir_p () callers.

RC> Oh, it may well be, so I was going to checkin a variant anyway:

RC> 1 is failure :}.

Uh, yes... Thanks! I was sure I'm missing something :)
