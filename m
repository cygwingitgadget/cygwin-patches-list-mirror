Return-Path: <cygwin-patches-return-2005-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24428 invoked by alias); 26 Mar 2002 11:48:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24409 invoked from network); 26 Mar 2002 11:48:41 -0000
Date: Tue, 26 Mar 2002 04:00:00 -0000
From: Pavel Tsekov <ptsekov@syntrex.com>
Reply-To: Pavel Tsekov <ptsekov@syntrex.com>
Organization: Syntrex, Inc.
X-Priority: 3 (Normal)
Message-ID: <6412043858.20020326122806@syntrex.com>
To: "Robert Collins" <robert.collins@itdomain.com.au>
CC: cygwin-patches@cygwin.com
Subject: Re[2]: [PATCH] setup.exe: mkdir.cc. was: setup.exe crash
In-Reply-To: <FC169E059D1A0442A04C40F86D9BA76008ABAD@itdomain003.itdomain.net.au>
References: <FC169E059D1A0442A04C40F86D9BA76008ABAD@itdomain003.itdomain.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q1/txt/msg00362.txt.bz2

Hello Robert,

Tuesday, March 26, 2002, 12:10:09 PM, you wrote:

RC> Pavel,
RC>         care to supply a changelog? Thanks for tracking this down too.

Of course! :) I didn't supply it the first time because I've sent the
patch for review.

Btw.  I haven't checked if the new return value is a problem for
any of the mkdir_p () callers.

Here is the ChangeLog entry:

2002-03-26  Pavel Tsekov  <ptsekov@gmx.net>

            * mkdir.cc (mkdir_p): Stop processing if the path is exhausted.
            Return -1 on 'path exhausted' condition.
